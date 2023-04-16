local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

wazeRelationship = {}
Tunnel.bindInterface("waze_namoro", wazeRelationship)

cRelationship = Tunnel.getInterface("waze_namoro")
------------------------------------------------------------------
-- CÓDIGO
------------------------------------------------------------------

--[[ 
    DATABASE:
    0  - SOLTEIRO
    1  - NAMORANDO
    2  - PEDIDO DE CASAMENTO FEITO
    3  - CASAMENTO OFICIALIZADO 

    -- COLOCAR NO /RG (vrp_policia)
    -- COLOCAR NO F11 (vrp_identidade)

    -- CRIAR ALIANÇA DE OURO E PRATA E PARES
]]


vRP.prepare('relacionamento/GetUserRelacinamento', 'SELECT * FROM waze_relacionamento WHERE user_id = @user_id')
vRP.prepare('relacionamento/InsertRelacionamento', 'INSERT INTO waze_relacionamento(user_id,relacionamento,relacionamentoCom) VALUES(@user_id,@relacionamento,@relacionamentoCom)')
vRP.prepare('relacionamento/UpdateRelacionamento', 'UPDATE waze_relacionamento SET relacionamento = @relacionamento, relacionamentoCom = @relacionamentoCom WHERE user_id = @user_id')
vRP.prepare('relacionamento/RemoverRelacionamento', 'DELETE waze_relacionamento WHERE user_id = @user_id')

function ChecarSolteiro(user_id)
    local query = vRP.query('relacionamento/GetUserRelacinamento', {user_id = user_id})
    if not query or not query[1] or query[1] == nil then
        vRP.execute('relacionamento/InsertRelacionamento', {user_id = user_id, relacionamento = 0, relacionamentoCom = -1})
        return true
    end
    if query and query[1] then
        if parseInt(query[1].relacionamento) == 0 then
            return true
        end
    end
    return false
end

function GetRelacionamento(user_id)
	local query = vRP.query('relacionamento/GetUserRelacinamento', {user_id = user_id})
	if not query or not query[1] or query[1] == nil then
		vRP.execute('relacionamento/InsertRelacionamento', {user_id = user_id, relacionamento = 0, relacionamentoCom = -1})
		return 0, nil
	end

    if query[1] and query[1] ~= nil then
		local row = query[1] 
        return row.relacionamento, row.relacionamentoCom
    end
end

RegisterServerEvent('waze:Relacionamento:Casar')
AddEventHandler('waze:Relacionamento:Casar', function(user_id)
    local source = vRP.getUserSource(user_id)
    local nsource = vRPclient.getNearestPlayer(source, 5)
    if nsource then
        local nuser_id = vRP.getUserId(nsource)
        local identity = vRP.getUserIdentity(user_id)
        local nidentity = vRP.getUserIdentity(nuser_id)

        vRPclient._playAnim(source, false, {"amb@medic@standing@kneel@idle_a" , "idle_a"}, true)
        if vRP.request(source, 'Você tem certeza que quer enviar um pedido de <b>casamento</b>?', 20) then
            local status, comQuem = GetRelacionamento(user_id)
            local status2, comQuem2 = GetRelacionamento(nuser_id)
            if status == 1 and status2 == 1 and comQuem == nuser_id and comQuem2 == user_id then
                if vRP.request(nsource, '<b>' .. identity.name .. ' ' .. identity.firstname .. '</b> está te pedindo em <b>casamento</b>, deseja aceitar?', 20) then
                    if vRP.tryGetInventoryItem(user_id,'paraliancaouro',1) then
                        -- DÁ AS ALIANÇAS PARA AMBOS
                        vRP.giveInventoryItem(user_id,'aliancaouro',1)
                        vRP.giveInventoryItem(nuser_id,'aliancaouro',1)

                        -- REMOVE AS ALIANÇAS DE PRATA
                        vRP.tryGetInventoryItem(user_id,'aliancaprata',1)
                        vRP.tryGetInventoryItem(user_id,'aliancaprata',1)

                        -- SETA OS DOIS NOIVANDO NA DATABASE
                        vRP.execute('relacionamento/UpdateRelacionamento', {user_id = user_id, relacionamento = 2, relacionamentoCom = nuser_id})
                        vRP.execute('relacionamento/UpdateRelacionamento', {user_id = nuser_id, relacionamento = 2, relacionamentoCom = user_id})

                        TriggerClientEvent('Notify', source, 'sucesso',  'Você está, agora, noivando com <b>'..nidentity.name .. ' ' .. nidentity.firstname .. '</b>. Parabéns!')
                        TriggerClientEvent('Notify', nsource, 'sucesso', 'Você está, agora, noivando com <b>'..identity.name .. ' ' .. identity.firstname .. '</b>. Parabéns!')

                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Você <b>NÃO</b> possui um par de alianças!')
                        TriggerClientEvent('Notify', nsource, 'negado', 'A outra pessoa <b>NÃO</b> possui um par de alianças!')
                    end

                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Você precisa estar namorando com a pessoa com que deseja casar!')
            end
        end
    else
        TriggerClientEvent('Notify', source, 'negado', 'Não há ninguém por perto.')
    end
    cRelationship.ZerarAnim(source)
end)


