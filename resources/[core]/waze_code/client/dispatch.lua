local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR A CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()

		if IsPedArmed(ped,6) then
			timeDistance = 4
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
		end
		Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for _, i in ipairs(GetActivePlayers()) do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Q COVER LOJA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetPlayerCanUseCover(PlayerId(),false)
	ReplaceHudColourWithRgba(255,0,0,250,255)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 4
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			local speed = GetEntitySpeed(vehicle)*3.6
			if GetEntityModel(vehicle) ~= GetHashKey('buzzard2') and GetEntityModel(vehicle) ~= GetHashKey('wrpolmav') and GetEntityModel(vehicle) ~= GetHashKey('helinorte') then
				timeDistance = 4
				SetPedConfigFlag(PlayerPedId(),35,false) 
				if speed >= 40 or GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_STUNGUN") then
					timeDistance = 4
					DisableControlAction(0,69,true)
					DisableControlAction(0,92,true)
				end
			end
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsPedInAnyVehicle(ped) then
			local speed = GetEntitySpeed(vehicle)*3.6
			timeDistance = 4
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				if speed <= 120.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end    
			end
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------

local blips = {

	{ 265.05,-1262.65,29.3,361,41,"Posto de Gasolina",0.4 },
	{ 819.02,-1027.96,26.41,361,41,"Posto de Gasolina",0.4 },
	{ 1208.61,-1402.43,35.23,361,41,"Posto de Gasolina",0.4 },
	{ 1181.48,-330.26,69.32,361,41,"Posto de Gasolina",0.4 },
	{ 621.01,268.68,103.09,361,41,"Posto de Gasolina",0.4 },
	{ 2581.09,361.79,108.47,361,41,"Posto de Gasolina",0.4 },
	{ 175.08,-1562.12,29.27,361,41,"Posto de Gasolina",0.4 },
	{ -319.76,-1471.63,30.55,361,41,"Posto de Gasolina",0.4 },
	{ 1782.33,3328.46,41.26,361,41,"Posto de Gasolina",0.4 },
	{ 49.42,2778.8,58.05,361,41,"Posto de Gasolina",0.4 },
	{ 264.09,2606.56,44.99,361,41,"Posto de Gasolina",0.4 },
	{ 1039.38,2671.28,39.56,361,41,"Posto de Gasolina",0.4 },
	{ 1207.4,2659.93,37.9,361,41,"Posto de Gasolina",0.4 },
	{ 2539.19,2594.47,37.95,361,41,"Posto de Gasolina",0.4 },
	{ 2679.95,3264.18,55.25,361,41,"Posto de Gasolina",0.4 },
	{ 2005.03,3774.43,32.41,361,41,"Posto de Gasolina",0.4 },
	{ 1687.07,4929.53,42.08,361,41,"Posto de Gasolina",0.4 },
	{ 1701.53,6415.99,32.77,361,41,"Posto de Gasolina",0.4 },
	{ 180.1,6602.88,31.87,361,41,"Posto de Gasolina",0.4 },
	{ -94.46,6419.59,31.48,361,41,"Posto de Gasolina",0.4 },
	{ -2555.17,2334.23,33.08,361,41,"Posto de Gasolina",0.4 },
	{ -1800.09,803.54,138.72,361,41,"Posto de Gasolina",0.4 },
	{ -1437.0,-276.8,46.21,361,41,"Posto de Gasolina",0.4 },
	{ -2096.3,-320.17,13.17,361,41,"Posto de Gasolina",0.4 },
	{ -724.56,-935.97,19.22,361,41,"Posto de Gasolina",0.4 },
	{ -525.26,-1211.19,18.19,361,41,"Posto de Gasolina",0.4 },
	{ -70.96,-1762.21,29.54,361,41,"Posto de Gasolina",0.4 },

	{ -209.0,-1322.56,30.9,402,17,"Bennys",0.6 },

	{ 317.25,2623.14,44.46,50,4,"Garagem",0.4 },
	{ -773.34,5598.15,33.60,50,4,"Garagem",0.4 },
	{ 596.40,90.65,93.12,50,4,"Garagem",0.4 },
	{ -340.76,265.97,85.67,50,4,"Garagem",0.4 },
	{ -2030.01,-465.97,11.60,50,4,"Garagem",0.4 },
	{ -1184.92,-1510.00,4.64,50,4,"Garagem",0.4 },
	{ -73.44,-2004.99,18.27,50,4,"Garagem",0.4 },
	{ -348.88,-874.02,31.31,50,4,"Garagem",0.4 },
	{ 67.74,12.27,69.21,50,4,"Garagem",0.4 },
	{ 361.90,297.81,103.88,50,4,"Garagem",0.4 },
	{ 1156.90,-453.73,66.98,50,4,"Garagem",0.4 },
	{ -102.21,6345.18,31.57,50,4,"Garagem",0.4 },
	{ 1300.95,4319.0,38.18,50,4,"Garagem",0.4 },

	{ 4519.84,-4515.06,4.5,50,4,"Garagem",0.4 },
	{ 5099.9,-5721.52,15.78,50,4,"Garagem",0.4 },

	{ 605.4,-1.07,82.75,526,17,"Departamento de Polícia",0.4 },
	{ -440.37,6020.18,31.5,526,17,"Departamento de Polícia",0.4 },
	{ 1858.82,3678.83,33.71,526,17,"Departamento de Polícia",0.4 },
	{ 25.65,-1346.58,29.49,52,4,"Mercado",0.4 },
	{ 2556.75,382.01,108.62,52,4,"Mercado",0.4 },
	{ 1163.54,-323.04,69.20,52,4,"Mercado",0.4 },
	{ -707.37,-913.68,19.21,52,4,"Mercado",0.4 },
	{ -47.73,-1757.25,29.42,52,4,"Mercado",0.4 },
	{ 373.90,326.91,103.56,52,4,"Mercado",0.4 },
	{ -3243.10,1001.23,12.83,52,4,"Mercado",0.4 },
	{ 1729.38,6415.54,35.03,52,4,"Mercado",0.4 },
	{ 547.90,2670.36,42.15,52,4,"Mercado",0.4 },
	{ 1960.75,3741.33,32.34,52,4,"Mercado",0.4 },
	{ 2677.90,3280.88,55.24,52,4,"Mercado",0.4 },
	{ 1698.45,4924.15,42.06,52,4,"Mercado",0.4 },
	{ -1820.93,793.18,138.11,52,4,"Mercado",0.4 },
	{ 1392.46,3604.95,34.98,52,4,"Mercado",0.4 },
	{ -3040.10,585.44,7.90,52,4,"Mercado",0.4 },

	{ 4972.73,-5598.54,23.71,52,4,"Mercado",0.4 },
	{ 4958.71,-4471.97,10.66,52,4,"Mercado",0.4 },

	{ -1222.78,-907.22,12.32,93,27,"Loja de Bebidas",0.4 },
	{ -2967.82,390.93,15.04,93,27,"Loja de Bebidas",0.4 },
	{ 1165.91,2709.41,38.15,93,27,"Loja de Bebidas",0.4 },
	{ 1135.56,-982.20,46.41,93,27,"Loja de Bebidas",0.4 },
	{ -1487.18,-379.02,40.16,93,27,"Loja de Bebidas",0.4 },
	{ -560.17,286.79,82.17,93,4,"Bar",0.4 },
	{ 128.11,-1284.99,29.27,93,4,"Bar",0.4 },
	{ 1985.80,3053.68,47.21,93,4,"Bar",0.4 },
	{ -80.89,214.78,96.55,93,4,"Bar",0.4 },
	{ 224.60,-1511.02,29.29,93,4,"Bar",0.4 },
	{ -1387.82,-587.80,30.31,121,48,"Bahamas",0.4 },
	{ 296.16,-583.79,43.15,51,49,"Hospital Saint Kashi",0.4 },
	{ 1830.12,3662.13,33.84,51,49,"Hospital Saint Kashi",0.4 },
	{ 75.40,-1392.92,29.37,73,4,"Loja de Roupas",0.4 },
	{ -709.40,-153.66,37.41,73,4,"Loja de Roupas",0.4 },
	{ -163.20,-302.03,39.73,73,4,"Loja de Roupas",0.4 },
	{ 425.58,-806.23,29.49,73,4,"Loja de Roupas",0.4 },
	{ -822.34,-1073.49,11.32,73,4,"Loja de Roupas",0.4 },
	{ -1193.81,-768.49,17.31,73,4,"Loja de Roupas",0.4 },
	{ -1450.85,-238.15,49.81,73,4,"Loja de Roupas",0.4 },
	{ 4.90,6512.47,31.87,73,4,"Loja de Roupas",0.4 },
	{ 1693.95,4822.67,42.06,73,4,"Loja de Roupas",0.4 },
	{ 126.05,-223.10,54.55,73,4,"Loja de Roupas",0.4 },
	{ 614.26,2761.91,42.08,73,4,"Loja de Roupas",0.4 },
	{ 1196.74,2710.21,38.22,73,4,"Loja de Roupas",0.4 },
	{ -3170.18,1044.54,20.86,73,4,"Loja de Roupas",0.4 },
	{ -1101.46,2710.57,19.10,73,4,"Loja de Roupas",0.4 },
	{ 1692.62,3759.50,34.70,76,4,"Ammunation",0.4 },
	{ 252.89,-49.25,69.94,76,4,"Ammunation",0.4 },
	{ 843.28,-1034.02,28.19,76,4,"Ammunation",0.4 },
	{ -331.35,6083.45,31.45,76,4,"Ammunation",0.4 },
	{ -663.15,-934.92,21.82,76,4,"Ammunation",0.4 },
	{ -1305.18,-393.48,36.69,76,4,"Ammunation",0.4 },
	{ -1118.80,2698.22,18.55,76,4,"Ammunation",0.4 },
	{ 2568.83,293.89,108.73,76,4,"Ammunation",0.4 },
	{ -3172.68,1087.10,20.83,76,4,"Ammunation",0.4 },
	{ 21.32,-1106.44,29.79,76,4,"Ammunation",0.4 },
	{ 811.19,-2157.67,29.61,76,4,"Ammunation",0.4 },
	{ -815.59,-182.16,37.56,71,4,"Barbeiro",0.4 },
	{ 139.21,-1708.96,29.30,71,4,"Barbeiro",0.4 },
	{ -1282.00,-1118.86,7.00,71,4,"Barbeiro",0.4 },
	{ 1934.11,3730.73,32.85,71,4,"Barbeiro",0.4 },
	{ 1211.07,-475.00,66.21,71,4,"Barbeiro",0.4 },
	{ -34.97,-150.90,57.08,71,4,"Barbeiro",0.4 },
	{ -280.37,6227.01,31.70,71,4,"Barbeiro",0.4 },
	{ -1213.44,-331.02,37.78,207,82,"Banco",0.4 },
	{ -351.59,-49.68,49.04,207,82,"Banco",0.4 },
	{ 235.12,216.84,106.28,207,82,"Banco",0.4 },
	{ 313.47,-278.81,54.17,207,82,"Banco",0.4 },
	{ 149.35,-1040.53,29.37,207,82,"Banco",0.4 },
	{ -2962.60,482.17,15.70,207,82,"Banco",0.4 },
	{ -112.81,6469.91,31.62,207,82,"Banco",0.4 },
	{ 1175.74,2706.80,38.09,207,82,"Banco",0.4 },
	{ 1322.64,-1651.97,52.27,75,48,"Estúdio de Tatuagem",0.4 },
	{ -1153.67,-1425.68,4.95,75,48,"Estúdio de Tatuagem",0.4 },
	{ 322.13,180.46,103.58,75,48,"Estúdio de Tatuagem",0.4 },
	{ -3170.07,1075.05,20.82,75,48,"Estúdio de Tatuagem",0.4 },
	{ 1864.63,3747.73,33.03,75,48,"Estúdio de Tatuagem",0.4 },
	{ -293.71,6200.04,31.48,75,48,"Estúdio de Tatuagem",0.4 },
	{ -1612.35,-1180.02,0.31,266,4,"Cais",0.4 },
	{ -1522.91,1501.84,110.65,266,4,"Cais",0.4 },
	{ 1336.21,4278.94,31.05,266,4,"Cais",0.4 },
	{ -183.69,795.89,197.35,266,4,"Cais",0.4 },

	{ 5095.68,-4655.92,1.74,266,4,"Cais",0.4 },
	{ 5153.45,-4656.01,1.44,266,4,"Cais",0.4 },

	{ -48.5,-1112.74,26.44,225,4,"Concessionária",0.4 },
	{ 946.68,-990.2,39.24,402,66,"Mecânica",0.5 },
	{ 118.94,6616.97,31.84,402,66,"Mecânica",0.5 },
	{ 1178.76,2651.47,37.81,402,66,"Mecânica",0.5 },
	{ -560.47, 280.83, 82.19, 522,66,"Emprego | Pizzaboy",0.5 },
	{ 453.55,-607.58,28.58, 513,66,"Emprego | Motorista de Ônibus",0.5 },
--	{ -470.13,-1717.9,18.69, 318,66,"Emprego | Lixeiro",0.5 },
--	{ 228.71, 121.01, 102.6, 532,66,"Emprego | Carro Forte",0.5 },
--	{ -534.27,-2200.84,6.31,540,66,"Emprego | Faxineiro",0.5 },

--	{ 950.06,-2108.55,30.56, 273,66,"Açougue",0.5 },
--	{ -1117.16,-503.12,35.81, 135,66,"Teatro",0.5 },
--	{ 2469.38,-420.0,93.4, 181,66,"Prefeitura",0.5 },
--	{ 59.96,3714.18,39.76, 522,66,"Moto club",0.5 },
--	{ 1700.92,3293.88,48.93, 307,66,"Trevor",0.5 },
--	{ -2349.66,3267.96,32.82, 584,66,"Fort Zancudo",0.5 },
--	{ 247.69,-3315.71,5.8, 267,66,"Porto",0.5 },
--	{ 1459.64,1133.87,114.33, 540,66,"Fazenda",0.5 },
--	{ -2964.61,61.11,11.61, 126,66,"Resort",0.5 },
--	{ 717.48,565.28,129.23, 431,66,"Observatório",0.5 },

--	{ 976.54,-117.65,78.17,431,66,"Roubos",0.5 },
--	{ 589.74,-468.42,24.75,431,66,"Roubos",0.5 },
--	{ -561.58,5283.4,73.06,431,66,"Roubos",0.5 },
--	{ 2717.82,1543.08,29.2,431,66,"Roubos",0.5 },
--	{ 2404.39,3127.97,48.16,431,66,"Roubos",0.5 },
--	{ -2195.32,4288.28,49.18,431,66,"Roubos",0.5 },
--	{ 1395.33,3614.05,34.99,431,66,"Roubos",0.5 },
--	{ -1667.2,189.9,61.76,431,66,"Roubos",0.5 },
--	{ -1886.92,2050.45,140.99,431,66,"Roubos",0.5 },
--	{ -1644.89,-1076.58,12.98,431,66,"Roubos",0.5 },
--	{ 1308.84,4362.02,41.55,431,66,"Roubos",0.5 },

	--{ 128.11,-1284.99,29.27,93,8,"Vanilla",0.5 },
	--{ -2357.13,3251.32,101.46,16,0,"Zancudo",0.5 }, 
	--{ 1985.26,3046.01,48.94,93,0,"Yellow Jack",0.5 },
	--{ 246.95,-3314.37,5.54,431,0,"Roubos",0.5 },
	--{ 2492.64,-384.57,95.61,431,0,"Roubos",0.5 },
	--{ 1727.72,3269.65,41.16,431,0,"Roubos",0.5 },
	--{ 2445.23,4979.15,56.75,431,0,"Roubos",0.5 },
	--{ 979.73,-2184.08,38.99,431,0,"Roubos",0.5 },
	--{ 679.84,580.39,131.4,431,0,"Roubos",0.5 },
	--{ -544.32,5318.15,89.96,431,0,"Roubos",0.5 },
	--{ 1366.87,4349.36,43.86,431,0,"Roubos",0.5 },
	--{ 972.63,-120.09,74.32,431,0,"Roubos",0.5 },
	--{ 2388.02,3081.12,48.18,431,0,"Roubos",0.5 },
	--{ 1562.31,3567.57,34.14,431,0,"Roubos",0.5 },
	--{ -2197.53,4282.64,52.82,431,0,"Roubos",0.5 },
	--{ -1643.58,-1079.31,13.17,431,0,"Roubos",0.5 },
	--{ 55.88,3724.0,39.73,431,0,"Roubos",0.5 },
	--{-1171.15,-498.63,36.28,431,0,"Roubos",0.5 },
	--{ -3010.35,110.19,13.44,431,0,"Roubos",0.5 },
	--{ 1464.26,1129.62,114.22,431,0,"Roubos",0.5 },
	--{ -1679.71,195.99,65.19,431,0,"Roubos",0.5 },
	--{ 2734.05,1517.51,37.4,431,0,"Roubos",0.5 },
	--{ 1389.75,3649.43,56.03,431,0,"Roubos",0.5 },
	--{ -1885.45,2048.76,140.98,431,0,"Roubos",0.5 },
	--{ 589.49,-468.65,24.75,431,0,"Roubos",0.5 },

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip,v[4])
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v[5])
		SetBlipScale(blip,v[7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v[6])
		EndTextCommandSetBlipName(blip)
	end
end)

