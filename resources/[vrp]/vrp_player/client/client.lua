-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
client = {}
Tunnel.bindInterface("vrp_player",client)
vSERVER = Tunnel.getInterface("vrp_player")
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- TIMER GARMAS
-- -----------------------------------------------------------------------------------------------------------------------------------------
local statusGarmas = false
local delayGarmas = 60
--local delayTratas = 0 
local delayReboque = 0
RegisterNetEvent("waze:GerarDelayGarmas")
AddEventHandler("waze:GerarDelayGarmas",function()
	statusGarmas = true
end)

CreateThread(function()
	while true do
		Wait(1000)
		if statusGarmas then
			if delayGarmas > 0 then
				delayGarmas = delayGarmas - 1
			else
				statusGarmas = false
				TriggerServerEvent('waze:ZerarStatusGarmas')
				delayGarmas = 60
			end
		end

		--if delayTratas > 0 then delayTratas = delayTratas - 1 end
		if delayReboque > 0 then delayReboque = delayReboque - 1 end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAÇÃO DE TRATAS
-----------------------------------------------------------------------------------------------------------------------------------------

--function client.PodeReceberTratas()
--	if delayTratas == 0 then return true end return false
--end
--
--function client.SetDelayTratas(delay)
--	delayTratas = parseInt(delay)
--end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAÇÃO DE ANIMAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function client.FazendoAnim(animDict, animName)
	local ped = PlayerPedId()
	local PlayingAnim = IsEntityPlayingAnim(ped, animDict, animName, 3)	 
	return PlayingAnim
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(30*60000)
		vSERVER.WekakdjinWKKkdeinIAIASAO()
	end
end)

