-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("vrp_mdt")
src = {}
Tunnel.bindInterface("vrp_mdt",src)
local mdt = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mdt",function(source,args)
	if vSERVER.checkPermission() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu" })
		mdt = true
		vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("mdtClose",function(data,cb)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	mdt = false
	vRP._DeletarObjeto()
	vRP.stopAnin(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("infoUser",function(data,cb)
	local tickets,name,lastname,identity,age,arrests,warnings = vSERVER.infoUser(data.user)
	cb({ tickets = tickets, name = name, lastname = lastname, identity = identity, age = age, arrests = arrests, warnings = warnings })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARREST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("arrestsUser",function(data,cb)
	local arrests = vSERVER.arrestsUser(data.user)
	if arrests then
		cb({ arrests = arrests })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TICKET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ticketsUser",function(data,cb)
	local tickets = vSERVER.ticketsUser(data.user)
	if tickets then
		cb({ tickets = tickets })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("warningsUser",function(data,cb)
	local warnings = vSERVER.warningsUser(data.user)
	if warnings then
		cb({ warnings = warnings })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("warningUser",function(data,cb)
	if data.user then
		vSERVER.warningUser(data.user,data.date,data.info,data.officer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TICKET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ticketUser",function(data,cb)
	if data.user then
		vSERVER.ticketUser(data.user,data.value,data.date,data.info,data.officer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARREST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("arrestUser",function(data,cb)
	if data.user then
		vSERVER.arrestUser(data.user,data.value,data.date,data.info,data.officer)
	end
end)


function src.Distancia()
	if #(GetEntityCoords(PlayerPedId()) - vec3(611.65,-2.5,82.79)) < 5.0 then
		return true
	end
	return false
end

