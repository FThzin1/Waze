local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Proxy.getInterface("vRP")

wazeDrugRoute = {}
Tunnel.bindInterface("waze_entrega_drogas", wazeDrugRoute)
cDrugs = Tunnel.getInterface("waze_entrega_drogas")

local StatusBoostDrugs = false

function wazeDrugRoute.GetStatusBoostDrugs()
    return StatusBoostDrugs
end

local QtdDrogas = 0

function wazeDrugRoute.IObiuBAEgukjKASdh()
    local source = source
    local user_id = vRP.getUserId(source)
    local policiais = vRP.getUsersByPermission('policiadroga.permissao')
    if #policiais >= 0 and #policiais <= 4 then
        policiais = 1
    elseif #policiais > 5 then
        policiais = 8*0.3
    elseif #policiais > 10 then
        policiais = 15*0.3
    else
        policiais = #policiais*0.3
    end

    if vRP.tryGetInventoryItem(user_id,'lancaperfume', 1) then
        local PrecoDroga = 12000
        local pagamento = parseInt(policiais*PrecoDroga) 
        if vRP.hasPermission(user_id, 'xxxxxx.permissao') then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 1x lança perfumes por $' .. parseInt(pagamento*0.3))
            vRP.giveInventoryItem(user_id, 'dinheirosujo', parseInt(pagamento*0.3))
        else
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 1x lança perfumes por $' .. pagamento)
            vRP.giveInventoryItem(user_id, 'dinheirosujo', pagamento)
        end
    end

    if vRP.tryGetInventoryItem(user_id,'cocaina', 2) then
        local PrecoDroga = 7000
        local pagamento = parseInt(policiais*PrecoDroga) 
        
        if vRP.hasGroup(user_id,'vagos') then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x cocaina por $' .. parseInt(pagamento*0.5))
            vRP.giveInventoryItem(user_id, 'dinheirosujo', parseInt(pagamento*0.5))
        else
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x cocaina por $' .. pagamento)
            vRP.giveInventoryItem(user_id, 'dinheirosujo', pagamento)
            -- TriggerEvent('waze:Saldofac:Add', 'vagos', 0.05*pagamento )
        end
    end

    if vRP.tryGetInventoryItem(user_id,'baseado', 2) then
        local PrecoDroga = 7000
        local pagamento = parseInt(policiais*PrecoDroga) 
        
        if vRP.hasGroup(user_id,'groove') then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x baseado por $' .. parseInt(pagamento*0.5))
            vRP.giveInventoryItem(user_id, 'dinheirosujo', parseInt(pagamento*0.5))
        else
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x baseado por $' .. pagamento)
            vRP.giveInventoryItem(user_id, 'dinheirosujo', pagamento)
            -- TriggerEvent('waze:Saldofac:Add', 'groove', 0.05*pagamento)
        end
    end

    if vRP.tryGetInventoryItem(user_id,'metanfetamina', 2) then
        local PrecoDroga = 7000
        local pagamento = parseInt(policiais*PrecoDroga) 
        
        if vRP.hasGroup(user_id,'ballas') then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x metanfetamina por $' .. parseInt(pagamento*0.5))
            vRP.giveInventoryItem(user_id, 'dinheirosujo', parseInt(pagamento*0.5))
        else
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x metanfetamina por $' .. pagamento)
            vRP.giveInventoryItem(user_id, 'dinheirosujo', pagamento)
            -- TriggerEvent('waze:Saldofac:Add', 'ballas', 0.05*pagamento )
        end
        
    end
    

end