local Robberys = {
	{ 1197.05,-3253.15,7.1,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Departamento de Cargas",0.5 },
	{ -424.11,-2789.91,6.54,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Mini Porto",0.5 },
	{ 185.39,1214.0,225.6,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Auditório",0.5 },
	{ 1019.17,-2511.71,28.49,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Cypress",0.5 },
	{ -1537.11,130.73,57.38,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Mansão Playboy",0.5 },
	{ -99.98,-2232.12,7.8,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Caixa d'Água",0.5 },
	{ 589.07,-468.36,24.75,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Galpão",0.5 },
	{ -450.93,6011.42,31.72,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Delegacia Paleto Bay",0.5 },
	{ 1850.07,3686.02,34.27,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Delegacia Sandy Shores",0.5 },
	{ 1459.31,1133.82,114.33,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Fazenda",0.5 },
	{ 2403.64,3127.98,48.16,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Aeroporto Abandonado",0.5 },
	{ 802.84,2174.88,53.08,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Mini Fazenda",0.5 },
	{ 849.26,2383.68,54.16,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Motocross",0.5 },
	{ 2424.68,4961.18,46.21,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Fazenda Norte",0.5 },
	{ 670.95,580.21,130.46,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Observatório",0.5 },
	{ 66.49,3726.72,39.72,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Motoclub Norte",0.5 },
	{ -1116.61,-502.28,35.8,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Teatro",0.5 },
	{ 247.57,-3315.71,5.8,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Porto",0.5 },
	{ -2194.94,4289.03,49.18,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Bar Hookies",0.5 },
	{ 1219.73,333.55,82.0,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Estábulo",0.5 },
	{ 442.92,-978.1,30.69,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Delegacia Praça",0.5 },
	{ 181.75,2780.29,45.71,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Shipping Services",0.5 },
	{ -429.64,1109.46,327.69,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Palácio",0.5 },
	{ 1508.36,3560.86,35.32,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Motel",0.5 },
	{ 1308.91,4362.3,41.55,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Milliars Boat",0.5 },
	{ -1668.05,190.06,61.75,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Universidade",0.5 },
	{ -244.23,-2028.85,29.95,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Estádio",0.5 },
	{ 2336.31,2566.99,47.75,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Trailer Magic",0.5 },
	{ 1093.02,-2251.45,31.24,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Parking Bilgeco",0.5 },
	{ 287.77,2843.78,44.71,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Fábrica",0.5 },
	{ -2299.71,336.85,174.61,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Faculdade",0.5 },
	{ 1395.3,3614.04,34.99,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Liquors Ace",0.5 },
	{ -424.57,284.07,83.2,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Comedy Club",0.5 },
	{ -1886.54,2050.09,140.99,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Vinhedo",0.5 },
	{ -2953.28,49.24,11.61,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Resort",0.5 },
	{ 445.12,-222.64,56.02,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Clube de Tênis",0.5 },
	{ -582.11,-1020.17,22.33,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Japão",0.5 },
	{ 794.43,-102.8,82.04,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Aladdins Cave",0.5 },
	{ 1694.29,-1596.4,113.82,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Depósito",0.5 },
	{ 729.41,-1974.01,29.3,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Hidrelétrica",0.5 },
	{ -557.04,-1646.66,19.16,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Lixão",0.5 },
	{ -877.3,-2177.66,9.81,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Crastenburg Hotel",0.5 },
	{ -1668.75,-3102.99,13.95,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Galpões",0.5 },
	{ 2710.01,3455.02,56.32,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>You Tool",0.5 },
	{ -1380.33,349.64,64.25,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Hotel",0.5 },
	{ -1684.81,-291.5,51.9,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Cemitério",0.5 },
	{ -1134.41,2682.74,18.51,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Fontinelle's",0.5 },
	{ 1134.93,-789.18,57.61,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Hipermercado",0.5 },
	{ 731.46,-1097.39,23.08,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>LS Customs",0.5 },
	{ -1366.0,56.24,54.1,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Campo de Golf",0.5 },
	{ 434.24,3572.96,33.3,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Departamento Abandonado",0.5 },
	{ 1373.26,-568.76,74.33,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Rua sem Fim",0.5 },
	{ -406.63,1086.3,327.71,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Palácio",0.5 },
	{ -671.84,-1185.69,10.62,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Machine Maintenance",0.5 },
	{ 1075.37,-2330.51,30.3,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Stay Frost",0.5 },
	{ -963.49,-1429.29,7.77,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Hotel Abandonado",0.5 },
	{ 179.22,-1722.16,29.4,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Posto dos Ballas",0.5 },
	{ 55.74,-1585.99,29.6,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Taco Bell",0.5 },
	{ -351.2,14.9,47.86,431,17,"<FONT color='#ff9933'>Roubos | <FONT color='#ffffff'>Vila",0.5 },

}
local blips = {}
local roubos = false
RegisterCommand("roubos",function(source,args)
	roubos = not roubos

	if roubos then
		TriggerEvent("Notify","sucesso","Adicionado a marcação dos roubos.",3000)
		for k,v in pairs(Robberys) do
			blips[k] = AddBlipForCoord(v[1],v[2],v[3])
			SetBlipSprite(blips[k],v[4])
			SetBlipColour(blips[k],v[5])
			SetBlipScale(blips[k],v[7])
			SetBlipAsShortRange(blips[k],true)
			BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString(v[6])
		    EndTextCommandSetBlipName(blips[k])
		end
	else
		TriggerEvent("Notify","aviso","Removido a marcação dos roubos.",3000)
		for k,v in pairs(blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
		blips = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local teleport = {
	{ 340.64,-592.7,43.29,338.53,-583.79,74.16 },  -- HOSPITAL HELIPONTO
	{ 338.53,-583.79,74.16,340.64,-592.7,43.29 },

	{ 298.85,-599.1,43.3,359.55,-584.95,28.82 },  -- RUA PARA HP
	{ 359.55,-584.95,28.82,298.85,-599.1,43.3 },

	{ -80.89,214.78,96.55,1120.96,-3152.57,-37.06 }, -- MOTOCLUB
	{ 1120.96,-3152.57,-37.06,-80.89,214.78,96.55 },

	--{ -1381.19,-632.52,30.82,-1379.75,-631.2,30.82 }, -- BAHAMA
	--{ -1379.75,-631.2,30.82,-1381.19,-632.52,30.82 },

	{ 135.84,-761.72,45.76,2033.87,2942.1,-61.9 }, -- TID
	{ 2033.87,2942.1,-61.9,135.84,-761.72,45.76 },

	{ -1078.13,-254.51,44.03,-1072.45,-246.43,54.01 }, -- LIFE
	{ -1072.45,-246.43,54.01,-1078.13,-254.51,44.03 },
	{ -1058.14,-238.15,44.03,-1058.54,-236.79,44.03 },
	{ -1058.54,-236.79,44.03,-1058.14,-238.15,44.03 },

	--{ 1242.29,-759.87,43.67,903.1,-3182.1,-97.05 }, -- NAO EXISTE
	--{ 903.1,-3182.1,-97.05,1242.29,-759.87,43.67 },

	{ 535.85,-21.77,70.64,565.73,5.01,103.24 }, -- HELI PONTO DP 
	{ 565.73,5.01,103.24,535.85,-21.77,70.64 },

	--{ 565.58,3.67,103.24,557.91,-1.15,87.81 }, -- HELI ANTIGO 
	--{ 557.91,-1.15,87.81,565.58,3.67,103.24 },
	--{ 559.84,-3.43,82.73,557.16,-1.6,70.63 }, -- GARAGEM DP
	--{ 557.16,-1.6,70.63,559.84,-3.43,82.73 }, 
	--{ 612.32,15.74,82.75,612.83,15.63,87.82 }, -- SECRETARIA DP
	--{ 612.83,15.63,87.82,612.32,15.74,82.75 }, 

}


CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(teleport) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~   ACESSAR")
					if distance <= 1 and IsControlJustPressed(1,38) then
						Wait(300)
						SetEntityCoords(ped,v[4],v[5],v[6])
					end
				end
			end
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end

--[[ 	{ parts,-815.59,-182.16,37.56 },
	{ parts,139.21,-1708.96,29.30 },
	{ parts,-1282.00,-1118.86,7.00 },
	{ parts,1934.11,3730.73,32.85 },
	{ parts,1211.07,-475.00,66.21 },
	{ parts,-34.97,-150.90,57.08 },
	{ parts,-280.37,6227.01,31.70 },
	{ parts,616.12,7.97,82.79 }]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if IsPedBeingStunned(ped) then
			timeDistance = 4
			SetPedToRagdoll(ped,7500,7500,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			timeDistance = 4
			TriggerEvent("cancelando",true)
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			Wait(7500)
			StopGameplayCamShaking()
			TriggerEvent("cancelando",false)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR X NA MOTO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,0) == ped and GetVehicleClass(vehicle) == 8 then
				timeDistance = 4
				DisableControlAction(0,345,true)
            end
        end
        Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DAMAGE WALK MODE
-----------------------------------------------------------------------------------------------------------------------------------------
local hurt = false
CreateThread(function()
	while true do
		local delayThread = 500
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) then
			if GetEntityHealth(ped) <= 199 then
				delayThread = 5
				setHurt()
			elseif hurt and GetEntityHealth(ped) > 200 then
				setNotHurt()
			end
		end
		Wait(delayThread)
	end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(),"move_m@injured",true)
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
	DisableControlAction(0,21) 
	DisableControlAction(0,22)
end

function setNotHurt()
    hurt = false
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	LoadInterior(GetInteriorAtCoords(-447.35,6010.87,31.72))
	LoadInterior(GetInteriorAtCoords(165.52,6640.41,31.72))
	LoadInterior(GetInteriorAtCoords(-2543.5,2310.94,33.42))
	LoadInterior(GetInteriorAtCoords(326.65,-593.17,43.29))
	LoadInterior(GetInteriorAtCoords(134.83,-1043.01,22.97))
	LoadInterior(GetInteriorAtCoords(798.45,-735.37,28.0))
	LoadInterior(GetInteriorAtCoords(1827.15,3681.98,34.28))
	LoadInterior(GetInteriorAtCoords(-160.24,6322.65,31.6))
	LoadInterior(GetInteriorAtCoords(1851.54,3689.08,34.29))
	LoadInterior(GetInteriorAtCoords(14.95,-1602.61,29.38))
	for _,v in pairs(allIpls) do
		loadInt(v.coords,v.interiorsProps)
	end
end)

function loadInt(coordsTable,table)
	for _,v in pairs(coordsTable) do
		local interior = GetInteriorAtCoords(v[1],v[2],v[3])
		LoadInterior(interior)
		for _,i in pairs(table) do
			EnableInteriorProp(interior,i)
			Wait(10)
		end
		RefreshInterior(interior)
	end
end

allIpls = {
	{
		interiorsProps = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = {{ -1150.7,-1520.7,10.6 }}
	},
	{
		interiorsProps = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = {{ -47.1,-1115.3,26.5 }}
	},
	{
		interiorsProps = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = {{ -802.3,175.0,72.8 }}
	},
	{
		interiorsProps = {
			"meth_lab_basic",
			"meth_lab_production",
			"meth_lab_setup"
		},
		coords = {{ 1009.5,-3196.6,-38.9 }} -- Metanfetamina
	},
	{
		interiorsProps = {
			"security_high",
			"equipment_basic",
			"equipment_upgrade",
			"production_upgrade",
			"table_equipment_upgrade",
			"coke_press_upgrade",
			"security_low",
			"set_up"
		},
		coords = {{ 1093.6,-3196.6,-38.9 }} -- Cocaina
	},
	{
		interiorsProps = {
			"counterfeit_cashpile100a",
			"counterfeit_cashpile100b",
			"counterfeit_cashpile100c",
			"counterfeit_cashpile100d",
			"counterfeit_security",
			"counterfeit_setup",
			"counterfeit_standard_equip",
			"money_cutter",
			"special_chairs",
			"dryera_on",
			"dryerb_on",
			"dryerc_on",
			"dryerd_on"
		},
		coords = {{ 1121.0,-3196.0,-40.4 }} -- Lavagem
	},
	{
		interiorsProps = {
			"coke_stash1",
			"coke_stash2",
			"coke_stash3",
			"decorative_02",
			"furnishings_02",
			"walls_01",
			"mural_02",
			"gun_locker",
			"mod_booth"
		},
		coords = {{ 1107.0,-3157.3,-37.5 }} -- Motoclub
	},
	{
		interiorsProps = {
			"coke_large",
			"decorative_01",
			"furnishings_01",
			"walls_01",
			"lower_walls_default",
			"gun_locker",
			"mod_booth"
		},
		coords = {{ 998.4,-3164.7,-38.9 }} -- Motoclub2
	},
	{
		interiorsProps = {
			"chair01",
			"equipment_basic",
			"interior_upgrade",
			"security_low",
			"set_up"
		},
		coords = {{ 1163.8,-3195.7,-39.0 }} -- Escritório
	},
	{
		interiorsProps = {
			"garage_decor_01",
			"garage_decor_02",
			"garage_decor_03",
			"garage_decor_04",
			"lighting_option01",
			"lighting_option02",
			"lighting_option03",
			"lighting_option04",
			"lighting_option05",
			"lighting_option06",
			"lighting_option07",
			"lighting_option08",
			"lighting_option09",
			"numbering_style01_n3",
			"numbering_style02_n3",
			"numbering_style03_n3",
			"numbering_style04_n3",
			"numbering_style05_n3",
			"numbering_style06_n3",
			"numbering_style07_n3",
			"numbering_style08_n3",
			"numbering_style09_n3",
			"urban_style_set",
			"car_floor_hatch",
			"door_blocker"
		},
		coords = {{ 994.59,-3002.59,-39.64 }} -- Mecanica
	},
	{
		interiorsProps = {
			"bunker_style_a",
			"upgrade_bunker_set",
			"security_upgrade",
			"office_upgrade_set",
			"gun_wall_blocker",
			"gun_range_lights",
			"gun_locker_upgrade",
			"Gun_schematic_set"
		},
		coords = {{ 899.55,-3246.03,-98.04 }} -- Bunker
	},
	{
		interiorsProps = {
			"Int01_ba_clubname_01",
	        "Int01_ba_Style03",
	        "Int01_ba_style03_podium",
	        "Int01_ba_equipment_setup",
	        "Int01_ba_equipment_upgrade",
	        "Int01_ba_security_upgrade",
	        "Int01_ba_dj04",
	        "DJ_01_Lights_01",
	        "DJ_02_Lights_01",
	        "DJ_03_Lights_01",
	        "DJ_04_Lights_01",
	        "Int01_ba_bar_content",
	        "Int01_ba_booze_03",
	        "Int01_ba_trophy01",
	        "Int01_ba_Clutter",
	        "Int01_ba_deliverytruck",
	        "Int01_ba_dry_ice",
	        "light_rigs_off",
	        "Int01_ba_lightgrid_01",
	        "Int01_ba_trad_lights",
	        "Int01_ba_trophy04",
	        "Int01_ba_trophy05",
	        "Int01_ba_trophy07",
	        "Int01_ba_trophy08",
	        "Int01_ba_trophy09",
	        "Int01_ba_trophy10",
	        "Int01_ba_trophy11",
	        "Int01_ba_booze_01",
			"Int01_ba_booze_02",
			"Int01_ba_booze_03",
			"int01_ba_lights_screen",
			"Int01_ba_bar_content"
        },
		coords = {{ -1604.664, -3012.583, -78.00 }} -- Galaxy
	}
}