--[[ CreateThread(function()
	while true do
		Wait(60*60000)
		vSERVER.WekakdjinWKKkdeinIAIASAOXmas()
	end
end) ]]
----------------------------------------------------------------------------------------------------------------------------------------
-- /VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vtuning",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify",'importante',"<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Chassi:</b> "..parseInt(body/10).."%<br><b>Engine:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",15000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("SyncDoorsEveryone")
AddEventHandler("SyncDoorsEveryone",function(veh,doors)
	SetVehicleDoorsLocked(veh,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	if vSERVER.CheckVip('ambos') or vSERVER.PossuiCompArma() or vSERVER.CheckBooster() then
		if not args[1] then
			TriggerEvent('Notify', "aviso", 'Você deve especificar o componente que deseja equipar.<br><br>/attachs <componente>. Componentes:<br>- <b>lan</b> (lanterna)<br>- <b>mira</b> (mira)<br>- <b>emp</b> (empunhadura)<br>- <b>todos</b> (Todos os acima)')
		else
			local NomeComp = string.lower(args[1])
			local arma = GetSelectedPedWeapon(ped)
			if NomeComp == 'lan' then
				if arma == GetHashKey("WEAPON_PISTOL_MK2") then
					GiveWeaponComponentToPed(ped, arma,GetHashKey("COMPONENT_AT_PI_FLSH_02"))
					TriggerEvent('Notify', "sucesso", '<b>Lanterna</b> equipada.')
				elseif arma == GetHashKey("WEAPON_HEAVYPISTOL") or arma == GetHashKey("WEAPON_COMBATPISTOL") then
					GiveWeaponComponentToPed(ped, arma,GetHashKey("COMPONENT_AT_PI_FLSH"))
					TriggerEvent('Notify', "sucesso", '<b>Lanterna</b> equipada.')
				elseif arma == GetHashKey("WEAPON_SMG_MK2") 
					or arma == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") 
					or arma == GetHashKey("WEAPON_CARBINERIFLE") 
					or arma == GetHashKey("WEAPON_SMG") 
					or arma == GetHashKey("WEAPON_PUMPSHOTGUN") 
					or arma == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
						GiveWeaponComponentToPed(ped, arma, GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerEvent('Notify', "sucesso", '<b>Lanterna</b> equipada.')
				end
			elseif NomeComp == 'mira' then
				if arma == GetHashKey("WEAPON_PISTOL_MK2") then
					GiveWeaponComponentToPed(ped, arma,GetHashKey("COMPONENT_AT_PI_RAIL"))
					TriggerEvent('Notify', "sucesso", '<b>Mira</b> equipada.')
				elseif arma == GetHashKey("WEAPON_SMG_MK2") then
					GiveWeaponComponentToPed(ped, arma, GetHashKey("COMPONENT_AT_SCOPE_SMALL_SMG_MK2"))
					TriggerEvent('Notify', "sucesso", '<b>Mira</b> equipada.')
				elseif arma == GetHashKey("WEAPON_SMG") then
					GiveWeaponComponentToPed(ped, arma, GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
					TriggerEvent('Notify', "sucesso", '<b>Mira</b> equipada.')
				elseif arma == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") or arma == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
					GiveWeaponComponentToPed(ped, arma, GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
					TriggerEvent('Notify', "sucesso", '<b>Mira</b> equipada.')
				elseif arma == GetHashKey("WEAPON_CARBINERIFLE") then
					GiveWeaponComponentToPed(ped, arma, GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
					TriggerEvent('Notify', "sucesso", '<b>Mira</b> equipada.')
				end
			-- elseif NomeComp == 'sup' then
			-- 	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
			-- 		GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			-- 		TriggerEvent('Notify', "sucesso", '<b>Silenciador</b> equipado.')
			-- 	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
			-- 		GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_SUPP"))
			-- 		TriggerEvent('Notify', "sucesso", '<b>Silenciador</b> equipado.')
			-- 	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
			-- 		GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP"))
			-- 		TriggerEvent('Notify', "sucesso", '<b>Silenciador</b> equipado.')
			-- 	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
			-- 		GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP_02"))
			-- 		TriggerEvent('Notify', "sucesso", '<b>Silenciador</b> equipado.')
			-- 	end
			elseif NomeComp == 'emp' then
				if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") or GetSelectedPedWeapon(ped) == GetHashKey("weapon_specialcarbine_mk2") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
					TriggerEvent('Notify', "sucesso", '<b>Empunhadura</b> equipada.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerEvent('Notify', "sucesso", '<b>Empunhadura</b> equipada.')
				end
			elseif NomeComp == 'todos' then
				if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_RAIL"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_FLSH_02"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_COMP"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
					-- GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_SMALL_SMG_MK2"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("weapon_combatpdw") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SR_SUPP"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MILITARYRIFLE") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_MILITARYRIFLE_CLIP_02"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_MILITARYRIFLE_SIGHT_01"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_SUPP"))
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") or GetSelectedPedWeapon(ped) == GetHashKey("weapon_specialcarbine_mk2") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SIGHTS"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_06"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_02"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_SUPP_02"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_03"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_BARREL_02"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_04"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("weapon_snspistol_mk2") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_SUPP_02"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SNSPISTOL_MK2_CLIP_02"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_AR_FLSH"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_07"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_MUZZLE_04"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("weapon_heavysniper_mk2") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CLIP_ARMORPIERCING"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_MAX"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_NV"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SCOPE_THERMAL"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_SR_SUPP_03"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_AT_PI_FLSH"))
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
					TriggerEvent('Notify', "sucesso", '<b>TODOS</b> os componentes equipados.')
				end
			end
		end
	else
		TriggerEvent('Notify', "negado", 'Você não possui um kit de componentes.<br><br>OBS: Membros <b>waze Elite</b> não necessitam deste item para usar o comando.')
	end
end)

RegisterNetEvent('waze:attachs2')
AddEventHandler('waze:attachs2', function()
	local ped = PlayerPedId()
	local arma = GetSelectedPedWeapon(ped)
	if arma == GetHashKey('WEAPON_CARBINERIFLE_MK2') then
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_AFGRIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_SCOPE_MEDIUM_MK2'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_SUPP'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_FLSH'))
	elseif arma == GetHashKey('WEAPON_ASSAULTRIFLE_MK2') then
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_ASSAULTRIFLE_MK2_CLIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_AFGRIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_FLSH'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_SIGHTS'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
	elseif arma == GetHashKey('WEAPON_PISTOL_MK2') then
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_PISTOL_MK2_CLIP_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_PISTOL_MK2_CLIP_HOLLOWPOINT'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_PI_RAIL'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_PI_FLSH_02'))
		GiveWeaponComponentToPed(ped, arma, GetHashKey('COMPONENT_AT_PI_SUPP_02'))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIGAR TURBAO
-----------------------------------------------------------------------------------------------------------------------------------------
local turbao = false
local qtdturbao = 150.0
RegisterNetEvent('waze:LigarTurbao')
AddEventHandler('waze:LigarTurbao', function(qtd)
	if qtd then qtdturbao = qtd end
	local ped = PlayerPedId()
	turbao = not turbao
	print('TURBAO', turbao)
end)

CreateThread(function() 
	while true do
		local timeDistance = 1000
		if turbao then
			local ped = PlayerPedId()
			local veh = GetVehiclePedIsIn(ped, false)
			if veh then
				timeDistance = 4
				if IsControlJustPressed(0,10) then
					SetVehicleEnginePowerMultiplier(veh, qtdturbao)
					SetVehicleEngineTorqueMultiplier(veh, qtdturbao)
					TriggerEvent('chatMessage', 'TURBAO', {0,150,0}, 'LIGADO ' .. qtdturbao .. 'Kg')
				end
				if IsControlJustPressed(0,11) then
					SetVehicleEnginePowerMultiplier(veh, 1.0)
					SetVehicleEngineTorqueMultiplier(veh, 1.0)
					TriggerEvent('chatMessage', 'TURBAO', {150,0,0}, 'DESLIGADO')
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE TIMER
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ CreateThread(function()
    Wait(1000)
    local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 then
        source = source
        TriggerServerEvent('PoliceTimer', source)
    end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- CR
-----------------------------------------------------------------------------------------------------------------------------------------
local cruising = false
local valorCruising = 320
RegisterCommand('cr',function(source,args)
	if not exports["chat"]:statusChat() then return end
	local veh = GetVehiclePedIsIn(PlayerPedId(),false)
	local maxspeed = GetVehicleMaxSpeed(GetEntityModel(veh))
	local vehspeed = GetEntitySpeed(veh)*3.6
	if GetPedInVehicleSeat(veh,-1) == PlayerPedId() and math.ceil(vehspeed) >= 0 and not IsEntityInAir(veh) then
		if args[1] == nil then
			cruising = false
			valorCruising = 320
			TriggerEvent('Notify',"sucesso",'Cruiser desligado com sucesso.')
		elseif parseInt(args[1]) >= 10 and parseInt(args[1]) <= 320 then
			cruising = true
			SetEntityMaxSpeed(veh,0.278*args[1])
			valorCruising = args[1]
			TriggerEvent('Notify',"sucesso",'Velocidade máxima travada em <b>'.. parseInt(args[1])..' km/h</b>.')
		elseif parseInt(args[1]) < 10 or parseInt(args[1]) > 320 then
            TriggerEvent('Notify',"negado",'A velocidade de cruising deve ser entre 10KMH e 320KMH.')
            valorCruising = 290
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUISERADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:Cruiser')
AddEventHandler('waze:Cruiser', function(cruisador)
	if cruisador then
		valorCruising = cruisador
		TriggerEvent('Notify',"sucesso",'Velocidade máxima travada em <b>'.. cruisador..' km/h</b>.')
	else
		valorCruising = 9999
		TriggerEvent('Notify',"sucesso",'Você desligou o limitador de velocidade.')
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('gameEventTriggered', function (name, args)
	if name == "CEventNetworkPlayerEnteredVehicle" then
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped,false)
		while veh do
			SetEntityMaxSpeed(veh,0.278*valorCruising)
			Wait(500)
		end
	end
end)

function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false

    repeat
        if not IsEntityDead(ped) then
            SetPedDropsWeaponsWhenDead(ped, false)
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

CreateThread(function()
    while true do
        Wait(1000)
        SetWeaponDrops()
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR COR DE ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cor",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local tinta = parseInt(args[1])
	--if vSERVER.CheckBooster() then	
	if vSERVER.CheckVip('ambos') or vSERVER.CheckBooster() then	
		if tinta >= 0 then
			SetPedWeaponTintIndex(PlayerPedId(),GetSelectedPedWeapon(PlayerPedId()),tinta)
			TriggerEvent('Notify', "sucesso", 'Você pintou sua arma com a tinta ' .. tinta .. '.')
		else
			TriggerEvent('Notify', "negado", 'Você precisa especificar uma pintura válida.')
		end
	else
		TriggerEvent('Notify', "negado", 'Somente membros <b>VIP</b> e <b>waze ELITE</b>, <b>Booster</b> podem utilizar esse comando.')
	end
end)

RegisterCommand("pintura",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local ped = PlayerPedId()
    local arma = GetSelectedPedWeapon(ped)
	local pintura = parseInt(args[1])
	--if vSERVER.CheckVip() then
		if vSERVER.CheckVip('ambos') then
		if args[1] then
			if arma == GetHashKey('WEAPON_ASSAULTRIFLE_MK2') then
				if pintura == 1 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO"))
				elseif pintura == 2 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_02"))
				elseif pintura == 3 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_03"))
				elseif pintura == 4 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_04"))
				elseif pintura == 5 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_05"))
				elseif pintura == 6 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_06"))
				elseif pintura == 7 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_07"))
				elseif pintura == 8 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_08"))
				elseif pintura == 9 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_09"))
				elseif pintura == 10 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_10"))
				elseif pintura == 11 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01"))
				end
			elseif arma == GetHashKey('WEAPON_PISTOL_MK2') then
				if pintura == 1 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO"))
				elseif pintura == 2 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_02"))
				elseif pintura == 3 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_03"))
				elseif pintura == 4 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_04"))
				elseif pintura == 5 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_05"))
				elseif pintura == 6 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_06"))
				elseif pintura == 7 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_07"))
				elseif pintura == 8 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_08"))
				elseif pintura == 9 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_09"))
				elseif pintura == 10 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_10"))
				elseif pintura == 11 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_IND_01"))
				elseif pintura == 12 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_SLIDE"))
				elseif pintura == 13 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_02_SLIDE"))
				elseif pintura == 14 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_03_SLIDE"))
				elseif pintura == 15 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_04_SLIDE"))
				elseif pintura == 16 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_05_SLIDE"))
				elseif pintura == 17 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_06_SLIDE"))
				elseif pintura == 18 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_07_SLIDE"))
				elseif pintura == 19 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_08_SLIDE"))
				elseif pintura == 20 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_09_SLIDE"))
				elseif pintura == 21 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_10_SLIDE"))
				elseif pintura == 22 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_PISTOL_MK2_CAMO_IND_01_SLIDE"))
				end
			elseif arma == GetHashKey('WEAPON_CARBINERIFLE_MK2') then
				if pintura == 1 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO"))
				elseif pintura == 2 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_02"))
				elseif pintura == 3 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_03"))
				elseif pintura == 4 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_04"))
				elseif pintura == 5 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_05"))
				elseif pintura == 6 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_06"))
				elseif pintura == 7 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_07"))
				elseif pintura == 8 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_08"))
				elseif pintura == 9 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_09"))
				elseif pintura == 10 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_10"))
				elseif pintura == 11 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01"))
				end
			elseif arma == GetHashKey('WEAPON_SPECIALCARBINE_MK2') then
				if pintura == 1 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO"))
				elseif pintura == 2 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_02"))
				elseif pintura == 3 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_03"))
				elseif pintura == 4 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_04"))
				elseif pintura == 5 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_05"))
				elseif pintura == 6 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_06"))
				elseif pintura == 7 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_07"))
				elseif pintura == 8 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_08"))
				elseif pintura == 9 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_09"))
				elseif pintura == 10 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_10"))
				elseif pintura == 11 then
					GiveWeaponComponentToPed(ped,arma,GetHashKey("COMPONENT_SPECIALCARBINEE_MK2_CAMO_IND_01"))
				end
			else
				TriggerEvent('Notify', 'negado', 'Esse comando só funciona em armas do tipo <b>MK2</b>.')
			end
		else
			TriggerEvent('Notify', 'negado', 'Especifique um número de pintura.')
		end
	else
		TriggerEvent('Notify', 'negado', 'Somente membros <b>waze</b> e <b>waze ELITE</b> podem utilizar esse comando.')
	end
end)

local energetico = false
RegisterNetEvent('energeticos')
AddEventHandler('energeticos',function()
	energetico = true
	SetRunSprintMultiplierForPlayer(PlayerId(),1.2)
	Wait(60000)
	energetico = false
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	TriggerEvent("Notify",'aviso',"O efeito passou e seu coração voltou a bater normalmente.",8000)
end)



-- CreateThread(function()
-- 	while true do
-- 		RestorePlayerStamina(PlayerId(),1.0)
-- 		Wait(4)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO O F6
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
    cancelando = status
end)

CreateThread(function()
	while true do
		local ORTiming = 500
		if cancelando then
			ORTiming = 4
			BlockWeaponWheelThisFrame()
			DisablePlayerFiring(PlayerId(),true)
			DisableControlAction(0,75)
			DisableControlAction(0,20,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,137,true)
		end
		Wait(ORTiming)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(1000)
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        if x == px and y == py then
            if tempo > 0 then
                tempo = tempo - 1
                if tempo == 60 then
                    TriggerEvent("Notify","importante","Você vai ser desconectado em <b>60 segundos</b>.",8000)
                end
            else
                TriggerServerEvent("kickAFK")
            end
        else
            tempo = 1800
        end
        px = x
        py = y
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("capo",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRE E FECHA OS VIDROS
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterCommand("vidros",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywins",VehToNet(vehicle))
	end
end)

RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if vidros then
					vidros = false
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				else
					vidros = true
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTA-MALAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pmalas",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hood",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRE E FECHA OS VIDROS
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			if vidros then
				vidros = false
				RollUpWindow(v,0)
				RollUpWindow(v,1)
				RollUpWindow(v,2)
				RollUpWindow(v,3)
				else
				vidros = true
				RollDownWindow(v,0)
				RollDownWindow(v,1)
				RollDownWindow(v,2)
				RollDownWindow(v,3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("portas",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		if parseInt(args[1]) == -1 then
			TriggerServerEvent("trytrunk",VehToNet(vehicle))
		else
			TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
		end
	end
end)

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOS direita/esquerda
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmaosd')
AddEventHandler('setmaosd',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			ClearPedProp(ped,6)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,6,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,6,parseInt(modelo),parseInt(cor),2)
		end
	end
end)

RegisterNetEvent('setmaose')
AddEventHandler('setmaose',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			ClearPedProp(ped,7)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,7,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,7,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmascara')
AddEventHandler('setmascara',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if modelo == nil then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(1100)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps"},false)
			Wait(1500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setblusa')
AddEventHandler('setblusa',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.CheckVip('ambos') then
		if not modelo then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcolete')
AddEventHandler('setcolete',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.CheckVip('ambos') then
		if not modelo then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"clothingtie","try_tie_negative_a"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setjaqueta')
AddEventHandler('setjaqueta',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.CheckVip('ambos') then
		if not modelo then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmochila')
AddEventHandler('setmochila',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.CheckVip('ambos') then
		if not modelo then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,5,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,5,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,5,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmaos')
AddEventHandler('setmaos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"nmt_3_rcm-10","cs_nigel_dual-10"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCALCA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcalca')
AddEventHandler('setcalca',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.CheckVip('ambos') then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(true,{"re@construction","out_of_breath"},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(true,{"re@construction","out_of_breath"},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,15,0,2)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"re@construction","out_of_breath"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"re@construction","out_of_breath"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETACESSORIOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setacessorios')
AddEventHandler('setacessorios',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.CheckVip('ambos') then
		if not modelo then
			SetPedComponentVariation(ped,7,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSAPATOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setsapatos')
AddEventHandler('setsapatos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.CheckVip('ambos') and not IsPedInAnyVehicle(ped) then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(false,{"random@domestic","pickup_low"},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,34,0,2)
				Wait(500)
				ClearPedTasks(ped)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(false,{"random@domestic","pickup_low"},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,35,0,2)
				Wait(500)
				ClearPedTasks(ped)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{"random@domestic","pickup_low"},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{"random@domestic","pickup_low"},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setchapeu')
AddEventHandler('setchapeu',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"missheist_agency2ahelmet","take_off_helmet_stand"},false)
			Wait(1200)
			ClearPedProp(ped,0)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") and parseInt(modelo) ~= 39 then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(600)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") and parseInt(modelo) ~= 38 then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(600)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setoculos')
AddEventHandler('setoculos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"missheist_agency2ahelmet", "take_off_helmet_stand"},false)
			Wait(1200)
			ClearPedTasks(ped)
			ClearPedProp(ped,1)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(600)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},false)
			Wait(600)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)

CreateThread(function()
    while true do
        Wait(1000)
        InvalidateIdleCam()
        DistantCopCarSirens(false)
        SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 0.4) 
        
        SetWeaponDamageModifier(GetHashKey("weapon_dagger"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_bat"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_bottle"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_crowbar"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_flashlight"), 0.3) 
        SetWeaponDamageModifier(GetHashKey("weapon_golfclub"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_hammer"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_hatchet"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_knuckle"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_knife"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_machete"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_switchblade"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_wrench"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_poolcue"), 0.4) 
        SetWeaponDamageModifier(GetHashKey("weapon_battleaxe"), 0.4) 
        
        SetWeaponDamageModifier(GetHashKey("WEAPON_NIGHTSTICK"), 0.0) 
        SetWeaponDamageModifier(GetHashKey("WEAPON_PUMPSHOTGUN"), 1.5)
        SetWeaponDamageModifier(GetHashKey("WEAPON_SAWNOFFSHOTGUN"), 1.7)
        SetWeaponDamageModifier(GetHashKey("WEAPON_PISTOL_MK2"), 1.3)
        SetWeaponDamageModifier(GetHashKey("WEAPON_COMBATPISTOL"), 1.5)
        SetWeaponDamageModifier(GetHashKey("WEAPON_HEAVYPISTOL"), 2.0)
        SetWeaponDamageModifier(GetHashKey("WEAPON_CARBINERIFLE_MK2"), 2.9)
        SetWeaponDamageModifier(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), 2.4)
        SetWeaponDamageModifier(GetHashKey("weapon_carbinerifle"), 2.2)
        SetWeaponDamageModifier(GetHashKey("WEAPON_SMG"), 2.6)
        SetWeaponDamageModifier(GetHashKey("WEAPON_SMG_MK2"), 2.4)
        SetWeaponDamageModifier(GetHashKey("WEAPON_COMBATPDW"), 2.3)
        SetWeaponDamageModifier(GetHashKey("WEAPON_SPECIALCARBINE_MK2"), 2.5)
        SetWeaponDamageModifier(GetHashKey("weapon_machinepistol"), 2.5)
 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOW
-----------------------------------------------------------------------------------------------------------------------------------------
local VeiculosNoReboque = {}
RegisterCommand("tow",function(source,args)
	local vehicle = GetPlayersLastVehicle()
	local vehicletow = IsVehicleModel(vehicle,GetHashKey("flatbed"))

	if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
		local rebocado = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
		if IsEntityAVehicle(vehicle) and IsEntityAVehicle(rebocado) then
			TriggerServerEvent("trytow",VehToNet(vehicle) --[[ caminhao reboque ]],VehToNet(rebocado) --[[ veiculo rebocado ]])
		end
	end
end)

RegisterNetEvent('synctow')
AddEventHandler('synctow',function(vehid,rebid)
	if NetworkDoesNetworkIdExist(vehid) and NetworkDoesNetworkIdExist(rebid) then
		local CaminhaoReboque = NetToVeh(vehid)
		local VeiculoRebocado = NetToVeh(rebid)
		if DoesEntityExist(VeiculoRebocado) and DoesEntityExist(CaminhaoReboque) then
			if not VeiculosNoReboque[vehid] or VeiculosNoReboque[vehid] == nil then
				if VeiculoRebocado ~= CaminhaoReboque then
					local min,max = GetModelDimensions(GetEntityModel(VeiculoRebocado))
					AttachEntityToEntity(VeiculoRebocado,CaminhaoReboque,GetEntityBoneIndexByName(CaminhaoReboque,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
					VeiculosNoReboque[vehid] = rebid
				end
			else
				for k, v in pairs(VeiculosNoReboque) do
					if vehid == k then
						k, v = NetToVeh(k), NetToVeh(v)
						AttachEntityToEntity(v,k,20,-0.5,-15.0,-0.3,0.0,0.0,0.0,false,false,true,false,20,true)
						DetachEntity(v,false,false)
						PlaceObjectOnGroundProperly(v)
						VeiculosNoReboque[k] = nil
					end
				end				
			end
		end
	end
end)

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('reparar')
AddEventHandler('reparar',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryreparar",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local fuel = GetVehicleFuelLevel(v)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
				SetVehicleOnGroundProperly(v)
				SetVehicleFuelLevel(v,fuel)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('repararmotor')
AddEventHandler('repararmotor',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trymotor",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncmotor')
AddEventHandler('syncmotor',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleEngineHealth(v,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('wazebandagem')
AddEventHandler('wazebandagem',function()
    local ped = PlayerPedId()
    local bandagem = 0
    repeat
        Wait(600)
        bandagem = bandagem + 1
        if GetEntityHealth(ped) > 101 then
            SetEntityHealth(ped,GetEntityHealth(ped)+2)
        end
    until GetEntityHealth(ped) >= 399 or GetEntityHealth(ped) <= 101 or bandagem == 60
	TriggerEvent("Notify","sucesso","Tratamento concluido.")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('repararpneus')
AddEventHandler('repararpneus',function(vehicle)
	TriggerServerEvent("trypneus",VehToNet(vehicle))
end)

RegisterNetEvent('syncpneus')
AddEventHandler('syncpneus',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			for i = 0,5 do
				SetVehicleTyreFixed(v,i)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updateRoupas")
AddEventHandler("updateRoupas",function(custom)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if custom[1] == -1 then
			SetPedComponentVariation(ped,1,0,0,2)
		else
			SetPedComponentVariation(ped,1,custom[1],custom[2],2)
		end

		if custom[3] == -1 then
			SetPedComponentVariation(ped,5,0,0,2)
		else
			SetPedComponentVariation(ped,5,custom[3],custom[4],2)
		end

		if custom[5] == -1 then
			SetPedComponentVariation(ped,7,0,0,2)
		else
			SetPedComponentVariation(ped,7,custom[5],custom[6],2)
		end

		if custom[7] == -1 then
			SetPedComponentVariation(ped,3,15,0,2)
		else
			SetPedComponentVariation(ped,3,custom[7],custom[8],2)
		end

		if custom[9] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,4,15,0,2)
			end
		else
			SetPedComponentVariation(ped,4,custom[9],custom[10],2)
		end

		if custom[11] == -1 then
			SetPedComponentVariation(ped,8,15,0,2)
		else
			SetPedComponentVariation(ped,8,custom[11],custom[12],2)
		end

		if custom[13] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,6,35,0,2)
			end
		else
			SetPedComponentVariation(ped,6,custom[13],custom[14],2)
		end

		if custom[15] == -1 then
			SetPedComponentVariation(ped,11,15,0,2)
		else
			SetPedComponentVariation(ped,11,custom[15],custom[16],2)
		end

		if custom[17] == -1 then
			SetPedComponentVariation(ped,9,0,0,2)
		else
			SetPedComponentVariation(ped,9,custom[17],custom[18],2)
		end

		if custom[19] == -1 then
			SetPedComponentVariation(ped,10,0,0,2)
		else
			SetPedComponentVariation(ped,10,custom[19],custom[20],2)
		end

		if custom[21] == -1 then
			ClearPedProp(ped,0)
		else
			SetPedPropIndex(ped,0,custom[21],custom[22],2)
		end

		if custom[23] == -1 then
			ClearPedProp(ped,1)
		else
			SetPedPropIndex(ped,1,custom[23],custom[24],2)
		end

		if custom[25] == -1 then
			ClearPedProp(ped,2)
		else
			SetPedPropIndex(ped,2,custom[25],custom[26],2)
		end

		if custom[27] == -1 then
			ClearPedProp(ped,6)
		else
			SetPedPropIndex(ped,6,custom[27],custom[28],2)
		end

		if custom[29] == -1 then
			ClearPedProp(ped,7)
		else
			SetPedPropIndex(ped,7,custom[29],custom[30],2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUX VEH CONTROL
-----------------------------------------------------------------------------------------------------------------------------------------
local count_bcast_timer = 0
local delay_bcast_timer = 200

local count_sndclean_timer = 0
local delay_sndclean_timer = 400

local actv_ind_timer = false
local count_ind_timer = 0
local delay_ind_timer = 180

local actv_lxsrnmute_temp = false
local srntone_temp = 0
local dsrn_mute = true

local state_indic = {}
local state_lxsiren = {}
local state_pwrcall = {}
local state_airmanu = {}

local ind_state_o = 0
local ind_state_l = 1
local ind_state_r = 2
local ind_state_h = 3

local snd_lxsiren = {}
local snd_pwrcall = {}
local snd_airmanu = {}

local eModelsWithFireSrn = {
	"FIRETRUK"
}

local eModelsWithPcall = {
	"AMBULANCE",
	"FIRETRUK",
	"LGUARD"
}

function useFiretruckSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithFireSrn, 1 do
		if model == GetHashKey(eModelsWithFireSrn[i]) then
			return true
		end
	end
	return false
end

function usePowercallAuxSrn(veh)
	local model = GetEntityModel(veh)
	for i = 1,#eModelsWithPcall,1 do
		if model == GetHashKey(eModelsWithPcall[i]) then
			return true
		end
	end
	return false
end

function CleanupSounds()
	if count_sndclean_timer > delay_sndclean_timer then
		count_sndclean_timer = 0
		for k, v in pairs(state_lxsiren) do
			if v > 0 then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_lxsiren[k] ~= nil then
						StopSound(snd_lxsiren[k])
						ReleaseSoundId(snd_lxsiren[k])
						snd_lxsiren[k] = nil
						state_lxsiren[k] = nil
					end
				end
			end
		end
		for k, v in pairs(state_pwrcall) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_pwrcall[k] ~= nil then
						StopSound(snd_pwrcall[k])
						ReleaseSoundId(snd_pwrcall[k])
						snd_pwrcall[k] = nil
						state_pwrcall[k] = nil
					end
				end
			end
		end
		for k, v in pairs(state_airmanu) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k, -1) then
					if snd_airmanu[k] ~= nil then
						StopSound(snd_airmanu[k])
						ReleaseSoundId(snd_airmanu[k])
						snd_airmanu[k] = nil
						state_airmanu[k] = nil
					end
				end
			end
		end
	else
		count_sndclean_timer = count_sndclean_timer + 1
	end
end

function TogIndicStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate == ind_state_o then
			SetVehicleIndicatorLights(veh,0,false)
			SetVehicleIndicatorLights(veh,1,false)
		elseif newstate == ind_state_l then
			SetVehicleIndicatorLights(veh,0,false)
			SetVehicleIndicatorLights(veh,1,true)
		elseif newstate == ind_state_r then
			SetVehicleIndicatorLights(veh,0,true)
			SetVehicleIndicatorLights(veh,1,false)
		elseif newstate == ind_state_h then
			SetVehicleIndicatorLights(veh,0,true)
			SetVehicleIndicatorLights(veh,1,true)
		end
		state_indic[veh] = newstate
	end
end

function TogMuteDfltSrnForVeh(veh,toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		DisableVehicleImpactExplosionActivation(veh,toggle)
	end
end

function SetLxSirenStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_lxsiren[veh] then
			if snd_lxsiren[veh] then
				StopSound(snd_lxsiren[veh])
				ReleaseSoundId(snd_lxsiren[veh])
				snd_lxsiren[veh] = nil
			end
			if newstate == 1 then
				if useFiretruckSiren(veh) then
					TogMuteDfltSrnForVeh(veh,false)
				else
					snd_lxsiren[veh] = GetSoundId()
					PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_SIREN_1",veh,0,0,0)
					TogMuteDfltSrnForVeh(veh,true)
				end
			elseif newstate == 2 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_SIREN_2",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			elseif newstate == 3 then
				snd_lxsiren[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_AMBULANCE_WARNING",veh,0,0,0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_POLICE_WARNING",veh,0,0,0)
				end
				TogMuteDfltSrnForVeh(veh,true)
			else
				TogMuteDfltSrnForVeh(veh,true)
			end
			state_lxsiren[veh] = newstate
		end
	end
end

function TogPowercallStateForVeh(veh,toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if toggle == true then
			if snd_pwrcall[veh] == nil then
				snd_pwrcall[veh] = GetSoundId()
				if usePowercallAuxSrn(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh],"VEHICLES_HORNS_AMBULANCE_WARNING",veh,0,0,0)
				else
					PlaySoundFromEntity(snd_pwrcall[veh],"VEHICLES_HORNS_SIREN_1",veh,0,0,0)
				end
			end
		else
			if snd_pwrcall[veh] then
				StopSound(snd_pwrcall[veh])
				ReleaseSoundId(snd_pwrcall[veh])
				snd_pwrcall[veh] = nil
			end
		end
		state_pwrcall[veh] = toggle
	end
end

function SetAirManuStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
			if snd_airmanu[veh] then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end
			if newstate == 1 then
				snd_airmanu[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh],"VEHICLES_HORNS_FIRETRUCK_WARNING",veh,0,0,0)
				else
					PlaySoundFromEntity(snd_airmanu[veh],"SIRENS_AIRHORN",veh,0,0,0)
				end
			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"VEHICLES_HORNS_SIREN_1",veh,0,0,0)
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"VEHICLES_HORNS_SIREN_2",veh,0,0,0)
			end
			state_airmanu[veh] = newstate
		end
	end
end

RegisterNetEvent("lvc_TogIndicState_c")
AddEventHandler("lvc_TogIndicState_c",function(sender,newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogIndicStateForVeh(veh,newstate)
			end
		end
	end
end)

RegisterNetEvent("lvc_TogDfltSrnMuted_c")
AddEventHandler("lvc_TogDfltSrnMuted_c",function(sender,toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogMuteDfltSrnForVeh(veh,toggle)
			end
		end
	end
end)

RegisterNetEvent("lvc_SetLxSirenState_c")
AddEventHandler("lvc_SetLxSirenState_c",function(sender,newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetLxSirenStateForVeh(veh,newstate)
			end
		end
	end
end)

RegisterNetEvent("lvc_TogPwrcallState_c")
AddEventHandler("lvc_TogPwrcallState_c",function(sender,toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogPowercallStateForVeh(veh,toggle)
			end
		end
	end
end)

RegisterNetEvent("lvc_SetAirManuState_c")
AddEventHandler("lvc_SetAirManuState_c",function(sender,newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetAirManuStateForVeh(veh,newstate)
			end
		end
	end
end)

local isArmed = false
local inVehicle = false

Citizen.CreateThread(function()
    while true do
		local ped = PlayerPedId()
        if IsPedArmed(ped, 4) or IsPedArmed(ped, 6) or IsPedArmed(ped, 2) then
            isArmed = true
		else
			isArmed = false
        end

        if IsPedInAnyVehicle(ped) then
			inVehicle = true
		else
			inVehicle = false
        end
        
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
	while true do
		CleanupSounds()
		local playerped = PlayerPedId()		
		if IsPedInAnyVehicle(playerped) then
			local veh = GetVehiclePedIsUsing(playerped)
			if GetPedInVehicleSeat(veh,-1) == playerped then
				DisableControlAction(0,84,true)
				DisableControlAction(0,83,true)

				if state_indic[veh] ~= ind_state_o and state_indic[veh] ~= ind_state_l and state_indic[veh] ~= ind_state_r and state_indic[veh] ~= ind_state_h then
					state_indic[veh] = ind_state_o
				end

				if actv_ind_timer == true then
					if state_indic[veh] == ind_state_l or state_indic[veh] == ind_state_r then
						if GetEntitySpeed(veh) < 6 then
							count_ind_timer = 0
						else
							if count_ind_timer > delay_ind_timer then
								count_ind_timer = 0
								actv_ind_timer = false
								state_indic[veh] = ind_state_o
								PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
								TogIndicStateForVeh(veh, state_indic[veh])
								count_bcast_timer = delay_bcast_timer
							else
								count_ind_timer = count_ind_timer + 1
							end
						end
					end
				end

				if GetVehicleClass(veh) == 18 then
					local actv_manu = false
					local actv_horn = false
					DisableControlAction(0,86,true)
					DisableControlAction(0,81,true)
					DisableControlAction(0,82,true)
					DisableControlAction(0,19,true)
					DisableControlAction(0,85,true)
					DisableControlAction(0,80,true)
					SetVehRadioStation(veh,"OFF")
					SetVehicleRadioEnabled(veh,false)
					
					if state_lxsiren[veh] ~= 1 and state_lxsiren[veh] ~= 2 and state_lxsiren[veh] ~= 3 then
						state_lxsiren[veh] = 0
					end

					if state_pwrcall[veh] ~= true then
						state_pwrcall[veh] = false
					end

					if state_airmanu[veh] ~= 1 and state_airmanu[veh] ~= 2 and state_airmanu[veh] ~= 3 then
						state_airmanu[veh] = 0
					end

					if useFiretruckSiren(veh) and state_lxsiren[veh] == 1 then
						TogMuteDfltSrnForVeh(veh,false)
						dsrn_mute = false
					else
						TogMuteDfltSrnForVeh(veh,true)
						dsrn_mute = true
					end

					if not IsVehicleSirenOn(veh) and state_lxsiren[veh] > 0 then
						PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
						SetLxSirenStateForVeh(veh,0)
						count_bcast_timer = delay_bcast_timer
					end

					if not IsVehicleSirenOn(veh) and state_pwrcall[veh] == true then
						PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
						TogPowercallStateForVeh(veh,false)
						count_bcast_timer = delay_bcast_timer
					end

					if not IsPauseMenuActive() then
						if IsDisabledControlJustReleased(0,85) then
							if IsVehicleSirenOn(veh) then
								PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
								SetVehicleSiren(veh,false)
							else
								PlaySoundFrontend(-1,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
								SetVehicleSiren(veh,true)
								count_bcast_timer = delay_bcast_timer
							end
						elseif IsDisabledControlJustReleased(0,19) or IsDisabledControlJustReleased(0,82) then
							local cstate = state_lxsiren[veh]
							if cstate == 0 then
								if IsVehicleSirenOn(veh) then
									PlaySoundFrontend(-1,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
									SetLxSirenStateForVeh(veh,1)
									count_bcast_timer = delay_bcast_timer
								end
							else
								PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
								SetLxSirenStateForVeh(veh,0)
								count_bcast_timer = delay_bcast_timer
							end
						end

						if state_lxsiren[veh] > 0 then
							if IsDisabledControlJustReleased(0,80) or IsDisabledControlJustReleased(0,81) then
								if IsVehicleSirenOn(veh) then
									local cstate = state_lxsiren[veh]
									local nstate = 1
									PlaySoundFrontend(-1,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
									if cstate == 1 then
										nstate = 2
									elseif cstate == 2 then
										nstate = 3
									else	
										nstate = 1
									end
									SetLxSirenStateForVeh(veh,nstate)
									count_bcast_timer = delay_bcast_timer
								end
							end
						end

						if state_lxsiren[veh] < 1 then
							if IsDisabledControlPressed(0,80) or IsDisabledControlPressed(0,81) then
								actv_manu = true
							else
								actv_manu = false
							end
						else
							actv_manu = false
						end

						if IsDisabledControlPressed(0,86) then
							actv_horn = true
						else
							actv_horn = false
						end
					end

					local hmanu_state_new = 0
					if actv_horn == true and actv_manu == false then
						hmanu_state_new = 1
					elseif actv_horn == false and actv_manu == true then
						hmanu_state_new = 2
					elseif actv_horn == true and actv_manu == true then
						hmanu_state_new = 3
					end

					if hmanu_state_new == 1 then
						if not useFiretruckSiren(veh) then
							if state_lxsiren[veh] > 0 and actv_lxsrnmute_temp == false then
								srntone_temp = state_lxsiren[veh]
								SetLxSirenStateForVeh(veh,0)
								actv_lxsrnmute_temp = true
							end
						end
					else
						if not useFiretruckSiren(veh) then
							if actv_lxsrnmute_temp == true then
								SetLxSirenStateForVeh(veh,srntone_temp)
								actv_lxsrnmute_temp = false
							end
						end
					end

					if state_airmanu[veh] ~= hmanu_state_new then
						SetAirManuStateForVeh(veh,hmanu_state_new)
						count_bcast_timer = delay_bcast_timer
					end	
				end

				if GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 and GetVehicleClass(veh) ~= 21 then
					if not IsPauseMenuActive() then
						if IsDisabledControlJustReleased(0,84) then
							local cstate = state_indic[veh]
							if cstate == ind_state_l then
								state_indic[veh] = ind_state_o
								actv_ind_timer = false
								PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
							else
								state_indic[veh] = ind_state_l
								actv_ind_timer = true
								PlaySoundFrontend(-1,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
							end
							TogIndicStateForVeh(veh,state_indic[veh])
							count_ind_timer = 0
							count_bcast_timer = delay_bcast_timer
						elseif IsDisabledControlJustReleased(0,83) then
							local cstate = state_indic[veh]
							if cstate == ind_state_r then
								state_indic[veh] = ind_state_o
								actv_ind_timer = false
								PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
							else
								state_indic[veh] = ind_state_r
								actv_ind_timer = true
								PlaySoundFrontend(-1,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
							end
							TogIndicStateForVeh(veh, state_indic[veh])
							count_ind_timer = 0
							count_bcast_timer = delay_bcast_timer
						elseif IsControlJustReleased(0,202) then
							if GetLastInputMethod(0) then
								local cstate = state_indic[veh]
								if cstate == ind_state_h then
									state_indic[veh] = ind_state_o
									PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
								else
									state_indic[veh] = ind_state_h
									PlaySoundFrontend(-1,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
								end
								TogIndicStateForVeh(veh,state_indic[veh])
								actv_ind_timer = false
								count_ind_timer = 0
								count_bcast_timer = delay_bcast_timer
							end
						end
					end
					if count_bcast_timer > delay_bcast_timer then
						count_bcast_timer = 0
						if GetVehicleClass(veh) == 18 then
							TriggerServerEvent("lvc_TogDfltSrnMuted_s",dsrn_mute)
							TriggerServerEvent("lvc_SetLxSirenState_s",state_lxsiren[veh])
							TriggerServerEvent("lvc_TogPwrcallState_s",state_pwrcall[veh])
							TriggerServerEvent("lvc_SetAirManuState_s",state_airmanu[veh])
						end
						TriggerServerEvent("lvc_TogIndicState_s",state_indic[veh])
					else
						count_bcast_timer = count_bcast_timer + 1
					end
				end
			end
		end

		Citizen.Wait(5)
	end
end)

CreateThread(function()
	while true do
		Wait(4)
		DisableControlAction(0,36,true)
		if isArmed then
			HideHudComponentThisFrame( 2 ) -- Weapon Icon
			HideHudComponentThisFrame( 20 ) -- Weapon Stats
			HideHudComponentThisFrame( 21 ) -- Weapon Stats
		end

		if inVehicle then
			HideHudComponentThisFrame( 9 ) -- Street Name
		end
		
		CleanupSounds()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
        TriggerEvent("Notify","aviso","Sistema de FPS boost <b>ATIVADO</b>!")
    elseif args[1] == "off" then
        SetTimecycleModifier("default")
        TriggerEvent("Notify","aviso","Sistema de FPS boost <b>DESATIVADO</b>!")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVAR AIM ASSIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local bool,hash = GetCurrentPedWeapon(ped,1)
		local weapongroup = GetWeapontypeGroup(hash)
		if bool and weapongroup ~= -728555052 then
			SetPlayerLockon(PlayerId(),false)
		else
			SetPlayerLockon(PlayerId(),true)
		end
		Wait(1000)
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- -- PEÇA MECANICO 
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:MecAnim')
AddEventHandler('waze:MecAnim', function(item)
	if item == 'placa' then 
		vRP._playAnim(false,{task="WORLD_HUMAN_WELDING"},false)
		TriggerEvent("progress",15000,"Montando kit")
		Wait(15000)
		ClearPedTasks(PlayerPedId())
	elseif item == 'latadetinta' then
		vRP._playAnim(false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
		TriggerEvent("progress",15000,"Misturando tintas")
		Wait(15000)
		ClearPedTasks(PlayerPedId())
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT BAHAMAS
-----------------------------------------------------------------------------------------------------------------------------------------
function client.CheckEstaEmCarro()
	return IsPedInAnyVehicle(PlayerPedId(), false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OFICINA CLANDESTINA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cloneplates')
AddEventHandler('cloneplates',function(placa)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local clonada = GetVehicleNumberPlateText(vehicle)
    if IsEntityAVehicle(vehicle) then
        PlateIndex = GetVehicleNumberPlateText(vehicle)
        SetVehicleNumberPlateText(vehicle,placa)
        FreezeEntityPosition(vehicle,false)
        if clonada == CLONADA then 
            SetVehicleNumberPlateText(vehicle,PlateIndex)
            PlateIndex = nil
        end
    end
end)

local oficinasClandestinas = {
	[1] = {732.0,-1089.0,22.17}, -- Próximo aos trilhos de trem
	[2] = {1175.2,2639.95,37.76} -- Mecânica do norte
}

local camuflando = false
RegisterCommand('clonarvehs', function(source, args, rawCmd)
	if not camuflando then
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
		if vSERVER.checkCamuflagem('placa') then
			local placa = vSERVER.GetPlacaLivre()
			DisableControlAction(0,75,true)
			camuflando = true
			FreezeEntityPosition(vehicle,true)
			TriggerEvent('cloneplates', placa)
			camuflando = false
			FreezeEntityPosition(vehicle,false)
			DisableControlAction(0,75,false)
		end
	end
end)
RegisterCommand('pintarvehs', function(source, args, rawCmd)
	if not camuflando then
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsUsing(ped)
		for b, n in pairs(oficinasClandestinas) do
			local x,y,z = table.unpack(n)
			local distance = #(GetEntityCoords(ped) - vec3(x,y,z))
			if distance <= 7 and GetPedInVehicleSeat(vehicle,-1) == ped then
					if vSERVER.checkCamuflagem('pintura') then
					DisableControlAction(0,75,true)
					camuflando = true
					FreezeEntityPosition(vehicle,true)
					TriggerEvent("progress",4*1000,"Trocando pintura")
					Wait(4*1000)
					local r,g,b = math.random(0,255), math.random(0,255), math.random(0,255)
					TriggerEvent('carroCor', vehicle, r, g, b)
					camuflando = false
					FreezeEntityPosition(vehicle,false)
					DisableControlAction(0,75,false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-----------------------------------------------------------------------------------------------------------------------------------------
local inCamera = false
local camSelect = nil
local cameras = {
	["1"] = { 433.93,-978.23,34.72,104.89 },
	["2"] = { 424.59,-996.6,34.72,119.06 },
	["3"] = { 438.16,-999.32,33.72,192.76 },
	["4"] = { 148.99,-1036.29,32.34,306.15 },
	["5"] = { 300.97,-582.22,45.29,218.27 },
	["6"] = { 227.4,-577.62,46.86,269.3 },
	["7"] = { 22.0,-1602.84,32.37,153.08 }
}

RegisterNetEvent("waze:serviceCamera")
AddEventHandler("waze:serviceCamera",function(num)
	local ped = PlayerPedId()

	if inCamera then
		ClearTimecycleModifier()
		DestroyCam(camSelect,false)
		RenderScriptCams(false,false,0,1,0)
		PlaySoundFrontend(-1,"HACKING_SUCCESS",false)
        TriggerEvent('active:checkcam',true)
		inCamera = false
		camSelect = nil
	else
		if cameras[num] then
			TriggerEvent('active:checkcam',false)
			inCamera = true
			SetTimecycleModifier("heliGunCam")
			PlaySoundFrontend(-1,"HACKING_SUCCESS",false)
			camSelect = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
			SetCamCoord(camSelect,cameras[num][1],cameras[num][2],cameras[num][3])
			SetCamRot(camSelect,-20.0,0.0,cameras[num][4])
			RenderScriptCams(true,false,0,1,0)
		end
	end
end)