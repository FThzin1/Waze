-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_atm",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = 0
local recompensa = 0
local andamento = false
local dinheirosujo = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local caixas = {
	[1] = { ['seconds'] = 25 },
	[2] = { ['seconds'] = 39 },
	[3] = { ['seconds'] = 39 },
	[4] = { ['seconds'] = 35 },
	[5] = { ['seconds'] = 33 },
	[6] = { ['seconds'] = 33 },
	[7] = { ['seconds'] = 55 },
	[8] = { ['seconds'] = 39 },
	[9] = { ['seconds'] = 35 },
	[10] = { ['seconds'] = 60 },
	[11] = { ['seconds'] = 43 },
	[12] = { ['seconds'] = 27 },
	[13] = { ['seconds'] = 45 },
	[14] = { ['seconds'] = 50 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(x,y,z) --id,x,y,z,head
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia.permissao")
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if #policia <= 3 then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
			return false
		elseif (os.time()-timers) <= 1800 then
			TriggerClientEvent("Notify",source,"aviso","Os caixas estão vazios, aguarde <b>"..vRP.format(parseInt((1800-(os.time()-timers)))).." segundos</b> até que os civis depositem dinheiro.",8000)
			return false
		else
			andamento = true
			timers = os.time()
			dinheirosujo = {}
			vRPclient.setStandBY(source,parseInt(900))
			for l,w in pairs(policia) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('blip:criar:caixaeletronico',player,x,y,z)
						TriggerClientEvent("NotifyPush",player,{ code = 31, title = "Roubo à caixa eletrônico", x = x, y = y, z = z })
					end)
				end
			end
			exports["waze-system"]:sendLogs(user_id,{ webhook = "robATM", text = "Roubou um caixa eletrônico" })
			if player then
				async(function()
					TriggerClientEvent('blip:remover:caixaeletronico',player)
					--TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
				end)
			end
			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.cancelRobbery()
	if andamento then
		andamento = false
		local policia = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(policia) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent('blip:remover:caixaeletronico',player)
					--TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(1000)
		if andamento then
			for k,v in pairs(dinheirosujo) do
				if v > 0 then
					dinheirosujo[k] = v - 1
					vRP._giveInventoryItem(k,"dinheirosujo",recompensa)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paisanapolicia.permissao"))
end

function func.giveItens()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		random = math.random(30000,50000)
		vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(random))
		TriggerClientEvent("Notify",source,'sucesso',"Você roubou <b>"..random.."</b> de dinheiro sujo.")
	end
end

function func.getItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"bombacaseira",1) then
			return true
		else
			return false
		end
	end
end

function func.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"bombacaseira") >= 1 then
			return true
		else
			return false
		end
	end
end