RegisterServerEvent('waze:Relacionamento:Namorar')
AddEventHandler('waze:Relacionamento:Namorar', function(user_id)
    local source = vRP.getUserSource(user_id)
    local nsource = vRPclient.getNearestPlayer(source, 5)
    if nsource then
        local nuser_id = vRP.getUserId(nsource)
        local identity = vRP.getUserIdentity(user_id)
        local nidentity = vRP.getUserIdentity(nuser_id)

        vRPclient._playAnim(source, false, {"amb@medic@standing@kneel@idle_a" , "idle_a"}, true)
        if vRP.request(source, 'Você tem certeza que quer enviar um pedido de <b>namoro</b>?', 20) then
            if ChecarSolteiro(user_id) then
                if ChecarSolteiro(nuser_id) then
                    if vRP.request(nsource, '<b>' .. identity.name .. ' ' .. identity.firstname .. '</b> está te pedindo em <b>namoro</b>, deseja aceitar?', 20) then
                        if vRP.tryGetInventoryItem(user_id,'paraliancaprata',1) then
                        --     DÁ AS ALIANÇAS PARA AMBOS
                            vRP.giveInventoryItem(user_id,'aliancaprata',1)
                            vRP.giveInventoryItem(nuser_id,'aliancaprata',1)

                            -- SETA OS DOIS NAMORANDO NA DATABASE
                            vRP.execute('relacionamento/UpdateRelacionamento', {user_id = user_id, relacionamento = 1, relacionamentoCom = nuser_id})
                            vRP.execute('relacionamento/UpdateRelacionamento', {user_id = nuser_id, relacionamento = 1, relacionamentoCom = user_id})

                            TriggerClientEvent('Notify', source, 'sucesso',  'Você está, agora, namorando com <b>'..nidentity.name .. ' ' .. nidentity.firstname .. '</b>. Parabéns!')
                            TriggerClientEvent('Notify', nsource, 'sucesso', 'Você está, agora, namorando com <b>'..identity.name .. ' ' .. identity.firstname .. '</b>. Parabéns!')

                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Você <b>NÃO</b> possui um par de alianças!')
                            TriggerClientEvent('Notify', nsource, 'negado', 'A outra pessoa <b>NÃO</b> possui um par de alianças!')
                        end
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'A pessoa precisa estar solteira para fazer isso.')
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Você precisa estar solteiro(a) para fazer isso.')
            end
            
        end
    else
        TriggerClientEvent('Notify', source, 'negado', 'Não há ninguém por perto.')
    end
    cRelationship.ZerarAnim(source)
end)


-- RegisterCommand('casido', function(source, args, rawCmd)
    
--     local user_id = vRP.getUserId(source)
--     TriggerEvent('waze:Relacionamento:Casar', user_id)
-- end)
-- RegisterCommand('namorido', function(source, args, rawCmd)
    
--     local user_id = vRP.getUserId(source)
--     TriggerEvent('waze:Relacionamento:Namorar', user_id)
-- end)

