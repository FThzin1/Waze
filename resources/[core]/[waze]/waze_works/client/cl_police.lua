local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

policia = {}
Tunnel.bindInterface("emp_policia", policia)
sPolice = Tunnel.getInterface("emp_policia")

local policebLigado = false

function policia.StatusBoost(status)
    policebLigado = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local dinheirofeito = 0

local coordenadas = {
	{ ['id'] = 1, ['x'] = 634.81, ['y'] = 5.22, ['z'] = 90.24},
	{ ['id'] = 2, ['x'] = 631.99, ['y'] = 7.25, ['z'] = 90.24 },
	{ ['id'] = 3, ['x'] = 633.28, ['y'] = 9.53, ['z'] = 90.24 },
	{ ['id'] = 4, ['x'] = 1852.04, ['y'] = 3690.91, ['z'] = 34.29 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = {['x'] = 403.22, ['y'] = -966.97, ['z'] = 28.74}, -- COMEÇO PRIMEIRA ROTA
	[2] = {['x'] = 408.24, ['y'] = -692.31, ['z'] = 28.57},
	[3] = {['x'] = 96.86, ['y'] = -573.59, ['z'] = 30.8},
	[4] = {['x'] = -91.56, ['y'] = -712.18, ['z'] = 33.99},
	[5] = {['x'] = -213.12, ['y'] = -535.53, ['z'] = 34.06},
	[6] = {['x'] = -319.32, ['y'] = -306.93, ['z'] = 30.17},
	[7] = {['x'] = -467.67, ['y'] = -127.78, ['z'] = 38.07},
	[8] = {['x'] = -555.97, ['y'] = -23.76, ['z'] = 43.06},
	[9] = {['x'] = -538.78, ['y'] = 234.36, ['z'] = 82.08},
	[10] = {['x'] = -500.75, ['y'] = 570.12, ['z'] = 119.2},
	[11] = {['x'] = -240.33, ['y'] = 418.75, ['z'] = 108.34},
	[12] = {['x'] = 53.77, ['y'] = 345.11, ['z'] = 111.95},
	[13] = {['x'] = 235.41, ['y'] = 345.97, ['z'] = 104.82},
	[14] = {['x'] = 547.81, ['y'] = 247.06, ['z'] = 102.37},
	[15] = {['x'] = 767.0, ['y'] = 134.68, ['z'] = 78.64},
	[16] = {['x'] = 788.24, ['y'] = -60.9, ['z'] = 79.84},
	[17] = {['x'] = 1175.27, ['y'] = -273.98, ['z'] = 68.36},
	[18] = {['x'] = 1168.83, ['y'] = -612.93, ['z'] = 62.96},
	[19] = {['x'] = 1150.65, ['y'] = -985.55, ['z'] = 45.19},
	[20] = {['x'] = 1223.39, ['y'] = -1413.0, ['z'] = 34.3}, 
	[21] = {['x'] = 821.23, ['y'] = -1428.53, ['z'] = 26.48}, 
	[22] = {['x'] = 537.4, ['y'] = -1407.81, ['z'] = 28.61}, 
	[23] = {['x'] = 504.23, ['y'] = -1149.0, ['z'] = 28.59}, 
	[24] = {['x'] = 402.54, ['y'] = -1115.36, ['z'] = 28.69}, 
	[25] = {['x'] = 402.79, ['y'] = -1027.46, ['z'] = 28.64}, 	-- FINAL DA PRIMERA ROTA

	[26] = {['x'] = 353.54, ['y'] = -1037.89, ['z'] = 28.59}, -- COMEÇO SEGUNDA ROTA
	[27] = {['x'] = 130.5, ['y'] = -1008.67, ['z'] = 28.72},
	[28] = {['x'] = 58.3, ['y'] = -1112.42, ['z'] = 28.72},
	[29] = {['x'] = 78.18, ['y'] = -1340.74, ['z'] = 28.6},
	[30] = {['x'] = 69.04, ['y'] = -1483.01, ['z'] = 28.65},
	[31] = {['x'] = -121.04, ['y'] = -1713.5, ['z'] = 29.07},
	[32] = {['x'] = -357.19, ['y'] = -1815.41, ['z'] = 22.15},
	[33] = {['x'] = -684.97, ['y'] = -1632.22, ['z'] = 23.38},
	[34] = {['x'] = -662.53, ['y'] = -1246.58, ['z'] = 9.8},
	[35] = {['x'] = -808.76, ['y'] = -1024.44, ['z'] = 12.42},
	[36] = {['x'] = -742.91, ['y'] = -860.63, ['z'] = 21.75},
	[37] = {['x'] = -1063.94, ['y'] = -780.69, ['z'] = 18.66},
	[38] = {['x'] = -1264.79, ['y'] = -896.32, ['z'] = 10.64},
	[39] = {['x'] = -1512.34, ['y'] = -680.63, ['z'] = 27.71},
	[40] = {['x'] = -1395.4, ['y'] = -574.44, ['z'] = 29.6},
	[41] = {['x'] = -1525.89, ['y'] = -371.97, ['z'] = 42.43},
	[42] = {['x'] = -1580.7, ['y'] = -197.98, ['z'] = 54.78},
	[43] = {['x'] = -1829.03, ['y'] = 123.27, ['z'] = 75.96},
	[44] = {['x'] = -1762.74, ['y'] = 789.74, ['z'] = 138.98},
	[45] = {['x'] = -1806.93, ['y'] = 777.63, ['z'] = 136.26},
	[46] = {['x'] = -1821.31, ['y'] = 153.91, ['z'] = 76.44},
	[47] = {['x'] = -1510.4, ['y'] = 232.37, ['z'] = 59.7},
	[48] = {['x'] = -1345.47, ['y'] = 202.32, ['z'] = 57.71},
	[49] = {['x'] = -871.64, ['y'] = 218.96, ['z'] = 72.92},
	[50] = {['x'] = -570.84, ['y'] = 250.57, ['z'] = 82.27},
	[51] = {['x'] = -545.23, ['y'] = 147.21, ['z'] = 62.7},
	[52] = {['x'] = -526.02, ['y'] = -119.15, ['z'] = 38.22},
	[53] = {['x'] = -582.12, ['y'] = -133.88, ['z'] = 34.68}, 	-- FINAL DA SEGUNDA ROTA

	[54] = {['x'] = 403.7, ['y'] = -970.77, ['z'] = 28.67}, -- COMEÇO DA TERCEIRA ROTA
	[55] = {['x'] = 362.14, ['y'] = -842.1, ['z'] = 28.49},
	[56] = {['x'] = 352.92, ['y'] = -686.85, ['z'] = 28.65},
	[57] = {['x'] = 584.19, ['y'] = -353.21, ['z'] = 34.57},
	[58] = {['x'] = 1013.67, ['y'] = 287.87, ['z'] = 82.11},
	[59] = {['x'] = 1426.51, ['y'] = 717.45, ['z'] = 77.42},
	[60] = {['x'] = 1676.04, ['y'] = 1301.06, ['z'] = 85.86},
	[61] = {['x'] = 1921.25, ['y'] = 2427.73, ['z'] = 53.9},
	[62] = {['x'] = 2268.93, ['y'] = 2767.5, ['z'] = 43.02},
	[63] = {['x'] = 2434.3, ['y'] = 2862.43, ['z'] = 48.37},
	[64] = {['x'] = 2270.03, ['y'] = 3008.26, ['z'] = 45.0},
	[65] = {['x'] = 1988.02, ['y'] = 3118.41, ['z'] = 46.38},
	[66] = {['x'] = 1930.25, ['y'] = 2986.24, ['z'] = 44.94},
	[67] = {['x'] = 1597.57, ['y'] = 2819.26, ['z'] = 38.15},
	[68] = {['x'] = 1199.59, ['y'] = 2686.69, ['z'] = 37.07},
	[69] = {['x'] = 600.43, ['y'] = 2700.08, ['z'] = 40.79},
	[70] = {['x'] = 299.46, ['y'] = 2644.15, ['z'] = 43.88},
	[71] = {['x'] = 461.32, ['y'] = 2419.61, ['z'] = 46.18},
	[72] = {['x'] = 912.15, ['y'] = 2206.28, ['z'] = 47.9},
	[73] = {['x'] = 1164.82, ['y'] = 1800.74, ['z'] = 74.0},
	[74] = {['x'] = 1285.35, ['y'] = 1315.49, ['z'] = 106.3},
	[75] = {['x'] = 1117.65, ['y'] = 557.06, ['z'] = 96.45},
	[76] = {['x'] = 838.7, ['y'] = 228.16, ['z'] = 81.94},
	[77] = {['x'] = 699.5, ['y'] = 35.53, ['z'] = 83.45},
	[78] = {['x'] = 506.24, ['y'] = -126.29, ['z'] = 59.43},
	[79] = {['x'] = 379.61, ['y'] = -158.17, ['z'] = 63.04},
	[80] = {['x'] = 313.04, ['y'] = -359.25, ['z'] = 44.52},
	[81] = {['x'] = 180.81, ['y'] = -794.31, ['z'] = 30.72},
	[82] = {['x'] = 263.33, ['y'] = -864.43, ['z'] = 28.5}, 
	[83] = {['x'] = 215.36, ['y'] = -936.57, ['z'] = 23.46}, 
	[84] = {['x'] = 229.42, ['y'] = -1017.73, ['z'] = 28.65}, 
	[85] = {['x'] = 290.29, ['y'] = -1061.88, ['z'] = 28.56}, -- FINAL DA TERCEIRA ROTA

	[86] = {['x'] = 1692.14, ['y'] = 3570.83, ['z'] = 35.28}, -- COMEÇO DA ROTA DO NORTE
	[87] = {['x'] = 1793.32, ['y'] = 3332.75, ['z'] = 41.04},
	[88] = {['x'] = 2204.55, ['y'] = 3015.47, ['z'] = 44.96},
	[89] = {['x'] = 2249.44, ['y'] = 3218.38, ['z'] = 47.88},
	[90] = {['x'] = 2463.34, ['y'] = 3205.8, ['z'] = 48.96},
	[91] = {['x'] = 2701.83, ['y'] = 3437.96, ['z'] = 55.47},
	[92] = {['x'] = 2891.81, ['y'] = 3638.31, ['z'] = 52.28},
	[93] = {['x'] = 2808.05, ['y'] = 4390.72, ['z'] = 48.95},
	[94] = {['x'] = 2520.64, ['y'] = 4155.64, ['z'] = 38.59},
	[95] = {['x'] = 2471.63, ['y'] = 4549.73, ['z'] = 35.14},
	[96] = {['x'] = 2176.27, ['y'] = 4752.21, ['z'] = 40.77},
	[97] = {['x'] = 1867.06, ['y'] = 4584.64, ['z'] = 35.91},
	[98] = {['x'] = 1667.44, ['y'] = 4890.03, ['z'] = 41.71},
	[99] = {['x'] = 2106.01, ['y'] = 5217.29, ['z'] = 56.55},
	[100] = {['x'] = 2498.9, ['y'] = 5094.01, ['z'] = 44.36},
	[101] = {['x'] = 2691.53, ['y'] = 4764.04, ['z'] = 44.11},
	[102] = {['x'] = 2839.96, ['y'] = 4216.95, ['z'] = 49.7},
	[103] = {['x'] = 2794.56, ['y'] = 3445.57, ['z'] = 55.15},
	[104] = {['x'] = 2449.96, ['y'] = 2996.69, ['z'] = 42.6},
	[105] = {['x'] = 2067.55, ['y'] = 2999.44, ['z'] = 44.71},
	[106] = {['x'] = 1549.67, ['y'] = 2784.26, ['z'] = 37.79},
	[107] = {['x'] = 991.36, ['y'] = 2696.09, ['z'] = 39.42},
	[108] = {['x'] = 558.79, ['y'] = 2693.21, ['z'] = 41.8},
	[109] = {['x'] = 232.89, ['y'] = 2629.72, ['z'] = 45.97},
	[110] = {['x'] = -233.17, ['y'] = 2885.19, ['z'] = 46.22},
	[111] = {['x'] = -462.47, ['y'] = 2713.49, ['z'] = 49.64},
	[112] = {['x'] = -344.0, ['y'] = 2727.15, ['z'] = 66.85},
	[113] = {['x'] = -264.68, ['y'] = 2628.64, ['z'] = 61.29},
	[114] = {['x'] = -157.35, ['y'] = 2684.79, ['z'] = 56.55},
	[115] = {['x'] = 53.66, ['y'] = 2744.26, ['z'] = 56.72},
	[116] = {['x'] = 321.98, ['y'] = 2643.98, ['z'] = 44.16},
	[117] = {['x'] = 615.75, ['y'] = 2694.24, ['z'] = 40.83},
	[118] = {['x'] = 1121.42, ['y'] = 2682.67, ['z'] = 38.08},
	[119] = {['x'] = 1505.44, ['y'] = 2748.63, ['z'] = 37.53},
	[120] = {['x'] = 1877.54, ['y'] = 2951.84, ['z'] = 45.35},
	[121] = {['x'] = 1968.82, ['y'] = 3124.1, ['z'] = 46.58},
	[122] = {['x'] = 1750.86, ['y'] = 3418.67, ['z'] = 37.61},
	[123] = {['x'] = 1875.53, ['y'] = 3608.94, ['z'] = 34.09},
	[124] = {['x'] = 1978.12, ['y'] = 3737.24, ['z'] = 32.07}, -- FIM DA ROTA DO NORTE

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('piniciar', function(source, args, rawCmd)
    if not exports["chat"]:statusChat() then return end
	if not servico then
		for _,v in pairs(coordenadas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = #(vec3(v.x,v.y,v.z) - GetEntityCoords(ped))
			if distance <= 1.5 then
				servico = true
				if v.id == 2 then
					selecionado = 26 -- primeiro ponto 2a rota
				elseif v.id == 3 then
					selecionado = 54 -- primeiro ponto 3a rota
				elseif v.id == 4 then
					selecionado = 86 -- primeiro ponto rota do norte
				else
					selecionado = 1 -- primeiro ponto 1a rota
				end
				CriandoBlipCops(locs,selecionado)
				TriggerEvent("Notify","sucesso","Você entrou em serviço.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		if servico then
			timeDistance = 4
				local ped = PlayerPedId()
				local distance = #(vec3(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z) - GetEntityCoords(ped))

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,50,1,0,0,1)
				if distance <= 4.5 then
					if sPolice.checkPermission() then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("vra3")) or
							IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("vra4")) or
							IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("vrq8")) or
							IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("vrrs6")) or
							IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("vrrs5")) or
							IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("vrraptor")) or

							IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("vrtahoe")) or
							IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("vrdm1200")) then
							RemoveBlip(blips)
							if selecionado == 25 then -- ponto final
								selecionado = 1 -- ponto inicial
							elseif selecionado == 53 then
								selecionado = 26
							elseif selecionado == 85 then
								selecionado = 54
							elseif selecionado == 124 then
								selecionado = 86
							else
								selecionado = selecionado + 1
							end				
							local pagamento = math.random(300,500)
							if IsPedInAnyVehicle(ped) then
								local vehicle = GetVehiclePedIsIn(ped)
								local speed = GetEntitySpeed(vehicle)*3.6
								if speed <= 100	then
									if not policebLigado then
									sPolice.IcyuiAAvgbU5sDX(pagamento)
									dinheirofeito = dinheirofeito + pagamento
									end
									if policebLigado then
									sPolice.IcyuiAAvgbU5sDXboost(pagamento)
									dinheirofeito = dinheirofeito + pagamento
									end
								end
							else
								if not policebLigado then
								sPolice.IcyuiAAvgbU5sDX(pagamento)
								dinheirofeito = dinheirofeito + pagamento
								end
								if policebLigado then
								sPolice.IcyuiAAvgbU5sDXboost(pagamento)
								dinheirofeito = dinheirofeito + pagamento
								end
							end
							CriandoBlipCops(locs,selecionado)
						end
					end
				end
			end
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fservico', function(source, args, rawCmd)
    if not exports["chat"]:statusChat() then return end
	if servico then
		servico = false
		RemoveBlip(blips)
		TriggerEvent("Notify","aviso","Você saiu de serviço. O total ganho durante essa rota de patrulha foi de <b>$"..dinheirofeito.."</b>")
		dinheirofeito = 0
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlipCops(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,433)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de patrulha")
	EndTextCommandSetBlipName(blips)
end

AddEventHandler('playerSpawned', function()
    Wait(3000)
    policebLigado = sPolice.GetStatusBoost()
    print('O boost da rota policial está: ' .. tostring(policebLigado))
end)