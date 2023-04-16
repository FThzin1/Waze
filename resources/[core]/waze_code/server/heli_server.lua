RegisterServerEvent("vrp_codes:Holofote")
AddEventHandler("vrp_codes:Holofote",function(state)
	local serverID = source
	TriggerClientEvent("vrp_codes:Holofote",-1,serverID,state)
end)