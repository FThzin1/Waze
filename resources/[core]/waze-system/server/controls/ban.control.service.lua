-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMANENTBAN
-----------------------------------------------------------------------------------------------------------------------------------------
function permanentBan(data)
    local request = exports.oxmysql:executeSync("SELECT * FROM bans WHERE user_id = ?",{ parseInt(data.user_id) })
    if request[1] then
        TriggerClientEvent("Notify",vRP.getUserSource(parseInt(data.staff_id)),"negado","Este jogador já está banido.")
        return  
    end

    exports.oxmysql:executeSync("INSERT INTO bans (user_id,reason,type,staff_id) VALUES (?,?,?,?)",{ parseInt(data.user_id),tostring(data.reason),tostring("permanent"),parseInt(data.staff_id) })
    TriggerClientEvent("Notify",vRP.getUserSource(parseInt(data.staff_id)),"sucesso","Banimento aplicado com sucesso.")

    if vRP.getUserSource(data.user_id) then
        vRP.kick(vRP.getUserSource(data.user_id),"\n\nSeu acesso ao servidor foi revogado permanentemente.\nMotivo: "..data.reason.."\n\nPara mais informações entre em contato via ticket.") 
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPORARYBAN
-----------------------------------------------------------------------------------------------------------------------------------------
function temporaryBan(data)
    local request = exports.oxmysql:executeSync("SELECT * FROM bans WHERE user_id = ?",{ parseInt(data.user_id) })
    if request[1] then
        TriggerClientEvent("Notify",vRP.getUserSource(parseInt(data.staff_id)),"negado","Este jogador já está banido.")
        return  
    end

    if parseInt(data.timeBan) then
        local timeBan = data.timeBan * 86400 + os.time()
        
        exports.oxmysql:executeSync("INSERT INTO bans (user_id,reason,type,time,staff_id) VALUES (?,?,?,?,?)",{ parseInt(data.user_id),tostring(data.reason),tostring("temporary"),timeBan,parseInt(data.staff_id) })
        TriggerClientEvent("Notify",vRP.getUserSource(parseInt(data.staff_id)),"sucesso","Banimento aplicado com sucesso.")
        
        if vRP.getUserSource(data.user_id) then
            vRP.kick(vRP.getUserSource(data.user_id),"\n\nSeu acesso ao servidor foi revogado por "..data.timeBan.." dia(s).\nMotivo: "..data.reason.."\n\nPara mais informações entre em contato via ticket.") 
        end
    else
        TriggerClientEvent("Notify",vRP.getUserSource(parseInt(data.staff_id)),"negado","O tempo de ban está no formato incorreto.")
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKBAN
-----------------------------------------------------------------------------------------------------------------------------------------
function checkBan(data)
    local request = exports.oxmysql:executeSync("SELECT * FROM bans WHERE user_id = ?",{ parseInt(data.user_id) })
    if request[1] then
        if tostring(request[1].type) == "temporary" then
            if os.time() >= parseInt(request[1].time) then
                exports.oxmysql:executeSync("DELETE FROM bans WHERE user_id = ?",{ parseInt(data.user_id) })
                return { canSet = true, request = nil }
            end
        end
        return { canJoin = false, request = request[1] }
    end
    return { canJoin = true, request = nil }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("permanentBan",permanentBan)
exports("temporaryBan",temporaryBan)
exports("checkBan",checkBan)