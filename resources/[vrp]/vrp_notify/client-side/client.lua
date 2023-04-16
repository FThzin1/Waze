local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vSERVER = Tunnel.getInterface('vrp_notify')

rusher = {}
Tunnel.bindInterface('vrp_notify', rusher)

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local adm = false
function rusher.tAdm()
    adm = not adm
    if adm then
        TriggerEvent('Notify', "sucesso", 'DEATH NOTIFY Ativada.')
    else
        TriggerEvent('Notify', "sucesso", 'DEATH NOTIFY Desativada.')
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,prefix,mensagem,timer)
	if not timer then timer = 9000 end
	if mensagem == nil or mensagem == 'undefined' or mensagem == 1000 or mensagem == 2000 or mensagem == 3000 or mensagem == 4000 or mensagem == 5000 or mensagem == 6000 or mensagem == 7000 or mensagem == 8000 or mensagem == 9000 or mensagem == 10000 or mensagem == 20000 or mensagem == 35000 then
		mensagem = prefix
	end
	SendNUIMessage({ show = "notify", type = css, message = mensagem, time = timer })
end)

local WeaponsCode = {
    [GetHashKey('WEAPON_UNARMED')] = 'WEAPON_UNARMED',
    [GetHashKey('WEAPON_KNIFE')] = "WEAPON_KNIFE",
    [GetHashKey('WEAPON_NIGHTSTICK')] = "WEAPON_NIGHTSTICK",
    [GetHashKey('WEAPON_HAMMER')] = "WEAPON_HAMMER",
    [GetHashKey('WEAPON_BAT')] = "WEAPON_BAT",
    [GetHashKey('WEAPON_GOLFCLUB')] = "WEAPON_GOLFCLUB",
    [GetHashKey('WEAPON_CROWBAR')] = "WEAPON_CROWBAR",
    [GetHashKey('WEAPON_PISTOL')] = "WEAPON_PISTOL",
    [GetHashKey('WEAPON_COMBATPISTOL')] = "WEAPON_COMBATPISTOL",
    [GetHashKey('WEAPON_APPISTOL')] = "WEAPON_APPISTOL",
    [GetHashKey('WEAPON_PISTOL50')] = "WEAPON_PISTOL50",
    [GetHashKey('WEAPON_MICROSMG')] = "WEAPON_MICROSMG",
    [GetHashKey('WEAPON_SMG')] = "WEAPON_SMG",
    [GetHashKey('WEAPON_ASSAULTSMG')] = "WEAPON_ASSAULTSMG",
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey('WEAPON_CARBINERIFLE')] = "WEAPON_CARBINERIFLE",
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = "WEAPON_ADVANCEDRIFLE",
    [GetHashKey('WEAPON_MG')] = "WEAPON_MG",
    [GetHashKey('WEAPON_COMBATMG')] = "WEAPON_COMBATMG",
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = "WEAPON_PUMPSHOTGUN",
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = "WEAPON_SAWNOFFSHOTGUN",
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = "WEAPON_ASSAULTSHOTGUN",
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = "WEAPON_BULLPUPSHOTGUN",
    [GetHashKey('WEAPON_STUNGUN')] = "WEAPON_STUNGUN",
    [GetHashKey('WEAPON_SNIPERRIFLE')] = "WEAPON_SNIPERRIFLE",
    [GetHashKey('WEAPON_HEAVYSNIPER')] = "WEAPON_HEAVYSNIPER",
    [GetHashKey('WEAPON_GRENADELAUNCHER')] = "WEAPON_GRENADELAUNCHER",
    [GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE')] = 'WEAPON_GRENADELAUNCHER_SMOKE',
    [GetHashKey('WEAPON_RPG')] = "WEAPON_RPG",
    [GetHashKey('WEAPON_MINIGUN')] = "WEAPON_MINIGUN",
    [GetHashKey('WEAPON_GRENADE')] = "WEAPON_GRENADE",
    [GetHashKey('WEAPON_STICKYBOMB')] = "WEAPON_STICKYBOMB",
    [GetHashKey('WEAPON_SMOKEGRENADE')] = "WEAPON_SMOKEGRENADE",
    [GetHashKey('WEAPON_BZGAS')] = "WEAPON_BZGAS",
    [GetHashKey('WEAPON_MOLOTOV')] = "WEAPON_MOLOTOV",
    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = "WEAPON_FIREEXTINGUISHER",
    [GetHashKey('WEAPON_PETROLCAN')] = "WEAPON_PETROLCAN",
    [GetHashKey('WEAPON_FLARE')] = "WEAPON_FLARE",
    [GetHashKey('WEAPON_SNSPISTOL')] = "WEAPON_SNSPISTOL",
    [GetHashKey('WEAPON_SPECIALCARBINE')] = "WEAPON_SPECIALCARBINE",
    [GetHashKey('WEAPON_HEAVYPISTOL')] = "WEAPON_HEAVYPISTOL",
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = "WEAPON_BULLPUPRIFLE",
    [GetHashKey('WEAPON_HOMINGLAUNCHER')] = "WEAPON_HOMINGLAUNCHER",
    [GetHashKey('WEAPON_PROXMINE')] = "WEAPON_PROXMINE",
    [GetHashKey('WEAPON_SNOWBALL')] = "WEAPON_SNOWBALL",
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = "WEAPON_VINTAGEPISTOL",
    [GetHashKey('WEAPON_DAGGER')] = "WEAPON_DAGGER",
    [GetHashKey('WEAPON_FIREWORK')] = "WEAPON_FIREWORK",
    [GetHashKey('WEAPON_MUSKET')] = "WEAPON_MUSKET",
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = "WEAPON_MARKSMANRIFLE",
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = "WEAPON_HEAVYSHOTGUN",
    [GetHashKey('WEAPON_GUSENBERG')] = "WEAPON_GUSENBERG",
    [GetHashKey('WEAPON_HATCHET')] = "WEAPON_HATCHET",
    [GetHashKey('WEAPON_RAILGUN')] = "WEAPON_RAILGUN",
    [GetHashKey('WEAPON_COMBATPDW')] = "WEAPON_COMBATPDW",
    [GetHashKey('WEAPON_KNUCKLE')] = "WEAPON_KNUCKLE",
    [GetHashKey('WEAPON_MARKSMANPISTOL')] = "WEAPON_MARKSMANPISTOL",
    [GetHashKey('WEAPON_FLASHLIGHT')] = "WEAPON_FLASHLIGHT",
    [GetHashKey('WEAPON_MACHETE')] = "WEAPON_MACHETE",
    [GetHashKey('WEAPON_MACHINEPISTOL')] = "WEAPON_MACHINEPISTOL",
    [GetHashKey('WEAPON_SWITCHBLADE')] = "WEAPON_SWITCHBLADE",
    [GetHashKey('WEAPON_REVOLVER')] = "WEAPON_REVOLVER",
    [GetHashKey('WEAPON_COMPACTRIFLE')] = "WEAPON_COMPACTRIFLE",
    [GetHashKey('WEAPON_DBSHOTGUN')] = "WEAPON_DBSHOTGUN",
    [GetHashKey('WEAPON_FLAREGUN')] = "WEAPON_FLAREGUN",
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = "WEAPON_AUTOSHOTGUN",
    [GetHashKey('WEAPON_BATTLEAXE')] = "WEAPON_BATTLEAXE",
    [GetHashKey('WEAPON_COMPACTLAUNCHER')] = "WEAPON_COMPACTLAUNCHER",
    [GetHashKey('WEAPON_MINISMG')] = "WEAPON_MINISMG",
    [GetHashKey('WEAPON_PIPEBOMB')] = "WEAPON_PIPEBOMB",
    [GetHashKey('WEAPON_POOLCUE')] = "WEAPON_POOLCUE",
    [GetHashKey('WEAPON_SWEEPER')] = "WEAPON_SWEEPER",
    [GetHashKey('WEAPON_WRENCH')] = "WEAPON_WRENCH",
    [GetHashKey('WEAPON_PISTOL_MK2')] =  "WEAPON_PISTOL_MK2",
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] =  "WEAPON_SNSPISTOL_MK2",
    [GetHashKey('WEAPON_REVOLVER_MK2')] =  "WEAPON_REVOLVER_MK2",
    [GetHashKey('WEAPON_SMG_MK2')] =  "WEAPON_SMG_MK2",
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] =  "WEAPON_PUMPSHOTGUN_MK2",
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] =  "WEAPON_ASSAULTRIFLE_MK2",
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] =  "WEAPON_CARBINERIFLE_MK2",
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] =  "WEAPON_SPECIALCARBINE_MK2",
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] =  "WEAPON_BULLPUPRIFLE_MK2",
    [GetHashKey('WEAPON_COMBATMG_MK2')] =  "WEAPON_COMBATMG_MK2",
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] =  "WEAPON_HEAVYSNIPER_MK2",
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] =  "WEAPON_MARKSMANRIFLE_MK2"
} 

AddEventHandler('gameEventTriggered',function(event,args)
    if event == 'CEventNetworkEntityDamage' then
		if PlayerPedId() == args[1] then
            if GetEntityHealth(args[1]) <= 101 then

                local arma = 'DESCONHECIDO'
                if WeaponsCode[args[7]] then
                    arma = WeaponsCode[args[7]]
                end

                local index = NetworkGetPlayerIndexFromPed(args[2]);
                local src = GetPlayerServerId(index);
                TriggerServerEvent('rusher:DLog',src,arma);
                TriggerEvent("vrp_policia:setCombatMode", 20)
            end 
        end 
    end
end)

RegisterNetEvent("NotifyKill")
AddEventHandler("NotifyKill",function(data,timer)
    if not timer or timer == "" then
		timer = 3000
	end
	if adm then
        SendNUIMessage({ kill = true, weapon = {string.upper(data.weapon_killer)}, killer = { name = data.killer_name}, victim = { name = data.victim_name} })
    end
end)