RegisterCommand('terminar', function(source, args, rawCmd)
    local user_id = vRP.getUserId(source)
    local status, comQuem = GetRelacionamento(user_id)
    if status == 0 then
        TriggerClientEvent('Notify', source, 'negado', 'Você precisa estar namorando ou noivando para isso.')
    elseif status == 1 or status == 2 then
        local nuser_id = comQuem
        local nsource = vRP.getUserSource(nuser_id)
        local identity = vRP.getUserIdentity(user_id)
        local nidentity = vRP.getUserIdentity(nuser_id)

        if vRP.request(source, 'Você deseja terminar seu relacionamento com <b>' .. nidentity.name .. ' ' .. nidentity.firstname .. '</b>?' , 15) then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você encerrou seu relacionamento com <b>' .. nidentity.name .. ' ' .. nidentity.firstname .. '</b>.')
            
            if nsource then
                TriggerClientEvent('Notify', nsource, 'sucesso', '<b>' .. identity.name .. ' ' .. identity.firstname .. '</b> terminou o relacionamento com você.')
                vRP.tryGetInventoryItem(nuser_id,'aliancaouro',1)
                vRP.tryGetInventoryItem(nuser_id,'aliancaprata',1)
            end
            vRP.tryGetInventoryItem(user_id,'aliancaouro',1)
            vRP.tryGetInventoryItem(user_id,'aliancaprata',1)

            -- SETA OS DOIS SOLTEIROS NA DATABASE
            vRP.execute('relacionamento/UpdateRelacionamento', {user_id = user_id, relacionamento = 0, relacionamentoCom = -1})
            vRP.execute('relacionamento/UpdateRelacionamento', {user_id = nuser_id, relacionamento = 0, relacionamentoCom = -1})
        end

    elseif status == 3 then
        TriggerClientEvent('Notify', source, 'negado', 'Para encerrar um casamento, você deve ir ao cartório e solicitar o divórcio.')
    end
end)

function wazeRelationship.PediuPraCasar()
    local source = source
    local user_id = vRP.getUserId(source)
    local usersPerto = 0

    local players = vRPclient.getNearestPlayers(source, 5)
    for k, v in pairs(players) do
        usersPerto = usersPerto + 1
    end

    if usersPerto > 1 then
        local status, comQuem = GetRelacionamento(user_id)
        if status == 2 then
            local nsource = vRP.getUserSource(comQuem)
            if nsource then
                if players[nsource] then
                    local identity = vRP.getUserIdentity(user_id)
                    local nidentity = vRP.getUserIdentity(comQuem)
                    if vRP.request(source, 'Deseja realmente pedir <b>' .. nidentity.name .. ' ' .. nidentity.firstname .. '</b>?', 20) then
                        if vRP.request(nsource, 'Aceita <b>' .. identity.name .. ' ' .. identity.firstname .. '</b> em <b>casamento</b>?', 20) then
                            if vRP.tryFullPayment(user_id,300000) then
                                print(identity.name .. ' ' .. identity.firstname .. ' se casou com ' .. nidentity.name .. ' ' .. nidentity.firstname)
                                -- SETA OS DOIS SOLTEIROS NA DATABASE
                                vRP.execute('relacionamento/UpdateRelacionamento', {user_id = user_id, relacionamento = 3, relacionamentoCom = comQuem})
                                vRP.execute('relacionamento/UpdateRelacionamento', {user_id = comQuem, relacionamento = 3, relacionamentoCom = user_id})
                                TriggerClientEvent('chatMessage', -1, 'CARTÓRIO', {227, 0, 95}, '^1'.. identity.name .. ' ' .. identity.firstname .. ' ^0se casou com ^1' .. nidentity.name .. ' ' .. nidentity.firstname .. '^0.  Parabéns aos pombinhos!')
                                
                                -- GERAR LOG DE CASAMENTO
                                local jogador = user_id .. ' ' .. identity.name .. ' ' .. identity.firstname
                                local jogador2 = comQuem .. ' ' .. nidentity.name .. ' ' .. nidentity.firstname
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "relationshipLog", text = "Casou-se com "..jogador2 })
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'O solicitante deve possuir, no mínimo, $300.000,00.')
                            end
                        end
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'A outra parte deve estar presente.')
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'A outra parte deve estar presente.')
            end
        else
            TriggerClientEvent('Notify', source, 'negado', 'Você precisa estar noivando para isso.')
        end
    else
        TriggerClientEvent('Notify', source, 'negado', 'Deve haver alguém para testemunhar o casamento.')
    end
end

