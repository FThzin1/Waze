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
Tunnel.bindInterface("barbershop",src)
vCLIENT = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateSkin(myClothes)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"currentCharacterMode", json.encode(myClothes))
		SetTimeout(1000, function()
			local value = vRP.getUData(user_id,"currentCharacterMode")
			if value ~= nil then
				local custom = json.decode(value) or {}
				vCLIENT.updateFacial(source,custom)
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESBUGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("desbugar",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local value = vRP.getUData(user_id,"currentCharacterMode")
		if value ~= nil then
			local custom = json.decode(value) or {}
			vCLIENT.setCharacter(source,custom)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('start-barbershop:init', function(user_id)
	local player = vRP.getUserSource(user_id)
	if player then
		local value = vRP.getUData(user_id,'currentCharacterMode')
		if value ~= nil then
			local custom = json.decode(value) or {}
			vCLIENT.setCharacter(player,custom)
		end
	end
end)