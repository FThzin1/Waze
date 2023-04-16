local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
pizzA = {}
Tunnel.bindInterface("waze_uber",pizzA)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function pizzA.PegarPlaca()
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	return identity.registration
end

function pizzA.x6NiGfpALlLSxRi()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		randmoney = math.random(250,500)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"financeiro","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
		exports["waze-system"]:sendLogs(user_id,{ webhook = "worksPizza", text = "Recebeu $"..randmoney.." no emprego de entregador de pizza" })
		return true
	end
end