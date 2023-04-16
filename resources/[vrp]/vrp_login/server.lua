-----------------------------------------------------------------------------------------------------------------------------------------
-- CONECTAR A VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local mrqz = {}
Tunnel.bindInterface(GetCurrentResourceName(),mrqz)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN BASE
-----------------------------------------------------------------------------------------------------------------------------------------
function mrqz.checkBase()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        for k,v in pairs(bases) do
            
        end
    end
end

function mrqz.checkAdm()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'chamadoadmin.permissao') then
        return true
    else return false end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECANDO PERM POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
function mrqz.checkPol()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,permpolicia)  then
            return true 
        else
            TriggerClientEvent('Notify', source,'aviso','Você não possui carteira assinada como policial, desse modo, você foi teleportado para a garagem principal.')
            return false 
        end
    end
end