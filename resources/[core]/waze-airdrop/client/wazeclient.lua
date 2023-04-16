local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
--------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
--------------------------------------------------------------------------------------------------------------------------------
waze = {}
Tunnel.bindInterface("waze-airdrop", waze)
waze_SERVER = Tunnel.getInterface("waze-airdrop")
--------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------
local wzconfig = {}
local blips = {}
local coords = nil
local crate = nil
local parachute = nil
local thwpegardrop = false
local particleId = 0
local x,y,z = nil
local thwevent = nil
local thwdropFloor = false

local safe = {}

--------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPARTICLE
--------------------------------------------------------------------------------------------------------------------------------
local function requestParticle(dict)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict)
        Citizen.Wait(50)
    end
    UseParticleFxAssetNextCall(dict);
end
--------------------------------------------------------------------------------------------------------------------------------
-- DRAWPARTICLE
--------------------------------------------------------------------------------------------------------------------------------
local function drawParticle(x, y, z, particleDict, particleName)
    requestParticle(particleDict)
    particleId = StartParticleFxLoopedAtCoord(particleName, x, y, z, 0.0, 0.0, 0.0, 2.0, false, false, false, false);
end
--------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
--------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.4,0.4)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 300) + 0.01
	DrawRect(0.0,0.0145,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end
--------------------------------------------------------------------------------------------------------------------------------
-- DRAWSCREEN
--------------------------------------------------------------------------------------------------------------------------------
local function drawScreen(text,font,x,y,scale)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(255,255,255,150)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
--------------------------------------------------------------------------------------------------------------------------------
-- wazeriarBlipDrop
--------------------------------------------------------------------------------------------------------------------------------
local function wazeriarBlipDrop(index, delete, x, y, z, sprite, colour, scale, text)
    if not delete then
        blips[index] = AddBlipForCoord(x, y, z)
        SetBlipSprite(blips[index],sprite)
        SetBlipColour(blips[index],colour)
        SetBlipScale(blips[index],scale)
        SetBlipAsShortRange(blips[index],true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(text)
        EndTextCommandSetBlipName(blips[index])
    else
        if DoesBlipExist(blips[index]) then
            RemoveBlip(blips[index])
        end
        blips[index] = nil
    end
end
--------------------------------------------------------------------------------------------------------------------------------
-- PICKUPAIRDROP
--------------------------------------------------------------------------------------------------------------------------------
local function pickupAirDrop()
    local ped = PlayerPedId()
    local count = 0

    thwpegardrop = true

    FreezeEntityPosition(ped, true)

    local function cancel()
        thwpegardrop = false
        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)
    end

    while count <= wcfg.timepick do

        count = count + 1
        if not IsEntityPlayingAnim(ped, "amb@medic@standing@tendtodead@idle_a", "idle_a", 3) then
            ClearPedTasksImmediately(ped)
            vRP.playAnim(false, {"amb@medic@standing@tendtodead@idle_a", "idle_a"}, true)
            Citizen.Wait(500)
        end
        if GetEntityHealth(ped) <= 101 or IsControlJustPressed(0, 168) then
            cancel()
            return false
        end
        drawScreen("PRESSIONE ~b~F7 ~w~PARA CANCELAR A ~b~COLETA", 4,0.5,0.93,0.50,255,255,255,180)
        drawScreen("AGUARDE ~b~"..math.ceil((wcfg.timepick-count)/100) .. " ~w~SEGUNDOS", 4,0.5,0.96,0.50,255,255,255,180)
        Citizen.Wait(4)
    end

    cancel()
    return true
end
--------------------------------------------------------------------------------------------------------------------------------
-- CHECKAREACLEAROFPLAYER
--------------------------------------------------------------------------------------------------------------------------------
local function checkAreaClearOfPlayer(radius)

    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)

    for k, v in pairs(GetActivePlayers()) do
        local nped = GetPlayerPed(v)
        local npedCoords = GetEntityCoords(nped)
        if ped ~= nped then
            if Vdist2(pedCoords,npedCoords) <= radius then
                if GetEntityHealth(nped) > 101 then
                    return false
                end
            end
        end
    end

    return true
end
--------------------------------------------------------------------------------------------------------------------------------
-- SYNCconfig
--------------------------------------------------------------------------------------------------------------------------------
function waze.syncwzconfig(_wzconfig)
    wzconfig = _wzconfig
end
--------------------------------------------------------------------------------------------------------------------------------
-- finalizardrop
--------------------------------------------------------------------------------------------------------------------------------
function finalizardrop()

    if DoesEntityExist(crate) then
        DeleteEntity(crate)
    end

    if DoesEntityExist(thwdropFloor) then
        DeleteEntity(thwdropFloor)
    end

    if DoesEntityExist(parachute) then
        DeleteEntity(parachute)
    end

    DeleteObject(parachuteObj)
    DeleteObject(crateObj)

    coords = nil
    crate = nil
    parachute = nil
    thwdropFloor = false

    wazeriarBlipDrop("airSupplyCenterFalling", true)
