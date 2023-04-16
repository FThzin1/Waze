local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

sRelationship = Tunnel.getInterface("waze_namoro")

wazeRelationship = {}
Tunnel.bindInterface("waze_namoro", wazeRelationship)

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


------------------------------------------------------------------
-- CONFIG
------------------------------------------------------------------


------------------------------------------------------------------
-- CÓDIGO
------------------------------------------------------------------
local Cartorio = {441.18,-981.13,30.69}

RegisterCommand('casar', function(source, args, rawCmd)
    if not exports["chat"]:statusChat() then return end
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local dist = #(pedCoords - vec3(Cartorio[1], Cartorio[2], Cartorio[3]))
    if dist < 3.0 then
        sRelationship.PediuPraCasar()
    else
        TriggerEvent('Notify', 'negado',  'Você deve ir até o cartório para fazer isso.')
    end
end)

RegisterCommand('divorciar', function(source, args, rawCmd)
    if not exports["chat"]:statusChat() then return end
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local dist = #(pedCoords - vec3(Cartorio[1], Cartorio[2], Cartorio[3]))
    if dist < 3.0 then
        sRelationship.PediuDivorcio()
    else
        TriggerEvent('Notify', 'negado',  'Você deve ir até o cartório para fazer isso.')
    end
end)

function wazeRelationship.ZerarAnim()
    vRP.DeletarObjeto()
    ClearPedTasks(PlayerPedId())
end


------------------------------------------------------------------
-- FUNÇÕES
------------------------------------------------------------------



