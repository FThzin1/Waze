-----------------------------------------------------------------------------------------------------------------------------------------
-- CONECTAR A VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local mrqz = {}
Tunnel.bindInterface(GetCurrentResourceName(),mrqz)
vServer = Tunnel.getInterface(GetCurrentResourceName())

function ToggleActionMenu()
    SetNuiFocus(true,true)
    SendNUIMessage({ action = 'open' })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGIN SPAWNS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("spawn", function(data, cb)
	for k,v in pairs(Shared.Spawns) do
		if data.name == v.name  then
			SetEntityCoords(PlayerPedId(), v.cds.x, v.cds.y, v.cds.z)
		end
	end
	
	if data.name == "delegacia" then 
		if vServer.checkPol() then 
			for k,v in pairs(Shared.Spawns) do 
				if data.name == v.name  then
					SetEntityCoords(PlayerPedId(), v.cds.x, v.cds.y, v.cds.z)
				end
			end
		else
			SetEntityCoords(PlayerPedId(),203.45,-804.66,31.03)
		end
	end

	if data.name == "base" then 
		local x,y,z = vServer.tpbase()
		print(x,y,z)
		if vServer.checkBase() then 
			SetEntityCoords(PlayerPedId(),x,y,z)
		else
			SetEntityCoords(PlayerPedId(),203.45,-804.66,31.03)
		end
	end
	
	if data.name == "ultima-loc" then
		TriggerEvent("ToogleBackCharacter")
	end

    SendNUIMessage({ action = "close" })
    SetNuiFocus(false,false)
    TriggerEvent("ToogleBackCharacter")
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rusher_login:startShowing')
AddEventHandler('rusher_login:startShowing', function()
	ToggleActionMenu()
end)

RegisterCommand("spawnn",function(source,args,rawCommand)
	ToggleActionMenu()

end)