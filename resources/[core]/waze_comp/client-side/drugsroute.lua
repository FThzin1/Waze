local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

wazeDrugRoute = {}
Tunnel.bindInterface("waze_entrega_drogas", wazeDrugRoute)
sDrugs = Tunnel.getInterface("waze_entrega_drogas")

vRP = Proxy.getInterface("vRP")
vRPclient = Proxy.getInterface("vRP")

local dBoostLigado = false

function wazeDrugRoute.StatusBoostDrugs(status)
    dBoostLigado = status
end

local PosDrogas = {
    [1] = {['x'] = -102.52, ['y'] = -11.47, ['z'] = 66.36},
    [2] = {['x'] = -106.76, ['y'] = -8.37, ['z'] = 66.36},
    [3] = {['x'] = -161.17, ['y'] = -4.36, ['z'] = 62.47},
    [4] = {['x'] = -175.89, ['y'] = -9.86, ['z'] = 58.22},
    [5] = {['x'] = 360.16, ['y'] = 357.55, ['z'] = 103.92},
    [6] = {['x'] = -273.56, ['y'] = 28.27, ['z'] = 54.76},
    [7] = {['x'] = 189.78, ['y'] = 308.98, ['z'] = 105.4},
    [8] = {['x'] = -290.62, ['y'] = 14.93, ['z'] = 54.76},
    [9] = {['x'] = -315.17, ['y'] = -3.48, ['z'] = 48.19},
    [10] = {['x'] = -357.55, ['y'] = 16.76, ['z'] = 47.86},
    [11] = {['x'] = -351.75, ['y'] = 14.79, ['z'] = 47.86},
    [12] = {['x'] = -490.37, ['y'] = 28.37, ['z'] = 46.3},
    [13] = {['x'] = 1223.84, ['y'] = -503.24, ['z'] = 66.4},
    [14] = {['x'] = -502.4, ['y'] = 32.62, ['z'] = 44.72},
    [15] = {['x'] = -533.79, ['y'] = 33.44, ['z'] = 44.62},
    [16] = {['x'] = 1125.63, ['y'] = -1242.08, ['z'] = 21.37},
    [17] = {['x'] = 1185.57, ['y'] = -1394.89, ['z'] = 35.14},
    [18] = {['x'] = -507.21, ['y'] = 101.09, ['z'] = 63.81},
    [19] = {['x'] = -511.14, ['y'] = 100.18, ['z'] = 63.81},
    [20] = {['x'] = 961.71, ['y'] = -1586.18, ['z'] = 30.44},
    [21] = {['x'] = -395.84, ['y'] = 146.68, ['z'] = 65.73},
    [22] = {['x'] = 938.74, ['y'] = -2127.41, ['z'] = 30.51},
    [23] = {['x'] = -411.71, ['y'] = 152.49, ['z'] = 65.53},
    [24] = {['x'] = -198.3, ['y'] = 142.29, ['z'] = 70.33},
    [25] = {['x'] = -245.5, ['y'] = 203.35, ['z'] = 83.93},
    [26] = {['x'] = 194.08, ['y'] = -1843.64, ['z'] = 27.21},
    [27] = {['x'] = -182.88, ['y'] = 219.03, ['z'] = 88.77},
    [28] = {['x'] = -354.6, ['y'] = 213.26, ['z'] = 86.73},
    [29] = {['x'] = -559.1, ['y'] = -1803.63, ['z'] = 22.61},
    [30] = {['x'] = -775.05, ['y'] = 312.49, ['z'] = 85.7},
    [31] = {['x'] = -819.55, ['y'] = 267.85, ['z'] = 86.4},
    [32] = {['x'] = -843.11, ['y'] = 466.48, ['z'] = 87.61},
    [33] = {['x'] = -684.18, ['y'] = -1167.08, ['z'] = 14.6},
    [34] = {['x'] = -1245.55, ['y'] = 376.64, ['z'] = 75.35},
    [35] = {['x'] = -1331.64, ['y'] = -740.5, ['z'] = 25.26},
    [36] = {['x'] = -1636.33, ['y'] = 180.69, ['z'] = 61.76},
    [37] = {['x'] = -1368.49, ['y'] = -647.23, ['z'] = 28.7},
    [38] = {['x'] = -1504.83, ['y'] = -522.8, ['z'] = 33.43},
    [39] = {['x'] = -1345.25, ['y'] = -890.26, ['z'] = 13.44},
    [40] = {['x'] = -1652.97, ['y'] = -372.63, ['z'] = 45.34},
    [41] = {['x'] = -1373.53, ['y'] = -916.21, ['z'] = 10.28},
    [42] = {['x'] = -1790.17, ['y'] = -400.01, ['z'] = 46.49},
    [43] = {['x'] = -1381.94, ['y'] = -941.39, ['z'] = 10.13},
    [44] = {['x'] = -1360.22, ['y'] = -963.72, ['z'] = 9.7},
    [45] = {['x'] = -761.83, ['y'] = 352.02, ['z'] = 88.0},
    [46] = {['x'] = -1323.25, ['y'] = -1025.57, ['z'] = 7.75},
    [47] = {['x'] = -731.17, ['y'] = 321.03, ['z'] = 86.78},
    [48] = {['x'] = -496.74, ['y'] = 79.4, ['z'] = 55.86},
    [49] = {['x'] = -1318.51, ['y'] = -1159.68, ['z'] = 4.87},
    [50] = {['x'] = -355.83, ['y'] = 94.87, ['z'] = 66.25},
    [51] = {['x'] = -1342.31, ['y'] = -1234.48, ['z'] = 5.94},
    [52] = {['x'] = -186.23, ['y'] = 65.51, ['z'] = 67.88},
    [53] = {['x'] = -1309.44, ['y'] = -1317.57, ['z'] = 4.88},
    [54] = {['x'] = -1171.14, ['y'] = -1380.44, ['z'] = 4.98},
    [55] = {['x'] = -519.94, ['y'] = -593.49, ['z'] = 30.45},
    [56] = {['x'] = -594.06, ['y'] = -749.12, ['z'] = 29.49},
    [57] = {['x'] = -714.96, ['y'] = -713.75, ['z'] = 29.14},
    [58] = {['x'] = -672.89, ['y'] = -981.64, ['z'] = 22.35},
    [59] = {['x'] = -1107.58, ['y'] = -1223.05, ['z'] = 2.57},
    [60] = {['x'] = -1349.49, ['y'] = -945.47, ['z'] = 9.71},
    [61] = {['x'] = -1527.93, ['y'] = -886.28, ['z'] = 13.69},
    [62] = {['x'] = -1026.21, ['y'] = -1466.4, ['z'] = 5.58},
    [63] = {['x'] = -1263.22, ['y'] = -1117.55, ['z'] = 7.73},
    [64] = {['x'] = -969.91, ['y'] = -1431.45, ['z'] = 7.68},
    [65] = {['x'] = -924.75, ['y'] = -1163.45, ['z'] = 4.82},
    [66] = {['x'] = -991.18, ['y'] = -1518.7, ['z'] = 4.91},
    [67] = {['x'] = -812.83, ['y'] = -980.76, ['z'] = 14.16},
    [68] = {['x'] = -830.28, ['y'] = -1255.76, ['z'] = 6.59},
    [69] = {['x'] = -794.5, ['y'] = -726.63, ['z'] = 27.28},
    [70] = {['x'] = -116.17, ['y'] = -372.84, ['z'] = 38.0},
    [71] = {['x'] = -38.67, ['y'] = -218.36, ['z'] = 45.8},
    [72] = {['x'] = -428.7, ['y'] = -1728.27, ['z'] = 19.79},
    [73] = {['x'] = 253.18, ['y'] = -344.35, ['z'] = 44.53},
    [74] = {['x'] = -398.83, ['y'] = -1885.2, ['z'] = 21.54},
    [75] = {['x'] = -37.09, ['y'] = -1492.54, ['z'] = 31.22},
    [76] = {['x'] = 839.68, ['y'] = -182.07, ['z'] = 74.19},
    [77] = {['x'] = 49.89, ['y'] = -1453.51, ['z'] = 29.32},
    [78] = {['x'] = 879.91, ['y'] = -205.6, ['z'] = 71.98},
    [79] = {['x'] = 920.71, ['y'] = -238.59, ['z'] = 70.17},
    [80] = {['x'] = 231.35, ['y'] = -1752.66, ['z'] = 28.99},
    [81] = {['x'] = 952.74, ['y'] = -251.74, ['z'] = 67.97},
    [82] = {['x'] = 1122.2, ['y'] = -645.53, ['z'] = 56.82},
    [83] = {['x'] = 1142.36, ['y'] = -668.31, ['z'] = 57.09},
    [84] = {['x'] = 1231.46, ['y'] = -1083.04, ['z'] = 38.53},
    [85] = {['x'] = 1224.32, ['y'] = -1468.41, ['z'] = 34.85},
    [86] = {['x'] = 1003.4, ['y'] = -2409.77, ['z'] = 30.51},
    [87] = {['x'] = 749.14, ['y'] = -1697.23, ['z'] = 29.27},
    [88] = {['x'] = 977.98, ['y'] = -2227.07, ['z'] = 31.55},
    [89] = {['x'] = 849.46, ['y'] = -1995.26, ['z'] = 29.99},
    [90] = {['x'] = 441.76, ['y'] = -2080.89, ['z'] = 22.24},
    [91] = {['x'] = 369.77, ['y'] = -2452.31, ['z'] = 6.3},
    [92] = {['x'] = 1122.67, ['y'] = -1303.8, ['z'] = 34.72},
    [93] = {['x'] = 94.68, ['y'] = -2676.3, ['z'] = 6.01},
    [94] = {['x'] = -259.96, ['y'] = -2656.91, ['z'] = 6.28},
    [95] = {['x'] = 1082.61, ['y'] = -788.24, ['z'] = 58.27},
    [96] = {['x'] = -297.45, ['y'] = -2599.15, ['z'] = 6.2},
    [97] = {['x'] = -272.62, ['y'] = -2496.28, ['z'] = 7.3},
    [98] = {['x'] = 1120.19, ['y'] = -639.6, ['z'] = 56.82},
    [99] = {['x'] = -624.08, ['y'] = -2363.73, ['z'] = 13.95},
    [100] = {['x'] = 1150.03, ['y'] = -401.13, ['z'] = 67.34},
    [101] = {['x'] = 1099.49, ['y'] = -345.73, ['z'] = 67.19}
}

