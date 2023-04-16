local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

sPrison = Tunnel.getInterface("waze_prisao")

wazePrison = {}
Tunnel.bindInterface("waze_prisao", wazePrison)

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


-- COORDENADA DE TELEPORTE PRA DENTRO DA PRISÃO
-- 662.38,95.41,83.95

--------------------------------------------------------------------
-- CONFIG
--------------------------------------------------------------------

-- ETAPA INICIAL (0)
local Secretaria = {1775.75,2552.04,45.57}

----------------------------
-- ETAPA 1 - VARRER O PÁTIO
----------------------------
local Patio = {1724.01,2535.26,45.57}
local ReducaoPatio = 1 -- MESES A SEREM REDUZIDOS POR ESSA ETAPA
----------------------------
-- ETAPA 2 - LIMPAR GRADES
----------------------------
local Grades = {
    [1] = {1707.63,2550.42,45.57},
    [2] = {1706.87,2553.08,45.57},
    [3] = {1705.18,2553.89,45.57},
    [4] = {1710.61,2553.42,45.57}
}
local ReducaoGrades = 1
----------------------------
-- ETAPA 3 - LAVAR ROUPAS
----------------------------
local PilhaDeRoupas = {1772.56,2536.66,45.57}
local MaquinaDeLavar = {1712.12,2566.15,45.57,60.10}
local ReducaoLavagem = 2
----------------------------
-- ETAPA 4 - BANHO DE SOL
----------------------------
local BanhoDeSol = {1644.65,2532.1,45.57}
local TempoNoSol = 40 -- SEGUNDOS
local ReducaoDescanso = 7
----------------------------
-- ETAPA 5 - TIRAR LIXOS
----------------------------
local Lixeiras = {
    [1] = {1604.89,2564.15,45.86},
    [2] = {1625.43,2569.27,45.57},
    [3] = {1636.32,2565.52,45.57},
    [4] = {1604.95,2543.34,45.86},
    [5] = {1616.54,2530.49,45.86},
    [6] = {1613.13,2526.02,45.86}
}
local LixeiraFinal = {1619.64,2519.9,45.86}
local ReducaoLixo = 2

--------------------------------------------------------------------
-- CÓDIGO
--------------------------------------------------------------------

local preso = false
local etapa = 0
local blips = nil

-- ETAPA 2
local QualGrade = 1

-- ETAPA 3
local EstaComRoupas = false
local RoupasLavadas = 0

-- ETAPA 4 
local ContagemBanhoDeSol = 0

-- ETAPA 5 
local LixosTirados = {}
local Blipers = {}
local BlipsLixoCriados = false
local ComLixo = false

CreateThread(function() 
    while true do
        local ThreadDelay = 5000 
        if preso then
            ThreadDelay = 60000
            sPrison.onibAUIEGBiSNAKDjnAHUItgAutomatica()
            vRP.PrisionGod()
        end
        Wait(ThreadDelay)
    end
end)

