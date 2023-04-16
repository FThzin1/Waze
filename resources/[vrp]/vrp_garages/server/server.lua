-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_garages",src)
vCLIENT = Tunnel.getInterface("vrp_garages")
local inventory = module("vrp","cfg/inventory")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE VRP_GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
--vRP.prepare('IPVA/AllVehicles', 'SELECT * FROM vrp_user_vehicles')
vRP._prepare("creative/get_vehicle","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("creative/rem_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/get_vehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_update_vehicles","UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_detido","UPDATE vrp_user_vehicles SET detido = @detido, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_ipva","UPDATE vrp_user_vehicles SET ipva = @ipva WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/move_vehicle","UPDATE vrp_user_vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,ipva) VALUES(@user_id,@vehicle,@ipva)")
vRP._prepare("creative/con_maxvehs","SELECT COUNT(vehicle) as qtd FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("creative/rem_srv_data","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP._prepare("creative/get_estoque","SELECT * FROM vrp_estoque WHERE vehicle = @vehicle")
vRP._prepare("creative/set_estoque","UPDATE vrp_estoque SET quantidade = @quantidade WHERE vehicle = @vehicle")
vRP._prepare("creative/get_users","SELECT * FROM vrp_users WHERE id = @user_id")


vRP.prepare('waze/check_trusts', "SELECT * FROM waze_carkeys WHERE placa = @placa")
vRP.prepare('waze/sel_truste', "SELECT * FROM waze_carkeys WHERE user_id = @user_id AND placa = @placa")
vRP.prepare('waze/add_truste', "INSERT INTO waze_carkeys(user_id, placa) VALUES(@user_id, @placa)")
vRP.prepare('waze/rem_truste', "DELETE FROM waze_carkeys WHERE user_id = @user_id AND placa = @placa")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local police = {}
local vehlist = {}
local trydoors = {}
trydoors["CLONADOS"] = true
trydoors["AAAAAAAA"] = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNVEHICLESEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.returnVehicleEveryone(placa)
	return trydoors[placa]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("setPlateEveryone")
AddEventHandler("setPlateEveryone",function(placa)
	trydoors[placa] = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
--AddEventHandler("vRP:playerSpawn",function(user_id,source)
--    vCLIENT.syncTrydoors(source,trydoors)
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local garages = {
	[1] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[2] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[3] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[4] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[5] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[6] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[7] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[8] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[9] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[10] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[11] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[12] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[13] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[14] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[15] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[16] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[17] = { ['name'] = "Pescaria", ['payment'] = true, ['public'] = true }, -- pesca
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DEPARTAMENTO DE POLÍCIA ]------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	[18] = { ['name'] = "Policia", ['payment'] = false, ['perm'] = "carpolicia.permissao" }, -- sul
	[19] = { ['name'] = "PoliciaH", ['payment'] = false, ['perm'] = "carpolicia.permissao" }, -- sul
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DEPARTAMENTO MÉDICO ]----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	[21] = { ['name'] = "Paramedicoh", ['payment'] = false, ['perm'] = "medico.permissao" },
	[22] = { ['name'] = "Paramedico", ['payment'] = false, ['perm'] = "medico.permissao" },
-----------------------------------------------------------------------------------------------------------------------------------------
--[ AEROPORTO ]----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	[24] = { ['name'] = "Spawn", ['payment'] = false, ['public'] = true },
	[25] = { ['name'] = "PostOP", ['payment'] = false, ['public'] = true },
	[26] = { ['name'] = "Taxi", ['payment'] = false, ['public'] = true },
	[27] = { ['name'] = "Minerador", ['payment'] = false, ['public'] = true },
	[28] = { ['name'] = "Caminhoneiro", ['payment'] = false, ['public'] = true },
	[29] = { ['name'] = "Lenhador", ['payment'] = false, ['public'] = true },
	[30] = { ['name'] = "Lixeiro", ['payment'] = false, ['public'] = true },
	[31] = { ['name'] = "Motorista", ['payment'] = false, ['perm'] = "livre" },
	[32] = { ['name'] = "Mecanico", ['payment'] = false, ['perm'] = "mecanico.permissao" },

	[33] = { ['name'] = "Embarcações", ['payment'] = false, ['public'] = true },
	[34] = { ['name'] = "Embarcações", ['payment'] = false, ['public'] = true },
	[35] = { ['name'] = "Embarcações", ['payment'] = false, ['public'] = true },
	[36] = { ['name'] = "Embarcações", ['payment'] = false, ['public'] = true },
	[37] = { ['name'] = "Embarcações", ['payment'] = false, ['public'] = true },
	[38] = { ['name'] = "Embarcações", ['payment'] = false, ['public'] = true },
	[39] = { ['name'] = "Bicicletario", ['payment'] = false, ['public'] = true },
	[40] = { ['name'] = "Bicicletario", ['payment'] = false, ['public'] = true },
	[41] = { ['name'] = "Bicicletario", ['payment'] = false, ['public'] = true },
	[42] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[43] = { ['name'] = "Bennys", ['payment'] = false, ['perm'] = "bennys.permissao" },
	--[44] = { ['name'] = "Bratva", ['payment'] = false, ['perm'] = "bratva.permissao" },
	[46] = { ['name'] = "Grove", ['payment'] = false, ['public'] = true },
	[47] = { ['name'] = "Ballas", ['payment'] = false, ['public'] = true },
	[48] = { ['name'] = "Vagos", ['payment'] = false, ['public'] = true },
	[49] = { ['name'] = "Crips", ['payment'] = false, ['public'] = true },
	[50] = { ['name'] = "Bloods", ['payment'] = false, ['public'] = true },
	[51] = { ['name'] = "LifeInvader", ['payment'] = false, ['public'] = true },
	[52] = { ['name'] = "Bahamas", ['payment'] = false, ['public'] = true },
	[54] = { ['name'] = "Bratva", ['payment'] = false, ['public'] = true },
	[55] = { ['name'] = "Siciliana", ['payment'] = false, ['public'] = true },
	[56] = { ['name'] = "Warlocks", ['payment'] = false, ['public'] = true },
	[57] = { ['name'] = "HellAngels", ['payment'] = false, ['public'] = true },
	[58] = { ['name'] = "Prisao", ['payment'] = false, ['public'] = true },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------FORTHILLS-----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	[145] = { ['name'] = "FH01", ['payment'] = false, ['public'] = false },
	[148] = { ['name'] = "FH04", ['payment'] = false, ['public'] = false },
	[155] = { ['name'] = "FH11", ['payment'] = false, ['public'] = false },
	[159] = { ['name'] = "FH15", ['payment'] = false, ['public'] = false },
	[163] = { ['name'] = "FH19", ['payment'] = false, ['public'] = false },
	[167] = { ['name'] = "FH23", ['payment'] = false, ['public'] = false },
	[168] = { ['name'] = "FH24", ['payment'] = false, ['public'] = false },
	[170] = { ['name'] = "FH26", ['payment'] = false, ['public'] = false },
	[173] = { ['name'] = "FH29", ['payment'] = false, ['public'] = false },
	[175] = { ['name'] = "FH31", ['payment'] = false, ['public'] = false },
	[176] = { ['name'] = "FH32", ['payment'] = false, ['public'] = false },
	[189] = { ['name'] = "FH45", ['payment'] = false, ['public'] = false },
	[192] = { ['name'] = "FH48", ['payment'] = false, ['public'] = false },
	[193] = { ['name'] = "FH49", ['payment'] = false, ['public'] = false },
	[196] = { ['name'] = "FH52", ['payment'] = false, ['public'] = false },
	[198] = { ['name'] = "FH54", ['payment'] = false, ['public'] = false },
	[199] = { ['name'] = "FH55", ['payment'] = false, ['public'] = false },
	[202] = { ['name'] = "FH58", ['payment'] = false, ['public'] = false },
	[203] = { ['name'] = "FH59", ['payment'] = false, ['public'] = false },
	[212] = { ['name'] = "FH68", ['payment'] = false, ['public'] = false },
	[225] = { ['name'] = "FH81", ['payment'] = false, ['public'] = false },
	[235] = { ['name'] = "FH91", ['payment'] = false, ['public'] = false },
	[236] = { ['name'] = "FH92", ['payment'] = false, ['public'] = false },
	[237] = { ['name'] = "FH93", ['payment'] = false, ['public'] = false },
	[238] = { ['name'] = "FH94", ['payment'] = false, ['public'] = false },
	[339] = { ['name'] = "FH57", ['payment'] = false, ['public'] = false },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------LUXURY--------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	[245] = { ['name'] = "LX01", ['payment'] = false, ['public'] = false },
	[246] = { ['name'] = "LX02", ['payment'] = false, ['public'] = false },
	[247] = { ['name'] = "LX03", ['payment'] = false, ['public'] = false },
	[248] = { ['name'] = "LX04", ['payment'] = false, ['public'] = false },
	[249] = { ['name'] = "LX05", ['payment'] = false, ['public'] = false },
	[250] = { ['name'] = "LX06", ['payment'] = false, ['public'] = false },
	[251] = { ['name'] = "LX07", ['payment'] = false, ['public'] = false },
	[252] = { ['name'] = "LX08", ['payment'] = false, ['public'] = false },
	[253] = { ['name'] = "LX09", ['payment'] = false, ['public'] = false },
	[254] = { ['name'] = "LX10", ['payment'] = false, ['public'] = false },
	[255] = { ['name'] = "LX11", ['payment'] = false, ['public'] = false },
	[256] = { ['name'] = "LX12", ['payment'] = false, ['public'] = false },
	[257] = { ['name'] = "LX13", ['payment'] = false, ['public'] = false },
	[258] = { ['name'] = "LX14", ['payment'] = false, ['public'] = false },
	[259] = { ['name'] = "LX15", ['payment'] = false, ['public'] = false },
	[260] = { ['name'] = "LX16", ['payment'] = false, ['public'] = false },
	[261] = { ['name'] = "LX17", ['payment'] = false, ['public'] = false },
	[262] = { ['name'] = "LX18", ['payment'] = false, ['public'] = false },
	[263] = { ['name'] = "LX19", ['payment'] = false, ['public'] = false },
	[264] = { ['name'] = "LX20", ['payment'] = false, ['public'] = false },
	[265] = { ['name'] = "LX21", ['payment'] = false, ['public'] = false },
	[266] = { ['name'] = "LX22", ['payment'] = false, ['public'] = false },
	[267] = { ['name'] = "LX23", ['payment'] = false, ['public'] = false },
	[268] = { ['name'] = "LX24", ['payment'] = false, ['public'] = false },
	[269] = { ['name'] = "LX25", ['payment'] = false, ['public'] = false },
	[270] = { ['name'] = "LX26", ['payment'] = false, ['public'] = false },
	[271] = { ['name'] = "LX27", ['payment'] = false, ['public'] = false },
	[272] = { ['name'] = "LX28", ['payment'] = false, ['public'] = false },
	[273] = { ['name'] = "LX29", ['payment'] = false, ['public'] = false },
	[276] = { ['name'] = "LX32", ['payment'] = false, ['public'] = false },
	[278] = { ['name'] = "LX34", ['payment'] = false, ['public'] = false },
	[279] = { ['name'] = "LX35", ['payment'] = false, ['public'] = false },
	[280] = { ['name'] = "LX36", ['payment'] = false, ['public'] = false },
	[281] = { ['name'] = "LX37", ['payment'] = false, ['public'] = false },
	[282] = { ['name'] = "LX38", ['payment'] = false, ['public'] = false },
	[283] = { ['name'] = "LX39", ['payment'] = false, ['public'] = false },
	[284] = { ['name'] = "LX40", ['payment'] = false, ['public'] = false },
	[285] = { ['name'] = "LX41", ['payment'] = false, ['public'] = false },
	[286] = { ['name'] = "LX42", ['payment'] = false, ['public'] = false },
	[287] = { ['name'] = "LX43", ['payment'] = false, ['public'] = false },
	[288] = { ['name'] = "LX44", ['payment'] = false, ['public'] = false },
	[289] = { ['name'] = "LX45", ['payment'] = false, ['public'] = false },
	[290] = { ['name'] = "LX46", ['payment'] = false, ['public'] = false },
	[291] = { ['name'] = "LX47", ['payment'] = false, ['public'] = false },
	[292] = { ['name'] = "LX48", ['payment'] = false, ['public'] = false },
	[294] = { ['name'] = "LX50", ['payment'] = false, ['public'] = false },
	[295] = { ['name'] = "LX51", ['payment'] = false, ['public'] = false },
	[296] = { ['name'] = "LX52", ['payment'] = false, ['public'] = false },
	[297] = { ['name'] = "LX53", ['payment'] = false, ['public'] = false },
	[298] = { ['name'] = "LX54", ['payment'] = false, ['public'] = false },
	[299] = { ['name'] = "LX55", ['payment'] = false, ['public'] = false },
	[302] = { ['name'] = "LX58", ['payment'] = false, ['public'] = false },
	[303] = { ['name'] = "LX59", ['payment'] = false, ['public'] = false },
	[304] = { ['name'] = "LX60", ['payment'] = false, ['public'] = false },
	[305] = { ['name'] = "LX61", ['payment'] = false, ['public'] = false },
	[306] = { ['name'] = "LX62", ['payment'] = false, ['public'] = false },
	[307] = { ['name'] = "LX63", ['payment'] = false, ['public'] = false },
	[308] = { ['name'] = "LX64", ['payment'] = false, ['public'] = false },
	[309] = { ['name'] = "LX65", ['payment'] = false, ['public'] = false },
	[310] = { ['name'] = "LX66", ['payment'] = false, ['public'] = false },
	[311] = { ['name'] = "LX67", ['payment'] = false, ['public'] = false },
	[312] = { ['name'] = "LX68", ['payment'] = false, ['public'] = false },
	[313] = { ['name'] = "LX69", ['payment'] = false, ['public'] = false },
	[314] = { ['name'] = "LX70", ['payment'] = false, ['public'] = false },
	[366] = { ['name'] = "LK01", ['payment'] = false, ['public'] = false },
	[316] = { ['name'] = "FH100", ['payment'] = false, ['public'] = false },
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GARAGEMS ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local workgarage = {
	["Policia"] = {
		"wrdouble",
		"wrgranger",
		"wrgrowler",
		"wrkomoda",
		"wrtrx",
		"wrcontender"
	},
	["PoliciaB"] = {
		"pbus"
	},
	["PoliciaH"] = {
		"wrpolmav"
	},
	["Motorista"] = {
		"bus"
	},
	["Bicicletario"] = {
		"scorcher",
		"tribike",
		"tribike2",
		"tribike3",
		"fixter",
		"cruiser",
		"bmx"
	},
	["Embarcações"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark3",
		"speeder",
		"speeder2",
		"squalo",
		"suntrap",
		"toro",
		"toro2",
		"tropic"
	},
	["Pescaria"] = {
		"dinghy",
		"jetmax",
		"speeder",
		"speeder2",
		"squalo",
		"suntrap",
		"toro",
		"toro2",
		"tropic"
	},
	["Taxi"] = {
		"taxi"
	},
	["Caminhoneiro"] = {
		"phantom"
	},
	["Lixeiro"] = {
		"trash2"
	},
	["Lenhador"] = {
		"pounder"
	},
	["Minerador"] = {
		"tiptruck"
	},
	["Mecanico"] = {
		"towtruck",
		"towtruck2",
		"chimera",
		"slamtruck",
		"flatbed"
	},
	["PostOP"] = {
		"boxville4",
		"tribike3"
	},
	["Paramedicoh"] = {
		"polmav"
	},
	["Paramedico"] = {
		"sprinter1",
		"zendrack"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MYVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.myVehicles(work)
	local source = source
	local user_id = vRP.getUserId(source)
	local myvehicles = {}
	local ipva = ""
	local status = ""
	if user_id then
		if workgarage[work] then
			for k,v in pairs(workgarage) do
				if k == work then
					for k2,v2 in pairs(v) do
						status = "<span class=\"green\">"..k.."</span>"
						ipva = "<span class=\"green\">Pago</span>"
						myvehicles[#myvehicles + 1] = { name = v2, name2 = vRP.vehicleName(v2), engine = 100, body = 100, fuel = 100, status = status, ipva = ipva }
					end
				end
			end
			return myvehicles
		else
			local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
			local address = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if #address > 0 then
				for k,v in pairs(address) do
					if v.home == work then
						for k2,v2 in pairs(vehicle) do
							if parseInt(os.time()) <= parseInt(vehicle[k2].time+24*60*60) then
								status = "<span class=\"red\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.1)).."</span>"
							elseif vehicle[k2].detido == 1 then
								status = "<span class=\"orange\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.1)).."</span>"
							else
								status = "<span class=\"green\">Gratuita</span>"
							end

							if parseInt(os.time()) >= parseInt(vehicle[k2].ipva+24*15*60*60) then
								ipva = "<span class=\"red\">Atrasado</span>"
							else
								ipva = "<span class=\"green\">Pago</span>"
							end
							myvehicles[#myvehicles + 1] = { name = vehicle[k2].vehicle, name2 = vRP.vehicleName(vehicle[k2].vehicle), engine = parseInt(vehicle[k2].engine*0.1), body = parseInt(vehicle[k2].body*0.1), fuel = parseInt(vehicle[k2].fuel), status = status, ipva = ipva }
						end
						return myvehicles
					else
						for k2,v2 in pairs(vehicle) do
							if parseInt(os.time()) <= parseInt(vehicle[k2].time+24*60*60) then
								status = "<span class=\"red\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.1)).."</span>"
							elseif vehicle[k2].detido == 1 then
								status = "<span class=\"orange\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.1)).."</span>"
							else
								status = "<span class=\"green\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.006)).."</span>"
							end

							if parseInt(os.time()) >= parseInt(vehicle[k2].ipva+24*15*60*60) then
								ipva = "<span class=\"red\">Atrasado</span>"
							else
								ipva = "<span class=\"green\">Pago</span>"
							end
							
							myvehicles[#myvehicles + 1] = { name = vehicle[k2].vehicle, name2 = vRP.vehicleName(vehicle[k2].vehicle), engine = parseInt(vehicle[k2].engine*0.1), body = parseInt(vehicle[k2].body*0.1), fuel = parseInt(vehicle[k2].fuel), status = status, ipva = ipva }
						end
						return myvehicles
					end
				end
			else
				for k,v in pairs(vehicle) do
					if parseInt(os.time()) <= parseInt(vehicle[k].time+24*60*60) then
						status = "<span class=\"red\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k].vehicle)*0.5)).."</span>"
					elseif vehicle[k].detido == 1 then
						status = "<span class=\"orange\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k].vehicle)*0.01)).."</span>"
					else
						status = "<span class=\"green\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k].vehicle)*0.006)).."</span>"
					end

					if parseInt(os.time()) >= parseInt(vehicle[k].ipva+24*15*60*60) then
						ipva = "<span class=\"red\">Atrasado</span>"
					else
						ipva = "<span class=\"green\">Pago</span>"
					end
					myvehicles[#myvehicles + 1] = { name = vehicle[k].vehicle, name2 = vRP.vehicleName(vehicle[k].vehicle), engine = parseInt(vehicle[k].engine*0.1), body = parseInt(vehicle[k].body*0.1), fuel = parseInt(vehicle[k].fuel), status = status, ipva = ipva }
				end
				return myvehicles
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.spawnVehicles(name,use)
	if name then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			local identity = vRP.getUserIdentity(user_id)
			local value = vRP.getUData(parseInt(user_id),"vRP:multas")
			local multas = json.decode(value) or 0
			if multas >= 10000 then
				TriggerClientEvent("Notify",source,"negado","Você não pode ter mais de <b>$10.000</b> em multas pendentes.",10000)
				return true
			end
			if not vCLIENT.returnVehicle(source,name) then
				-- print('passou A')
				local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
				local tuning = vRP.getSData("custom:u"..user_id.."veh_"..name) or {}
				local custom = json.decode(tuning) or {}
				if vehicle[1] ~= nil then
					-- print('passouB')
					if parseInt(os.time()) <= parseInt(vehicle[1].time+24*60*60) then
						-- print('passou C')
						local ok = vRP.request(source,"Veículo na retenção, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.1)).."</b> dólares ?",60)
						if ok then
							if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.1)) then
								vRP.execute("creative/set_detido",{ user_id = parseInt(user_id), vehicle = name, detido = 0, time = 0 })
								TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.",10000)
								exports["waze-system"]:sendLogs(user_id,{ webhook = "garageInsurance", text = "Retirou o veículo "..vRP.vehicleName(name).." da retenção antes das 24 horas por $"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.25)) })
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
							end
						end
					elseif parseInt(vehicle[1].detido) >= 1 then
						-- print('passou D')
						local ok = vRP.request(source,"Veículo na detenção, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.1)).."</b> dólares ?",60)
						if ok then
							if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.1)) then
								vRP.execute("creative/set_detido",{ user_id = parseInt(user_id), vehicle = name, detido = 0, time = 0 })
								TriggerClientEvent("Notify",source,"financeiro","Veículo liberado.",10000)
								exports["waze-system"]:sendLogs(user_id,{ webhook = "garageInsurance", text = "Retirou o veículo "..vRP.vehicleName(name).." da retenção após 24 horas por $"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.15)) })
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
							end
						end
					else
						-- print('passou E')
						if parseInt(os.time()) <= parseInt(vehicle[1].ipva+24*15*60*60) then
							-- print('passou F')
							if garages[use].payment then
								-- print('passou G')
								if vRP.vehicleType(tostring(name)) == "exclusive" or vRP.vehicleType(tostring(name)) == "rental" then
									-- print('passou H')
									local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].engine,vehicle[1].body,vehicle[1].fuel,custom)
									vehlist[vehid] = { parseInt(user_id),name }
									TriggerEvent("setPlateEveryone",identity.registration)
									TriggerClientEvent("Notify",source,"sucesso","Veículo <b>exclusivo/alugado</b>. Não será cobrado a taxa de liberação.",10000)
								end
								if (vRP.getBankMoney(user_id)+vRP.getMoney(user_id)) >= parseInt(vRP.vehiclePrice(name)*0.005 and not vRP.vehicleType(tostring(name)) == "exclusive" or vRP.vehicleType(tostring(name)) == "rental") then
									-- print('passou H')
									if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.005)) then
										local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].engine,vehicle[1].body,vehicle[1].fuel,custom)
										if spawnveh then
											TriggerClientEvent('Notify', source, 'financeiro', 'Você pagou <b>$'..parseInt(vRP.vehiclePrice(name)*0.005)..'</b>.')
											vehlist[vehid] = { parseInt(user_id),name }
											TriggerEvent("setPlateEveryone",identity.registration)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
								end
							else
								local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].engine,vehicle[1].body,vehicle[1].fuel,custom,parseInt(vehicle[1].colorR),parseInt(vehicle[1].colorG),parseInt(vehicle[1].colorB),parseInt(vehicle[1].color2R),parseInt(vehicle[1].color2G),parseInt(vehicle[1].color2B),false)
								if spawnveh then
									vehlist[vehid] = { user_id,name }
									TriggerEvent("setPlateEveryone",identity.registration)
								end
							end
						else
							if vRP.vehicleType(tostring(name)) == "exclusive" or vRP.vehicleType(tostring(name)) == "rental" then
								vRP.execute("creative/set_ipva",{ user_id = parseInt(user_id), vehicle = name, ipva = parseInt(os.time()) })
								TriggerClientEvent("Notify",source,"sucesso","Pagamento do <b>IPVA</b> conclúido com sucesso.",10000)
							else
								local price_tax = parseInt(vRP.vehiclePrice(name)*0.10)
								if price_tax > 100000 then
									price_tax = 100000
								end
								local ok = vRP.request(source,"Deseja pagar o <b>IPVA</b> do veículo <b>"..vRP.vehicleName(name).."</b> por <b>$"..vRP.format(price_tax).."</b> dólares?",60)
								if ok then
									if vRP.tryFullPayment(user_id,price_tax) then
										vRP.execute("creative/set_ipva",{ user_id = parseInt(user_id), vehicle = name, ipva = parseInt(os.time()) })
										TriggerClientEvent("Notify",source,"sucesso","Pagamento do <b>IPVA</b> conclúido com sucesso.",10000)
											exports["waze-system"]:sendLogs(user_id,{ webhook = "garageTax", text = "Pagou a taxa do veículo "..vRP.vehicleName(name).." por $"..vRP.format(price_tax) })
									else
										TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
									end
								end
							end
						end
					end
				else
					local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,1000,1000,100,custom,0,0,0,0,0,0,true)
					if spawnveh then
						vehlist[vehid] = { user_id,name }
						TriggerEvent("setPlateEveryone",identity.registration)
					end
				end
			else
				TriggerClientEvent("Notify",source,"aviso","Já possui um veículo deste modelo fora da garagem.",10000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.deleteVehicles2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRPclient.getNearestVehicle(source,30)
		if vehicle then
			vCLIENT.deleteVehicle(source,vehicle)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dv',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if not args[1] then
			local vehicle = vRPclient.getNearestVehicle(source,7)
			if vehicle then
				vCLIENT.deleteVehicle(source,vehicle)
			end
		else 
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			local vehicle = vRPclient.getNearestVehicle(nsource,7)
			if vehicle then
				vCLIENT.deleteVehicle(nsource,vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV AREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dvarea',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
    	if args[1] then
	        local x,y,z = vRPclient.getPosition(source)
	        vCLIENT.deleteVehicleArea(source,x,y,z,args[1])
	    end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addtrust', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	local placaid = identity.registration
	if args[1] then
		local nuser_id = parseInt(args[1])
		local rows = vRP.query("waze/sel_truste", {user_id = nuser_id, placa = placaid})
		if not rows[1] then
			vRP.execute("waze/add_truste", {user_id = nuser_id, placa = placaid})
			TriggerClientEvent('Notify', source, 'sucesso', 'Confiança dada ao passaporte <b>' .. nuser_id .. '</b>.')
		else
			TriggerClientEvent('Notify', source, 'negado', 'Esse passaporte <b>JÁ</b> possui sua confiança.')
		end
	else
		TriggerClientEvent('Notify', source, 'negado', 'Você precisa especificar um passaporte.')
	end
end)

RegisterCommand('remtrust', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	local placaid = identity.registration
	if args[1] then
		local nuser_id = parseInt(args[1])
		local rows = vRP.query("waze/sel_truste", {user_id = nuser_id, placa = placaid})
		if rows[1] then
			vRP.execute("waze/rem_truste", {user_id = nuser_id, placa = placaid})
			TriggerClientEvent('Notify', source, 'sucesso', 'Confiança revogada do passaporte <b>' .. nuser_id .. '</b>.')
		else
			TriggerClientEvent('Notify', source, 'negado', 'Esse passaporte <b>NÃO</b> possui sua confiança.')
		end
	else
		TriggerClientEvent('Notify', source, 'negado', 'Você precisa especificar um passaporte.')
	end
end)

RegisterCommand('trusts', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	local placaid = identity.registration
	local rows = vRP.query("waze/check_trusts", {placa = placaid})
	local acessos = ''
	for k, v in pairs(rows) do
		local nuser_id = parseInt(v.user_id)
		local nidentity = vRP.getUserIdentity(nuser_id)
		acessos = acessos .. '<br> - <b>' .. nidentity.name .. ' ' .. nidentity.firstname .. ' (' .. nuser_id .. ')</b>'
	end
	TriggerClientEvent('Notify', source, 'aviso','Acessos à placa: '..placaid..'<br>'..acessos..'')
end)

function src.vehicleLock()
	local source = source
	local user_id = vRP.getUserId(source)

	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		if vehicle and placa then
			local placa_user_id = vRP.getUserByRegistration(placa)
			local row = vRP.query("waze/sel_truste", {user_id = user_id, placa = placa})
			if user_id == placa_user_id or row[1] or user_id == 0 then
				vCLIENT.vehicleClientLock(-1,vnetid,lock)

				if not vRPclient.isInVehicle(source) then
					vRPclient.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
				end

				if lock == 1 then
					TriggerClientEvent("Notify",source,"importante","Veículo <b>trancado</b> com sucesso.",8000)
				else
					TriggerClientEvent("Notify",source,"importante","Veículo <b>destrancado</b> com sucesso.",8000)
				end
				TriggerClientEvent("vrp_sound:source",source,"lock",0.5)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.tryDelete(vehid,vehengine,vehbody,vehfuel)
	if vehlist[vehid] and vehid ~= 0 then
		local user_id = vehlist[vehid][1]
		local vehname = vehlist[vehid][2]
		local player = vRP.getUserSource(user_id)
		if player then
			vCLIENT.syncNameDelete(player,vehname)
		end

		if vehengine <= 100 then
			vehengine = 100
		end

		if vehbody <= 100 then
			vehbody = 100
		end

		if vehfuel >= 100 then
			vehfuel = 100
		end

		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = vehname })
		if vehicle[1] ~= nil then
			vRP.execute("creative/set_update_vehicles",{ user_id = parseInt(user_id), vehicle = vehname, engine = parseInt(vehengine), body = parseInt(vehbody), fuel = parseInt(vehfuel) })
		end
	end
	vCLIENT.syncVehicle(-1,vehid)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteveh")
