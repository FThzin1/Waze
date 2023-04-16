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
Tunnel.bindInterface("vrp_policia",src)
vSERVER = Tunnel.getInterface("vrp_policia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENT P
-----------------------------------------------------------------------------------------------------------------------------------------
local waze = 0
RegisterCommand("callpm",function(source,args,rawCommand)
	if vSERVER.CheckPolice() then
		if waze <= 0 then
			waze = 10
			TriggerServerEvent("waze:1020Police")
		else
			TriggerEvent('Notify','importante','Aguarde <b>'..parseInt(waze)..'</b> segundos.')
		end
	end
end)

RegisterKeyMapping('callpm','QRR','keyboard','PAGEUP')
-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if waze > 0 then
			waze = waze - 1
		end
		Wait(1000)
	end
end)

CreateThread(function()
    while true do
       local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 then
            vSERVER.toogle2obito()
        end
		Wait(1000)
   end
end)

CreateThread(function()
    while true do
       local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 then
            vSERVER.toogle1obito()
        end
		Wait(1000)
   end
end)

RegisterNetEvent('desligarRadios')
AddEventHandler('desligarRadios',function()
	local i = 0
    while i < 1033 do
      if exports.tokovoip_script:isPlayerInChannel(i) == true then
		exports.tokovoip_script:removePlayerFromRadio(i)
	  end	
      i = i + 1
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkDistance(x2,y2,z2,radius)
	local ped = PlayerPedId()
	local distance = #(vec3(x2,y2,z2) - GetEntityCoords(ped))
	if distance <= radius then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- /RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rmascara")
AddEventHandler("rmascara",function()
	SetPedComponentVariation(PlayerPedId(),1,0,0,2)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rchapeu")
AddEventHandler("rchapeu",function()
	ClearPedProp(PlayerPedId(),0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET & REMOVE ALGEMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setalgemas")
AddEventHandler("setalgemas",function()
	local ped = PlayerPedId()
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,7,41,0,2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,7,25,0,2)
	end
end)
RegisterNetEvent("removealgemas")
AddEventHandler("removealgemas",function()
	SetPedComponentVariation(PlayerPedId(),7,0,0,2)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function src.CarregarDif(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end	
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
--------------------------------------------------------------------------------------------------------------------------------------------------
other = nil
drag = false
carregado = false
RegisterNetEvent("carregar")
AddEventHandler("carregar",function(p1)
    other = p1
    drag = not drag
end)

CreateThread(function()
    while true do
    	local timeDistance = 500
		if drag and other then
			timeDistance = 4
			local ped = GetPlayerPed(GetPlayerFromServerId(other))
			Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
			carregado = true
        else
        	if carregado then
				DetachEntity(PlayerPedId(),true,false)
				carregado = false
			end
		end
		Wait(timeDistance)
	end
end)


RegisterCommand('+carregar',function()
	TriggerServerEvent("vrp_policia:carregaradm")
end)

RegisterKeyMapping('+algemar', '[GASEOUS] ALGEMAR', 'keyboard', 'g')
RegisterKeyMapping('+carregar', '[GASEOUS] CARREGAR', 'keyboard', 'h')
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
local blacklistedWeapons = {
	 { weapon = "WEAPON_DAGGER" },
	 { weapon = "WEAPON_BAT" },
	 { weapon = "WEAPON_BOTTLE" },
	 { weapon = "WEAPON_CROWBAR" },
	 { weapon = "WEAPON_FLASHLIGHT" },
	 { weapon = "WEAPON_GOLFCLUB" },
	 { weapon = "WEAPON_HAMMER" },
	 { weapon = "WEAPON_HATCHET" },
	 { weapon = "WEAPON_KNUCKLE" },
	 { weapon = "WEAPON_KNIFE" },
	 { weapon = "WEAPON_MACHETE" },
	 { weapon = "WEAPON_SWITCHBLADE" },
	 { weapon = "WEAPON_NIGHTSTICK" },
	 { weapon = "WEAPON_WRENCH" },
	 { weapon = "WEAPON_BATTLEAXE" },
	 { weapon = "WEAPON_POOLCUE" },
	 { weapon = "WEAPON_STONE_HATCHET" },
	 { weapon = "WEAPON_STUNGUN" },
	 { weapon = "WEAPON_FLARE" },
	 { weapon = "GADGET_PARACHUTE" },
	 { weapon = "WEAPON_FIREEXTINGUISHER" },
	 { weapon = "WEAPON_PETROLCAN" },
	 { weapon = "WEAPON_RAYPISTOL" },
	 { weapon = "WEAPON_FIREWORK" },
	 { weapon = "WEAPON_BZGAS" },
	 { weapon = "WEAPON_MUSKET" }
}

CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedArmed(ped,6) then
			timeDistance = 4
			local blacklistweapon = false
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			local armaNaMao = GetSelectedPedWeapon(ped)

			for i=1, #blacklistedWeapons do
				local index = blacklistedWeapons[i]
				if armaNaMao == GetHashKey(index.weapon) then
					blacklistweapon = true
				end
			end

			if IsPedShooting(ped) and not blacklistweapon then
				TriggerServerEvent('atirando',x,y,z)
				--TriggerEvent('waze:Investigacao:Polvora',armaNaMao)
			end
		end
		blacklistweapon = false
		Wait(timeDistance)
	end
end)

-- RegisterNetEvent('waze:QuebrarArma')
-- AddEventHandler('waze:QuebrarArma', function(arma)
-- 	local hasharma = GetHashKey(arma)
-- 	RemoveWeaponFromPed(PlayerPedId(), hasharma)
-- end)

local blips = {}
RegisterNetEvent('notificacao')
AddEventHandler('notificacao',function(x,y,z,user_id)
	if not DoesBlipExist(blips[user_id]) then
		TriggerEvent("NotifyPush",{ code = 71, title = "Disparos de Arma", x = x, y = y, z = z })
		blips[user_id] = AddBlipForCoord(x,y,z)
		SetBlipScale(blips[user_id],0.5)
		SetBlipSprite(blips[user_id],10)
		SetBlipColour(blips[user_id],49)
		SetBlipDisplay(blips[user_id],8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Disparos de arma de fogo")
		EndTextCommandSetBlipName(blips[user_id])
		SetBlipAsShortRange(blips[user_id],false)
		SetTimeout(30000,function()
			if DoesBlipExist(blips[user_id]) then
				RemoveBlip(blips[user_id])
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
local prisioneiro = false

RegisterNetEvent('wazeprisioneiro')
AddEventHandler('wazeprisioneiro',function(status)
	prisioneiro = status
	local ped = PlayerPedId()
	if prisioneiro then
		TriggerEvent('waze:ExcecaoGod', true)
		SetEntityInvincible(ped,false) --MQCU
		FreezeEntityPosition(ped,true)
		SetEntityVisible(ped,false,false)
		SetTimeout(10000,function()
			TriggerEvent('waze:ExcecaoGod', false)
			SetEntityInvincible(ped,false)
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true,false)
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON : THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(5000)
        if prisioneiro then
            local distance = #(GetEntityCoords(PlayerPedId()) - vec3(1700.5,2605.2,45.5))
            if distance >= 150 then
                SetEntityCoords(PlayerPedId(),1680.1,2513.0,46.5)
                TriggerEvent('Notify','negado','Não tente sair da área da penitenciaria.')
            end 
        end 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.putVehicle(seat)
	local veh = vRP.getNearestVehicle(11)
	if IsEntityAVehicle(veh) then
		if parseInt(seat) <= 1 or seat == nil then
			seat = -1
		elseif parseInt(seat) == 2 then
			seat = 0
		elseif parseInt(seat) == 3 then
			seat = 1
		elseif parseInt(seat) == 4 then
			seat = 2
		elseif parseInt(seat) == 5 then
			seat = 3
		elseif parseInt(seat) == 6 then
			seat = 4
		elseif parseInt(seat) == 7 then
			seat = 5
		elseif parseInt(seat) >= 8 then
			seat = 6
		end

		local ped = PlayerPedId()
		if IsVehicleSeatFree(veh,seat) then
			ClearPedTasks(ped)
			ClearPedSecondaryTask(ped)
			SetPedIntoVehicle(ped,veh,seat)
		end
	end
end
-- local denunciado = false
-- CreateThread(function() 
--     while true do
--         Wait(5000)
--         local ped = PlayerPedId()
--         if IsPedArmed(ped, 6) and GetSelectedPedWeapon(ped) ~= GetHashKey('WEAPON_STUNGUN') then
--             local chance = math.random(100)
--             if chance <= 6 then
--                 local pedX, pedY, pedZ = table.unpack(GetEntityCoords(ped))
--                 temx9, x9 = GetClosestPed(pedX, pedY, pedZ, 50.0, 1, 0, 0, 0, 26)
--                 if temx9 and not IsPedInAnyVehicle(ped) and not src.ehPolicial() and not denunciado then
--                     denunciado = true
--                     loaddict("cellphone@")
--                     TaskPlayAnim(x9,"cellphone@","cellphone_call_in",3.0,3.0,-1,50,0,0,0,0)

--                     local coords = GetOffsetFromEntityInWorldCoords(x9,0.0,0.0,-5.0)
--                     object = CreateObject(GetHashKey("prop_amb_phone"),coords.x,coords.y,coords.z,true,true,true)
--                     SetEntityCollision(object,false,false)
--                     AttachEntityToEntity(object,x9,GetPedBoneIndex(x9,28422),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)

--                     Wait(5000)
--                     if not IsPedDeadOrDying(x9, false) then
--                         ClearPedTasks(x9)
--                         -- DeleteObject(object)
--                         TriggerServerEvent('waze:EstaArmado',pedX, pedY, pedZ)
--                         -- TriggerEvent('Notify', "importante", 'Um civil te viu armado e te denunciou para a polícia.')
--                     end

--                     denunciado = false
--                 end
--             end
--         end
--     end
-- end)

-- local blipsDen = {}
-- RegisterNetEvent('waze:NotificarArmado')
-- AddEventHandler('waze:NotificarArmado',function(x,y,z,user_id)
--     if not DoesBlipExist(blipsDen[user_id]) then
--         PlaySoundFrontend(-1,"Enter_1st","GTAO_FM_Events_Soundset",false)
--         TriggerEvent('chatMessage',"911",{64,64,255},"Denúncia de indivíduo armado nesta localização.")
--         blipsDen[user_id] = AddBlipForCoord(x,y,z)
--         SetBlipScale(blipsDen[user_id],0.7)
--         SetBlipSprite(blipsDen[user_id],162)
--         SetBlipColour(blipsDen[user_id],49)
--         BeginTextCommandSetBlipName("STRING")
--         AddTextComponentString("Denúncia de porte ilegal de armas")
--         EndTextCommandSetBlipName(blipsDen[user_id])
--         SetBlipAsShortRange(blipsDen[user_id],false)
--         SetTimeout(30000,function()
--             if DoesBlipExist(blipsDen[user_id]) then
--                 RemoveBlip(blipsDen[user_id])
--             end
--         end)
--     end
-- end)

--[[ function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end ]]