local PosEntregas = {
    [1] = {['x'] = -186.52, ['y'] = -1700.83, ['z'] = 32.88, ['CorBlipR'] = 0, ['CorBlipG'] = 255, ['CorBlipB'] = 0}, -- GROOVE
    [2] = {['x'] = 360.77,  ['y'] = -2042.53, ['z'] = 22.36, ['CorBlipR'] = 255, ['CorBlipG'] = 255, ['CorBlipB'] = 0}, -- VAGOS
    [3] = {['x'] = 84.81, ['y'] = -1967.15, ['z'] = 20.75, ['CorBlipR'] = 134, ['CorBlipG'] = 52, ['CorBlipB'] = 235 }, -- BALLAS
}

local EstaEntregando = false
local EntregaSorteada = false
local blip = false
local PontoDeEntrega = 0

RegisterNetEvent('waze:AdminEntregaDrogas')
AddEventHandler('waze:AdminEntregaDrogas', function()
    EstaEntregando = true
end)

CreateThread(function() 
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        if not EstaEntregando then
            for _, InfoEntregas in pairs(PosEntregas) do
                local distance = #(GetEntityCoords(ped) - vec3(InfoEntregas.x, InfoEntregas.y, InfoEntregas.z))
                if distance <= 1 then
                    timeDistance = 4
                    DrawMarker(27, InfoEntregas.x, InfoEntregas.y, InfoEntregas.z-1, 0, 0, 0, 0, 0, 0,1.0, 1.0, 1.0, InfoEntregas.CorBlipR, InfoEntregas.CorBlipG, InfoEntregas.CorBlipB,55, 0, 0, 0, 1)
                    if IsControlJustPressed(0,38) then
                        if sDrugs.CooldownLiberado() then
                            sDrugs.SetCooldown()
                            TriggerEvent('Notify', "sucesso", 'Você inicou a entrega de drogas.')
                            EstaEntregando = true
                        end
                    end
                end
            end
        else
            if not EntregaSorteada then
                EntregaSorteada = true
                PontoDeEntrega = math.random(#PosDrogas)
                if not blip then
                    CriandoBlipDR(PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z)
                    blip = true
                end
            else
                local distDrogas = #(GetEntityCoords(ped) - vec3(PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z))
                if distDrogas < 15 then
                    timeDistance = 4
                    DrawMarker(21, PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z, 0, 0, 0, 0, 0, 0,0.5,0.5,0.5, 255,0,0,55, 0, 0, 0, 1)
                    if distDrogas < 0.5 then
                        DT3DDR(PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z, 'PRESSIONE ~r~[E] ~w~PARA ENTREGAR AS DROGAS', 255,255,255)
                        if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
                            local ChanceChamarPm = math.random(100)
                            if ChanceChamarPm > 45 then
                                TriggerServerEvent('waze:DrogasChamarPolicia', PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z)
                            end
                            if not dBoostLigado then
                                sDrugs.IObiuBAEgukjKASdh()
                            end
                            if dBoostLigado then
                                sDrugs.IObiuBAEgukjKASdhboost()
                            end
                            EntregaSorteada = false
                            if blip then
                                RemoveBlip(blips)
                                blip = false
                            end
                            vRP._playAnim(false,{"pickup_object","pickup_low"},false)
                            TriggerEvent("progress",5000)
                            FreezeEntityPosition(ped, true)
                            Wait(5000)
                            FreezeEntityPosition(ped, false)
                            SpawnObject(PosDrogas[PontoDeEntrega].x, PosDrogas[PontoDeEntrega].y, PosDrogas[PontoDeEntrega].z)
                            ClearPedTasks(ped)
                            DeleteOBJ()
                        end
                    end
                end
            end

            if EstaEntregando then
                timeDistance = 4
                if IsControlJustPressed(0,168) then
                    sDrugs.SetCooldown()
                    if blip then
                        RemoveBlip(blips)
                        blip = false
                    end
                    EstaEntregando = false
                    EntregaSorteada = false
                    
                    PontoDeEntrega = 0
                    TriggerEvent('Notify', "sucesso", 'Você cancelou as entregas de droga.')
                end
            end
        end
        Wait(timeDistance)
    end
end)

local blipsDenuncia = {}
RegisterNetEvent('waze:DrogasChamarPolicia')
AddEventHandler('waze:DrogasChamarPolicia',function(x,y,z,user_id)
    if not DoesBlipExist(blipsDenuncia[user_id]) then
        TriggerEvent("NotifyPush",{ code = 31, title = "Denúncia de droga", x = x, y = y, z = z })
        blipsDenuncia[user_id] = AddBlipForCoord(x,y,z)
        SetBlipScale(blipsDenuncia[user_id],0.5)
        SetBlipSprite(blipsDenuncia[user_id],164)
        SetBlipColour(blipsDenuncia[user_id],49)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Denúncia de droga")
        EndTextCommandSetBlipName(blipsDenuncia[user_id])
        SetBlipAsShortRange(blipsDenuncia[user_id],false)
        SetTimeout(30000,function()
            if DoesBlipExist(blipsDenuncia[user_id]) then
                RemoveBlip(blipsDenuncia[user_id])
            end
        end)
    end
end)

local obj
function SpawnObject(x,y,z)
    local objectname = 'prop_drug_package'
    RequestModel(objectname)
    while not HasModelLoaded(objectname) do
	    Wait(1)
    end

    obj = CreateObject(GetHashKey(objectname), x,y,z-1, true, true, true)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)

end

function DeleteOBJ()
    DeleteObject(obj)
end

function CriandoBlipDR(x,y,z)
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,501)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de drogas")
	EndTextCommandSetBlipName(blips)
end

function DT3DDR(x,y,z, text, r,g,b)
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

AddEventHandler('playerSpawned', function()
    Wait(3000)
    dBoostLigado = sDrugs.GetStatusBoostDrugs()
    print('O boost de vendas de drogas está: ' .. tostring(dBoostLigado))
end)