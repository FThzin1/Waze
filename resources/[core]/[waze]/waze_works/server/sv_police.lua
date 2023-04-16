local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

policia = {}
Tunnel.bindInterface("emp_policia", policia)

cPolice = Tunnel.getInterface("emp_policia")


local StatusBoostPolice = false

function policia.GetStatusBoost()
    return StatusBoostPolice
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function policia.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"policia.permissao")
end

function policia.IcyuiAAvgbU5sDX()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        randmoney = math.random(1200,1800)
        vRP.giveMoney(user_id,parseInt(randmoney))
        TriggerClientEvent("Notify",source,"financeiro","Você recebeu <b>$"..parseInt(randmoney).." dólares</b>.")
        exports["waze-system"]:sendLogs(user_id,{ webhook = "worksPolice", text = "Recebeu $"..randmoney.." na rota policial" })
    end
end

function policia.IcyuiAAvgbU5sDXboost()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        randmoney = math.random(1500,2300)
        vRP.giveMoney(user_id,parseInt(randmoney))
        TriggerClientEvent("Notify",source,"financeiro","Você recebeu <b>$"..parseInt(randmoney).." dólares</b>.")
        exports["waze-system"]:sendLogs(user_id,{ webhook = "worksPolice", text = "Recebeu $"..randmoney.." na rota policial" })
    end
end

CreateThread(function() 
    while true do
        local hora = parseInt(os.date('%H'))
        local minuto = parseInt(os.date('%M'))
        if hora == 14 and minuto == 0 then

            cPolice.StatusBoost(-1, true)
            StatusBoostPolice = true

        end

        if hora == 18 and minuto == 0 then

            cPolice.StatusBoost(-1, false)
            StatusBoostPolice = false

        end

        Wait(58000)    
    end
end)

RegisterCommand('boostpolice', function(source, args, rawCmd)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'dev.permissao') then
        if args[1] then
            if parseInt(args[1]) == 1 then

                cPolice.StatusBoost(-1, true)
                StatusBoostPolice = true
                TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>LIGOU</b> o boost da rota <b>policial</b>!')
            elseif parseInt(args[1]) == 0 then
                cPolice.StatusBoost(-1, false)
                StatusBoostPolice = false
                TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>DESLIGOU</b> o boost da rota <b>policial</b>!')
            end
        else
            TriggerClientEvent('Notify', source, 'negado', 'Você deve especificar <b>1</b> ou <b>0</b>.')
        end
    end
end)