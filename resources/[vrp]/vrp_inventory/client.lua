local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_inventory")

client = {}
Tunnel.bindInterface("vrp_inventory",client)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data)
	StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end)

function client.FecharInventario()
    StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEANCHOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vehicleanchor')
AddEventHandler('vehicleanchor',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    FreezeEntityPosition(vehicle,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("moc",function(source,args)
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) then
          if not invOpen then
              StartScreenEffect("MenuMGSelectionIn", 0, true)
              invOpen = true
              SetNuiFocus(true,true)
              SendNUIMessage({ action = "showMenu" })
           else
               StopScreenEffect("MenuMGSelectionIn")
               SetNuiFocus(false,false)
               SendNUIMessage({ action = "hideMenu" })
               invOpen = false
          end
     end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("moc","Abrir a mochila","keyboard","oem_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAR FAZENDO ANIMACAO
------------------------------------------ 1 -------- 2 -----------------------------------------------------------------------------------
function client.EstiverFazendoAnimacao(zoio, tandera)
    local ped = PlayerPedId()
    if IsEntityPlayingAnim(ped, zoio, tandera, 3) then 
        return true  
    else 
        return false 
    end
end

--local contagemBandagem = 0
--function client.SetBandagem(QtdBandagem)
--    contagemBandagem = QtdBandagem
--end
--
--CreateThread(function() 
--    while true do
--        Wait(1000)
--        if contagemBandagem > 0 then
--            contagemBandagem = contagemBandagem - 1
--            local ped = PlayerPedId()
--            local vida = GetEntityHealth(ped)
--            if vida + 3 <= 395 then
--                if vida > 101 then
--                    SetEntityHealth(ped, vida +3)
--                else
--                    contagemBandagem = 0
--                    TriggerEvent('Notify', "importante", 'A bandagem foi cancelada por você estar em coma.')
--                end
--            else 
--                TriggerEvent('Notify', "sucesso", 'Tratamento finalizado.')
--                SetEntityHealth(ped, 395)
--                TriggerEvent('cancelando',false)
--                -- TriggerEvent('Notify', "sucesso", 'VIDA 395')
--                contagemBandagem = 0
--            end
--        end
--    end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	vRPNserver.dropItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
    if data.item == "test" or
    data.item == "wbody|WEAPON_STUNGUN" or
    data.item == "wbody|WEAPON_FLASHLIGHT" or
    data.item == "wbody|WEAPON_NIGHTSTICK" or
    data.item == "wbody|WEAPON_COMBATPISTOL" or
    data.item == "wbody|WEAPON_HEAVYPISTOL" or
    data.item == "wbody|WEAPON_COMBATPDW" or
    data.item == "wbody|WEAPON_CARBINERIFLE" or
    data.item == "wbody|WEAPON_CARBINERIFLE_MK2" or
    data.item == "wbody|WEAPON_SMG" or
    data.item == "wbody|WEAPON_PUMPSHOTGUN" or
    data.item == "wammo|WEAPON_COMBATPISTOL" or
    data.item == "wammo|WEAPON_HEAVYPISTOL" or
    data.item == "wammo|WEAPON_COMBATPDW" or
    data.item == "wammo|WEAPON_CARBINERIFLE" or
    data.item == "wammo|WEAPON_CARBINERIFLE_MK2" or
    data.item == "wammo|WEAPON_SMG" and
    data.item == "wammo|WEAPON_PUMPSHOTGUN" then
        TriggerEvent("Notify","negado","Você não pode enviar itens do arsenal policial.")
        return
    end
	vRPNserver.sendItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	vRPNserver.useItem(data.item,data.type,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,peso,maxpeso = vRPNserver.Mochila()
	if inventario then
		cb({ inventario = inventario, peso = peso, maxpeso = maxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:Update")
AddEventHandler("Creative:Update",function(action)
	SendNUIMessage({ action = action })
end)

local CancelandoBotoes = false

RegisterNetEvent('inventory:BlockButtons')
AddEventHandler('inventory:BlockButtons', function(status)
    CancelandoBotoes = status
end)

CreateThread(function() 
    while true do
        local ThreadDelay = 3000
        if CancelandoBotoes then
            ThreadDelay = 4
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 68, true)
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 70, true)
            DisableControlAction(0, 91, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 114, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 144, true)
        end

        Wait(ThreadDelay)
    end
end)

