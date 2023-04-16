-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_hud", cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local voice = 2
local showHud = true
local showMovie = false
local showHood = false
local talking = false
local radioDisplay = ""
local pauseBreak = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress", function(time, text)
    SendNUIMessage({ type = "ui", display = true, time = time })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VOICETALKING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vrp_hud:talking", function(status)
    talking = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud", function(source, args)
    showHud = not showHud
    updateDisplayHud()
    SendNUIMessage({ hud = showHud })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("movie", function(source, args)
    showMovie = not showMovie
    updateDisplayHud()
    SendNUIMessage({ movie = showMovie })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if IsPauseMenuActive() then
            SendNUIMessage({ hud = false })
            pauseBreak = true
        else
            if pauseBreak and showHud then
                SendNUIMessage({ hud = true })
                pauseBreak = false
            end
        end

        if showHud then
            updateDisplayHud()
        end

        Citizen.Wait(200)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------
function updateDisplayHud()
    local ped = PlayerPedId()
    local health = (GetEntityHealth(ped) - 100) / 300 * 100
    local vehicle = GetVehiclePedIsUsing(ped)
    local speed = GetEntitySpeed(vehicle) * 3.6

    if IsPedInAnyVehicle(ped) then
        SendNUIMessage({ health = health, radio = radioDisplay, voice = voice, hood = showHood, car = true, speed = speed })
    else
        SendNUIMessage({ health = health, radio = radioDisplay, voice = voice, hood = showHood })
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    DisplayRadar(false)

    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Citizen.Wait(100)
    end

    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

    SetMinimapClipType(1)

    SetMinimapComponentPosition("minimap", "L", "B", 0.0, 0.0, 0.158, 0.28)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.155, 0.12, 0.080, 0.164)
    SetMinimapComponentPosition("minimap_blur", "L", "B", -0.005, 0.021, 0.240, 0.302)

    Citizen.Wait(5000)

    SetBigmapActive(true, false)

    Citizen.Wait(100)

    SetBigmapActive(false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:toggleHood")
AddEventHandler("vrp_hud:toggleHood", function()
    showHood = not showHood
    if showHood then
        SetPedComponentVariation(PlayerPedId(), 1, 69, 0, 1)
    else
        SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 1)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:removeHood")
AddEventHandler("vrp_hud:removeHood", function()
    if showHood then
        showHood = false
        SendNUIMessage({ hood = showHood })
        SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 1)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOICEMODE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vrp_hud:setTalkingMode", function(status)
    voice = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIODISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:RadioDisplay")
AddEventHandler("vrp_hud:RadioDisplay", function(number)
    if parseInt(number) <= 0 then
        radioDisplay = ""
    else
        radioDisplay = parseInt(number) .. "Mhz <s>:</s>"
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) and showHud then
            if not IsMinimapRendering() then
                DisplayRadar(true)
            end
        else
            if IsMinimapRendering() then
                DisplayRadar(false)
            end
        end

        Citizen.Wait(1000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
local agachar = false
local movimento = false
local ctrl = 0
Citizen.CreateThread(function()
    while true do 
		local timeDistance = 500
        local ped = PlayerPedId()
		if DoesEntityExist(ped) and not IsEntityDead(ped) then 
			timeDistance = 4
            if not IsPauseMenuActive() then 
                if IsPedJumping(ped) then
                    movimento = false
                end
            end
        end
        if DoesEntityExist(ped) and not IsEntityDead(ped) then
			timeDistance = 4 
            DisableControlAction(0,36,true)
            if not IsPauseMenuActive() then 
				timeDistance = 4
				if IsDisabledControlJustPressed(0,36) and not IsPedInAnyVehicle(ped) and ctrl == 0 then
					timeDistance = 4
					ctrl = 1
                    RequestAnimSet("move_ped_crouched")
                    RequestAnimSet("move_ped_crouched_strafing")
                    if agachar == true then 
                        ResetPedMovementClipset(ped,0.30)
                        ResetPedStrafeClipset(ped)
                        movimento = false
                        agachar = false 
                    elseif agachar == false then
                        SetPedMovementClipset(ped,"move_ped_crouched",0.30)
                        SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                        agachar = true 
                    end 
                end
            end 
		end 
		if agachar == true then 
			timeDistance = 4
			DisablePlayerFiring(PlayerId(),true)
			if IsPedArmed(ped, 7) and not IsPedInAnyVehicle(ped) and not IsPedJumping(ped) and not IsPedFalling(ped) and not IsPedSwimming(ped) and IsControlJustPressed(0,25) then
				ctrl = 1
				ResetPedMovementClipset(ped,0.30)
				ResetPedStrafeClipset(ped)
				movimento = false
				agachar = false 
			end
		end

		Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if ctrl > 0 then
			ctrl = ctrl - 1
		end
	end
end)