local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local waze = {}
Tunnel.bindInterface("vrp_admin",waze)
vSERVER = Tunnel.getInterface("vrp_admin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS DO DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		SetDiscordAppId(949807655738810398)
		SetDiscordRichPresenceAsset('cfxscripts')
        SetRichPresence('discord.gg/cfxscripts')

        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/cfxscripts")
		Wait(60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('adminClothes')
AddEventHandler('adminClothes',function(custom)
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
			if GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') then
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey('mp_f_freemode_01') then
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
			if GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') then
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey('mp_f_freemode_01') then
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
-- TELACINZA
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ local locksound = false
CreateThread(function()
    while true do
        Wait(500)
        local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 then
            alreadyDead = true
            wazeScreenEffect('DeathFailOut', 0, 0)
            if not locksound then
                locksound = true
            end
            ShakeGameplayCam('DEATH_FAIL_IN_EFFECT_SHAKE', 1.0)

            local scaleform = RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')

            while not HasScaleformMovieLoaded(scaleform) do
                Wait(5) -- TODO 0
            end

            if HasScaleformMovieLoaded(scaleform) then
                Wait(5) -- TODO 0

                Wait(500)

                PlaySoundFrontend(-1, 'TextHit', 'WastedSounds', 1)
                while GetEntityHealth(PlayerPedId()) <= 101 do
                    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                    Wait(5) -- TODO 0
                end

                StopScreenEffect('DeathFailOut')
                locksound = false
            end
        end
    end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.syncArea(x,y,z)
    ClearAreaOfVehicles(x,y,z,2000.0,false,false,false,false,false)
    ClearAreaOfEverything(x,y,z,2000.0,false,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.applySkinAdmin(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(),mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEADING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("h",function(source,args)
    vRP.prompt("Heading:",GetEntityHeading(PlayerPedId()))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.vehicleHash(vehicle)
	vRP.prompt("Hash:",GetEntityModel(vehicle))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.spawnVeh(name)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Wait(10)
	end

	if HasModelLoaded(mhash) then
		local ped = PlayerPedId()
		local nveh = CreateVehicle(mhash,GetEntityCoords(ped),GetEntityHeading(ped),true,false)

		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			NetworkRegisterEntityAsNetworked(nveh)
			Wait(1)
		end

		SetVehicleOnGroundProperly(nveh)
		SetVehicleAsNoLongerNeeded(nveh)
		SetVehicleIsStolen(nveh,false)
		SetPedIntoVehicle(ped,nveh,-1)
		SetVehicleNeedsToBeHotwired(nveh,false)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehRadioStation(nveh,"OFF")

		SetModelAsNoLongerNeeded(mhash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- efeitinhonoclip
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('efeitinholgbt')
AddEventHandler('efeitinholgbt',function()
    local particleDictionary = "scr_rcbarry2"
    local particleName = "scr_clown_death"
    RequestNamedPtfxAsset(particleDictionary)
    while not HasNamedPtfxAssetLoaded(particleDictionary) do
    Wait(0)
    end
    SetPtfxAssetNextCall(particleDictionary)
    local effect = wazeParticleFxLoopedOnPedBone("scr_clown_death",v,0.0,0.0,-0.6,0.0,0.0,20.0,GetPedBoneIndex(v,11816),2.0,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY 
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.tptoWay()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		ped = GetVehiclePedIsUsing(ped)
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped,x,y,height,1,0,0)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(ped) do
			Wait(1)
		end

		Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(ped,0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(ped) do
		Wait(1)
	end

	SetEntityCoordsNoOffset(ped,x,y,z,1,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TROLLS
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.makeFly()
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))

    SetEntityCoords(ped,x,y,z+1000)
	vRP.giveWeapons({["GADGET_PARACHUTE"] = { ammo = 1000 }})
end

function waze.neyMar(ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	SetPedToRagdollWithFall(PlayerPedId(),1500,2000,0,ForwardVector,1.0,0.0,0.0,0.0,0.0,0.0,0.0)
end

function waze.ExplodirPessoa(x,y,z)
	AddExplosion(x,y,z, 6, 100.0, true, false, 5.0)
end

RegisterNetEvent('waze:FurarPneuTeleguiado')
AddEventHandler('waze:FurarPneuTeleguiado', function(roda)
	if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1)  == PlayerPedId() then
		SetVehicleTyreBurst(GetVehiclePedIsIn(PlayerPedId(), false), roda, true, 1000.0)
	end
end)

function waze.SyncPneuFurado(veh,index)
	local carro = NetToVeh(veh)
	if veh and carro then
		SetVehicleTyreBurst(carro, index, true, 1000.0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteobj")
AddEventHandler("syncdeleteobj",function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToEnt(index)
        if DoesEntityExist(v) then
            SetEntityAsMissionEntity(v,false,false)
            DeleteEntity(v)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.vehicleTuning()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,0,GetNumVehicleMods(vehicle,0)-1,false)
		SetVehicleMod(vehicle,1,GetNumVehicleMods(vehicle,1)-1,false)
		SetVehicleMod(vehicle,2,GetNumVehicleMods(vehicle,2)-1,false)
		SetVehicleMod(vehicle,3,GetNumVehicleMods(vehicle,3)-1,false)
		SetVehicleMod(vehicle,4,GetNumVehicleMods(vehicle,4)-1,false)
		SetVehicleMod(vehicle,5,GetNumVehicleMods(vehicle,5)-1,false)
		SetVehicleMod(vehicle,6,GetNumVehicleMods(vehicle,6)-1,false)
		SetVehicleMod(vehicle,7,GetNumVehicleMods(vehicle,7)-1,false)
		SetVehicleMod(vehicle,8,GetNumVehicleMods(vehicle,8)-1,false)
		SetVehicleMod(vehicle,9,GetNumVehicleMods(vehicle,9)-1,false)
		SetVehicleMod(vehicle,10,GetNumVehicleMods(vehicle,10)-1,false)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,14,16,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-2,false)
		SetVehicleMod(vehicle,16,GetNumVehicleMods(vehicle,16)-1,false)
		ToggleVehicleMod(vehicle,17,true)
		ToggleVehicleMod(vehicle,18,true)
		ToggleVehicleMod(vehicle,19,true)
		ToggleVehicleMod(vehicle,20,true)
		ToggleVehicleMod(vehicle,21,true)
		ToggleVehicleMod(vehicle,22,true)
		SetVehicleMod(vehicle,24,1,false)
		SetVehicleMod(vehicle,25,GetNumVehicleMods(vehicle,25)-1,false)
		SetVehicleMod(vehicle,27,GetNumVehicleMods(vehicle,27)-1,false)
		SetVehicleMod(vehicle,28,GetNumVehicleMods(vehicle,28)-1,false)
		SetVehicleMod(vehicle,30,GetNumVehicleMods(vehicle,30)-1,false)
		SetVehicleMod(vehicle,34,GetNumVehicleMods(vehicle,34)-1,false)
		SetVehicleMod(vehicle,35,GetNumVehicleMods(vehicle,35)-1,false)
		SetVehicleMod(vehicle,38,GetNumVehicleMods(vehicle,38)-1,true)
        SetVehicleWindowTint(vehicle,1)
	end
end

function waze.vehicleTuning2(vehicle)
	local ped = PlayerPedId()
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-1,false)
		ToggleVehicleMod(vehicle,18,true)
	end
end

------------------------------------------------------------------------------------------------------------------------------
-- COR FAROL
------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:CorFarolCl')
AddEventHandler('waze:CorFarolCl',function(vehicle, cor)
	TriggerServerEvent("waze:SyncCorFarol",VehToNet(vehicle), cor)
end)

RegisterNetEvent("waze:SyncCorFarolCl")
AddEventHandler("waze:SyncCorFarolCl",function(index, cor)
	CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				ToggleVehicleMod(v, 22, true)
				SetVehicleHeadlightsColour(v, cor)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('foguinho')
AddEventHandler('foguinho',function(source)
    local ped = PlayerPedId(-1)
    if not blutzadafire then
        blutzadafire = true
        Wait(100)
        wazeEntityFire(ped);
    else
        blutzadafire = false
        StopEntityFire(ped);
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('bigar')
AddEventHandler('bigar',function()
	local ped = PlayerPedId()
    vRP._stopAnim(true)
    FreezeEntityPosition(ped,true)
    TriggerEvent("cancelando",true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESBIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('desbigar')
AddEventHandler('desbigar',function()
	local ped = PlayerPedId()
    vRP._stopAnim(false)
    FreezeEntityPosition(ped,false)
    TriggerEvent("cancelando",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICAÇÃO /ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('wazeUi:MostrarNotAdm')
AddEventHandler('wazeUi:MostrarNotAdm', function (args)
	local title = args[1]
	local message = args[2]
	local type = args[3]
	SendNUIMessage({ action = 'sendNotification', title = title, message = message, type = type })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:AdminSetPlaca')
AddEventHandler('waze:AdminSetPlaca', function(nveh, placa)
	SetVehicleNumberPlateText(nveh,placa)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINFUEL2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admfuel2")
AddEventHandler("admfuel2",function(fuel)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local fuel = fuel + 0.0
    SetVehicleFuelLevel(vehicle,fuel)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('admcuff')
AddEventHandler('admcuff',function()
	local ped = PlayerPedId()
	if vRP.isHandcuffed() then
		vRP._setHandcuffed(source,false)
		SetPedComponentVariation(PlayerPedId(),7,0,0,2)
	end
end)

local showMe = {}
RegisterNetEvent("vrp_showme:pressMe")
AddEventHandler("vrp_showme:pressMe",function(source,text,v)
	local pedSource = GetPlayerFromServerId(source)
	if pedSource ~= -1 then
		showMe[GetPlayerPed(pedSource)] = { text,v[1],v[2],v[3],v[4],v[5] }
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOWMEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(showMe) do
			local coordsMe = GetEntityCoords(k)
			local distance = #(coords - coordsMe)
			if distance <= 5 then
				timeDistance = 4
				if HasEntityClearLosToEntity(ped,k,17) then
					showMe3D(coordsMe.x,coordsMe.y,coordsMe.z+0.90,string.upper(v[1]),v[3],v[4],v[5],v[6])
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRHEADSHOWMETIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k,v in pairs(showMe) do
			if v[2] > 0 then
				v[2] = v[2] - 1
				if v[2] <= 0 then
					showMe[k] = nil
				end
			end
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWME3D
-----------------------------------------------------------------------------------------------------------------------------------------
function showMe3D(x,y,z,text,h,back,color,opacity)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(color,color,color,opacity)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / h
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,back,back,back,150)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Jogadores = {}
local ModoAdminAtivado = false
local admdist = 1500
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('amreset', function(source, args, rawCmd)
    Jogadores = {}
    ModoAdminAtivado = false
    print('Admin reset')
end)

RegisterCommand('amdist', function(source, args, rawCmd)
    if args[1] then
        admdist = tonumber(args[1])
        print('Distancia alterada para '..admdist)
    end
end)

local Armas = {
    [GetHashKey('WEAPON_UNARMED')] = "",
    [GetHashKey('WEAPON_KNIFE')] = "KNIFE",
    [GetHashKey('WEAPON_NIGHTSTICK')] = "NIGHTSTICK",
    [GetHashKey('WEAPON_HAMMER')] = "HAMMER",
    [GetHashKey('WEAPON_BAT')] = "BAT",
    [GetHashKey('WEAPON_GOLFCLUB')] = "GOLFCLUB",
    [GetHashKey('WEAPON_CROWBAR')] = "CROWBAR",
    [GetHashKey('WEAPON_PISTOL')] = "PISTOL",
    [GetHashKey('WEAPON_COMBATPISTOL')] = "COMBATPISTOL",
    [GetHashKey('WEAPON_APPISTOL')] = "APPISTOL",
    [GetHashKey('WEAPON_PISTOL50')] = "PISTOL50",
    [GetHashKey('WEAPON_MICROSMG')] = "MICROSMG",
    [GetHashKey('WEAPON_SMG')] = "SMG",
    [GetHashKey('WEAPON_ASSAULTSMG')] = "ASSAULTSMG",
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = "ASSAULTRIFLE",
    [GetHashKey('WEAPON_CARBINERIFLE')] = "CARBINERIFLE",
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = "ADVANCEDRIFLE",
    [GetHashKey('WEAPON_MG')] = "MG",
    [GetHashKey('WEAPON_COMBATMG')] = "COMBATMG",
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = "PUMPSHOTGUN",
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = "SAWNOFFSHOTGUN",
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = "ASSAULTSHOTGUN",
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = "BULLPUPSHOTGUN",
    [GetHashKey('WEAPON_STUNGUN')] = "STUNGUN",
    [GetHashKey('WEAPON_SNIPERRIFLE')] = "SNIPERRIFLE",
    [GetHashKey('WEAPON_HEAVYSNIPER')] = "HEAVYSNIPER",
    [GetHashKey('WEAPON_GRENADELAUNCHER')] = "GRENADELAUNCHER",
    [GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE')] = "SMOKE GRENADELAUNCHER",
    [GetHashKey('WEAPON_RPG')] = "RPG",
    [GetHashKey('WEAPON_MINIGUN')] = "MINIGUN",
    [GetHashKey('WEAPON_GRENADE')] = "GRENADE",
    [GetHashKey('WEAPON_STICKYBOMB')] = "STICKYBOMB",
    [GetHashKey('WEAPON_SMOKEGRENADE')] = "SMOKEGRENADE",
    [GetHashKey('WEAPON_BZGAS')] = "BZGAS",
    [GetHashKey('WEAPON_MOLOTOV')] = "MOLOTOV",
    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = "FIREEXTINGUISHER",
    [GetHashKey('WEAPON_PETROLCAN')] = "PETROLCAN",
    [GetHashKey('WEAPON_FLARE')] = "FLARE",
    [GetHashKey('WEAPON_SNSPISTOL')] = "SNSPISTOL",
    [GetHashKey('WEAPON_SPECIALCARBINE')] = "SPECIALCARBINE",
    [GetHashKey('WEAPON_HEAVYPISTOL')] = "HEAVYPISTOL",
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = "BULLPUPRIFLE",
    [GetHashKey('WEAPON_HOMINGLAUNCHER')] = "HOMINGLAUNCHER",
    [GetHashKey('WEAPON_PROXMINE')] = "PROXMINE",
    [GetHashKey('WEAPON_SNOWBALL')] = "SNOWBALL",
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = "VINTAGEPISTOL",
    [GetHashKey('WEAPON_DAGGER')] = "DAGGER",
    [GetHashKey('WEAPON_FIREWORK')] = "FIREWORK",
    [GetHashKey('WEAPON_MUSKET')] = "MUSKET",
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = "MARKSMANRIFLE",
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = "HEAVYSHOTGUN",
    [GetHashKey('WEAPON_GUSENBERG')] = "GUSENBERG",
    [GetHashKey('WEAPON_HATCHET')] = "HATCHET",
    [GetHashKey('WEAPON_RAILGUN')] = "RAILGUN",
    [GetHashKey('WEAPON_COMBATPDW')] = "COMBATPDW",
    [GetHashKey('WEAPON_KNUCKLE')] = "KNUCKLE",
    [GetHashKey('WEAPON_MARKSMANPISTOL')] = "MARKSMANPISTOL",
    [GetHashKey('WEAPON_FLASHLIGHT')] = "FLASHLIGHT",
    [GetHashKey('WEAPON_MACHETE')] = "MACHETE",
    [GetHashKey('WEAPON_MACHINEPISTOL')] = "MACHINEPISTOL",
    [GetHashKey('WEAPON_SWITCHBLADE')] = "SWITCHBLADE",
    [GetHashKey('WEAPON_REVOLVER')] = "REVOLVER",
    [GetHashKey('WEAPON_COMPACTRIFLE')] = "COMPACTRIFLE",
    [GetHashKey('WEAPON_DBSHOTGUN')] = "DBSHOTGUN",
    [GetHashKey('WEAPON_FLAREGUN')] = "FLAREGUN",
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = "AUTOSHOTGUN",
    [GetHashKey('WEAPON_BATTLEAXE')] = "BATTLEAXE",
    [GetHashKey('WEAPON_COMPACTLAUNCHER')] = "COMPACTLAUNCHER",
    [GetHashKey('WEAPON_MINISMG')] = "MINISMG",
    [GetHashKey('WEAPON_PIPEBOMB')] = "PIPEBOMB",
    [GetHashKey('WEAPON_POOLCUE')] = "POOLCUE",
    [GetHashKey('WEAPON_SWEEPER')] = "SWEEPER",
    [GetHashKey('WEAPON_WRENCH')] = "WRENCH",
    [GetHashKey('WEAPON_PISTOL_MK2')] = "PISTOL  II",
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = "SNSPISTOL  II",
    [GetHashKey('WEAPON_REVOLVER_MK2')] = "REVOLVER  II",
    [GetHashKey('WEAPON_SMG_MK2')] = "SMG  II",
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = "PUMPSHOTGUN  II",
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = "ASSAULTRIFLE  II",
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] = "CARBINERIFLE  II",
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = "SPECIALCARBINE  II",
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = "BULLPUPRIFLE  II",
    [GetHashKey('WEAPON_COMBATMG_MK2')] = "COMBATMG  II",
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = "HEAVYSNIPER  II",
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = "MARKSMANRIFLE  II"
}
function waze.SyncPlayerlist(Playerlist)
    Jogadores = Playerlist
    print('Player list has been synced')
end
function waze.ToggleAdmmode()
    if ModoAdminAtivado then
        ModoAdminAtivado = false
        TriggerEvent('Notify', 'aviso', 'Todos as tags foram limpas e removidas. Modo admin <b>desativado</b>.')
        return false
    else
        ModoAdminAtivado = true
        TriggerEvent('Notify', 'aviso', 'Todos as tags foram criadas. Modo admin <b>ativado</b>.')
        return true
    end
end
CreateThread(function() 
    while true do
        local ThreadDelay = 3000
        if ModoAdminAtivado then
            ThreadDelay = 1
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)

            for k, v in pairs(GetActivePlayers()) do
                local nsource = GetPlayerServerId(v)
                local nped = GetPlayerPed(v)
                local npedCoords = GetEntityCoords(nped)
                if ped ~= nped then
                    if Jogadores[nsource] and Jogadores[nsource] ~= nil and nped and nped ~= nil then
                        if #(pedCoords - npedCoords) <= admdist then
                            local tablet = Jogadores[nsource]
                            local x,y,z = table.unpack(npedCoords)
                            local veh = GetVehiclePedIsIn(nped)
                            local weap = Armas[GetSelectedPedWeapon(nped)] or ''
                            if not IsPedInAnyVehicle(nped, false) then
                                DrawText3D(x,y,z+0.85, GetPlayerName(v) .. ' ' .. '~r~(HP: ' .. GetEntityHealth(nped) .. ')\n~b~[ID]: ' .. tablet.user_id .. ' ' .. tablet.name .. '\n~y~'..weap)
                            else
                                local seat = GetPedInVehicleSeat(veh, -1)
                                local seat2 = GetPedInVehicleSeat(veh, 0)
                                local seat3 = GetPedInVehicleSeat(veh, 1)
                                local seat4 = GetPedInVehicleSeat(veh, 2)
                                local seat5 = GetPedInVehicleSeat(veh, 3)
                                local seat6 = GetPedInVehicleSeat(veh, 4)
                                local seat7 = GetPedInVehicleSeat(veh, 5)
                                local seat8 = GetPedInVehicleSeat(veh, 6)
                                if seat == nped then
                                    DrawText3D(x-0.8,y+0.8,z+0.85, GetPlayerName(v) .. ' ' .. '~r~(HP: ' .. GetEntityHealth(nped) .. ')\n~b~[ID]: ' .. tablet.user_id .. ' ' .. tablet.name .. '\n~y~P1'..'\n'..weap)

                                elseif seat2 == nped then
                                    DrawText3D(x+0.8,y+0.8,z+0.85, GetPlayerName(v) .. ' ' .. '~r~(HP: ' .. GetEntityHealth(nped) .. ')\n~b~[ID]: ' .. tablet.user_id .. ' ' .. tablet.name .. '\n~y~P2'..'\n'..weap)

                                elseif seat3 == nped then
                                    DrawText3D(x-0.8,y,z+0.85, GetPlayerName(v) .. ' ' .. '~r~(HP: ' .. GetEntityHealth(nped) .. ')\n~b~[ID]: ' .. tablet.user_id .. ' ' .. tablet.name .. '\n~y~P3'..'\n'..weap)

                                elseif seat4 == nped then
                                    DrawText3D(x+0.8,y,z+0.85, GetPlayerName(v) .. ' ' .. '~r~(HP: ' .. GetEntityHealth(nped) .. ')\n~b~[ID]: ' .. tablet.user_id .. ' ' .. tablet.name .. '\n~y~P4'..'\n'..weap)

                                elseif seat5 == nped then
                                    DrawText3D(x-0.8,y-0.8,z+0.85, GetPlayerName(v) .. ' ' .. '~r~(HP: ' .. GetEntityHealth(nped) .. ')\n~b~[ID]: ' .. tablet.user_id .. ' ' .. tablet.name .. '\n~y~P5'..'\n'..weap)

                                elseif seat6 == nped then
                                    DrawText3D(x+0.8,y-0.8,z+0.85, GetPlayerName(v) .. ' ' .. '~r~(HP: ' .. GetEntityHealth(nped) .. ')\n~b~[ID]: ' .. tablet.user_id .. ' ' .. tablet.name .. '\n~y~P6'..'\n'..weap)

                                elseif seat7 == nped then
                                    DrawText3D(x-0.8,y-0.16,z+0.85, GetPlayerName(v) .. ' ' .. '~r~(HP: ' .. GetEntityHealth(nped) .. ')\n~b~[ID]: ' .. tablet.user_id .. ' ' .. tablet.name .. '\n~y~P7'..'\n'..weap)

                                elseif seat8 == nped then
                                    DrawText3D(x+0.8,y-0.16,z+0.85, GetPlayerName(v) .. ' ' .. '~r~(HP: ' .. GetEntityHealth(nped) .. ')\n~b~[ID]: ' .. tablet.user_id .. ' ' .. tablet.name .. '\n~y~P8'..'\n'..weap)

                                end
                            end
                        end
                    end
                end
            end

        end
        Wait(ThreadDelay)
    end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vec3(px,py,pz) - vec3(x,y,z))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.4, 0.4)
        SetTextColour(255,255,255,255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 150)
        SetTextDropshadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local biguos = {}
local ModoDominas = false
local distanciaAdm = 1500 
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('amreset2', function(source, args, rawCmd)
    players = {}
    ModoDominas = false
    print('Modo dominas reset')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('amdistance',function(source, args, rawCmd)
    if args[1] then
        distanciaAdm = parseInt(args[1])
        print('Distancia alterada para '..distanciaAdm) 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.updateList(status)
    biguos = status 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEAM
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.ModoDominasAd()
    if ModoDominas then
        TriggerEvent('Notify', 'aviso', 'MODO ADMIN Modo dominas <b>desativado</b>.')
        ModoDominas = false
        vSERVER.reportLog("Desativado")
        return false
    else
        TriggerEvent('Notify', 'aviso', 'MODO ADMIN Modo dominas <b>ativado</b>.')
        ModoDominas = true
        vSERVER.reportLog("Ativado")
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AM : THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 5000
        if ModoDominas then
            timeDistance = 1
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            
            for k,v in pairs(GetActivePlayers()) do 
                local nsource = GetPlayerServerId(v)
                local nped = GetPlayerPed(v)
                local ncoords = GetEntityCoords(nped)
                if ped ~= nped then
                    if biguos[nsource] and biguos[nsource] ~= nil and nped and nped ~= nil then
                        if #(coords - ncoords) <= distanciaAdm then
                            local data = biguos[nsource]
                           	if GetEntityHealth(nped) <= 101 then
                           	    dwText(ncoords.x,ncoords.y,ncoords.z+0.85,"(~b~"..data.user_id.."~w~) "..data.name.." (~r~MORTO~w~)")
                           	else
								if data.job == '' then
									if data.gerente == '' then
										dwText(ncoords.x,ncoords.y,ncoords.z+0.85,"(~b~"..data.user_id.."~w~) "..data.name.." \n~b~VIDA:~w~ "..GetEntityHealth(nped).." ")
									else
										dwText(ncoords.x,ncoords.y,ncoords.z+0.85,"(~b~"..data.user_id.."~w~) "..data.name.." \n~b~STAFF: ~w~"..data.gerente.." \n~b~VIDA:~w~ "..GetEntityHealth(nped).." ")
									end
								else
									if data.gerente == '' then
										dwText(ncoords.x,ncoords.y,ncoords.z+0.85,"(~b~"..data.user_id.."~w~) "..data.name.." \n~b~SET: ~w~"..data.job.." \n~b~VIDA:~w~ "..GetEntityHealth(nped).." ")
									else
                           	    		dwText(ncoords.x,ncoords.y,ncoords.z+0.85,"(~b~"..data.user_id.."~w~) "..data.name.." \n~b~SET: ~w~"..data.job.." \n~b~STAFF: ~w~"..data.gerente.." \n~b~VIDA:~w~ "..GetEntityHealth(nped).." ")
									end
								end
                           	end
                        end
                    end
                end
            end
        end
        Wait(timeDistance) 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local dist = #(GetGameplayCamCoords() - vec3(x, y, z))

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.3, 0.3)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 150)
        SetTextDropshadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ZERAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterNetEvent('waze:ZerarInv')
--AddEventHandler('waze:ZerarInv', function()
--	TriggerServerEvent('clearInventory')
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ZERAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:ZerarArmas')
AddEventHandler('waze:ZerarArmas', function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR NO CARRO TELEGUIADO 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:SetarDentroDocarro')
AddEventHandler('waze:SetarDentroDocarro', function(nsource)
	local nplayer = GetPlayerFromServerId(nsource)
	local nped = GetPlayerPed(nplayer)
	local ncarro = GetVehiclePedIsUsing(nped)
	local ped = PlayerPedId()
	if ncarro then
		SetPedIntoVehicle(ped, ncarro, -2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR NO CARRO TELEGUIADO 2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:SetarDentroDocarro2')
AddEventHandler('waze:SetarDentroDocarro2', function()
	local ped = PlayerPedId()
	local ncarro = vRP.getNearestVehicle(15)
	if IsVehicleSeatFree(ncarro, -1) then
		SetPedIntoVehicle(ped, ncarro, -1)
	else
		SetPedIntoVehicle(ped, ncarro, -2)
	end
end)

RegisterNetEvent('waze:VerCustom:MostrarCl')
AddEventHandler('waze:VerCustom:MostrarCl', function()
	local ped = PlayerPedId()
	local custom = {}
	custom[1] = { GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1) }
	custom[3] = { GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3) }
	custom[4] = { GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4) }
	custom[5] = { GetPedDrawableVariation(ped,5),GetPedTextureVariation(ped,5) }
	custom[6] = { GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6) }
	custom[7] = { GetPedDrawableVariation(ped,7),GetPedTextureVariation(ped,7) }
	custom[8] = { GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8) }
	custom[9] = { GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9) }
	custom[10] = { GetPedDrawableVariation(ped,10),GetPedTextureVariation(ped,10) }
	custom[11] = { GetPedDrawableVariation(ped,11),GetPedTextureVariation(ped,11) }
	custom["p0"] = { GetPedPropIndex(ped,0),math.max(GetPedPropTextureIndex(ped,0),0) }
	custom["p1"] = { GetPedPropIndex(ped,1),math.max(GetPedPropTextureIndex(ped,1),0) }
	custom["p2"] = { GetPedPropIndex(ped,2),math.max(GetPedPropTextureIndex(ped,2),0) }
	custom["p6"] = { GetPedPropIndex(ped,6),math.max(GetPedPropTextureIndex(ped,6),0) }
	custom["p7"] = { GetPedPropIndex(ped,7),math.max(GetPedPropTextureIndex(ped,7),0) }
	TriggerServerEvent('waze:VerCustom:Mostrar', custom) 
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VCOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('carroCor')
AddEventHandler('carroCor',function(vehicle, r, g, b)
	TriggerServerEvent("trycorveh",VehToNet(vehicle), r, g, b)
end)
RegisterNetEvent("synccorveh")
AddEventHandler("synccorveh",function(index, r, g, b)
	CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				SetVehicleCustomPrimaryColour(v, r, g, b)
				SetVehicleCustomSecondaryColour(v, r, g, b)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PINTAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('pintarveiculo')
AddEventHandler('pintarveiculo',function(vehicle, tipo, valor)
	TriggerServerEvent("trypintarveh",VehToNet(vehicle), tipo, valor)
end)
RegisterNetEvent("syncpintarveh")
AddEventHandler("syncpintarveh",function(index, tipo, valor)
	CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				SetVehicleModColor_1(v, tipo, valor, 0)
				SetVehicleModColor_2(v, tipo, valor)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPAR PLAYER - /marcar
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:MarcarPlayer')
AddEventHandler('waze:MarcarPlayer',function(x,y,z,id)
	jogador = AddBlipForCoord(x,y,z)
	SetBlipSprite(jogador,126)
	SetBlipColour(jogador,43)
	SetBlipScale(jogador,0.4)
	SetBlipAsShortRange(jogador,false)
	SetBlipRoute(jogador,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("ID " .. id)
	EndTextCommandSetBlipName(jogador)
	Wait(60000)
	if jogador then
		RemoveBlip(jogador)
	end
end)

RegisterNetEvent('waze:rMarcarPlayer')
AddEventHandler('waze:rMarcarPlayer',function()
	RemoveBlip(jogador)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:MarcarGps')
AddEventHandler('waze:MarcarGps', function (x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("waze:RepararMotor")
AddEventHandler("waze:RepararMotor",function(vida)
    SetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), false), vida)
end)

--local ArmasDlog = {
--    [GetHashKey('WEAPON_UNARMED')] = 'WEAPON_UNARMED',
--    [GetHashKey('WEAPON_KNIFE')] = "WEAPON_KNIFE",
--    [GetHashKey('WEAPON_NIGHTSTICK')] = "WEAPON_NIGHTSTICK",
--    [GetHashKey('WEAPON_HAMMER')] = "WEAPON_HAMMER",
--    [GetHashKey('WEAPON_BAT')] = "WEAPON_BAT",
--    [GetHashKey('WEAPON_GOLFCLUB')] = "WEAPON_GOLFCLUB",
--    [GetHashKey('WEAPON_CROWBAR')] = "WEAPON_CROWBAR",
--    [GetHashKey('WEAPON_PISTOL')] = "WEAPON_PISTOL",
--    [GetHashKey('WEAPON_COMBATPISTOL')] = "WEAPON_COMBATPISTOL",
--    [GetHashKey('WEAPON_APPISTOL')] = "WEAPON_APPISTOL",
--    [GetHashKey('WEAPON_PISTOL50')] = "WEAPON_PISTOL50",
--    [GetHashKey('WEAPON_MICROSMG')] = "WEAPON_MICROSMG",
--    [GetHashKey('WEAPON_SMG')] = "WEAPON_SMG",
--    [GetHashKey('WEAPON_ASSAULTSMG')] = "WEAPON_ASSAULTSMG",
--    [GetHashKey('WEAPON_ASSAULTRIFLE')] = "WEAPON_ASSAULTRIFLE",
--    [GetHashKey('WEAPON_CARBINERIFLE')] = "WEAPON_CARBINERIFLE",
--    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = "WEAPON_ADVANCEDRIFLE",
--    [GetHashKey('WEAPON_MG')] = "WEAPON_MG",
--    [GetHashKey('WEAPON_COMBATMG')] = "WEAPON_COMBATMG",
--    [GetHashKey('WEAPON_PUMPSHOTGUN')] = "WEAPON_PUMPSHOTGUN",
--    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = "WEAPON_SAWNOFFSHOTGUN",
--    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = "WEAPON_ASSAULTSHOTGUN",
--    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = "WEAPON_BULLPUPSHOTGUN",
--    [GetHashKey('WEAPON_STUNGUN')] = "WEAPON_STUNGUN",
--    [GetHashKey('WEAPON_SNIPERRIFLE')] = "WEAPON_SNIPERRIFLE",
--    [GetHashKey('WEAPON_HEAVYSNIPER')] = "WEAPON_HEAVYSNIPER",
--    [GetHashKey('WEAPON_GRENADELAUNCHER')] = "WEAPON_GRENADELAUNCHER",
--    [GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE')] = 'WEAPON_GRENADELAUNCHER_SMOKE',
--    [GetHashKey('WEAPON_RPG')] = "WEAPON_RPG",
--    [GetHashKey('WEAPON_MINIGUN')] = "WEAPON_MINIGUN",
--    [GetHashKey('WEAPON_GRENADE')] = "WEAPON_GRENADE",
--    [GetHashKey('WEAPON_STICKYBOMB')] = "WEAPON_STICKYBOMB",
--    [GetHashKey('WEAPON_SMOKEGRENADE')] = "WEAPON_SMOKEGRENADE",
--    [GetHashKey('WEAPON_BZGAS')] = "WEAPON_BZGAS",
--    [GetHashKey('WEAPON_MOLOTOV')] = "WEAPON_MOLOTOV",
--    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = "WEAPON_FIREEXTINGUISHER",
--    [GetHashKey('WEAPON_PETROLCAN')] = "WEAPON_PETROLCAN",
--    [GetHashKey('WEAPON_FLARE')] = "WEAPON_FLARE",
--    [GetHashKey('WEAPON_SNSPISTOL')] = "WEAPON_SNSPISTOL",
--    [GetHashKey('WEAPON_SPECIALCARBINE')] = "WEAPON_SPECIALCARBINE",
--    [GetHashKey('WEAPON_HEAVYPISTOL')] = "WEAPON_HEAVYPISTOL",
--    [GetHashKey('WEAPON_BULLPUPRIFLE')] = "WEAPON_BULLPUPRIFLE",
--    [GetHashKey('WEAPON_HOMINGLAUNCHER')] = "WEAPON_HOMINGLAUNCHER",
--    [GetHashKey('WEAPON_PROXMINE')] = "WEAPON_PROXMINE",
--    [GetHashKey('WEAPON_SNOWBALL')] = "WEAPON_SNOWBALL",
--    [GetHashKey('WEAPON_VINTAGEPISTOL')] = "WEAPON_VINTAGEPISTOL",
--    [GetHashKey('WEAPON_DAGGER')] = "WEAPON_DAGGER",
--    [GetHashKey('WEAPON_FIREWORK')] = "WEAPON_FIREWORK",
--    [GetHashKey('WEAPON_MUSKET')] = "WEAPON_MUSKET",
--    [GetHashKey('WEAPON_MARKSMANRIFLE')] = "WEAPON_MARKSMANRIFLE",
--    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = "WEAPON_HEAVYSHOTGUN",
--    [GetHashKey('WEAPON_GUSENBERG')] = "WEAPON_GUSENBERG",
--    [GetHashKey('WEAPON_HATCHET')] = "WEAPON_HATCHET",
--    [GetHashKey('WEAPON_RAILGUN')] = "WEAPON_RAILGUN",
--    [GetHashKey('WEAPON_COMBATPDW')] = "WEAPON_COMBATPDW",
--    [GetHashKey('WEAPON_KNUCKLE')] = "WEAPON_KNUCKLE",
--    [GetHashKey('WEAPON_MARKSMANPISTOL')] = "WEAPON_MARKSMANPISTOL",
--    [GetHashKey('WEAPON_FLASHLIGHT')] = "WEAPON_FLASHLIGHT",
--    [GetHashKey('WEAPON_MACHETE')] = "WEAPON_MACHETE",
--    [GetHashKey('WEAPON_MACHINEPISTOL')] = "WEAPON_MACHINEPISTOL",
--    [GetHashKey('WEAPON_SWITCHBLADE')] = "WEAPON_SWITCHBLADE",
--    [GetHashKey('WEAPON_REVOLVER')] = "WEAPON_REVOLVER",
--    [GetHashKey('WEAPON_COMPACTRIFLE')] = "WEAPON_COMPACTRIFLE",
--    [GetHashKey('WEAPON_DBSHOTGUN')] = "WEAPON_DBSHOTGUN",
--    [GetHashKey('WEAPON_FLAREGUN')] = "WEAPON_FLAREGUN",
--    [GetHashKey('WEAPON_AUTOSHOTGUN')] = "WEAPON_AUTOSHOTGUN",
--    [GetHashKey('WEAPON_BATTLEAXE')] = "WEAPON_BATTLEAXE",
--    [GetHashKey('WEAPON_COMPACTLAUNCHER')] = "WEAPON_COMPACTLAUNCHER",
--    [GetHashKey('WEAPON_MINISMG')] = "WEAPON_MINISMG",
--    [GetHashKey('WEAPON_PIPEBOMB')] = "WEAPON_PIPEBOMB",
--    [GetHashKey('WEAPON_POOLCUE')] = "WEAPON_POOLCUE",
--    [GetHashKey('WEAPON_SWEEPER')] = "WEAPON_SWEEPER",
--    [GetHashKey('WEAPON_WRENCH')] = "WEAPON_WRENCH",
--    [GetHashKey('WEAPON_PISTOL_MK2')] =  "WEAPON_PISTOL_MK2",
--    [GetHashKey('WEAPON_SNSPISTOL_MK2')] =  "WEAPON_SNSPISTOL_MK2",
--    [GetHashKey('WEAPON_REVOLVER_MK2')] =  "WEAPON_REVOLVER_MK2",
--    [GetHashKey('WEAPON_SMG_MK2')] =  "WEAPON_SMG_MK2",
--    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] =  "WEAPON_PUMPSHOTGUN_MK2",
--    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] =  "WEAPON_ASSAULTRIFLE_MK2",
--    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] =  "WEAPON_CARBINERIFLE_MK2",
--    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] =  "WEAPON_SPECIALCARBINE_MK2",
--    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] =  "WEAPON_BULLPUPRIFLE_MK2",
--    [GetHashKey('WEAPON_COMBATMG_MK2')] =  "WEAPON_COMBATMG_MK2",
--    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] =  "WEAPON_HEAVYSNIPER_MK2",
--    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] =  "WEAPON_MARKSMANRIFLE_MK2"
--}
--
--
--AddEventHandler('gameEventTriggered',function(event,args)
--    if event == 'CEventNetworkEntityDamage' then
--		if PlayerPedId() == args[1] then
--            if GetEntityHealth(args[1]) <= 101 then
--
--                local arma = 'DESCONHECIDO'
--                if ArmasDlog[args[7]] then
--                    arma = ArmasDlog[args[7]]
--                end
--
--                local index = NetworkGetPlayerIndexFromPed(args[2]);
--                local src = GetPlayerServerId(index);
--                TriggerServerEvent('waze:DLog',src,arma);
--            end 
--        end 
--    end
--end)

--local inTrunk = false
--RegisterNetEvent("vrp_admin:EnterTrunk")
--AddEventHandler("vrp_admin:EnterTrunk",function()
--	local ped = PlayerPedId()
--
--	if not inTrunk then
--		local vehicle = vRP.vehList(11)
--		if DoesEntityExist(vehicle) then
--			local trunk = GetEntityBoneIndexByName(vehicle,"boot")
--			if trunk ~= -1 then
--				local coords = GetEntityCoords(ped)
--				local coordsEnt = GetWorldPositionOfEntityBone(vehicle,trunk)
--				local distance = #(coords - coordsEnt)
--				if distance <= 3.0 then
--					timeDistance = 4
--					if GetVehicleDoorAngleRatio(vehicle,5) < 0.9 and GetVehicleDoorsLockedForPlayer(vehicle,PlayerId()) ~= 1 then
--						SetCarBootOpen(vehicle)
--						SetEntityVisible(ped,false,false)
--						Wait(750)
--						AttachEntityToEntity(ped,vehicle,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
--						inTrunk = true
--						Wait(500)
--						SetVehicleDoorShut(vehicle,5)
--					end
--				end
--			end
--		end
--	end
--end)
--
--RegisterNetEvent("vrp_admin:CheckTrunk")
--AddEventHandler("vrp_admin:CheckTrunk",function()
--	local ped = PlayerPedId()
--
--	if inTrunk then
--		local vehicle = GetEntityAttachedTo(ped)
--		if DoesEntityExist(vehicle) then
--			SetCarBootOpen(vehicle)
--			Wait(750)
--			inTrunk = false
--			DetachEntity(ped,false,false)
--			SetEntityVisible(ped,true,false)
--			SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
--			Wait(500)
--			SetVehicleDoorShut(vehicle,5)
--		end
--	end
--end)
--
--CreateThread(function()
--	while true do
--		local timeDistance = 500
--
--		if inTrunk then
--			local ped = PlayerPedId()
--			local vehicle = GetEntityAttachedTo(ped)
--			if DoesEntityExist(vehicle) then
--				timeDistance = 4
--
--				DisableControlAction(1,73,true)
--				DisableControlAction(1,29,true)
--				DisableControlAction(1,47,true)
--				DisableControlAction(1,187,true)
--				DisableControlAction(1,189,true)
--				DisableControlAction(1,190,true)
--				DisableControlAction(1,188,true)
--				DisableControlAction(1,311,true)
--				DisableControlAction(1,245,true)
--				DisableControlAction(1,257,true)
--				DisableControlAction(1,167,true)
--				DisableControlAction(1,140,true)
--				DisableControlAction(1,141,true)
--				DisableControlAction(1,142,true)
--				DisableControlAction(1,137,true)
--				DisableControlAction(1,37,true)
--				DisablePlayerFiring(ped,true)
--
--				if IsEntityVisible(ped) then
--					SetEntityVisible(ped,false,false)
--				end
--
--				if IsControlJustPressed(1,38) then
--					SetCarBootOpen(vehicle)
--					Wait(750)
--					inTrunk = false
--					DetachEntity(ped,false,false)
--					SetEntityVisible(ped,true,false)
--					SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
--					Wait(500)
--					SetVehicleDoorShut(vehicle,5)
--				end
--			else
--				inTrunk = false
--				DetachEntity(ped,false,false)
--				SetEntityVisible(ped,true,false)
--				SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
--			end
--		end
--		Wait(timeDistance)
--	end
--end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('waze:AdmAviso')
AddEventHandler('waze:AdmAviso',function(titulo, msg, tempo)
	CreateThread(function()
        local scaleform =  RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
        while not HasScaleformMovieLoaded(scaleform) do Wait(0) end
        BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
        PushScaleformMovieMethodParameterString(titulo)
        PushScaleformMovieMethodParameterString(msg)
        EndScaleformMovieMethod()
        PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS")

        while tempo > 0 do
            Wait(1)
            tempo = tempo - 0.01

            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end

		SetScaleformMovieAsNoLongerNeeded(scaleform)
		
	end)
end)

local wasd = false
local drifttroll = false
function waze.CheckWasd()
	wasd = not wasd
	return wasd
end

function waze.CheckDrift()
	drifttroll = not drifttroll
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsIn(ped, false)
		SetVehicleReduceGrip(veh,drifttroll)
	end
	return drifttroll
end

CreateThread(function() 
	while true do
		local ThreadDelay = 2000
		local ped = PlayerPedId()
		if drifttroll then
			ThreadDelay = 5
			if IsPedInAnyVehicle(ped, false) then
				local veh = GetVehiclePedIsIn(ped, false)
				SetVehicleReduceGrip(veh,true)
			end
		end

		if wasd then
			ThreadDelay = 5
			for i = 0, 357 do
				DisableControlAction(0, i, true)
			end
		end
		Wait(ThreadDelay)
	end
end)