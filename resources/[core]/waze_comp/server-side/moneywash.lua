local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
startMoneyWash = {}
Tunnel.bindInterface("vrp_lavagem",startMoneyWash)
local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR O PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function startMoneyWash.ChecarPagamento()
	local source = source 
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 100000 or vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 500000 then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem dinheiro sujo suficiente para realizar a lavagem.",5000)
			return false
		end 
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAR OS COMPONENTES NO INVENTARIO DO MELIANTE
-----------------------------------------------------------------------------------------------------------------------------------------
function startMoneyWash.VerificarComponente(componente,qcomponente)
	local source = source 
	local user_id = vRP.getUserId(source)
	if user_id then 
		if vRP.getInventoryItemAmount(user_id,componente) >= qcomponente then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui alvejante suficiente.")
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR O PAGAMENTO DO PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function startMoneyWash.EnviarPagamento(tipo)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then
        if tipo == "lavagemsimples" then
            if vRP.getInventoryItemAmount(user_id,"alvejante") >= 10 and vRP.tryGetInventoryItem(user_id,"dinheirosujo",parseInt(100000)) and vRP.tryGetInventoryItem(user_id,"alvejante",10) then
                vRP.giveMoney(user_id,parseInt(97000))
            end
        elseif tipo == "lavagemavancada" then 
            if vRP.getInventoryItemAmount(user_id,"alvejantemodificado") >= 10 and vRP.tryGetInventoryItem(user_id,"dinheirosujo",parseInt(500000)) and vRP.tryGetInventoryItem(user_id,"alvejantemodificado",10) then
                vRP.giveMoney(user_id,parseInt(470000)) 
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAR PERMISSAO DE PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function startMoneyWash.PermissaoPlayer(permissao)
	local source = source 
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,permissao)
	end 
end