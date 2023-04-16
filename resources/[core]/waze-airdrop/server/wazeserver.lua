local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

waze = {}
Tunnel.bindInterface("waze-airdrop", waze)
waze_SERVER = Tunnel.getInterface("waze-airdrop")


local wazeollected = false
local thwstartado = false

local function pegardados(dado)
    for chave, valor in pairs(wcfg.airdrops) do
        if chave == dado then
           return valor
        end
     end
end

function waze.setwazeollected()
    wazeollected = false
end

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode({content = message}), { ["Content-Type"] = "application/json" })
	end
end

local wazeoords = nil

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    waze_SERVER.syncwzconfig(source, wzconfig)
end)

function waze.getdrop()
    local source = source 
    local user_id = vRP.getUserId(source)
    TriggerClientEvent("Notify",-1,"importante","O <b>Airdrop</b> foi <b>Coletado</b>.")
end

function waze.supplyt()
    local source = source 
    local user_id = vRP.getUserId(source)
    thwstartado = false
    TriggerClientEvent("Notify",-1,"importante","O evento <b>Airdrop</b> foi <b>Finalizado</b>.")
end

local function startadrop(nome)
    local infos = pegardados(nome)
    local coordsx,coordsy,coordsz = infos.locate.x,infos.locate.y,infos.locate.z
    wazeoords1,wazeoords2,wazeoords3 = coordsx,coordsy,coordsz
    print(wazeoords1,wazeoords2,wazeoords3)

    waze_SERVER.startadrop(-1, wazeoords1,wazeoords2,wazeoords3)
end

function waze.thwgetdrop()
    local source = source
    local user_id = vRP.getUserId(source)
    local saquear = math.random(1,1)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if not wazeollected then
            wazeollected = true
        else
            TriggerClientEvent("Notify",source,"negado","Este Airdrop já foi Coletado!")
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.checkIntPermissions()
    local source = source
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,2)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id then
        TriggerClientEvent("Notify",source,"negado","Você não consegue resgatar o airdrop com pessoas ao seu lado.")
        return false
    else
        return true
    end
end

-- Citizen.CreateThread(function()
-- 	while true do
--         sleepbrq = 60000
-- 		if os.date('%H') ==  '10' or '12' or '14' or '16' or '00' or '22' or '1' or '2' then
--             if os.date('%M') == '00' then
--                 thwstartado = true
--                 wazeollected = false
--                 startadrop()
--                 TriggerClientEvent('Notify',-1,'aviso','Aviso','Airdrop foi lançado.')
--             end
--         end
-- 		Citizen.Wait(sleepbrq)
-- 	end
-- end)

RegisterCommand("airdrop2",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    thwstartado = true
    wazeollected = false
    startadrop("wazedrop1")
end)