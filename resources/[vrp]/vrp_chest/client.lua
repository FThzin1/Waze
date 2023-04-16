-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vSERVER = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestTimer = 0
local chestOpen = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	vSERVER.BauFechar(chestOpen)
	chestTimer = 5
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	if data.item == "test" or
    data.item == "wbody|WEAPON_STUNGUN" or
    data.item == "wbody|WEAPON_FLASHLIGHT" or
    data.item == "wbody|WEAPON_NIGHTSTICK" or
    data.item == "wbody|WEAPON_COMBATPISTOL" or
    data.item == "wbody|WEAPON_HEAVYPISTOL" or
    data.item == "wbody|WEAPON_COMBATPDW" or
    data.item == "wbody|WEAPON_CARBINERIFLE" or
    data.item == "wbody|WEAPON_CARBINERIFLE_MK2" or
    data.item == "wbody|WEAPON_SMG" or
    data.item == "wbody|WEAPON_PUMPSHOTGUN" or
    data.item == "wammo|WEAPON_COMBATPISTOL" or
    data.item == "wammo|WEAPON_HEAVYPISTOL" or
    data.item == "wammo|WEAPON_COMBATPDW" or
    data.item == "wammo|WEAPON_CARBINERIFLE" or
    data.item == "wammo|WEAPON_CARBINERIFLE_MK2" or
    data.item == "wammo|WEAPON_SMG" and
    data.item == "wammo|WEAPON_PUMPSHOTGUN" then
        TriggerEvent("Notify","negado","Você não pode retirar itens do arsenal policial.")
        return
    end
	if chestTimer <= 0 then
		chestTimer = 5
		TriggerEvent('cancelando', true)
		vRP.playAnim(false, {"amb@world_human_security_shine_torch@male@exit", "exit"}, false)
		vSERVER.takeItem(tostring(chestOpen),data.item,data.amount)
		Wait(1000)
		TriggerEvent('cancelando', false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	if data.item == "test" or
    data.item == "wbody|WEAPON_STUNGUN" or
    data.item == "wbody|WEAPON_FLASHLIGHT" or
    data.item == "wbody|WEAPON_NIGHTSTICK" or
    data.item == "wbody|WEAPON_COMBATPISTOL" or
    data.item == "wbody|WEAPON_HEAVYPISTOL" or
    data.item == "wbody|WEAPON_COMBATPDW" or
    data.item == "wbody|WEAPON_CARBINERIFLE" or
    data.item == "wbody|WEAPON_CARBINERIFLE_MK2" or
    data.item == "wbody|WEAPON_SMG" or
    data.item == "wbody|WEAPON_PUMPSHOTGUN" or
    data.item == "wammo|WEAPON_COMBATPISTOL" or
    data.item == "wammo|WEAPON_HEAVYPISTOL" or
    data.item == "wammo|WEAPON_COMBATPDW" or
    data.item == "wammo|WEAPON_CARBINERIFLE" or
    data.item == "wammo|WEAPON_CARBINERIFLE_MK2" or
    data.item == "wammo|WEAPON_SMG" and
    data.item == "wammo|WEAPON_PUMPSHOTGUN" then
        TriggerEvent("Notify","negado","Você não pode guardar itens do arsenal policial.")
        return
    end
	if chestTimer <= 0 then
		chestTimer = 5
		TriggerEvent('cancelando', true)
		vRP.playAnim(false,{"mp_common","givetake1_a"},false)
		vSERVER.storeItem(tostring(chestOpen),data.item,data.amount)
		Wait(1000)
		TriggerEvent('cancelando', false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateChest")
AddEventHandler("Creative:UpdateChest",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2 = vSERVER.openChest(tostring(chestOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	{ chest = "Staff", coords = vec3(978.06,69.73,116.17) },
	{ chest = "Scripted", coords = vec3(760.36,-1913.37,29.46) },
	{ chest = "PoliciaSul", coords = vec3(627.65,-24.26,82.78) },
    -- { chest = "PoliciaSul", coords = vec3(605.4,-1.07,82.7) },
    { chest = "Ballas", coords = vec3(125.17,-1946.33,20.76) },
    { chest = "Vagos", coords = vec3(371.83,-2041.09,22.2) },
    { chest = "Grove", coords = vec3(-150.66,-1625.29,36.85) },
    { chest = "Bratva", coords = vec3(563.57,-3127.45,18.77) },
    { chest = "Siciliana", coords = vec3(-1497.05,845.79,181.6) },
    { chest = "Bloods", coords = vec3(-1080.72,-1677.05,4.58) },
    { chest = "Crips", coords = vec3(1268.8,-1710.33,54.78) },
	{ chest = "Bennys", coords = vec3(-196.47,-1314.76,31.29) },
    { chest = "Bahamas", coords = vec3(-1386.32,-627.45,30.82) },
	{ chest = "LifeInvader", coords = vec3(-1062.82,-250.12,44.03) },
	{ chest = "HellAngels", coords = vec3(474.88,-1308.63,29.21) },
	{ chest = "Warlocks", coords = vec3(59.87,-2685.46,6.01) },
    { chest = "Hospital", coords = vec3(310.77,-599.77,43.3) },
	{ chest = "HospitalNorte", coords = vec3(1839.32,3689.75,34.28) },
	{ chest = "Mecanico", coords = vec3(948.15,-971.47,39.76) },
	{ chest = "Farmgroove", coords = vec3(102.24,6328.67,31.38) },
	{ chest = "Farmballas", coords = vec3(1505.25,6391.8,20.79) },
	{ chest = "Farmvagos",  coords = vec3(-1104.09,4953.45,218.65) },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if chestTimer > 0 then
			chestTimer = chestTimer - 1
		end
		Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chest",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local ped = PlayerPedId()
	
	if GetEntityHealth(ped) <= 101 then TriggerEvent('Notify', "negado", 'Você não pode fazer isso em coma.') return end
	if IsPedInAnyVehicle(ped, false) then TriggerEvent('Notify', "negado", 'Você não pode fazer isso em um veículo.') return end

	for i=1, #chest do
		local index = chest[i]
		local distance = #(GetEntityCoords(ped) - index.coords)
		if distance <= 2.0 and chestTimer <= 0 and vSERVER.checkIntPermissions(index.chest) then
			chestTimer = 5
			local start = math.random(1,1000)
			Wait(start)
			if vSERVER.ChecarBauAberto(chestOpen) ~= true then
				TriggerEvent('Notify',"sucesso",'Abrindo baú...')
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				chestOpen = index.chest
			else
				TriggerEvent('Notify', "negado", 'O baú já está sendo usado por outra pessoa.')
			end
		end
	end
end)


RegisterCommand('chestadm',function(source,args)
	if not args[1] then
		return 
	end

	if vSERVER.CheckAdm() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = 'showMenu' })
		chestOpen = args[1] 
	end
end)