end

--------------------------------------------------------------------------------------------------------------------------------
-- startadrop
--------------------------------------------------------------------------------------------------------------------------------
function waze.startadrop(c,v,r)
    thwevent = 1
    TriggerEvent("Notify","aviso","Um suprimento está sendo encomendado, verifique seu GPS para mais informações.")
    TriggerEvent("waze-airdrop:source", "airdrop", 0.5)

    x, y, z = c,v,r
    local crateObj = GetHashKey("ex_prop_adv_case")
    local parachuteObj = GetHashKey("p_parachute1_sp_dec")

    local sky = z + 550
    local floor = z - 1.0

    crate = CreateObject(crateObj, x, y, sky, false, true, false)
    SetEntityAsMissionEntity(crate,true,true)

    parachute = CreateObject(parachuteObj, x, y, sky, false, true, false)

    FreezeEntityPosition(crate, true)
    FreezeEntityPosition(parachute, true)

    AttachEntityToEntity(parachute, crate, 0, 0.0, 0.0, 3.4, 0.0, 0.0, 0.0, false, false, false, true, 2, true)

    blips["airSupplyArea"] = AddBlipForRadius(x, y, z, wcfg.radius)

    SetBlipColour(blips["airSupplyArea"], 3)
    SetBlipAlpha(blips["airSupplyArea"], 70)

    ativarsafe(c, v, r)
    safe = true 

    wazeriarBlipDrop("airSupplyCenterFalling", false, x, y, z, 94, 3, 1.0, wcfg.nomedoevento)
    drawParticle(x, y, z-1.0, "core", "exp_grd_flare")

    while sky > floor do
        sky = sky - 0.1
        SetEntityCoords(crate, x, y, sky)

        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local _, _, pedZ = table.unpack(pedCoords)

        if #(pedCoords - vector3( x, y, sky)) <= 1.7 then
            SetEntityHealth(ped, 101)
        end

        if sky - floor <= 1 then
            if parachute then
                DeleteEntity(parachute)
            end

            wazeriarBlipDrop("airSupplyCenterFalling", true)
            wazeriarBlipDrop("airSupplyCenterOnFloor", false, x, y, z, 568, 3, 1.0, wcfg.nomedoevento)
            StopParticleFxLooped(particleId, false)
            SetEntityCoords(crate,x,y,floor)
            PlaceObjectOnGroundProperly(crate)

            coords = c,v,r
            thwdropFloor = true
            break
        end
        Citizen.Wait(1) 
    end
end
--------------------------------------------------------------------------------------------------------------------------------
-- MAINTHREAD
--------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function() 
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local timeDistance = 2000
        if thwevent ~= nil then
            timeDistance = 4
            local dist = #(pedCoords - vector3(x,y,z))
            local alive = GetEntityHealth(ped) > 101
            if not IsPedInAnyVehicle(ped) and alive and not thwpegardrop and not create ~= nil and not thwdropFloor == false then
                if dist <= 3.0 then
                    DrawText3D(x,y,z,"~b~E ~w~AIRDROP")
                    if dist <= 1.5 then
                        if IsControlJustPressed(0,38) then
                            if waze_SERVER.checkIntPermissions() then
                                if pickupAirDrop() then
                                    if alive then
                                        finalizardrop()
                                        waze_SERVER.thwgetdrop()
                                        waze_SERVER.getdrop()
                                        Wait(wcfg.timesafe)
                                        safe = false
                                        waze_SERVER.supplyt()
                                        wazeriarBlipDrop("airSupplyArea", true)
                                        wazeriarBlipDrop("airSupplyCenterOnFloor", true)

                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("waze-airdrop:source")
AddEventHandler("waze-airdrop:source",function(sound,volume)
	SendNUIMessage({ transactionType = "playSound", transactionFile = sound, transactionVolume = volume })
end)

RegisterNetEvent("waze-airdrop:distance")
AddEventHandler("waze-airdrop:distance",function(playerid,maxdistance,sound,volume)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local coordsPed = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerid)))
	local distance = #(coords - coordsPed)

	if distance <= maxdistance then
		SendNUIMessage({ transactionType = "playSound", transactionFile = sound, transactionVolume = volume })
	end
end)

RegisterNetEvent("waze-airdrop:fixed")
AddEventHandler("waze-airdrop:fixed",function(playerid,x2,y2,z2,maxdistance,sound,volume)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(x2,y2,z2))
	if distance <= maxdistance then
		SendNUIMessage({ transactionType = "playSound", transactionFile = sound, transactionVolume = volume })
	end
end)

function ativarsafe(x,y,z)
    Citizen.CreateThread(function()
        while (ativarsafe) do
            if safe then
                print(x, y, z)
                DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, wcfg.radius * 1.98103, wcfg.radius * 1.98103, 80.0, 0, 0, 255, 155, 0, 0, 0, 0, 0, 0, 0)

            end
            Wait(0)
        end
    end)
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        finalizardrop()
    end
end)