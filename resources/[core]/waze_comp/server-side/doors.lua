-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
startDoors = {}
Tunnel.bindInterface("vrp_doors",startDoors)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
local doors = {

	-- DEPARTAMENT POLICE  
	[1] = { ["x"] = 613.0, ["y"] = -10.91, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "policia.permissao", ["sound"] = true },
	[2] = { ["x"] = 608.99, ["y"] = -9.66, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "policia.permissao", ["sound"] = true },
	[3] = { ["x"] = 605.29, ["y"] = -8.22, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "policia.permissao", ["sound"] = true },
	[4] = { ["x"] = 601.33, ["y"] = -6.96, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "policia.permissao", ["sound"] = true },
	[5] = { ["x"] = 613.94, ["y"] = -1.68, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "policia.permissao", ["sound"] = true },

	[6] = { ["x"] = 619.55, ["y"] = -3.84, ["z"] = 82.78, ["hash"] = -1320876379, ["lock"] = false, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "policia.permissao", ["sound"] = true },
	[7] = { ["x"] = 620.45, ["y"] = 4.21, ["z"] = 82.78, ["hash"] = -626684119, ["lock"] = false, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "policia.permissao", ["sound"] = true },
	[8] = { ["x"] = 624.08, ["y"] = -15.76, ["z"] = 82.78, ["hash"] = -543497392, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "admin.permissao", ["sound"] = true },

	-- HOSPITAL 
	[9] = { ["x"] = 329.52, ["y"] = -585.62, ["z"] = 43.33, ["hash"] = -770740285, ["lock"] = false, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "medico.permissao", ["sound"] = true, ["other"] = 10 },
	[10] = { ["x"] = 329.90, ["y"] = -585.79, ["z"] = 43.33, ["hash"] = -770740285, ["lock"] = false, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "medico.permissao", ["sound"] = true, ["other"] = 9 },

	-- Ballas 
	[11] = { ["x"] = 1483.59, ["y"] = 6392.12, ["z"] = 23.34, ["hash"] = -147325430, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "ballas.permissao", ["sound"] = true },

	-- Grove
	[12] = { ["x"] = 97.32, ["y"] = 6327.68, ["z"] = 31.38, ["hash"] = -147325430, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "grove.permissao", ["sound"] = true },

	-- Grove
	[13] = { ["x"] = -1096.53, ["y"] = 6327.68, ["z"] = 218.47, ["hash"] = -147325430, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "vagos.permissao", ["sound"] = true },

	-- CRIPS
	[14] = { ["x"] = 1274.68, ["y"] = -1720.8, ["z"] = 54.69, ["hash"] = 1145337974, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "crips.permissao", ["sound"] = true },
	
	-- SCORP
	[15] = { ["x"] = 743.64, ["y"] = -1905.85, ["z"] = 29.3, ["hash"] = -1430323452, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "scripted.permissao", ["sound"] = true },

	-- BAHAMAS
	[16] = { ["x"] = -1387.56, ["y"] = -586.58, ["z"] = 30.23, ["hash"] = -131296141, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "bahamas.permissao", ["sound"] = true, ["other"] = 17 },
	[17] = { ["x"] = -1389.06, ["y"] = -587.32, ["z"] = 30.23, ["hash"] = -131296141, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "bahamas.permissao", ["sound"] = true, ["other"] = 16 },

	-- COSA NOSTRA
	[18] = { ["x"] = -1517.28, ["y"] = 851.71, ["z"] = 181.6, ["hash"] = 1033441082, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "siciliana.permissao", ["sound"] = true, ["other"] = 19 },
	[19] = { ["x"] = -1516.39, ["y"] = 851.28, ["z"] = 181.6, ["hash"] = 1033441082, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "siciliana.permissao", ["sound"] = true, ["other"] = 18 },
	[20] = { ["x"] = -1490.8, ["y"] = 852.71, ["z"] = 181.6, ["hash"] = 1033441082, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "siciliana.permissao", ["sound"] = true, ["other"] = 21 },
	[21] = { ["x"] = -1490.55, ["y"] = 851.78, ["z"] = 181.6, ["hash"] = 1033441082, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "siciliana.permissao", ["sound"] = true, ["other"] = 20 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function startDoors.doorsStatistics(doorNumber,doorStatus)
	local source = source

	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("vrp_doors:doorsUpdate",-1,doors)

	if doors[parseInt(doorNumber)].sound then
		TriggerClientEvent("vrp_sound:source",source,"doorlock",0.1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_doors:doorsStatistics")
AddEventHandler("vrp_doors:doorsStatistics",function(doorNumber,doorStatus)
	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("vrp_doors:doorsUpdate",-1,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function startDoors.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if doors[parseInt(doorNumber)].perm ~= nil then
			if vRP.hasPermission(user_id,doors[parseInt(doorNumber)].perm) then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_doors:doorsUpdate",source,doors)
end)

