local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

wazePrison = {}
Tunnel.bindInterface("waze_prisao", wazePrison)

cPrison = Tunnel.getInterface("waze_prisao")

function wazePrison.onibAUIEGBiSNAKDjnAHUItg(qtd, sobrepor)
    local source = source
    TriggerEvent('waze:ReducaoPenalAbcde', source, qtd)
end

function wazePrison.onibAUIEGBiSNAKDjnAHUItgAutomatica()
    local source = source
    TriggerEvent('waze:ReducaoPenalAbcdef', source)
end
