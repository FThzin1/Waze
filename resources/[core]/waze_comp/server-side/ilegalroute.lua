local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

wazeFarm = {}
Tunnel.bindInterface("waze_npc_farms", wazeFarm)
cFarm = Tunnel.getInterface("waze_npc_farms")

local StatusBoostFarm = false

function wazeFarm.GetSatusBoostFarm()
    return StatusBoostFarm
end
--local delayIniciarRota = {}

function wazeFarm.OFlyNcqwyVnLBLqXkEnJeScFb(permissao)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, permissao) or vRP.hasPermission(user_id, 'admin.permissao') then
        --if not delayIniciarRota[user_id] or os.time() > (delayIniciarRota[user_id] + 400) then
           --delayIniciarRota[user_id] = os.time()
            return true, permissao
        --else
            --TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Você deve aguardar para iniciar outra rota novamente.')
        --end
    end
    return false
end 

function wazeFarm.rqkWrVlbDiRADhQwchLtLdZuk(PermCliente)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, PermCliente) then
        local qtd = math.random(24,30)
        local qtdPecaArma = math.random(22,33)
        local qtdPecaArmaBloods = math.random(28,40)
        local qtdBns = math.random(10,15)
        local qtdSujo = math.random(1800,2600)
        local qtdSujoBloods = math.random(2200,3000)
        -- local qtdArmas = math.random(300,600)
        local qtdSujo2 = math.random(1800,2600)
        local qtdBhsSujo = math.random(800,1000)
        local qtdBhsAlv = math.random(20,26)

        if PermCliente == 'crips.permissao' or PermCliente == 'bloods.permissao' then
                vRP.giveInventoryItem(user_id, 'materialarmas', qtdPecaArma)
                vRP.giveInventoryItem(user_id, 'dinheirosujo', qtdSujo)
                local rdm = math.random(200)
                if rdm <= 10 then --3
                    vRP.giveInventoryItem(user_id, 'materialak', 1)
                    exports["waze-system"]:sendLogs(user_id,{ webhook = "routeWeapon", text = "Recebeu 1 Material de AK no Farm - CHANCE: "..rdm.."/200" })
                end
        elseif PermCliente == 'siciliana.permissao' or PermCliente == 'bratva.permissao' then
                vRP.giveInventoryItem(user_id, 'material9mm', qtd)
                vRP.giveInventoryItem(user_id, 'dinheirosujo', qtdSujo2)
                local rdm = math.random(200)
                  if rdm <= 15 then
                    local qtd762 = math.random(18,22)
                    vRP.giveInventoryItem(user_id, 'material762', qtd762)
                    exports["waze-system"]:sendLogs(user_id,{ webhook = "routeBullet", text = "Recebeu "..qtd762.." Material de 762 no Farm - CHANCE: "..rdm.."/200" })
                  end
        elseif PermCliente == 'bahamas.permissao' or PermCliente == 'lifeinvader.permissao' then                vRP.giveInventoryItem(user_id, 'alvejante', qtdBhsAlv)
                vRP.giveInventoryItem(user_id, 'dinheirosujo', qtdBhsSujo)
                local rdm = math.random(200)
                if rdm <= 15 then
                  local qtdmodificado = math.random(8,15)
                  vRP.giveInventoryItem(user_id, 'alvejantemodificado', qtdmodificado)
                  exports["waze-system"]:sendLogs(user_id,{ webhook = "routeWash", text = "Recebeu "..qtdmodificado.." Alvejantes Premium - CHANCE: "..rdm.."/200" })
                end
        end
    end
end

function wazeFarm.rqkWrVlbDiRADhQwchLtLdBoost(PermCliente)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, PermCliente) then
        local qtd = math.random(28,38)
        local qtdPecaArma = math.random(28,40)
        local qtdPecaArmaBloods = math.random(32,52)
        local qtdBns = math.random(10,15)
        local qtdSujo = math.random(2200,3000)
        local qtdSujoBloods = math.random(2500,3800)
        -- local qtdArmas = math.random(300,600)
        local qtdSujo2 = math.random(2200,3000)
        local qtdBhsSujo = math.random(950,1300)
        local qtdBhsAlv = math.random(24,35)

        if PermCliente == 'crips.permissao' or PermCliente == 'bloods.permissao' then
                vRP.giveInventoryItem(user_id, 'materialarmas', qtdPecaArma)
                vRP.giveInventoryItem(user_id, 'dinheirosujo', qtdSujo)
                local rdm = math.random(200)
                if rdm <= 15 then --3
                    vRP.giveInventoryItem(user_id, 'materialak', 1)
                    exports["waze-system"]:sendLogs(user_id,{ webhook = "routeWeapon", text = "Recebeu 1 Material de AK no Farm - CHANCE: "..rdm.."/200" })
                end
        elseif PermCliente == 'siciliana.permissao' or PermCliente == 'bratva.permissao' then
                vRP.giveInventoryItem(user_id, 'material9mm', qtd)
                vRP.giveInventoryItem(user_id, 'dinheirosujo', qtdSujo2)
                local rdm = math.random(200)
                  if rdm <= 20 then
                    local qtd762 = math.random(18,22)
                    vRP.giveInventoryItem(user_id, 'material762', qtd762)
                    exports["waze-system"]:sendLogs(user_id,{ webhook = "routeBullet", text = "Recebeu "..qtd762.." Material de 762 no Farm - CHANCE: "..rdm.."/200" })
                  end
        elseif PermCliente == 'bahamas.permissao' or PermCliente == 'lifeinvader.permissao' then
                vRP.giveInventoryItem(user_id, 'alvejante', qtdBhsAlv)
                vRP.giveInventoryItem(user_id, 'dinheirosujo', qtdBhsSujo)
                local rdm = math.random(200)
                if rdm <= 20 then
                  local qtdmodificado = math.random(8,15)
                  vRP.giveInventoryItem(user_id, 'alvejantemodificado', qtdmodificado)
                  exports["waze-system"]:sendLogs(user_id,{ webhook = "routeWash", text = "Recebeu "..qtdmodificado.." Alvejantes Premium - CHANCE: "..rdm.."/200" })
                end
        end
    end
end

CreateThread(function() 
    while true do
        local hora = parseInt(os.date('%H'))
        local minuto = parseInt(os.date('%M'))
        if hora == 14 and minuto == 0 then

            cFarm.StatusBoostFarm(-1, true)
            StatusBoostFarm = true

        end

        if hora == 18 and minuto == 0 then

            cFarm.StatusBoostFarm(-1, false)
            StatusBoostFarm = false

        end

        Wait(58000)    
    end
end)

RegisterCommand('boostfarm', function(source, args, rawCmd)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'dev.permissao') then
        if args[1] then
            if parseInt(args[1]) == 1 then

                cFarm.StatusBoostFarm(-1, true)
                StatusBoostFarm = true
                TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>LIGOU</b> o boost dos farms de <b>munições, lavagem e armas</b>!')
            elseif parseInt(args[1]) == 0 then
                cFarm.StatusBoostFarm(-1, false)
                StatusBoostFarm = false
                TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>DESLIGOU</b> o boost dos farms de <b>munições, lavagem e armas</b>!')
            end
        else
            TriggerClientEvent('Notify', source, 'negado', 'Você deve especificar <b>1</b> ou <b>0</b>.')
        end
    end
end)