AddEventHandler("trydeleteveh",function(vehid)
	vCLIENT.syncVehicle(-1,vehid)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNHOUSES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.returnHouses(nome,garage)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			local address = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if #address > 0 then
				for k,v in pairs(address) do
					if v.home == garages[garage].name then
						if parseInt(v.garage) == 1 then
							local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(nome) })
							if resultOwner[1] then
								--if not vRP.hasGroup(user_id,"Platina") then
									if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*15*60*60) then
										TriggerClientEvent("Notify",source,"aviso","O <b>IPTU</b> da residência está atrasado.",10000)
										return false
									else
										vCLIENT.openGarage(source,nome,garage)
									end
								--end
							end
						end
					end
				end
			end
			if garages[garage].perm == "livre" then
				return vCLIENT.openGarage(source,nome,garage)
			elseif garages[garage].perm then
				if vRP.hasPermission(user_id,garages[garage].perm) or user_id == 0 then -- acessar garagens dos empregos
					return vCLIENT.openGarage(source,nome,garage)
				end
			elseif garages[garage].public then
				return vCLIENT.openGarage(source,nome,garage)
			end
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLE ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('travar',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") or user_id == 0 then
			if vRPclient.isInVehicle(source) then
				local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
				if vehicle then
					TriggerClientEvent("progress",source,5000,"travar/destravar")
					SetTimeout(5000,function()
						vCLIENT.vehicleAnchor(source,vehicle)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOAT ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ancorar',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.isInVehicle(source) then
			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
			if vehicle then
				vCLIENT.boatAnchor(source,vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR DATABASE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('lk', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,'admin') or vRP.hasGroup(user_id,'dev') then
			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
			if vehicle and placa then
				vCLIENT.vehicleClientLock(-1,vnetid,lock)
				TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
				vRPclient.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
				if lock == 1 then
					TriggerClientEvent("Notify",source,"importante","Veículo <b>trancado</b> com sucesso.",8000)
				else
					TriggerClientEvent("Notify",source,"importante","Veículo <b>destrancado</b> com sucesso.",8000)
				end
			end
		end
	end
end)

RegisterCommand('cardb', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.permissao') then
		if args[1] then

			if string.lower(args[1]) == 'deluxo' then
				if user_id ~= -1 and user_id ~= 5 then
					return
				end
			end

			if string.lower(args[1]) == 'mr300sel' or string.lower(args[1]) == 'porschewaze' then

				if user_id ~= -1 or user_id ~= 5 then 
					TriggerClientEvent('Notify', source, 'negado', 'Esse carro é somente para o waze.') 
					return 
				end

			end
			if args[2] then
				local nuser_id = parseInt(args[2])
				local vehname = args[1]
				local tuning = vRP.getSData("custom:u"..nuser_id.."veh_"..vehname) or {}
				local custom = json.decode(tuning) or {}
				vCLIENT.spawnVehicleAdmin(source, vehname, custom)
			else
				local vehname = args[1]
				local tuning = vRP.getSData("custom:u"..user_id.."veh_"..vehname) or {}
				local custom = json.decode(tuning) or {}
				vCLIENT.spawnVehicleAdmin(source, vehname, custom)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHS
-----------------------------------------------------------------------------------------------------------------------------------------
local delay_vehs = {}
RegisterCommand('vehs',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] and parseInt(args[2]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[2]))
			local myvehicles = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(args[1]) })

			local maxvehs = vRP.query("creative/con_maxvehs",{ user_id = parseInt(args[2]) })
			local maxvagas = 2
			if vRP.hasPermission(nplayer,"rental.permissao") then
				maxvagas = 4
			elseif vRP.hasPermission(nplayer,"waze.permissao") then
				maxvagas = 6
			elseif vRP.hasPermission(nplayer,"wazeelite.permissao") then
				maxvagas = 8
			end

			local vagasExtra = vRP.query('waze/maisgaragem_Get', { user_id = args[2] })
			if vagasExtra[1] then
				maxvagas = maxvagas + parseInt(vagasExtra[1].vagas)
			end

			local value = vRP.getUData(parseInt(user_id),"vRP:multas")
			local multas = json.decode(value) or 0
			if multas > 0 then
				TriggerClientEvent("Notify",source,"negado","Você tem multas pendentes.",10000)
				return
			end

			if parseInt(maxvehs[1].qtd) >= maxvagas then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end

			if myvehicles[1] then
				if vRP.vehicleType(tostring(args[1])) == "exclusive" or vRP.vehicleType(tostring(args[1])) == "rental" and not vRP.hasPermission(user_id,"admin.permissao") then
					TriggerClientEvent("Notify",source,"negado","<b>"..vRP.vehicleName(tostring(args[1])).."</b> não pode ser transferido por ser um veículo <b>Exclusivo ou Alugado</b>.",10000)
				else
					if delay_vehs[user_id] == 0 or not delay_vehs[user_id] then
						delay_vehs[user_id] = 200
						local identity3 = vRP.getUserIdentity(parseInt(args[2]))
						local identity2 = vRP.getUserIdentity(user_id)
						local price = tonumber(sanitizeString(vRP.prompt(source,"Valor:",""),"\"[]{}+=?!_()#@%/\\|,.",false))
						if nplayer ~= nil then		
							if vRP.request(source,"Deseja vender um <b>"..vRP.vehicleName(tostring(args[1])).."</b> para <b>"..identity3.name.." "..identity3.firstname.."</b> por <b>$"..vRP.format(parseInt(price)).."</b> dólares ?",30) then
								if vRP.request(nplayer,"Aceita comprar um <b>"..vRP.vehicleName(tostring(args[1])).."</b> de <b>"..identity2.name.." "..identity2.firstname.."</b> por <b>$"..vRP.format(parseInt(price)).."</b> dólares ?",30) then
									local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(args[2]), vehicle = tostring(args[1]) })
									if parseInt(price) > 0 then
										if vehicle[1] then
											TriggerClientEvent("Notify",source,"negado","<b>"..identity.name.." "..identity.firstname.."</b> já possui este modelo de veículo.",10000)
											TriggerClientEvent("Notify",nplayer,"negado","Você já possui um <b>"..vRP.vehicleName(tostring(args[1])).."</b> em sua garagem.",10000)
											return
										end

										if vRP.tryFullPayment(parseInt(args[2]),parseInt(price)) then
											vRP.execute("creative/move_vehicle",{ user_id = parseInt(user_id), nuser_id = parseInt(args[2]), vehicle = tostring(args[1]) })

											local custom = vRP.getSData("custom:u"..parseInt(user_id).."veh_"..tostring(args[1]))
											local custom2 = json.decode(custom)
											if custom2 then
												vRP.setSData("custom:u"..parseInt(args[2]).."veh_"..tostring(args[1]),json.encode(custom2))
												vRP.execute("creative/rem_srv_data",{ dkey = "custom:u"..parseInt(user_id).."veh_"..tostring(args[1]) })
											end

											local chest = vRP.getSData("chest:u"..parseInt(user_id).."veh_"..tostring(args[1]))
											local chest2 = json.decode(chest)
											if chest2 then
												vRP.setSData("chest:u"..parseInt(args[2]).."veh_"..tostring(args[1]),json.encode(chest2))
												vRP.execute("creative/rem_srv_data",{ dkey = "chest:u"..parseInt(user_id).."veh_"..tostring(args[1]) })
											end

											TriggerClientEvent("Notify",source,"sucesso","Você Vendeu <b>"..vRP.vehicleName(tostring(args[1])).."</b> e Recebeu <b>$"..vRP.format(parseInt(price)).."</b> dólares.",20000)
											TriggerClientEvent("Notify",nplayer,"importante","Você recebeu as chaves do veículo <b>"..vRP.vehicleName(tostring(args[1])).."</b> de <b>"..identity2.name.." "..identity2.firstname.."</b> e pagou <b>$"..vRP.format(parseInt(price)).."</b> dólares.",40000)
											vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
											vRPclient.playSound(nplayer,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
											local consulta = vRP.getUData(user_id,"vRP:paypal")
											local resultado = json.decode(consulta) or 0
											vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado + price)))
											--vRP.giveMoney(user_id,parseInt(price))
											exports["waze-system"]:sendLogs(user_id,{ webhook = "garageSell", text = "Vendeu o veículo "..vRP.vehicleName(tostring(args[1])).." por $"..vRP.format(parseInt(price)).." para ("..(args[2])..") "..identity3.name.." "..identity3.firstname })
										end
									else
										TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",8000)
										TriggerClientEvent("Notify",nplayer,"negado","Dinheiro insuficiente.",8000)
									end
								end
							end
						end
					else
						TriggerClientEvent("Notify",source,"importante","Aguarde "..vRP.getMinSecs(source,parseInt(delay_vehs[user_id])).." ate que você possa transferir novamente.",5000)
					end
				end
			end
		else
			local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
			if #vehicle > 0 then
				local car_names = {}
				for k,v in pairs(vehicle) do
					local carro = vRP.query('creative/get_vehicles', {user_id = user_id, vehicle = v.vehicle})
					if parseInt(os.time()) >= parseInt(carro[1].ipva+24*15*60*60) then
						car_names[#car_names + 1] = "<b>" .. vRP.vehicleName(v.vehicle) .. "</b> ("..v.vehicle..") - " .."<br>IPVA <b>ATRASADO</b><br>"
					else
						car_names[#car_names + 1] = "<b>" .. vRP.vehicleName(v.vehicle) .. "</b> ("..v.vehicle..") - " .."<br>IPVA em: "..vRP.getDayHours(parseInt(86400*15-(os.time()-carro[1].ipva))) .. '<br>'
					end
				end
				car_names = table.concat(car_names, "<br> ")
				TriggerClientEvent("Notify",source,"importante","Seus veículos: <br><br>" .. car_names, 10000)
			else 
				TriggerClientEvent("Notify",source,"importante","Você não possui nenhum veículo.",20000)
			end
		end
	end
end)

CreateThread(function()
	while true do
		for k,v in pairs(delay_vehs) do
			if v > 0 then
				delay_vehs[k] = v - 1
			end
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('savelivery',function(source,args,rawCommand)
    
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then
				local custom = json.decode(vRP.getSData("custom:u"..parseInt(puser_id).."veh_"..vname))
				local livery = vCLIENT.returnlivery(source,livery)
				custom.liveries = livery
				print(json.encode(custom))
				vRP.setSData("custom:u"..parseInt(puser_id).."veh_"..vname,json.encode(custom))	
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK LIVERY PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CheckLiveryPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"admin.permissao") 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local vehassh = vCLIENT.getHash(source,vehiclehash)
        vRP.prompt(source,"Hash:",""..vehassh)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER VEICULOS PASSADOS 5 DIAS SEM PAGAR IPVA
------------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("waze/getallcars","SELECT * FROM vrp_user_vehicles")
CreateThread(function()
	Wait(5)
	local qtd = 0
    local veiculost = vRP.query("waze/getallcars")
    for k,v in pairs(veiculost) do
        print(v["user_id"],v["vehicle"],v["ipva"])
        if parseInt(os.time()) >= parseInt(veiculost[k]["ipva"]+24*20*60*60) then
			if vRP.vehicleType(tostring(veiculost[k]["vehicle"])) ~= "exclusive" and vRP.vehicleType(tostring(veiculost[k]["vehicle"])) ~= "import" then
				exports["waze-system"]:sendRegister({ webhook = "garageLost", text = "O ID "..veiculost[k]["user_id"].." perdeu o veículo "..veiculost[k]["vehicle"].." pois ficou mais de 5 dias sem pagar o IPVA" })
            	vRP.execute("creative/rem_vehicle",{ user_id = veiculost[k]["user_id"], vehicle =  veiculost[k]["vehicle"] })
            	--print("deletou o carro "..veiculost[k]["vehicle"].. " do ID: "..veiculost[k]["user_id"])
				print('O JOGADOR ' ..tostring(veiculost[k]["user_id"]) .. ' PERDEU O CARRO ' .. tostring(veiculost[k]["vehicle"]) .. ' PORQUE FICOU MAIS DE 5 DIAS SEM PAGAR O IPVA!')
            	local estoque = vRP.query("creative/get_estoque",{ vehicle = veiculost[k]["vehicle"] })
            	vRP.execute("creative/set_estoque",{ vehicle = veiculost[k]["vehicle"], quantidade = parseInt(estoque[1]["quantidade"])+ 1})				--print("O carro " ..tostring(veiculost[k]["vehicle"]).. " foi removido do ID: " ..tostring(veiculost[k]["user_id"]))
				print('O CARRO DO JOGADOR ' .. tostring(veiculost[k]["user_id"]) .. ' FOI ADICIONADO AO ESTOQUE (' .. parseInt(estoque[1]["quantidade"]+ 1) .. ')!')
				qtd = qtd + 1
				--Wait(2000)
			end
        end
    end
	print("^3[ + ] starCars > ^7Um total de ^3"..qtd.." ^7carros foram vendidos por falta de pagamento de IPVA.")
end)

vRP.prepare('waze/maisgaragem_Get', 'SELECT * FROM waze_maisgaragem WHERE user_id = @user_id')
vRP.prepare('waze/maisgaragem_Criar', 'INSERT INTO waze_maisgaragem(user_id,vagas) VALUES(@user_id,@vagas)')
vRP.prepare('waze/maisgaragem_Add', 'UPDATE waze_maisgaragem SET vagas = @vagas WHERE user_id = @user_id')

-- CONFIG
local custoPrimeiraVaga = 5000000
local custoSegundaVaga = 15000000
local custoTerceiraVaga = 30000000
local custoQuartaVaga = 50000000
RegisterCommand('cgaragem', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	local query = vRP.query('waze/maisgaragem_Get', {user_id = user_id})
	local identity = vRP.getUserIdentity(user_id)
	if args[1] == 'valor' then
		TriggerClientEvent("Notify",source,'importante','Preços:<br>Para obter <b>1ª</b> você precisa de <b>$5.000.000</b>.<br>Para obter <b>2ª</b> você precisa de <b>$15.000.000</b><br>Para obter <b>3ª</b> você precisa de <b>$30.000.000</b><br>Para obter <b>4ª</b> você precisa de <b>$50.000.000</b>')
		return
	end
	if args[1] == 'comprar' then
		if vRP.request(source, 'Você deseja comprar uma vaga <b>extra</b> para sua garagem ?', 15) then
			if query[1] then
				local vagasAtuais = parseInt(query[1].vagas)

				local custo = custoPrimeiraVaga

				if vagasAtuais == 1 then
					custo = custoSegundaVaga
				elseif vagasAtuais == 2 then
					custo = custoTerceiraVaga
				elseif vagasAtuais == 3 then
					custo = custoQuartaVaga
				elseif vagasAtuais == 4 then
					TriggerClientEvent('Notify', source, "negado", 'Você já possui as <b>4 vagas extras</b>!')
					return
				end
				
				if vRP.tryFullPayment(user_id,custo) then
					vRP.execute('waze/maisgaragem_Add', {user_id = user_id, vagas = vagasAtuais + 1})
					exports["waze-system"]:sendLogs(user_id,{ webhook = "garageSlot", text = "Comprou sua " .. vagasAtuais + 1 ..  "ª vaga extra por $"..vRP.format(custo) })
					TriggerClientEvent('Notify', source, 'sucesso','Você comprou sua <b>' .. vagasAtuais + 1 ..  'ª</b> vaga extra.')
				else
					TriggerClientEvent('Notify', source, "negado", 'Você não possui <b>$' .. vRP.format(custo) ..  '</b> para comprar esta vaga extra!')
				end
			else
				if vRP.tryFullPayment(user_id,custoPrimeiraVaga) then
					vRP.execute('waze/maisgaragem_Criar', {user_id = user_id, vagas = 1})
					exports["waze-system"]:sendLogs(user_id,{ webhook = "garageSlot", text = "Comprou sua 1ª vaga extra por $"..vRP.format(custoPrimeiraVaga) })
					TriggerClientEvent('Notify', source, 'sucesso','Você comprou sua <b>1ª</b> vaga extra.')
				else
					TriggerClientEvent('Notify', source, "negado", 'Você não possui <b>$' .. vRP.format(custoPrimeiraVaga) ..  '</b> para comprar esta vaga extra!')
				end
			end
		end
	end
end)
 
function src.deleteVehicles()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		local identity = vRP.getUserIdentity(user_id)
		vRP.kick(source, 'Você foi banido do servidor.')
			local request = exports["waze-system"]:permanentBan({
				user_id = parseInt(user_id),
				staff_id = -1,
				reason = "Banido por TriggerEvent"
			})
		vRP.setBanned(user_id, 1)
		exports["waze-system"]:sendLogs(user_id,{ webhook = "garageFraud", text = "Foi banido tentando fraudar o evento 'deleteVehicles" })
    end
end