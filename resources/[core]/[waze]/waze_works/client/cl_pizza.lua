local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
pizzA = Tunnel.getInterface("waze_uber")
vRP = Proxy.getInterface("vRP")

------------------------------------------------------------------------------------------------------------
-- CONFIG
------------------------------------------------------------------------------------------------------------
local ComecarTrabalho = {-563.33, 285.12, 85.38}
local MotoSpawn = {-562.24, 302.03, 83.17}
local Recepcao = {-564.85, 278.28, 83.14}
local Bar = {-559.99,287.07,82.18}
local debug = false
local Entregas = {
	[1] = {['x'] = -310.44, ['y'] = 222.52, ['z'] = 87.93 }, 
	[2] = {['x'] = 325.97, ['y'] = 537.32, ['z'] = 153.86 }, 
	[3] = {['x'] = 641.36, ['y'] = 260.97, ['z'] = 103.3 }, 
	[4] = {['x'] = 1394.67, ['y'] = 1141.7, ['z'] = 114.62 }, 
	[5] = {['x'] = 1172.24, ['y'] = -377.0, ['z'] = 68.23 }, 
	[6] = {['x'] = 321.35, ['y'] = -197.54, ['z'] = 54.23 }, 
	[7] = {['x'] = 1139.28, ['y'] = -961.8, ['z'] = 47.53 }, 
	[8] = {['x'] = 1331.98, ['y'] = -1642.09, ['z'] = 52.12 }, 
	[9] = {['x'] = -1750.11, ['y'] = -697.2, ['z'] = 10.18 }, 
	[10] = {['x'] = -1269.35, ['y'] = -1296.04, ['z'] = 4.01 }, 
	[11] = {['x'] = -142.26, ['y'] = -1697.98, ['z'] = 30.77 }, 
	[12] = {['x'] = -20.52, ['y'] = -1858.37, ['z'] = 25.41 }, 
	[13] = {['x'] = 279.57, ['y'] = -2043.29, ['z'] = 19.77 }, 
	[14] = {['x'] = -1960.8, ['y'] = 212.11, ['z'] = 86.81 }, 
	[15] = {['x'] = -1673.05, ['y'] = 386.2, ['z'] = 89.35 }, 
	[16] = {['x'] = -773.5, ['y'] = 311.87, ['z'] = 85.7 }, 
	[17] = {['x'] = 318.23, ['y'] = 562.0, ['z'] = 154.54 }, 
	[18] = {['x'] = 659.57, ['y'] = 593.24, ['z'] = 129.06 }, 
	[19] = {['x'] = 1385.73, ['y'] = -593.04, ['z'] = 74.49 }, 
	[20] = {['x'] = -1130.17, ['y'] = 783.98, ['z'] = 163.89 }, 
	[21] = {['x'] = -746.9, ['y'] = 808.6, ['z'] = 215.03 }, 
	[22] = {['x'] = -185.25, ['y'] = 591.67, ['z'] = 197.83 }, 
	[23] = {['x'] = -1643.7, ['y'] = -988.15, ['z'] = 13.02 }, 
	[24] = {['x'] = -294.72, ['y'] = -828.3, ['z'] = 32.42 }, 
	[25] = {['x'] = -1750.25, ['y'] = -697.0, ['z'] = 10.18 }, 
	[26] = {['x'] = 736.61,	['y'] = 132.46,	['z'] = 80.72},
	[27] = {['x'] = 814.87,	['y'] = -1636.05,['z'] = 30.99},
	[28] = {['x'] = -1383.27,['y'] = 266.98,['z'] = 61.24},
	[29] = {['x'] = -746.92,['y'] = 808.73,['z'] = 214.82},
	[30] = {['x'] = -430.16,['y'] = 1204.82,['z'] = 325.76}
}



