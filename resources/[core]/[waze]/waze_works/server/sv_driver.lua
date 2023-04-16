-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
driveR = {}
Tunnel.bindInterface("vrp_driver",driveR)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function driveR.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(status,bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local value = (math.random(400,800)+bonus)

		if not status then
			vRP.giveMoney(user_id,parseInt(value))
		else
			vRP.giveMoney(user_id,parseInt(value))
		end
		TriggerClientEvent("Notify",source,"financeiro","Você recebeu <b>$"..vRP.format(parseInt(value)).." dólares</b>")
		exports["waze-system"]:sendLogs(user_id,{ webhook = "worksDriver", text = "Recebeu $"..value.." no emprego de motorista de ônibus" })
		TriggerClientEvent("vrp_sound:source",source,"coin",0.5)
	end
end