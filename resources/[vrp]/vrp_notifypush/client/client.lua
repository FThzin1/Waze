-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-----------------------------------------------------------------------------------------------------------------------------------------
local src = {}
Tunnel.bindInterface("vrp_notifypush",src)
vSERVER = Tunnel.getInterface("vrp_notifypush")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local showBlips = {}
local timeBlips = {}
local numberBlips = 0
local notifyPolice = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("notifysound",function(source,args)
	notifyPolice = not notifyPolice
	if notifyPolice then
		TriggerEvent("Notify","aviso","Você ativou o <b>som</b> das notificações policiais.",5000)
	else
		TriggerEvent("Notify","aviso","Você desativou o <b>som</b> das notificações policiais.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("notify",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		SetCurrentPedWeapon(ped,"WEAPON_UNARMED",true)
		if vSERVER.checkPolice() then
		SendNUIMessage({ action = "showAll" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("notify","Abrir as notificações","keyboard","f1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(data)
	data["street"] = GetStreetNameFromHashKey(GetStreetNameAtCoord(data["x"],data["y"],data["z"]))

	SendNUIMessage({ action = "notify", data = data })

	numberBlips = numberBlips + 1

	timeBlips[numberBlips] = 60
	showBlips[numberBlips] = AddBlipForRadius(data["x"],data["y"],data["z"])
	SetBlipColour(showBlips[numberBlips],data["blipColor"])
	SetBlipAlpha(showBlips[numberBlips],304)

	if notifyPolice then
		if parseInt(data.code) == 71 then
			PlaySoundFrontend(-1,"Enter_Area","DLC_Lowrider_Relay_Race_Sounds")
		elseif parseInt(data.code) == 10 then
			PlaySoundFrontend(-1,"Lose_1st","GTAO_FM_Events_Soundset",false)
		elseif parseInt(data.code) == 32 then
			PlaySoundFrontend(-1,"CHALLENGE_UNLOCKED","HUD_AWARDS",false)
		elseif parseInt(data.code) == 38 then
			PlaySoundFrontend(-1,"Beep_Red","DLC_HEIST_HACKING_SNAKE_SOUNDS",false)
		elseif parseInt(data.code) == 50 then
			PlaySoundFrontend(-1,"OOB_Cancel","GTAO_FM_Events_Soundset",false)
		elseif parseInt(data.code) == 72 then
			PlaySoundFrontend(-1,"MP_IDLE_TIMER","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
		else
			PlaySoundFrontend(-1,"Event_Message_Purple","GTAO_FM_Events_Soundset",false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k,v in pairs(timeBlips) do
			if timeBlips[k] > 0 then
				timeBlips[k] = timeBlips[k] - 1

				if timeBlips[k] <= 0 then
					RemoveBlip(showBlips[k])
					showBlips[k] = nil
					timeBlips[k] = nil
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOn",function()
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOff",function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setWay",function(data)
	SetNewWaypoint(data["x"] + 0.0001,data["y"] + 0.0001)
	SendNUIMessage({ action = "hideAll" })
end)

RegisterCommand("xd",function(source,args)
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	TriggerEvent('NotifyPush',{ code = 31, title = "Roubo a(o) XD", x = x, y = y, z = z })
end)