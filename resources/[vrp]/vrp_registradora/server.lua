local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_registradora",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
CreateThread(function()
	while true do
		Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ubiBAERTGIKASdasa
-----------------------------------------------------------------------------------------------------------------------------------------
function func.ubiBAERTGIKASdasa(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 0 then
			if timers[id] == 0 or not timers[id] then
				timers[id] = 600
				TriggerClientEvent('iniciandoregistradora',source,head,x,y,z)
				local random = math.random(100)
				if random >= 50 then
					TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.",8000)
					TriggerClientEvent("vrp_sound:source",source,'alarm',0.1)
					vRPclient.setStandBY(source,parseInt(180))
					for l,w in pairs(policia) do
						local player = vRP.getUserSource(parseInt(w))
						if player then
							async(function()
								local ids = idgens:gen()
								blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo à registradora",0.5,true)
								TriggerClientEvent("NotifyPush",player,{ code = 31, title = "Roubo à caixa registradora", x = x, y = y, z = z })
								SetTimeout(60000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
							end)
						end
					end
				end
				return true
			else
				TriggerClientEvent("Notify",source,"aviso","A registradora está vazia, aguarde <b>"..timers[id].." segundos</b> até que tenha dinheiro novamente.",8000)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
		end
		return false
	end
end

function func.iubAISUdBAOnIGoubda(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local dinsujo = math.random(4500,10000)
	exports["waze-system"]:sendLogs(user_id,{ webhook = "robMachine", text = "Roubou a Caixa Registradora #"..id.." ("..x..", ".. y..", "..z..")\nValor ganho: $"..vRP.format(dinsujo) })
	vRP.giveInventoryItem(user_id,"dinheirosujo",dinsujo)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	-- return true
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"medico.permissao") or vRP.hasPermission(user_id,"Paisanapolicia.permissao") or vRP.hasPermission(user_id,"Paisanamedico.permissao"))
end