------------------------------------------------------------------------------------------------------------
-- CÓDIGO
------------------------------------------------------------------------------------------------------------
local etapa = 0
local trabalhando = false
local pizzasNaMoto = 0
local entrega = false
local blip = false
local pizzaNaMao = false
local sorteado = math.random(1, #Entregas)

CreateThread(function()
    while true do
        local timeDistance = 500
		local ped = PlayerPedId()
        if etapa == 0 and not trabalhando then 
            local dist = #(GetEntityCoords(ped) - vec3(ComecarTrabalho[1], ComecarTrabalho[2], ComecarTrabalho[3]))
			if dist < 15 then
				timeDistance = 4
                DrawMarker(21,ComecarTrabalho[1], ComecarTrabalho[2], ComecarTrabalho[3],0,0,0,0,0,0,0.5,0.5,0.5,80, 80, 155,150,1,0,0,1)	
				if dist <= 0.6 then
				--	timeDistance = 4
					DrawText3D(ComecarTrabalho[1], ComecarTrabalho[2], ComecarTrabalho[3], "PRESSIONE ~b~[E] ~w~PARA COMEÇAR A TRABALHAR", 255,255,255)
					-- drawTxt("PRESSIONE ~b~[E] ~w~PARA COMEÇAR A TRABALHAR", 4,0.5,0.97,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then -- [E]
						vRP.CarregarObjeto("amb@medic@standing@timeofdeath@base","base","prop_notepad_01",49,60309)
						FreezeEntityPosition(ped, true)
						Wait(6000)
						FreezeEntityPosition(ped, false)
						ClearPedTasksImmediately(ped)
						vRP._DeletarObjeto()
						trabalhando = true
						TriggerEvent('Notify', "sucesso", 'Você entrou em serviço: <b>Uber Eats</b>')
						etapa = 1
					end
                end
            end
		end
		
		if etapa == 1 then
			local dist = #(GetEntityCoords(ped) - vec3(Recepcao[1], Recepcao[2], Recepcao[3]))
			timeDistance = 4
			DrawMarker(21,Recepcao[1], Recepcao[2], Recepcao[3],0,0,0,0,0,0,0.5,0.5,0.5,80, 80, 155,150,1,0,0,1)	
			drawTxt("VÁ ATÉ A RECEPÇÃO E SOLICITE SUA ~b~MOTO DE SERVIÇO", 4,0.5,0.97,0.50,255,255,255,180)
			if dist <= 0.6 then
			--	timeDistance = 1
				-- drawTxt("PRESSIONE ~b~[E] ~w~PARA COMEÇAR A TRABALHAR", 4,0.5,0.97,0.50,255,255,255,180)
				DrawText3D(Recepcao[1], Recepcao[2], Recepcao[3], "PRESSIONE ~b~[E] ~w~PARA SOLICITAR SUA MOTO", 255,255,255)
				if IsControlJustPressed(0,38) then -- [E]
					if not IsAnyVehicleNearPoint(MotoSpawn[1], MotoSpawn[2], MotoSpawn[3]-1, 20) then
						etapa = 2
						SpawnMoto()
					else
						TriggerEvent('Notify', "negado", 'Livre a área antes de solicitar sua moto de serviço.')
					end
				end
			end
		end
		if etapa == 2 then
			local posMotinha = GetEntityCoords(motinha)
			timeDistance = 4
			DrawMarker(0,posMotinha[1], posMotinha[2], posMotinha[3]+1.6,0,0,0,0,0,0,0.5,0.5,0.5,80, 80, 155,200,1,0,0,1)
			drawTxt("VÁ ATÉ O FUNDO E BUSQUE SUA ~b~MOTO", 4,0.5,0.97,0.50,255,255,255,180)
			if GetVehiclePedIsIn(ped, false) == motinha and GetPedInVehicleSeat(motinha,-1) == ped then
				etapa = 3
			end
		end
		if etapa == 3 then
			local dist = #(GetEntityCoords(ped) - vec3(Bar[1], Bar[2], Bar[3]))
			timeDistance = 4
			DrawMarker(21,Bar[1], Bar[2], Bar[3],0,0,0,0,0,0,0.5,0.5,0.5,80, 80, 155,150,1,0,0,1)	
			drawTxt("VÁ ATÉ O BAR E PEGUE O ~b~PEDIDO", 4,0.5,0.97,0.50,255,255,255,180)
			if dist <= 0.5 then
				-- drawTxt("PRESSIONE ~b~[E] ~w~PARA PEGAR O PEDIDO", 4,0.5,0.97,0.50,255,255,255,180)
				DrawText3D(Bar[1], Bar[2], Bar[3], "PRESSIONE ~b~[E] ~w~PARA PEGAR O PEDIDO", 255,255,255)
				if IsControlJustPressed(0, 38) then
					FreezeEntityPosition(ped, true)
					SetEntityCoords(ped, Bar[1], Bar[2], Bar[3]-1)
					SetEntityHeading(ped, 76.00)
					Wait(200)
					vRP._playAnim(false,{{"pickup_object","pickup_low"}},false)
					Wait(2000)
					vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",50,28422, 0.0, -0.15, -0.15, 0.0, 0.0, 0.0)
					loaddict("anim@heists@box_carry@")
					TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@","idle",3.0,3.0,-1,50,0,0,0,0)
					FreezeEntityPosition(ped, false)
					etapa = 4
				end
			end
		end
		if etapa == 4 then
			local dist = #(GetEntityCoords(ped) - GetEntityCoords(motinha))
			local xm, ym, zm = table.unpack(GetEntityCoords(motinha))
			if pizzasNaMoto + 1 <= 3 then
				timeDistance = 4
				drawTxt("CARREGUE A ~b~MOTO ~w~COM O PEDIDO", 4,0.5,0.97,0.50,255,255,255,180)
				if dist <= 1 then
					-- drawTxt("PRESSIONE ~b~[E] ~w~PARA COLOCAR A PIZZA NA MOTO", 4,0.5,0.97,0.50,255,255,255,180)
					DrawText3D(xm, ym, zm, "PRESSIONE ~b~[E] ~w~PARA CARREGAR A MOTO", 255,255,255)
					if IsControlJustPressed(0, 38) then
						if pizzasNaMoto == 0 then
							pizzinha1 = CreateObject(GetHashKey("prop_pizza_box_02"),0,0,0,true,true,true)
							AttachEntityToEntity(pizzinha1,motinha,GetEntityBoneIndexByName(motinha,"platelight"),0.0,0.25,0.2,0.0,0.0,0.0,false,false,false,true,2,true)
							-- print('Colocada 1')
							etapa = 3
						elseif pizzasNaMoto == 1 then
							pizzinha2 = CreateObject(GetHashKey("prop_pizza_box_02"),0,0,0,true,true,true)
							AttachEntityToEntity(pizzinha2,motinha,GetEntityBoneIndexByName(motinha,"platelight"),0.0,0.25,0.26,0.0,0.0,0.0,false,false,false,true,2,true)
							-- print('Colocada 2')
							etapa = 3
						elseif pizzasNaMoto == 2 then
							pizzinha3 = CreateObject(GetHashKey("prop_pizza_box_02"),0,0,0,true,true,true)
							AttachEntityToEntity(pizzinha3,motinha,GetEntityBoneIndexByName(motinha,"platelight"),0.0,0.25,0.32,0.0,0.0,0.0,false,false,false,true,2,true)
							-- print('Colocada 3')
						end
						pizzasNaMoto = pizzasNaMoto + 1
						ClearPedTasksImmediately(ped)
						vRP._DeletarObjeto()
					end
				end
			else
				etapa = 5
				TriggerEvent('Notify', "importante", 'Você pegou pedidos suficentes, vá entregá-los.')
			end 
		end
		if etapa == 5 then
			local xm, ym, zm = table.unpack(GetEntityCoords(motinha))
			if pizzasNaMoto > 0 then
				-- entrega = true
				local distMoto = #(GetEntityCoords(ped) - GetEntityCoords(motinha))
				local distPonto = #(GetEntityCoords(ped) - vec3(Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z))
				-- print('ELE PASSOU AQ: ', Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z)
				if not blip then
					CriandoBlipPizza(Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z)
					blip = true
					-- print('BLIP CRIADO CARALHO')
				end

				if distPonto < 15 then
					timeDistance = 4
					DrawMarker(21,Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z,0,0,0,0,0,0,0.5,0.5,0.5, 80, 80, 155, 255, 1,0,0,1)
					if distPonto < 1.5 and pizzaNaMao then
						-- drawTxt("~w~PRESSIONE ~b~[E] ~w~PARA ENTREGAR O PEDIDO", 4,0.5,0.97,0.50,255,255,50,180)
						DrawText3D(Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z, "PRESSIONE ~b~[E] ~w~PARA ENTREGAR O PEDIDO", 255,255,255)
						if IsControlJustPressed(0, 38) then
							ClearPedTasksImmediately(ped)
							vRP._DeletarObjeto()
							vRP._playAnim(false,{{"pickup_object","pickup_low"}},false)
							modelRequest('prop_pizza_box_02')
							pizzaNoChao = CreateObject(GetHashKey("prop_pizza_box_02"),Entregas[sorteado].x, Entregas[sorteado].y, Entregas[sorteado].z-1,true,true,true)
							pizzA.x6NiGfpALlLSxRi()
							Wait(8000)
							DeleteObject(pizzaNoChao)
							sorteado = math.random(1, #Entregas)
							pizzaNaMao = false
							pizzasNaMoto = pizzasNaMoto - 1
							if blip then
								RemoveBlip(blips)
								blip = false
							end
							
						end
					end
				end

				if distMoto <= 1.5 and not pizzaNaMao and not IsPedInVehicle(ped, motinha, false) then
					timeDistance = 4
					-- drawTxt("PRESSIONE ~b~[E] ~w~PARA PEGAR A PIZZA", 4,0.5,0.97,0.50,255,255,255,180)
					DrawText3D(xm, ym, zm, "PRESSIONE ~b~[E] ~w~PARA PEGAR A PIZZA", 255,255,255)
					if IsControlJustPressed(0, 38) then
						if pizzasNaMoto == 3 then
							DeleteObject(pizzinha3)
						elseif pizzasNaMoto == 2 then
							DeleteObject(pizzinha2)
						elseif pizzasNaMoto == 1 then
							DeleteObject(pizzinha1)
						end
						vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",50,28422, 0.0, -0.15, -0.15, 0.0, 0.0, 0.0)
						loaddict("anim@heists@box_carry@")
						TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@","idle",3.0,3.0,-1,50,0,0,0,0)
						pizzaNaMao = true
					end
				end
			else
				-- VOLTA PRA PEGAR MAIS PIZZA
				etapa = 3
				TriggerEvent('Notify', "aviso", 'Você acabou as entregas, volte até o restaurante para pegar mais pedidos.')
				-- print('acabou o serviço')
				-- etapa = 7
			end
		end
		Wait(timeDistance)
    end
end)


if debug then
	RegisterCommand('hd', function(src, args)
		print(GetEntityHeading(PlayerPedId()))
	end)
	RegisterCommand('cmoto', function(src, args)
		SpawnMoto()
	end)
	RegisterCommand('etapa', function(src, args)
		trabalhando = true
		etapa = tonumber(parseInt(args[1]))
	end)
	RegisterCommand('pegarpizza', function(src, args)
		vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",50,28422, 0.0, 0.17, -0.2, 0.0, 0.0, 0.0)
		loaddict("anim@heists@box_carry@")
		TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@","idle",3.0,3.0,-1,50,0,0,0,0)
	end)
	RegisterCommand('dmoto', function(src, args)
		if DoesEntityExist(motinha) then                                
			SetEntityAsMissionEntity(motinha, true, true)
			deleteCar(motinha)
		end
	end)
end

------------------------------------------------------------------------------------------------------------
-- CANCELAR
------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local ped = PlayerPedId()
    while true do
        local timeDistance = 500
		if trabalhando then
			timeDistance = 4
			if IsControlJustPressed(0, 168) then -- [F7]
				trabalhando = false
				etapa = 0
				TriggerEvent('Notify', "aviso", 'Você saiu de serviço: <b>Uber Eats</b>')
				if DoesEntityExist(motinha) then                                
					SetEntityAsMissionEntity(motinha, true, true)
					deleteCar(motinha)
				end
				FreezeEntityPosition(ped, false)
				ClearPedTasksImmediately(ped)
				vRP._DeletarObjeto()
				if DoesEntityExist(pizzinha1) then
					DeleteObject(pizzinha1)
					DeleteObject(pizzinha2)
					DeleteObject(pizzinha3)
				end
				if blip then
					RemoveBlip(blips)
					blip = false
				end
				pizzasNaMoto = 0
			end
		end
		Wait(timeDistance)
    end
end)
------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
------------------------------------------------------------------------------------------------------------
function CriandoBlipPizza(x,y,z)
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,358)
	SetBlipColour(blips,81)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega")
	EndTextCommandSetBlipName(blips)
end

function SpawnMoto()
    local mhash = GetHashKey('pcj')
    modelRequest('pcj')
    motinha = CreateVehicle(mhash,MotoSpawn[1], MotoSpawn[2], MotoSpawn[3]-1,260.21,true,false)
    local placa = pizzA.PegarPlaca()
    SetVehicleOnGroundProperly(motinha)
    SetVehicleNumberPlateText(motinha,placa)
    SetEntityAsMissionEntity(motinha,true,true)
    SetModelAsNoLongerNeeded(mhash)
end