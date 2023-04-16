local menu_state = {}

function tvRP.openMenuData(menudata)
	SendNUIMessage({ act = "open_menu", menudata = menudata })
end

function tvRP.closeMenu()
	SendNUIMessage({ act = "close_menu" })
end

local menu_celular = false
RegisterNetEvent("status:celular")
AddEventHandler("status:celular",function(status)
	menu_celular = status
end)

CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if menu_celular then
			timeDistance = 4
			BlockWeaponWheelThisFrame()
			DisablePlayerFiring(ped,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,327,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,16,true)
			DisableControlAction(0,17,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,68,true)
			DisableControlAction(0,70,true)
			DisableControlAction(0,91,true)
			DisableControlAction(0,114,true)
			DisableControlAction(0,222,true)
			DisableControlAction(0,225,true)
			DisableControlAction(0,238,true)
			DisableControlAction(0,330,true)
			DisableControlAction(0,331,true)
			DisableControlAction(0,347,true)
		end
		Wait(timeDistance)
	end
end)

function tvRP.prompt(title,default_text)
	SendNUIMessage({ act = "prompt", title = title, text = tostring(default_text) })
	SetNuiFocus(true)
end

function tvRP.request(id,text,time)
	SendNUIMessage({ act = "request", id = id, text = tostring(text), time = time })
end

RegisterNUICallback("menu",function(data,cb)
	if data.act == "close" then
		vRPserver._closeMenu(data.id)
	elseif data.act == "valid" then
		vRPserver._validMenuChoice(data.id,data.choice,data.mod)
	end
end)

RegisterNUICallback("menu_state",function(data,cb)
	menu_state = data
end)

RegisterNUICallback("prompt",function(data,cb)
	if data.act == "close" then
		SetNuiFocus(false)
		vRPserver._promptResult(data.result)
	end
end)

RegisterNUICallback("request",function(data,cb)
	if data.act == "response" then
		vRPserver._requestResult(data.id,data.ok)
	end
end)

RegisterNUICallback("init",function(data,cb)
	SendNUIMessage({ act = "cfg", cfg = {} })
	TriggerEvent("vRP:NUIready")
end)

function tvRP.setDiv(name,css,content)
	SendNUIMessage({ act = "set_div", name = name, css = css, content = content })
end

function tvRP.removeDiv(name)
	SendNUIMessage({ act = "remove_div", name = name })
end


function tvRP.loadAnimSet(dict)
    RequestAnimSet(dict)
    while not HasAnimSetLoaded(dict) do
        Wait(10)
    end
    SetPedMovementClipset(PlayerPedId(),dict,0.25)
end

function tvRP.CarregarAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR OBJETO
-----------------------------------------------------------------------------------------------------------------------------------------
local apontar = false
local animActived = false
local animDict = nil
local animName = nil
local animFlags = 0

local object = nil
local object2 = nil
function tvRP.CarregarObjeto(dict,anim,prop,flag,hand,pos1,pos2,pos3,pos4,pos5,pos6)
	tvRP.stopAnimActived()
	
	if DoesEntityExist(object) then
        TriggerServerEvent("trydeleteobj",ObjToNet(object))
        object = nil
	end
	
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Wait(10)
	end

	if pos1 then
		if dict ~= "" then
			tvRP.CarregarAnim(dict)
			TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
		end
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),pos1,pos2,pos3,pos4,pos5,pos6,true,true,false,true,1,true)
	else
		tvRP.CarregarAnim(dict)
		TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
	end
	SetEntityAsMissionEntity(object,true,true)
    SetEntityAsNoLongerNeeded(object)

    NetworkRegisterEntityAsNetworked(object)
    while not NetworkGetEntityIsNetworked(object) do
        Wait(10)
	end
	
	animDict = dict
    animName = anim
    animFlags = flag
    animActived = true

    local netid = ObjToNet(object)
    SetNetworkIdExistsOnAllMachines(netid,true)
    NetworkSetNetworkIdDynamic(netid,true)
    SetNetworkIdCanMigrate(netid,false)
    for _,i in ipairs(GetActivePlayers()) do
        SetNetworkIdSyncToPlayer(netid,i,true)
    end