CreateThread(function() 
    while true do
        local ThreadDelay = 5000
        if preso then
            ThreadDelay = 5
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            if etapa == 0 then
                dTPrison('PARA INICIAR SEU TRABALHO, VÁ ATÉ A ~g~RECEPÇÃO ~w~E PEÇA O ~g~ITINERÁRIO', 4,0.5,0.93,0.50,255,255,255,180)

                if not blips then
                    CriandoBlipPrison(Secretaria[1], Secretaria[2], Secretaria[3])
                end

                local dist = #(pedCoords - vec3(Secretaria[1], Secretaria[2], Secretaria[3]))
                if dist <= 15 then
                    DrawMarker(21, Secretaria[1], Secretaria[2], Secretaria[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,155, 1, 0, 0, 1)
                    if dist <= 0.7 then
                        DT3DPrison(Secretaria[1], Secretaria[2], Secretaria[3],'~g~[E] ~w~PARA PEGAR O ~g~ITINERÁRIO')

                        if IsControlJustPressed(0,38) then
                            etapa = 1
                            if blips then
                                RemoveBlip(blips)
                                blips = nil
                            end
                        end
                    end
                end
            elseif etapa == 1 then -- VARRER O PÁTIO
                dTPrison('VÁ ATÉ O ~g~PÁTIO~w~ E ~g~VARRA-O', 4,0.5,0.93,0.50,255,255,255,180)

                if not blips then
                    CriandoBlipPrison(Patio[1], Patio[2], Patio[3])
                end

                local dist = #(pedCoords - vec3(Patio[1], Patio[2], Patio[3]))
                if dist <= 15 then
                    DrawMarker(21, Patio[1], Patio[2], Patio[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,155, 1, 0, 0, 1)
                    if dist <= 0.7 then
                        DT3DPrison(Patio[1], Patio[2], Patio[3],'~g~[E] ~w~PARA VARRER O ~g~PÁTIO')

                        if IsControlJustPressed(0,38) then
                            vRP.CarregarObjeto("amb@world_human_janitor@male@idle_a" , "idle_a" , "prop_tool_broom" , 49 , 28422)
                            Wait(45000)
                            dist = #(pedCoords - vec3(Patio[1], Patio[2], Patio[3]))
                            if dist <= 5.0 and IsEntityPlayingAnim(ped, "amb@world_human_janitor@male@idle_a" , "idle_a", 3) then
                                etapa = 2
                                if blips then
                                    RemoveBlip(blips)
                                    blips = nil
                                end
                                sPrison.onibAUIEGBiSNAKDjnAHUItg(ReducaoPatio)
                            else
                                TriggerEvent('Notify', 'negado', 'Você <b>não</b> está varrendo corretamente!')
                            end
                            StopAnim()
                        end
                    end
                end

            elseif etapa == 2 then
                dTPrison('VÁ ATÉ AS ~g~CELAS~w~ E ~g~LIMPE-AS', 4,0.5,0.93,0.50,255,255,255,180)

                if not blips then
                    CriandoBlipPrison(Grades[QualGrade][1], Grades[QualGrade][2], Grades[QualGrade][3])
                end

                local dist = #(pedCoords - vec3(Grades[QualGrade][1], Grades[QualGrade][2], Grades[QualGrade][3]))
                if dist <= 15 then
                    DrawMarker(21, Grades[QualGrade][1], Grades[QualGrade][2], Grades[QualGrade][3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,155, 1, 0, 0, 1)
                    if dist <= 0.7 then
                        DT3DPrison(Grades[QualGrade][1], Grades[QualGrade][2], Grades[QualGrade][3],'~g~[E] ~w~PARA LIMPAR A ~g~GRADE')

                        if IsControlJustPressed(0,38) then
                            vRP.CarregarObjeto("timetable@maid@cleaning_window@base" , "base" , "prop_rag_01" , 49 , 28422)
                            Wait(18000)
                            dist = #(pedCoords - vec3(Grades[QualGrade][1], Grades[QualGrade][2], Grades[QualGrade][3]))
                            if dist <= 2.0 and IsEntityPlayingAnim(ped, "timetable@maid@cleaning_window@base" , "base", 3) then
                                if QualGrade == #Grades then
                                    QualGrade = 0
                                    etapa = 3
                                    if blips then
                                        RemoveBlip(blips)
                                        blips = nil
                                    end
                                else
                                    QualGrade = QualGrade + 1
                                    TriggerEvent('Notify', 'sucesso', '<b>Limpe</b> a próxima grade!')
                                end
                                sPrison.onibAUIEGBiSNAKDjnAHUItg(ReducaoGrades)
                            else
                                TriggerEvent('Notify', 'negado', 'Você <b>não</b> está limpando corretamente!')
                            end
                            StopAnim()
                        end
                    end
                end
            elseif etapa == 3 then
                dTPrison('VÁ ATÉ A ~g~LAVANDERIA~w~ E ~g~LAVE ~w~ROUPAS', 4,0.5,0.93,0.50,255,255,255,180)

                if not blips then
                    CriandoBlipPrison(PilhaDeRoupas[1], PilhaDeRoupas[2], PilhaDeRoupas[3])
                end

                if not EstaComRoupas then
                    local dist = #(pedCoords - vec3(PilhaDeRoupas[1], PilhaDeRoupas[2], PilhaDeRoupas[3]))
                    if dist <= 15 then
                        DrawMarker(21, PilhaDeRoupas[1], PilhaDeRoupas[2], PilhaDeRoupas[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,155, 1, 0, 0, 1)
                        if dist <= 0.7 then
                            DT3DPrison(PilhaDeRoupas[1], PilhaDeRoupas[2], PilhaDeRoupas[3],'~g~[E] ~w~PEGAR ~g~ROUPAS')

                            if IsControlJustPressed(0,38) then
                                vRP.playAnim(false,{{"pickup_object","pickup_low"}},false)
                                Wait(1600)
                                vRP.CarregarObjeto("anim@heists@box_carry@" , "idle" , "hei_prop_heist_box" , 50 , 28422)
                                EstaComRoupas = true
                            end
                        end
                    end
                else
                    local dist = #(pedCoords -  vec3(MaquinaDeLavar[1], MaquinaDeLavar[2], MaquinaDeLavar[3]))
                    if dist <= 15 then
                        DrawMarker(21, MaquinaDeLavar[1], MaquinaDeLavar[2], MaquinaDeLavar[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,155, 1, 0, 0, 1)
                        if dist <= 0.7 then
                            DT3DPrison(MaquinaDeLavar[1], MaquinaDeLavar[2], MaquinaDeLavar[3],'~g~[E] ~w~PARA COLOCAR NA ~g~MÁQUINA')
    
                            if IsControlJustPressed(0,38) then
                                SetEntityCoords(ped, MaquinaDeLavar[1], MaquinaDeLavar[2], MaquinaDeLavar[3]-0.97)
                                SetEntityHeading(ped, MaquinaDeLavar[4])
                                Wait(200)
                                vRP.playAnim(false,{{"pickup_object","pickup_low"}},false)
                                Wait(300)
                                StopAnim()
                                if RoupasLavadas == 2 then
                                    RoupasLavadas = 0
                                    etapa = 4
                                    if blips then
                                        RemoveBlip(blips)
                                        blips = nil
                                    end
                                    TriggerEvent('Notify', 'sucesso', 'Você trabalhou demais, vá tirar um descanso.')
                                else
                                    RoupasLavadas = RoupasLavadas + 1
                                    TriggerEvent('Notify', 'sucesso', '<b>Limpe</b> mais roupas!')
                                end
                                EstaComRoupas = false
                                sPrison.onibAUIEGBiSNAKDjnAHUItg(ReducaoLavagem)
                            end
                        end
                    end
                end
            elseif etapa == 4 then

                if not blips then
                    CriandoBlipPrison(BanhoDeSol[1], BanhoDeSol[2], BanhoDeSol[3])
                end

                local dist = #(pedCoords - vec3(BanhoDeSol[1], BanhoDeSol[2], BanhoDeSol[3]))
                if dist < 30 then
                    dTPrison('~g~[E] ~w~PARA DESCANSAR', 4,0.5,0.93,0.50,255,255,255,180)
                    if IsControlJustPressed(0,38) then
                        vRP.playAnim(false, {{"amb@world_human_sunbathe@female@front@idle_a" , "idle_a"}}, true)

                        repeat 
                            if not IsEntityPlayingAnim(ped, "amb@world_human_sunbathe@female@front@idle_a" , "idle_a", 3) then
                                vRP.playAnim(false, {{"amb@world_human_sunbathe@female@front@idle_a" , "idle_a"}}, true)
                            end
                            ContagemBanhoDeSol = ContagemBanhoDeSol + 1
                            -- print(ContagemBanhoDeSol)
                            Wait(1000)
                        until ContagemBanhoDeSol == TempoNoSol

                        if blips then
                            RemoveBlip(blips)
                            blips = nil
                        end
                        sPrison.onibAUIEGBiSNAKDjnAHUItg(ReducaoDescanso)
                        etapa = 5
                        ClearPedTasks(ped)
                        -- print('ACABOU')
                    end
                else
                    dTPrison('VÁ ATÉ A ~g~QUADRA~w~ E ~g~DESCANSE', 4,0.5,0.93,0.50,255,255,255,180)
                end
            elseif etapa == 5 then

                if not blips then
                    CriandoBlipPrison(LixeiraFinal[1], LixeiraFinal[2], LixeiraFinal[3])
                end

                if not BlipsLixoCriados then
                    for k, v in pairs(Lixeiras) do
                        CriandoBlipsPrison(k, v[1], v[2], v[3])
                    end
                    BlipsLixoCriados = true
                end

                if not ComLixo then
                    dTPrison('~g~COLETE ~w~TODOS OS LIXOS MARCADOS EM SEU ~g~GPS', 4,0.5,0.93,0.50,255,255,255,180)
                    for k,v in pairs(Lixeiras) do
                        if not LixosTirados[k] or LixosTirados[k] == nil then
                            local dist = #(pedCoords - vec3(v[1], v[2], v[3]))
                            if dist < 15 then
                                DrawMarker(21, v[1], v[2], v[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,155, 1, 0, 0, 1)
                                if dist <= 0.7 then
                                    DT3DPrison(v[1], v[2], v[3], '~g~[E]~w~ PARA PEGAR O LIXO')
                                    if IsControlJustPressed(0,38) then
                                        RemoveBlip(Blipers[k])
                                        ComLixo = true
                                        LixosTirados[k] = true
                                        vRP.CarregarObjeto("","", "prop_cs_rub_binbag_01" , 50 , 57005 , 0.11 , 0 , 0.0 , 0 , 260.0 , 60.0)
                                    end
                                end
                            end 
                        end
                    end
                else
                    dTPrison('LEVE O ~g~LIXO ~w~PARA A LIXEIRA ~g~CENTRAL', 4,0.5,0.93,0.50,255,255,255,180)
                    local dist = #(pedCoords - vec3(LixeiraFinal[1], LixeiraFinal[2], LixeiraFinal[3]))
                    if dist < 15 then
                        DrawMarker(21, LixeiraFinal[1], LixeiraFinal[2], LixeiraFinal[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,155, 1, 0, 0, 1)
                        if dist <= 0.7 then
                            DT3DPrison(LixeiraFinal[1], LixeiraFinal[2], LixeiraFinal[3], '~g~[E]~w~ PARA DEIXAR O LIXO')
                            if IsControlJustPressed(0,38) then
                                vRP.playAnim(false,{{"pickup_object","pickup_low"}},false)
                                Wait(300)
                                ComLixo = false
                                StopAnim()

                                if #LixosTirados == #Lixeiras then
                                    etapa = 1
                                    if blips then
                                        RemoveBlip(blips)
                                        blips = nil
                                    end
                                    ZerarVariaveis()
                                else
                                    TriggerEvent('Notify', 'sucesso', 'Você coletou um saco de lixo, vá e pegue os demais.')
                                end
                                sPrison.onibAUIEGBiSNAKDjnAHUItg(ReducaoLixo)
                            end
                        end
                    end 
                end

            end


        end
        Wait(ThreadDelay)
    end
end)

-- RegisterCommand('etapa', function(source, args, rawCmd)
    
--     if blips then
--         RemoveBlip(blips)
--         blips = nil
--     end
--     etapa = parseInt(args[1])
-- end)

--------------------------------------------------------------------
-- FUNCOES
--------------------------------------------------------------------
function dTPrison(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end


function DT3DPrison(x,y,z,text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    SetTextFont(6)
    SetTextScale(0.35,0.35)
    SetTextColour(255,255,255,255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function CriandoBlipPrison(x,y,z)
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Destino")
	EndTextCommandSetBlipName(blips)
end

function CriandoBlipsPrison(id,x,y,z)
	Blipers[id] = AddBlipForCoord(x,y,z)
	SetBlipSprite(Blipers[id] ,1)
	SetBlipColour(Blipers[id] ,3)
	SetBlipScale(Blipers[id] ,0.4)
	SetBlipAsShortRange(Blipers[id] ,false)
	SetBlipRoute(Blipers[id] ,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Destino")
	EndTextCommandSetBlipName(Blipers[id] )
end

function StopAnim()
    vRP.DeletarObjeto()
    ClearPedTasks(PlayerPedId())
end

function ZerarVariaveis()

    -- ETAPA 2
    QualGrade = 1

    -- ETAPA 3
    EstaComRoupas = false
    RoupasLavadas = 0

    -- ETAPA 4 
    ContagemBanhoDeSol = 0

    -- ETAPA 5 
    LixosTirados = {}
    Blipers = {}
    BlipsLixoCriados = false
    ComLixo = false

    if blips then
        RemoveBlip(blips)
        blips = nil
    end

    if #Blipers ~= 0 then
        for k, v in pairs(Blipers) do
            RemoveBlip(v)
        end
    end
    Blipers = {}
end

RegisterNetEvent('waze:VirarPrisioneiro')
AddEventHandler('waze:VirarPrisioneiro', function(status)
    ZerarVariaveis()
    preso = status
end)