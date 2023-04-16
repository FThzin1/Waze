local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("vrp_radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
    menuactive = not menuactive
    if menuactive then
        SetNuiFocus(true, true)
        SendNUIMessage({ nui = true })
    else
        SetNuiFocus(false)
        SendNUIMessage({ nui = false})
    end
end

RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
    outServers()
end)

CreateThread(function()
	while true do
		Wait(10000)
		if emP.checkRadio2() then
			outServers()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data.freq == "policia1" then
		if emP.checkPermission2("policia.permissao","Policia1") then
			ToggleActionMenu()
			outServers()
			exports.tokovoip_script:addPlayerToRadio(983)
		end
	elseif data.freq == "policia2" then
		if emP.checkPermission2("policiaacao.permissao","Policia2") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(984)
		end
	elseif data.freq == "medico" then
		if emP.checkPermission2("medico.permissao","Medicos") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(985)
		end
	elseif data.freq == "bennys" then
		if emP.checkPermission2("bennys.permissao","Bennys") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(986)
		end
	elseif data.freq == "bloods" then
		if emP.checkPermission2("bloods.permissao","Bloods") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(991)
		end
	elseif data.freq == "crips" then
		if emP.checkPermission2("crips.permissao","Crips") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(990)
		end	
	elseif data.freq == "ballas" then
		if emP.checkPermission2("ballas.permissao","Ballas") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(987)
		end	
	elseif data.freq == "vagos" then
		if emP.checkPermission2("vagos.permissao","Vagos") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(988)
		end		
	elseif data.freq == "grove" then
		if emP.checkPermission2("grove.permissao","Grove") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(989)
		end	
	elseif data.freq == "bratva" then
		if emP.checkPermission2("bratva.permissao","Bratva") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(992)
		end	
	elseif data.freq == "siciliana" then
		if emP.checkPermission2("siciliana.permissao","Siliciana") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(993)
		end

	elseif data.freq == "bahamas" then
		if emP.checkPermission2("bahamas.permissao","Bahamas") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(994)
		end		
	elseif data.freq == "lifeinvader" then
		if emP.checkPermission2("lifeinvader.permissao","Life Invader") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(995)
		end	

	elseif data.freq == "hells" then
		if emP.checkPermission2("hells.permissao","hells") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(996)
		end	
	elseif data.freq == "warlocks" then
		if emP.checkPermission2("warlocks.permissao","Warlocks") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(997)
		end
	elseif data.freq == "scripted" then
		if emP.checkPermission2("scripted.permissao","scripted") then
			outServers()
			ToggleActionMenu()
			exports.tokovoip_script:addPlayerToRadio(998)
		end
	elseif data.freq == "fechar" then
		ToggleActionMenu()
	end
end)
------------------------------------	-----------------------------------------------------------------------------------------------------
-- RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("radio",function(source,args)
    if emP.checkRadio() then
        ToggleActionMenu()
	end
end)

RegisterCommand("radiof",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local ped = PlayerPedId()
	if args[1] then
		if parseInt(args[1]) < 982 then
        	if emP.checkRadio() then
				if GetEntityHealth(ped) <= 101 then TriggerEvent('Notify', "negado", 'Você não pode fazer isso em coma.') return end
				if emP.checkPermission() then
                	outServers()
                	exports.tokovoip_script:addPlayerToRadio(parseInt(args[1]))
					TriggerEvent("Notify","sucesso","Você entrou na Frequência <b>"..args[1].."</b> do rádio.",8000)
				end
			end
		else
			TriggerEvent("Notify","negado","Você não tem permissão.")
		end
    end
end)

RegisterCommand("radiod",function(source,args)
	if not exports["chat"]:statusChat() then return end
	local ped = PlayerPedId()
    if emP.checkRadio() then
		if GetEntityHealth(ped) <= 101 then TriggerEvent('Notify', "negado", 'Você não pode fazer isso em coma.') return end
		if emP.checkPermission() then
			outServers()
		    TriggerEvent("Notify","sucesso","Você desconectou de todos os canais.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTSERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
function outServers()
	local i = 0
    while i < 1000 do
      if exports.tokovoip_script:isPlayerInChannel(i) == true then
		exports.tokovoip_script:removePlayerFromRadio(i)
	  end	
      i = i + 1
    end
end