function wazeDrugRoute.IObiuBAEgukjKASdhboost()
    local source = source
    local user_id = vRP.getUserId(source)
    local policiais = vRP.getUsersByPermission('policiadroga.permissao')
    if #policiais >= 0 and #policiais <= 4 then
        policiais = 1
    elseif #policiais > 5 then
        policiais = 8*0.3
    elseif #policiais > 10 then
        policiais = 15*0.3
    else
        policiais = #policiais*0.3
    end

    if vRP.tryGetInventoryItem(user_id,'lancaperfume', 1) then
        local PrecoDroga = 17000
        local pagamento = parseInt(policiais*PrecoDroga) 
        if vRP.hasPermission(user_id, 'drogas.permissao') then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 1x lança perfumes por $' .. parseInt(pagamento*0.3))
            vRP.giveInventoryItem(user_id, 'dinheirosujo', parseInt(pagamento*0.3))
        else
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 1x lança perfumes por $' .. pagamento)
            vRP.giveInventoryItem(user_id, 'dinheirosujo', pagamento)
        end
    end

    if vRP.tryGetInventoryItem(user_id,'cocaina', 2) then
        local PrecoDroga = 9000
        local pagamento = parseInt(policiais*PrecoDroga) 
        
        if vRP.hasGroup(user_id,'vagos') then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x cocaina por $' .. parseInt(pagamento*0.5))
            vRP.giveInventoryItem(user_id, 'dinheirosujo', parseInt(pagamento*0.5))
        else
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x cocaina por $' .. pagamento)
            vRP.giveInventoryItem(user_id, 'dinheirosujo', pagamento)
            -- TriggerEvent('waze:Saldofac:Add', 'vagos', 0.05*pagamento )
        end
    end

    if vRP.tryGetInventoryItem(user_id,'baseado', 2) then
        local PrecoDroga = 9000
        local pagamento = parseInt(policiais*PrecoDroga) 
        
        if vRP.hasGroup(user_id,'groove') then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x baseado por $' .. parseInt(pagamento*0.5))
            vRP.giveInventoryItem(user_id, 'dinheirosujo', parseInt(pagamento*0.5))
        else
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x baseado por $' .. pagamento)
            vRP.giveInventoryItem(user_id, 'dinheirosujo', pagamento)
            -- TriggerEvent('waze:Saldofac:Add', 'groove', 0.05*pagamento)
        end
    end

    if vRP.tryGetInventoryItem(user_id,'metanfetamina', 2) then
        local PrecoDroga = 9000
        local pagamento = parseInt(policiais*PrecoDroga) 
        
        if vRP.hasGroup(user_id,'ballas') then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x metanfetamina por $' .. parseInt(pagamento*0.5))
            vRP.giveInventoryItem(user_id, 'dinheirosujo', parseInt(pagamento*0.5))
        else
            TriggerClientEvent('Notify', source, 'sucesso', 'Você entregou 2x metanfetamina por $' .. pagamento)
            vRP.giveInventoryItem(user_id, 'dinheirosujo', pagamento)
            -- TriggerEvent('waze:Saldofac:Add', 'ballas', 0.05*pagamento )
        end
        
    end
    

end


RegisterServerEvent('waze:DrogasChamarPolicia')
AddEventHandler('waze:DrogasChamarPolicia',function(x,y,z)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"policia.permissao") then
			local pmson = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(pmson) do
				local player = vRP.getUserSource(w)
				if player then
                    TriggerClientEvent('waze:DrogasChamarPolicia',player,x,y,z,user_id)
				end
			end
		end
	end
end)

local delaySaqueFac = {}

function VerificarLiderFac(fac, id)
    if fac == 'groove' and id == 0 then
        return true
    elseif fac == 'vagos' and id == 0 then
        return true
    elseif fac == 'ballas' and id == 0 then
        return true
    end
    return false
end

local Cooldowns = {}
function wazeDrugRoute.SetCooldown()
    local source = source
    local user_id = vRP.getUserId(source)
    Cooldowns[user_id] = os.time()
end

function wazeDrugRoute.CooldownLiberado()
    local source = source
    local user_id = vRP.getUserId(source)
    if not Cooldowns[user_id] or os.time() > Cooldowns[user_id] + 100 then
        return true
    end
    TriggerClientEvent('Notify', source, 'negado', 'Você deve aguardar até pegar a próxima rota.')
    return false
end


RegisterCommand("voltarr",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then 
        if vRP.hasPermission(user_id,'admin.permissao') then
            Cooldowns[user_id] = false
        end
    end
end)

CreateThread(function() 
    while true do
        local hora = parseInt(os.date('%H'))
        local minuto = parseInt(os.date('%M'))
        if hora == 14 and minuto == 0 then

            cDrugs.StatusBoostDrugs(-1, true)
            StatusBoostDrugs = true

        end

        if hora == 18 and minuto == 0 then

            cDrugs.StatusBoostDrugs(-1, false)
            StatusBoostDrugs = false

        end

        Wait(58000)    
    end
end)

RegisterCommand('boostvendas', function(source, args, rawCmd)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'dev.permissao') then
        if args[1] then
            if parseInt(args[1]) == 1 then

                cDrugs.StatusBoostDrugs(-1, true)
                StatusBoostDrugs = true
                TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>LIGOU</b> o boost das vendas de <b>DROGAS</b>!')
            elseif parseInt(args[1]) == 0 then
                cDrugs.StatusBoostDrugs(-1, false)
                StatusBoostDrugs = false
                TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>DESLIGOU</b> o boost das vendas de <b>DROGAS</b>!')
            end
        else
            TriggerClientEvent('Notify', source,'negado', 'Você deve especificar <b>1</b> ou <b>0</b>.')
        end
    end
end)