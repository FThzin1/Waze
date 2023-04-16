-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
driveR = {}
Tunnel.bindInterface("vrp_driver",driveR)
--driverServer = Tunnel.getInterface("vrp_driver")
vSERVER = Tunnel.getInterface("vrp_driver")
vGARAGE = Tunnel.getInterface("vrp_garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blip = nil
local inService = false
local driverPosition = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local coords = {
	[1] = { 309.95,-760.52,30.09 },
	[2] = { 69.59,-974.80,30.14 },
	[3] = { 95.00,-634.89,45.02 },
	[4] = { 58.27,-283.32,48.20 },
	[5] = { 47.74,-160.44,56.03 },
	[6] = { 323.93,-267.58,54.71 },
	[7] = { 443.75,119.16,100.41 },
	[8] = { 125.62,-4.42,68.48 },
	[9] = { -524.08,133.59,63.91 },
	[10] = { -586.64,268.39,83.24 },
	[11] = { -640.38,-163.16,38.49 },
	[12] = { -597.89,-361.27,35.77 },
	[13] = { -646.06,-804.09,25.78 },
	[14] = { -932.63,-1199.67,5.91 },
	[15] = { -1234.65,-1080.87,9.12 },
	[16] = { -1373.99,-793.23,20.09 },
	[17] = { -2011.25,-160.04,29.40 },
	[18] = { -2981.70,404.50,15.75 },
	[19] = { -3101.58,1112.65,21.28 },
	[20] = { -2556.10,2322.01,33.89 },
	[21] = { -1094.86,2675.87,20.08 },
	[22] = { -72.63,2813.83,54.60 },
	[23] = { 540.55,2685.25,43.20 },
	[24] = { 1119.93,2682.04,39.31 },
	[25] = { 1470.51,2725.47,38.48 },
	[26] = { 2002.62,2603.65,55.07 },
	[27] = { 379.58,-599.20,29.58 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 1000

		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local distance = #(coords - vec3(453.09,-607.79,28.6))

		if distance <= 3.0 then
			timeDistance = 4
			if not inService then
				drawTxt("PRESSIONE ~g~E~w~ PARA INICIAR EXPEDIENTE",4,0.5,0.97,0.50,255,255,255,180)
			end

			if distance <= 1.1 then
				if IsControlJustPressed(1,38) then
					if not inService then
						wazedriveservice()
						inService = true
						makeBlipsPosition()
						TriggerEvent("Notify","sucesso","Você iniciou o emprego de <b>Motorista</b>.",5000)
					end
				end
			end
		end
		
		if inService then
			timeDistance = 4
			drawTxt("PRESSIONE ~g~F7~w~ PARA FINALIZAR",4,0.5,0.97,0.50,255,255,255,90)
			local veh = vRP.getNearestVehicle(7)
			if IsControlJustPressed(0,168) then
				inService = false
				TriggerEvent("Notify","aviso","Você terminou o emprego de <b>Motorista</b> e seu veiculo de trabalho foi deletado.",5000)
				if DoesBlipExist(blip) then
					RemoveBlip(blip)
					blip = nil
				end

				vGARAGE.deleteVehicles2(veh)
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function wazedriveservice()
	CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped) then
					local veh = GetVehiclePedIsUsing(ped)
					local coordsPed = GetEntityCoords(ped)
					local distance = #(coordsPed - vector3(coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3]))
					if distance <= 300 and IsVehicleModel(veh,GetHashKey("bus")) then
						timeDistance = 4
						DrawMarker(21,coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3]+0.60,0,0,0,0,180.0,130.0,2.0,2.0,1.0,121,206,121,100,1,0,0,1)
						if distance <= 15 then
							if IsControlJustPressed(1,38) then
								if driverPosition == #coords then
									driverPosition = 1
									vSERVER.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(true,500)
								else
									driverPosition = driverPosition + 1
									vSERVER.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(false,0)
								end
								makeBlipsPosition()
							end
						end
					end
				end
			end
			Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPSPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipsPosition()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end

	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3])
		SetBlipSprite(blip,433)
		SetBlipColour(blip,81)
		SetBlipScale(blip,0.4)
		SetBlipAsShortRange(blip,false)
		SetBlipRoute(blip,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Rota de Motorista")
		EndTextCommandSetBlipName(blip)
	end
end