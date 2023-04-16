local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()

src = {}
Tunnel.bindInterface("waze_roubos", src)

vCLIENT = Tunnel.getInterface("waze_roubos")

local Cooldowns = {}
local police = {}
--local escalando = false
local PermissoesBloqueadas = {
    'policia.permissao',
    'policiaacao.permissao',
    'paisanapolicia.permissao',
    --'medico.permissao',
    --'paisanamedico.permissao',
    --'bennys.permissao',
    --'paisanabennys.permissao',
    --'mecanico.permissao',
    --'paisanamecanico.permissao'
}

local CooldownAcao = {}

function shuffle(tbl)
    local temp = {}
    for k, v in pairs(tbl) do
        table.insert(temp, k)
    end
    for i = #temp, 2, -1 do
        local j = math.random(i)
        temp[i], temp[j] = temp[j], temp[i]
    end
    return temp
end

function src.CheckCooldown(Lugar, TempoCooldown, ItemNecessario, MinPolicia, PermDosPm, Estabelecimento, x, y, z, MaxPolicia, Prioridade)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local horaAgora = os.time()

    for k, v in pairs(PermissoesBloqueadas) do
        if vRP.hasPermission(user_id, v) then
            TriggerClientEvent('Notify', source, 'negado', 'Você não é permitido a fazer isso.')
            return false
        end
    end

    if not Cooldowns[Lugar] or horaAgora >= Cooldowns[Lugar] + TempoCooldown then

        local policia = vRP.getUsersByPermission(PermDosPm)
        -- CHECA MIN POLICIA
        if MinPolicia and MinPolicia > 0 then
            if #policia < MinPolicia then
                TriggerClientEvent('Notify', source, 'negado', 'Não há contingente policial para isso.')
                return false
            end
        end

        -- SE PRECISAR DE ITEM, CHECA SE TEM O ITEM
        if ItemNecessario ~= nil then
            if not vRP.tryGetInventoryItem(user_id,ItemNecessario,1) then
                TriggerClientEvent('Notify', source, 'negado', 'Você não possui <b>' .. vRP.itemNameList(ItemNecessario) .. '</b>.')
                return false
            end
        end
        
        for k,v in pairs(policia) do
            local player = vRP.getUserSource(parseInt(v))
            if player then
                async(function()
                    local id = idgens:gen()
                    TriggerClientEvent("NotifyPush",player,{ code = 31, title = "Roubo a(o) "..Estabelecimento, x = x, y = y, z = z })
                    TriggerClientEvent('chatMessage',player, "["..os.date("%H:%M:%S").."] DEPOL |",{102, 156, 255},"Roubo a(o) "..Estabelecimento)
                    police[id] = vRPclient.addBlip(player,x,y,z,437,1,"Roubo a(o) " .. Estabelecimento,0.8,false)
                    SetTimeout(80000,function() vRPclient.removeBlip(player,police[id]) idgens:free(id) end)
                end)
            end
        end

        -- RETORNA OK
        --vRPclient.setStandBY(source,parseInt(500)) -- Seta procurado
        --vCLIENT.SetMochila(source)
        Cooldowns[Lugar] = horaAgora
        exports["waze-system"]:sendLogs(user_id,{ webhook = "robBlip", text = "Iniciou o roubo "..Estabelecimento })
        vRPclient.playAnim(source, false, {"anim@heists@ornate_bank@grab_cash", "grab"}, true)
        Wait(50)
        --escalando = false
        return true

    end
    TriggerClientEvent('Notify', source, 'negado', 'Este cofre foi saqueado recentemente, aguarde <b>' .. (Cooldowns[Lugar]+TempoCooldown) - horaAgora .. 's</b>.')
    --escalando = false
    return false
end


function src.nIOUGBAIksdnklajbIUYVBEW(Estabelecimento, Recompensa)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local item = 'dinheirosujo'
    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item)*parseInt(Recompensa) <= vRP.getInventoryMaxWeight(user_id) then
        vRP.giveInventoryItem(user_id,item,Recompensa)
        exports["waze-system"]:sendLogs(user_id,{ webhook = "robBlip", text = "Finalizou o roubo "..Estabelecimento.." e recebeu D$"..vRP.format(Recompensa) })
        return
    end
    TriggerClientEvent('Notify', source, 'negado', 'O dinheiro não cabe na sua mochila.')
    return false
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end