end

function tvRP.CarregarObjeto2(dict,anim,prop,flag,hand,pos1,pos2,pos3,pos4,pos5,pos6)
	tvRP.stopAnimActived()

	if DoesEntityExist(object2) then
        TriggerServerEvent("trydeleteobj",ObjToNet(object2))
        object2 = nil
	end
	
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Wait(10)
	end

	if pos1 then
		if dict ~= "" then
			tvRP.CarregarAnim(dict)
			TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
		end
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object2 = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object2,false,false)
		AttachEntityToEntity(object2,ped,GetPedBoneIndex(ped,hand),pos1,pos2,pos3,pos4,pos5,pos6,true,true,false,true,1,true)
	else
		tvRP.CarregarAnim(dict)
		TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object2 = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object2,false,false)
		AttachEntityToEntity(object2,ped,GetPedBoneIndex(ped,hand),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
	end
	SetEntityAsMissionEntity(object2,true,true)
    SetEntityAsNoLongerNeeded(object2)

    NetworkRegisterEntityAsNetworked(object2)
    while not NetworkGetEntityIsNetworked(object2) do
        Wait(10)
	end
	
	animDict = dict
    animName = anim
    animFlags = flag
    animActived = true

    local netid = ObjToNet(object2)
    SetNetworkIdExistsOnAllMachines(netid,true)
    NetworkSetNetworkIdDynamic(netid,true)
    SetNetworkIdCanMigrate(netid,false)
    for _,i in ipairs(GetActivePlayers()) do
        SetNetworkIdSyncToPlayer(netid,i,true)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if not IsEntityPlayingAnim(ped,animDict,animName,3) and animActived then
            TaskPlayAnim(ped,animDict,animName,3.0,3.0,-1,animFlags,0,0,0,0)
        end
        Wait(500)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 500
        if animActived then
            timeDistance = 4
            DisableControlAction(0,16,true)
            DisableControlAction(0,17,true)
            DisableControlAction(0,24,true)
            DisableControlAction(0,25,true)
            DisableControlAction(0,257,true)
            DisableControlAction(0,327,true)
            BlockWeaponWheelThisFrame()
        end
        Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE OBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.DeletarObjeto(status)
    if status == "one" then
        tvRP.stopAnim(true)
    elseif status == "two" then
        tvRP.stopAnim(false)
    else
        tvRP.stopAnim(true)
        tvRP.stopAnim(false)
	end

	animActived = false
	TriggerEvent("binoculos",false)
    if DoesEntityExist(object) then
		TriggerServerEvent("trydeleteobj",ObjToNet(object))
        object = nil
    end
    if DoesEntityExist(object2) then
		TriggerServerEvent("trydeleteobj",ObjToNet(object2))
        object2 = nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PtfxThis(asset)
	RequestNamedPtfxAsset(asset)
	while not HasNamedPtfxAssetLoaded(asset) do  
		Wait(10)
	end
	UseParticleFxAssetNextCall(asset)
end
-----------------------------------------------------------------------------------------------------------------------------------
-- CANCELF6
-----------------------------------------------------------------------------------------------------------------------------------------
local cooldown = 0
CreateThread(function()
	while true do
		Wait(1000)
		if cooldown > 0 then
			cooldown = cooldown - 1
		end
	end
end)

RegisterCommand("keybindCancel",function(source,args)
	local ped = PlayerPedId()
	if not IsPauseMenuActive() then
        if cooldown < 1 then
		    cooldown = 8
            if GetEntityHealth(ped) > 101 and not menu_celular then
                if not menu_state.opened then
                    tvRP.DeletarObjeto()
                    tvRP.stopAnimActived()
                    ClearPedTasks(ped)
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindHandsupp",function(source,args)
	if not IsPauseMenuActive() then
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and not menu_celular and GetEntityHealth(ped) > 101 then
            SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
			if IsEntityPlayingAnim(ped,"random@mugging3","handsup_standing_base",3) then
				StopAnimTask(ped,"random@mugging3","handsup_standing_base",2.0)
				tvRP.stopAnimActived()
			else
				tvRP.playAnim(true,{"random@mugging3","handsup_standing_base"},true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APONTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindPoint",function(source,args)
	if not IsPauseMenuActive() then
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and not menu_celular and GetEntityHealth(ped) > 101 then
			tvRP.CarregarAnim("anim@mp_point")
			if not apontar then
				SetPedCurrentWeaponVisible(ped,0,1,1,1)
				SetPedConfigFlag(ped,36,1)
				Citizen.InvokeNative(0x2D537BA194896636,ped,"task_mp_pointing",0.5,0,"anim@mp_point",24)
				apontar = true
			else
				Citizen.InvokeNative(0xD01015C7316AE176,ped,"Stop")
				if not IsPedInjured(ped) then
					ClearPedSecondaryTask(ped)
				end
				if not IsPedInAnyVehicle(ped) then
					SetPedCurrentWeaponVisible(ped,1,1,1,1)
				end
				SetPedConfigFlag(ped,36,0)
				ClearPedSecondaryTask(ped)
				apontar = false
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIGARVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindEngine",function(source,args)
	if not IsPauseMenuActive() then
		local ped = PlayerPedId()
		if not menu_celular and GetEntityHealth(ped) > 101 then
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsIn(ped,false)
				if GetPedInVehicleSeat(vehicle,-1) == ped then
					tvRP.DeletarObjeto("two")
					local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E,vehicle)
					SetVehicleEngineOn(vehicle,not running,true,true)
					if running then
						SetVehicleUndriveable(vehicle,true)
					else
						SetVehicleUndriveable(vehicle,false)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybind",function(source,args)
	if not IsPauseMenuActive() then
		local ped = PlayerPedId()
		if not menu_celular then

			if args[1] == "f1" and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 then -- CRUZAR O BRACO (F1)
                if not IsPedInAnyVehicle(ped) and not menu_state.opened then
                    if IsEntityPlayingAnim(ped,"anim@amb@nightclub@peds@","rcmme_amanda1_stand_loop_cop",3) then
                        tvRP.DeletarObjeto()
                        tvRP.stopAnimActived()
                    else
                        tvRP.playAnim(true,{"anim@amb@nightclub@peds@","rcmme_amanda1_stand_loop_cop"},true)
                    end
                end
			elseif args[1] == "f2" and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 then -- AGUARDAR (F2)
                if not IsPedInAnyVehicle(ped) and not menu_state.opened then
                    if IsEntityPlayingAnim(ped,"mini@strip_club@idles@bouncer@base","base",3) then
                        tvRP.DeletarObjeto()
                        tvRP.stopAnimActived()
                    else
                        tvRP.playAnim(true,{"mini@strip_club@idles@bouncer@base","base"},true)
                    end
                end
			elseif args[1] == "f3" and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 then -- DEDO DO MEIO (F3)
                if not IsPedInAnyVehicle(ped) and not menu_state.opened then
                    if IsEntityPlayingAnim(ped,"anim@mp_player_intselfiethe_bird","idle_a",3) then
                        tvRP.DeletarObjeto()
                        tvRP.stopAnimActived()
                    else
                        tvRP.playAnim(true,{"anim@mp_player_intselfiethe_bird","idle_a"},true)
                    end
                end
			elseif args[1] == "f5" and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 then -- PUTO (F5)
                if not IsPedInAnyVehicle(ped) and not menu_state.opened then
                    tvRP.playAnim(true,{"misscarsteal4@actor","actor_berating_loop"},false)
                    tvRP.stopAnimActived()
                end
			elseif args[1] == "f10" and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 then -- MÃOS NA CABEÇA (F10)
                if not IsPedInAnyVehicle(ped) and not menu_state.opened then
					if IsEntityPlayingAnim(ped,"random@arrests@busted","idle_a",3) then
						tvRP.DeletarObjeto()
						tvRP.stopAnimActived()
					else
						tvRP.DeletarObjeto()
						tvRP.playAnim(true,{"random@arrests@busted","idle_a"},true)
					end
                end
			elseif args[1] == "del" and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 then -- BLZ (DEL)
                if not IsPedInAnyVehicle(ped) and not menu_state.opened then
                    tvRP.playAnim(true,{"anim@mp_player_intincarthumbs_upbodhi@ps@","enter"},false)
                    tvRP.stopAnimActived()
                end
			elseif args[1] == "left" and not IsPedInAnyVehicle(ped)  then -- JOIA (ARROW LEFT)
                SendNUIMessage({act = "event", event = "LEFT"})
                if menu_state.opened then
                    tvRP.playSound("NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET")
                end
				if not IsPedInAnyVehicle(ped) and not menu_state.opened and GetEntityHealth(ped) > 101 then
                    SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
                    tvRP.playAnim(true,{"anim@mp_player_intselfiethumbs_up","idle_a"},false)
                    tvRP.stopAnimActived()
				end
			elseif args[1] == "right" and not IsPedInAnyVehicle(ped) then -- FACEPALM (ARROW RIGHT)
                SendNUIMessage({act = "event", event = "RIGHT"})
                if menu_state.opened then
                    tvRP.playSound("NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET")
                end
				if not IsPedInAnyVehicle(ped) and not menu_state.opened and GetEntityHealth(ped) > 101 then
                    SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
					tvRP.playAnim(true,{"anim@mp_player_intupperface_palm","idle_a"},false)
                    tvRP.stopAnimActived()
				end
			elseif args[1] == "up" and not IsPedInAnyVehicle(ped) then -- SAUDACAO (ARROW UP)
				SendNUIMessage({ act = "event", event = "UP" })
                if menu_state.opened then
		            tvRP.playSound("NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET")
                end
				if not IsPedInAnyVehicle(ped) and not menu_state.opened and GetEntityHealth(ped) > 101 then
                    SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
                    tvRP.playAnim(true,{"anim@mp_player_intcelebrationmale@salute","salute"},false)
                    tvRP.stopAnimActived()
				end
			elseif args[1] == "down" and not IsPedInAnyVehicle(ped) then -- ASSOBIAR (ARROW DOWN)
                SendNUIMessage({act = "event", event = "DOWN"})
                if menu_state.opened then
                    tvRP.playSound("NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET")
                end
				if not IsPedInAnyVehicle(ped) and not menu_state.opened and GetEntityHealth(ped) > 101 then
					SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
                    tvRP.playAnim(true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
                    tvRP.stopAnimActived()
				end
			end
		end
	end
end)
RegisterCommand("cancel", function()
    local ped = PlayerPedId()
    SendNUIMessage({ act = "event", event = "CANCEL" }) 
end, false)

RegisterKeyMapping("cancel", "Cancel", "keyboard", "BACK")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCEPT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindAccept",function(source,args)
	local ped = PlayerPedId()
	if not menu_celular then
		SendNUIMessage({ act = "event", event = "Y" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindReject",function(source,args)
	local ped = PlayerPedId()
	if not menu_celular then
		SendNUIMessage({ act = "event", event = "U" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('keybindSelect', function() 
	local ped = PlayerPedId()
	if not menu_celular then
	    SendNUIMessage({act = "event", event = "SELECT"})
        if menu_state.opened then
            tvRP.playSound("SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterKeyMapping("keybindCancel","Cancelar animações","keyboard","f6")
RegisterKeyMapping("keybindHandsupp","Levantar as mãos","keyboard","x")
RegisterKeyMapping("keybindPoint","Apontar os dedos","keyboard","b")
RegisterKeyMapping("keybindEngine","Ligar veículo","keyboard","z")

RegisterKeyMapping("keybind f1","Animation Bind f1","keyboard","f1")
RegisterKeyMapping("keybind f2","Animation Bind f2","keyboard","f2")
RegisterKeyMapping("keybind f3","Animation Bind f3","keyboard","f3")
RegisterKeyMapping("keybind f5","Animation Bind f5","keyboard","f5")
RegisterKeyMapping("keybindCancel","Stop Animation","keyboard","f6")
RegisterKeyMapping("keybind f10","Animation Bind f10","keyboard","f10")

RegisterKeyMapping("keybind left","Bind Left","keyboard","left")
RegisterKeyMapping("keybind right","Bind Right","keyboard","right")
RegisterKeyMapping("keybind up","Bind Up","keyboard","up")
RegisterKeyMapping("keybind down","Bind Down","keyboard","down")

RegisterKeyMapping("keybindAccept","Aceitar chamado","keyboard","y")
RegisterKeyMapping("keybindReject","Rejeitar chamado","keyboard","u")
RegisterKeyMapping("keybindSelect","Enter","keyboard","return")
-----------------------------------------------------------------------------------------------------------------------------------------
-- POINT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		if apontar then
			timeDistance = 4
			local ped = PlayerPedId()
			local camPitch = GetGameplayCamRelativePitch()

			if camPitch < -70.0 then
				camPitch = -70.0
			elseif camPitch > 42.0 then
				camPitch = 42.0
			end
			camPitch = (camPitch + 70.0) / 112.0

			local camHeading = GetGameplayCamRelativeHeading()
			local cosCamHeading = Cos(camHeading)
			local sinCamHeading = Sin(camHeading)
			if camHeading < -180.0 then
				camHeading = -180.0
			elseif camHeading > 180.0 then
				camHeading = 180.0
			end
			camHeading = (camHeading + 180.0) / 360.0

			local blocked = 0
			local nn = 0
			local coords = GetOffsetFromEntityInWorldCoords(ped,(cosCamHeading*-0.2)-(sinCamHeading*(0.4*camHeading+0.3)),(sinCamHeading*-0.2)+(cosCamHeading*(0.4*camHeading+0.3)),0.6)
			local ray = Cast_3dRayPointToPoint(coords.x,coords.y,coords.z-0.2,coords.x,coords.y,coords.z+0.2,0.4,95,ped,7);
			nn,blocked,coords,coords = GetRaycastResult(ray)

			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Pitch",camPitch)
			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Heading",camHeading*-1.0+1.0)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isBlocked",blocked)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isFirstPerson",Citizen.InvokeNative(0xEE778F8C7E1142E2,Citizen.InvokeNative(0x19CAFA3C87F7C2FF))==4)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOLSTER
-----------------------------------------------------------------------------------------------------------------------------------------
local weapons = {
	"WEAPON_KNIFE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB",  
    "WEAPON_CROWBAR", "WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50",  
    "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_ASSAULTRIFLE",  
    "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_PUMPSHOTGUN",  
    "WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_BULLPUPSHOTGUN", "WEAPON_STUNGUN", "WEAPON_SNIPERRIFLE",  
    "WEAPON_HEAVYSNIPER", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_MINIGUN",  
    "WEAPON_GRENADE", "WEAPON_STICKYBOMB", "WEAPON_SMOKEGRENADE", "WEAPON_BZGAS", "WEAPON_MOLOTOV",  
    "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_FLARE", "WEAPON_SNSPISTOL", "WEAPON_SPECIALCARBINE",  
    "WEAPON_HEAVYPISTOL", "WEAPON_BULLPUPRIFLE", "WEAPON_HOMINGLAUNCHER", "WEAPON_PROXMINE", "WEAPON_SNOWBALL",  
    "WEAPON_VINTAGEPISTOL", "WEAPON_DAGGER", "WEAPON_FIREWORK", "WEAPON_MUSKET", "WEAPON_MARKSMANRIFLE",  
    "WEAPON_HEAVYSHOTGUN", "WEAPON_GUSENBERG", "WEAPON_HATCHET", "WEAPON_RAILGUN", "WEAPON_COMBATPDW",  
    "WEAPON_KNUCKLE", "WEAPON_MARKSMANPISTOL", "WEAPON_FLASHLIGHT", "WEAPON_MACHETE", "WEAPON_MACHINEPISTOL",  
    "WEAPON_SWITCHBLADE", "WEAPON_REVOLVER", "WEAPON_COMPACTRIFLE", "WEAPON_DBSHOTGUN", "WEAPON_FLAREGUN",  
    "WEAPON_AUTOSHOTGUN", "WEAPON_BATTLEAXE", "WEAPON_COMPACTLAUNCHER", "WEAPON_MINISMG", "WEAPON_PIPEBOMB",  
	"WEAPON_POOLCUE", "WEAPON_SWEEPER", "WEAPON_WRENCH", "WEAPON_PISTOL_MK2", "WEAPON_SNSPISTOL_MK2", 
	"WEAPON_REVOLVER_MK2", "WEAPON_SMG_MK2", "WEAPON_PUMPSHOTGUN_MK2", "WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE_MK2", "WEAPON_SPECIALCARBINE_MK2", "WEAPON_BULLPUPRIFLE_MK2", "WEAPON_COMBATMG_MK2",
	"WEAPON_HEAVYSNIPER_MK2", "WEAPON_MARKSMANRIFLE_MK2"
}

local holster = false
local holsterWeapon = nil
CreateThread(function()
	while true do
		local timeDistance = 200
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if GetEntityHealth(ped) > 101 and GetVehiclePedIsTryingToEnter(ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
				local checkWeapon,lastWeapon = CheckWeapon(ped)

				if lastWeapon ~= nil then
					holsterWeapon = lastWeapon
				end

				if checkWeapon then
					if not holster then
						timeDistance = 4

						if not IsEntityPlayingAnim(ped,"rcmjosh4","josh_leadout_cop2",3) then
							SetPedCurrentWeaponVisible(ped,0,0,1,1)
							loadAnimDict("rcmjosh4")
							TaskPlayAnim(ped,"rcmjosh4","josh_leadout_cop2",3.0,2.0,-1,48,10,0,0,0)
							Wait(200)
							SetPedCurrentWeaponVisible(ped, 1, 0, 1, 1)
							Wait(300)
							ClearPedTasks(ped)
						end
						holster = true
					end
				elseif not checkWeapon then
					if holster then
						timeDistance = 4

						if not IsEntityPlayingAnim(ped,"weapons@pistol@","aim_2_holster",3) then
							loadAnimDict("weapons@pistol@")
							SetCurrentPedWeapon(ped,GetHashKey(holsterWeapon),true)
							TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)
							Wait(450)
							SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
							ClearPedTasks(ped)
						end
						holster = false
					end
				end
			end
		end

		if GetEntityHealth(ped) <= 101 and holster then
			holster = false
			SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
		end

		Wait(timeDistance)
	end
end)

function CheckWeapon(ped)
	for i = 1,#weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true,weapons[i]
		end
	end
	return false,nil
end


function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(10)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCCLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncclean")
AddEventHandler("syncclean",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteped")
AddEventHandler("syncdeleteped",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToPed(index)
		if DoesEntityExist(v) then
			Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
			SetPedAsNoLongerNeeded(Citizen.PointerValueIntInitialized(v))
			DeletePed(v)
		end
	end
end)