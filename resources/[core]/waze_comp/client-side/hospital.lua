-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-----------------------------------------------------------------------------------------------------------------------------------------
local wazeHospital = {}
Tunnel.bindInterface("vrp_hospital",wazeHospital)
sHospital = Tunnel.getInterface("vrp_hospital")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inStretcher = false
local inTreat = false
local positions = {
	{ GetHashKey("v_med_bed1"),0.0,0.0 },
	{ GetHashKey("v_med_bed2"),0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 },
	{ -1091386327,1.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TREAT : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("deitar",function(source,args,rawCmd)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    if inStretcher then
        TriggerEvent("Notify","negado","Você já está em um tratamento.") 
        return 
    end

    for k,v in pairs(positions) do
        local object = GetClosestObjectOfType(coords,0.9,v[1],0,0,0)
        if DoesEntityExist(object) then
            local objectCoords = GetEntityCoords(object)

            SetEntityCoords(ped,objectCoords.x,objectCoords.y,objectCoords.z+v[2])
            SetEntityHeading(ped,GetEntityHeading(object)+v[3]-180.0)
            vRP._playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
            inStretcher = true
            
            sHospital.checkServices()
        end
    end
end)

RegisterCommand('cafezinho', function(source, args, rawCmd)
	if not exports["chat"]:statusChat() then return end
    local distance = #(GetEntityCoords(PlayerPedId()) - vec3(622.37,7.49,82.78))
    local ped = PlayerPedId()
    if distance <= 2.0 then
        if sHospital.checkPolice() and not IsPedInAnyVehicle(ped) then
            sHospital.treatmentPolice()
        else
            TriggerEvent('Notify', "negado", 'Você não pode fazer isso')
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TREAT : THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local DelayThread = 1000
        if inStretcher then
            DelayThread = 4
            local ped = PlayerPedId()

            if IsControlJustPressed(0,167) then
                ClearPedTasks(PlayerPedId())
                vRP._stopAnim(false)
                inStretcher = false  
            end

            if not IsEntityPlayingAnim(ped,"anim@gangops@morgue@table@","body_search",3) then
                inStretcher = false
            end
        end
        Wait(DelayThread)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TREAT : FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function wazeHospital.initTreat()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    if inTreat then
        return
    end

    inTreat = true
    TriggerEvent("Notify","sucesso","Você está sendo tratado, aguarde até a finalização.")
    TriggerEvent('waze:ExcecaoVida')
    TriggerEvent('waze:ExcecaoGod')

    if inTreat then
        repeat 
            Wait(400)
			if IsEntityPlayingAnim(ped,"anim@gangops@morgue@table@","body_search",3) then
				if GetEntityHealth(ped) > 101 then
					SetEntityHealth(ped,GetEntityHealth(ped)+1)
                    print("Vida do jogador atualizada "..GetEntityHealth(ped)+1)
				else
					TriggerEvent("Notify","negado","Tratamento cancelado.")
					inTreat = false
					return
				end
			else
				TriggerEvent("Notify","negado","Tratamento cancelado.")
				inTreat = false
                inStretcher = false
				return
			end
        until GetEntityHealth(ped) >= 399 or GetEntityHealth(ped) <= 101
        TriggerEvent("Notify","sucesso","Tratamento concluído.")
        inTreat = false  
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INTREAT : FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function wazeHospital.inTreat()
    return inTreat
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOP TREAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hospital:stopTreat")
AddEventHandler("vrp_hospital:stopTreat",function()
    if inTreat then
        inTreat = false
        TriggerEvent("Notify","negado","Você foi carregado, portanto seu tratamento foi finalizado") 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        local distance = #(GetEntityCoords(ped) - vec3(308.34,-594.96,43.3))
        if distance <= 20 then
            timeDistance = 4
            if distance <= 1.2 then
                Hospital3D(v[1],v[2],v[3],"PRESSIONE  ~o~E~w~  PARA COMPRAR ~o~5 ~w~BANDAGEM ~o~($25.000)",255,255,255)
                if IsControlJustPressed(0,38) then
                    sHospital.k8TaPrRNMyvR4THGLHbDkAewGpXpBUY()
                end
            end
        end
        Wait(timeDistance)
    end
end)

function Hospital3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vec3(px,py,pz) - vec3(x,y,z))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.35, 0.35)
        SetTextColour(r, g, b, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 55, 55, 55, 68)
    end
end