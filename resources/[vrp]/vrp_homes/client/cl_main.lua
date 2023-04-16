-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_homes",src)
vSERVER = Tunnel.getInterface("vrp_homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local houseOpen = ""
local houseTimer = 0
local homesList = {}
local homeObjects = {}
local houseNetwork = {}
local internHouses = {}
local adminChest = false
local insert_houses = function(value)
	local length = #internHouses
	internHouses[length + 1] = value
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	TriggerEvent("vrp_sound:source",'zipperclose',0.2)
	if adminChest then
		houseOpen = ""
		adminChest = false
		homesList = {}
		homeObjects = {}
		houseNetwork = {}
		internHouses = {}
	end
	vSERVER.chestClose()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	houseTimer = 5
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
	if houseTimer <= 0 then
		houseTimer = 5
		TriggerEvent("cancelando",true)
		vRP.playAnim(false,{"amb@world_human_security_shine_torch@male@exit","exit"},false)
		vSERVER.takeItem(tostring(houseOpen),data.item,data.amount)
		Wait(1000)
		TriggerEvent("cancelando",false)
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
	if houseTimer <= 0 then
		houseTimer = 5
		TriggerEvent("cancelando",true)
		vRP.playAnim(false,{"mp_common","givetake1_a"},false)
		vSERVER.storeItem(tostring(houseOpen),data.item,data.amount)
		Wait(1000)
		TriggerEvent("cancelando",false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_HOMES:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_homes:Update")
AddEventHandler("vrp_homes:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTVAULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestVault",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2 = vSERVER.openChest(tostring(houseOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("trancar",function(source,args)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(homesList) do
		local distance = #(coords - vector3(v[5],v[6],v[7]))
		if distance <= 1.5 then
			vSERVER.tryUnlock(k)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("enter",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(homesList) do
		local distance = #(coords - vector3(v[5],v[6],v[7]))
		if distance <= 1.1 and vSERVER.checkPermissions(k) then
			removeObjectHomes()
			print(tostring(k))
			vRP.giveWeapons({["GADGET_PARACHUTE"] = { ammo = 1000 }})
			DoScreenFadeOut(1000)
			houseOpen = tostring(k)
			vSERVER.setNetwork(tostring(k))
			vSERVER.applyHouseOpen(tostring(k))
			TriggerEvent("vrp_sound:source","enterexithouse",0.7)
			Wait(900)

			if v[1] == "Hotel" then
				createHotel(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Middle" then
				createMiddle(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Beach" then
				createBeach(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Trailer" then
				createTrailer(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Motel" then
				createMotel(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Mansion" then
				createMansion(ped,v[5],v[6],1499.0)
			end
			
			Wait(1000)

			if v[1] == "Motel" then
				SetEntityCoords(ped,v[5]+4.6,v[6]-6.36,1498.5)
				insert_houses({ v[5]+4.6,v[6]-6.36,1498.5,"exit","SAIR" })
				insert_houses({ v[5]+5.08,v[6]+2.05,1500.3,"vault","ABRIR" })
			end

			if v[1] == "Hotel" then
				SetEntityCoords(ped,v[5]-1.69,v[6]-3.91,1500.0)
				insert_houses({ v[5]-1.69,v[6]-3.91,1499.8,"exit","SAIR" })
				insert_houses({ v[5]-2.25,v[6]+0.95,1499.4,"vault","ABRIR" })
			end

			if v[1] == "Middle" then
				SetEntityCoords(ped,v[5]+1.36,v[6]-14.23,1500.0)
				insert_houses({ v[5]+1.36,v[6]-14.23,1499.5,"exit","SAIR" })
				insert_houses({ v[5]+7.15,v[6]-1.00,1499.0,"vault","ABRIR" })
			end

			if v[1] == "Trailer" then
				SetEntityCoords(ped,v[5]-1.44,v[6]-2.02,1500.0)
				insert_houses({ v[5]-1.44,v[6]-2.02,1499.5,"exit","SAIR" })
				insert_houses({ v[5]-4.36,v[6]-1.97,1499.2,"vault","ABRIR" })
			end

			if v[1] == "Beach" then
				SetEntityCoords(ped,v[5] + 0.11,v[6] - 3.68,1500.0 - 1,1,0,0,0)
				insert_houses({ v[5] + 0.11,v[6] - 3.68,1499.5,"exit","SAIR" })
				insert_houses({ v[5] + 8.36,v[6] - 3.60,1499.8,"vault","ABRIR" })
			end

			if v[1] == "Mansion" then
				SetEntityCoords(ped,v[5]-8.68,v[6]-3.43,1501.0)
				insert_houses({ v[5]-8.68,v[6]-3.43,1501.0,"exit","SAIR" })
				insert_houses({ v[5]-3.97,v[6]-13.58,1500.5,"vault","ABRIR" })
			end

			FreezeEntityPosition(ped,true)
			SetEntityInvincible(ped,true)
			Wait(3000)
			FreezeEntityPosition(ped,false)
			SetEntityInvincible(ped,false)
			DoScreenFadeIn(1000)
		end
	end
end)

RegisterCommand("enteradm",function(source,args)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(homesList) do
		local distance = #(coords - vector3(v[5],v[6],v[7]))
		if distance <= 1.1 and vSERVER.CheckAdm() then
			removeObjectHomes()
			print(tostring(k))
			DoScreenFadeOut(1000)
			houseOpen = tostring(k)
			vSERVER.setNetwork(tostring(k))
			vSERVER.applyHouseOpen(tostring(k))
			TriggerEvent("vrp_sound:source","enterexithouse",0.7)
			Wait(900)

			if v[1] == "Motel" then
				createMotel(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Hotel" then
				createHotel(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Middle" then
				createMiddle(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Beach" then
				createBeach(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Trailer" then
				createTrailer(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Mansion" then
				createMansion(ped,v[5],v[6],1499.0)
			end
			
			Wait(1000)

			if v[1] == "Motel" then
				SetEntityCoords(ped,v[5]+4.6,v[6]-6.36,1498.5)
				insert_houses({ v[5]+4.6,v[6]-6.36,1498.5,"exit","SAIR" })
				insert_houses({ v[5]+5.08,v[6]+2.05,1500.3,"vault","ABRIR" })
			end

			if v[1] == "Hotel" then
				SetEntityCoords(ped,v[5]-1.69,v[6]-3.91,1500.0)
				insert_houses({ v[5]-1.69,v[6]-3.91,1499.8,"exit","SAIR" })
				insert_houses({ v[5]-2.25,v[6]+ 0.95,1499.4,"vault","ABRIR" })
			end

			if v[1] == "Middle" then
				SetEntityCoords(ped,v[5]+1.36,v[6]-14.23,1500.0)
				insert_houses({ v[5]+1.36,v[6]-14.23,1499.5,"exit","SAIR" })
				insert_houses({ v[5]+7.15,v[6]-1.00,1499.0,"vault","ABRIR" })
			end

			if v[1] == "Trailer" then
				SetEntityCoords(ped,v[5]-1.44,v[6]-2.02,1500.0)
				insert_houses({ v[5]-1.44,v[6]-2.02,1499.5,"exit","SAIR" })
				insert_houses({ v[5]-4.36,v[6]-1.97,1499.2,"vault","ABRIR" })
			end

			if v[1] == "Beach" then
				SetEntityCoords(ped,v[5] + 0.11,v[6] - 3.68,1500.0 - 1,1,0,0,0)
				insert_houses({ v[5] + 0.11,v[6] - 3.68,1499.5,"exit","SAIR" })
				insert_houses({ v[5] + 8.36,v[6] - 3.60,1499.8,"vault","ABRIR" })
			end

			if v[1] == "Mansion" then
				SetEntityCoords(ped,v[5]-8.68,v[6]-3.43,1501.0)
				insert_houses({ v[5]-8.68,v[6]-3.43,1501.0,"exit","SAIR" })
				insert_houses({ v[5]-3.97,v[6]-13.58,1500.5,"vault","ABRIR" })
			end

			FreezeEntityPosition(ped,true)
			SetEntityInvincible(ped,true)
			Wait(3000)
			FreezeEntityPosition(ped,false)
			SetEntityInvincible(ped,false)
			DoScreenFadeIn(1000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVADE
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ RegisterCommand("invadir",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(homesList) do
		local distance = #(coords - vector3(v[5],v[6],v[7]))
		if distance <= 1.1 and vSERVER.CheckPolice(k) then
			removeObjectHomes()
			print(tostring(k))
			vRP.giveWeapons({["GADGET_PARACHUTE"] = { ammo = 1000 }})
			DoScreenFadeOut(1000)
			houseOpen = tostring(k)
			vSERVER.setNetwork(tostring(k))
			vSERVER.applyHouseOpen(tostring(k))
			TriggerEvent("vrp_sound:source","enterexithouse",0.7)
			Wait(900)

			if v[1] == "Motel" then
				createMotel(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Hotel" then
				createHotel(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Middle" then
				createMiddle(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Trailer" then
				createTrailer(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Beach" then
				createBeach(ped,v[5],v[6],1500.0)
			end

			if v[1] == "Mansion" then
				createMansion(ped,v[5],v[6],1499.0)
			end
			
			Wait(1000)

			if v[1] == "Motel" then
				SetEntityCoords(ped,v[5]+4.6,v[6]-6.36,1498.5)
				insert_houses({ v[5]+4.6,v[6]-6.36,1498.5,"exit","SAIR" })
				insert_houses({ v[5]+5.08,v[6]+2.05,1500.3,"vault","ABRIR" })
			end

			if v[1] == "Hotel" then
				SetEntityCoords(ped,v[5]-1.69,v[6]-3.91,1500.0)
				insert_houses({ v[5]-1.69,v[6]-3.91,1499.8,"exit","SAIR" })
				insert_houses({ v[5]-2.25,v[6]+0.95,1499.4,"vault","ABRIR" })
			end

			if v[1] == "Middle" then
				SetEntityCoords(ped,v[5]+1.36,v[6]-14.23,1500.0)
				insert_houses({ v[5]+1.36,v[6]-14.23,1499.5,"exit","SAIR" })
				insert_houses({ v[5]+7.15,v[6]-1.00,1499.0,"vault","ABRIR" })
			end

			if v[1] == "Beach" then
				SetEntityCoords(ped,v[5] + 0.11,v[6] - 3.68,1500.0 - 1,1,0,0,0)
				insert_houses({ v[5] + 0.11,v[6] - 3.68,1499.5,"exit","SAIR" })
				insert_houses({ v[5] + 8.36,v[6] - 3.60,1499.8,"vault","ABRIR" })
			end

			if v[1] == "Trailer" then
				SetEntityCoords(ped,v[5]-1.44,v[6]-2.02,1500.0)
				insert_houses({ v[5]-1.44,v[6]-2.02,1499.5,"exit","SAIR" })
				insert_houses({ v[5]-4.36,v[6]-1.97,1499.2,"vault","ABRIR" })
			end

			if v[1] == "Mansion" then
				SetEntityCoords(ped,v[5]-8.68,v[6]-3.43,1501.0)
				insert_houses({ v[5]-8.68,v[6]-3.43,1501.0,"exit","SAIR" })
				insert_houses({ v[5]-3.97,v[6]-13.58,1500.5,"vault","ABRIR" })
			end

			FreezeEntityPosition(ped,true)
			SetEntityInvincible(ped,true)
			Wait(3000)
			FreezeEntityPosition(ped,false)
			SetEntityInvincible(ped,false)
			DoScreenFadeIn(1000)
		end
	end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADNETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if houseOpen ~= "" and not adminChest then
			for k,v in ipairs(GetActivePlayers()) do
				if PlayerId() ~= v and houseNetwork[GetPlayerServerId(v)] == nil then
					NetworkFadeOutEntity(GetPlayerPed(v),true)
				end
			end
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADUPDATENETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if houseOpen ~= "" and not adminChest then
			houseNetwork = vSERVER.getNetwork(tostring(houseOpen))
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHOMESTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getHomeStatistics()
	return tostring(houseOpen)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANUPHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.cleanupHomes()
	houseOpen = ""
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHOMESTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getHomesRejoin()
	if houseOpen ~= "" and not adminChest then
		vSERVER.removeNetwork(tostring(houseOpen))
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateHomes(status)
	homesList = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASAS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local casas = false
RegisterNetEvent("homes:togglePropertys")
AddEventHandler("homes:togglePropertys",function(_ownedHomes)
    casas = not casas

    if casas then
        TriggerEvent('Notify', 'sucesso', 'Adicionado a marcação das residências.',3000)

        local ownedHomes = {}
        for _, w in pairs(_ownedHomes) do; ownedHomes[w.home] = true; end; 

        for k,v in pairs(homesList) do
            if not ownedHomes[k] then
                blips[k] = AddBlipForCoord(v[5],v[6],v[7])

                SetBlipSprite(blips[k],411)
                SetBlipScale(blips[k],0.4)
				SetBlipAsShortRange(blips[k],true)

                SetBlipAlpha(blips[k],255)
                SetBlipColour(blips[k],81)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('<FONT color="#ff9933">Residência | <FONT color="#ffffff">' .. k)
                EndTextCommandSetBlipName(blips[k])
            end
        end
    else
        TriggerEvent('Notify', 'sucesso', 'Removido a marcação das residências.',3000)
        for k,v in pairs(blips) do
            if DoesBlipExist(v) then
                RemoveBlip(v)
            end
        end
        blips = {}
    end
end)

function src.setBlipsOwner(x,y,z,homeName)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,411)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,53)
	SetBlipScale(blip,0.4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Sua Casa: "..homeName)
	EndTextCommandSetBlipName(blip)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOUSETIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(1000)
		if houseTimer > 0 then
			houseTimer = houseTimer - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE HOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function createMansion(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_mansion"),x,y,z,false,false,false)
	FreezeEntityPosition(homeObjects[1],true)
end

function createMotel(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_motel"),x,y,z,false,false,false)
	FreezeEntityPosition(homeObjects[1],true)
end

function createBeach(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_beach"),x,y,z,false,false,false)
	FreezeEntityPosition(homeObjects[1],true)
end

function createMiddle(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_middle"),x,y,z,false,false,false)
	FreezeEntityPosition(homeObjects[1],true)
end

function createTrailer(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_trailer"),x,y,z,false,false,false)
	FreezeEntityPosition(homeObjects[1],true)
end

function createHotel(ped,x,y,z)
	homeObjects[1] = CreateObjectNoOffset(GetHashKey("creative_hotel"),x,y,z,false,false,false)
	FreezeEntityPosition(homeObjects[1],true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEOBJECTHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function removeObjectHomes()
	if homeObjects ~= nil then
		for k,v in pairs(homeObjects) do
			SetEntityAsMissionEntity(homeObjects[k],false,false)
			DeleteEntity(homeObjects[k])
			homeObjects[k] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wazehomes+controls", function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and houseOpen ~= "" and not adminChest then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(internHouses) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.5 then
					timeDistance = 1
					if IsControlJustPressed(1,38) then
						if v[4] == "exit" then
							vSERVER.removeNetwork(tostring(houseOpen))
							print(tostring(houseOpen))
							TriggerEvent("vrp_sound:source","enterexithouse",0.5)
							DoScreenFadeOut(1000)
							Wait(1000)

							SetEntityCoords(ped,homesList[houseOpen][5],homesList[houseOpen][6],homesList[houseOpen][7]+0.1)
							FreezeEntityPosition(ped,true)

							Wait(3000)
							FreezeEntityPosition(ped,false)
							removeObjectHomes()
							DoScreenFadeIn(1000)
							vSERVER.removeHouseOpen()
							internHouses = {}
							houseOpen = ""
						elseif v[4] == "vault" then
							if vSERVER.checkIntPermissions(tostring(houseOpen)) then
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "showMenu" })
								TriggerEvent("vrp_sound:source","zipper",0.2)
							end
						end
					end
				end
			end
		end
		Wait(timeDistance)
	end
end)
RegisterKeyMapping("wazehomes+controls", "Uso da casa", "keyboard", "E")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN : VAULTADM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.InitVaultAdm(homeOpened)
	adminChest = true
	houseOpen = tostring(homeOpened)
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showMenu" })
	TriggerEvent("vrp_sound:source","zipper",0.2)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN CASA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:Login:SpawnarEmCasa')
AddEventHandler('waze:Login:SpawnarEmCasa', function(houseOpen)
	vRP.teleport(homesList[houseOpen][5],homesList[houseOpen][6],homesList[houseOpen][7])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH HOMES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:CasaRastrear')
AddEventHandler('waze:CasaRastrear', function(houseOpen)
	if houseOpen then
		if homesList[houseOpen] then
			TriggerEvent('Notify','sucesso','Casa encontrada. Foi informado em seu GPS a localização dela, em 1 minuto será removida.')
			local blimp = AddBlipForCoord(homesList[houseOpen][5],homesList[houseOpen][6],homesList[houseOpen][7])
			SetBlipSprite(blimp,411)
			SetBlipAsShortRange(blimp,false)
			SetBlipColour(blimp,3)
			SetBlipScale(blimp,0.4)
			SetBlipRoute(blimp,true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Casa encontrada: ~g~"..houseOpen)
			EndTextCommandSetBlipName(blimp)
			SetTimeout(60000, function()
				RemoveBlip(blimp)
				TriggerEvent('Notify','sucesso','Marcação removida.')
			end)
		else
			TriggerEvent('Notify','negado','Essa casa não existe!')
		end
	end
end)