function wazeRelationship.PediuDivorcio()
    local source = source
    local user_id = vRP.getUserId(source)
    
    local status, comQuem = GetRelacionamento(user_id)
    if status == 3 then
        local nsource = vRP.getUserSource(comQuem)
        local nplayer = vRPclient.getNearestPlayer(source, 5)
        if nsource and nplayer and nplayer == nsource then
            local identity = vRP.getUserIdentity(user_id)
            local nidentity = vRP.getUserIdentity(comQuem)
            if vRP.request(source, 'Deseja realmente divorciar-se de <b>' .. nidentity.name .. ' ' .. nidentity.firstname .. '</b>?', 20) then
                if vRP.request(nsource, 'Aceita divorciar-se de <b>' .. identity.name .. ' ' .. identity.firstname .. '</b>?', 20) then
                    print(identity.name .. ' ' .. identity.firstname .. ' se divorciou de ' .. nidentity.name .. ' ' .. nidentity.firstname)

                    -- SOMA DOS BENS
                    local Money1 = vRP.getBankMoney(user_id)+vRP.getMoney(user_id)
                    local Money2 = vRP.getBankMoney(comQuem)+vRP.getMoney(comQuem)

                    if user_id and comQuem then
                        local check1 = vRP.getUserSource(user_id)
                        local check2 = vRP.getUserSource(comQuem)

                        if check1 and check2 then

                            if vRP.tryFullPayment(user_id,Money1) and vRP.tryFullPayment(comQuem,Money2) then

                                -- SEPARAÇÃO DOS BENS
                                local MoneyFinal = parseInt((Money1+Money2)/2)
                                vRP.setBankMoney(user_id,MoneyFinal)
                                vRP.setBankMoney(comQuem,MoneyFinal)

                                -- GERAR LOG DE DIVORCIO
                                local jogador = user_id .. ' ' .. identity.name .. ' ' .. identity.firstname .. ' - DINHEIRO ANTES: $' .. vRP.format(Money1)
                                local jogador2 = '('..comQuem .. ') ' .. nidentity.name .. ' ' .. nidentity.firstname
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "relationshipLog", text = "Diversou-se de "..jogador2.."\nDINHEIRO de ("..user_id.."): $"..vRP.format(Money1).." e ("..comQuem.."): $"..vRP.format(Money2).."\nCOMUNHÃO FINAL: $"..vRP.format(MoneyFinal)  })                               

                                -- SETA OS DOIS SOLTEIROS NA DATABASE
                                vRP.execute('relacionamento/UpdateRelacionamento', {user_id = user_id, relacionamento = 0, relacionamentoCom = -1})
                                vRP.execute('relacionamento/UpdateRelacionamento', {user_id = comQuem, relacionamento = 0, relacionamentoCom = -1})

                                -- TIRA AMBAS AS ALIANÇAS
                                vRP.tryGetInventoryItem(comQuem,'aliancaouro',1)
                                vRP.tryGetInventoryItem(comQuem,'aliancaprata',1)
                                vRP.tryGetInventoryItem(user_id,'aliancaouro',1)
                                vRP.tryGetInventoryItem(user_id,'aliancaprata',1)
                                TriggerClientEvent('chatMessage', -1, 'CARTÓRIO', {227, 0, 95}, '^1'.. identity.name .. ' ' .. identity.firstname .. ' ^0divorciou-se de ^1' .. nidentity.name .. ' ' .. nidentity.firstname .. '^0. Uma pena!')
                                
                                -- BEM SUCEDIDO
                                TriggerClientEvent('Notify', check1, 'financeiro', 'O divórcio foi bem sucedido. Na comunhão total de bens, cada parte assumiu o valor de <b>$'..vRP.format(MoneyFinal)..'</b>.' )
                                TriggerClientEvent('Notify', check2, 'financeiro', 'O divórcio foi bem sucedido. Na comunhão total de bens, cada parte assumiu o valor de <b>$'..vRP.format(MoneyFinal)..'</b>.' )
                            
                            else
                                TriggerClientEvent('Notify', check1, 'negado', 'Algo de inesperado aconteceu. Printe isso e envie ao DEV.<br>'..user_id .. ': ' .. Money1 .. '<br>'..comQuem..': '..Money2)
                                TriggerClientEvent('Notify', check2, 'negado', 'Algo de inesperado aconteceu. Printe isso e envie ao DEV.<br>'..user_id .. ': ' .. Money1 .. '<br>'..comQuem..': '..Money2)
                            end
                        end
                    end
                end
            end
        else
            TriggerClientEvent('Notify', source, 'negado', 'A outra parte deve estar presente.')
        end
    else
        TriggerClientEvent('Notify', source, 'negado', 'Você precisa estar casado para isso.')
    end
end