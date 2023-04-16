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
Tunnel.bindInterface("vrp_policia",src)
vCLIENT = Tunnel.getInterface("vrp_policia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDGENS
-----------------------------------------------------------------------------------------------------------------------------------------
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
local plateOne = {
	[1] = { "Dylan" },
	[2] = { "Adam" },
	[3] = { "Alan" },
	[4] = { "Alvin" },
	[5] = { "Andrew" },
	[6] = { "Antony" },
	[7] = { "Arnold" },
	[8] = { "Bernard" },
	[9] = { "Bryan" },
	[10] = { "Calvin" },
	[11] = { "Charlie" },
	[12] = { "David" },
	[13] = { "Edward" },
	[14] = { "Enrico" },
	[15] = { "Eric" },
	[16] = { "Tom" },
	[17] = { "Oliver" },
	[18] = { "Patrick" },
	[19] = { "Richard" },
	[20] = { "Robert" },
	[21] = { "Ashley" },
	[22] = { "Adele" },
	[23] = { "Agnella" },
	[24] = { "Darla" },
	[25] = { "Emily" },
	[26] = { "Emma" },
	[27] = { "Francine" },
	[28] = { "Karolyn" },
	[29] = { "Katelyn" },
	[30] = { "Katherine" },
	[31] = { "Katie" },
	[32] = { "Mary" },
	[33] = { "Melanie" },
	[34] = { "Micheline" },
	[35] = { "Natalie" },
	[36] = { "Sophie" },
	[37] = { "Stephanie" },
	[38] = { "Susan" },
	[39] = { "Valerie" },
	[40] = { "Wendy" }
}

local plateTwo = {
	[1] = { "Wright" },
	[2] = { "Smith" },
	[3] = { "Johnson" },
	[4] = { "Williams" },
	[5] = { "Jones" },
	[6] = { "Scott" },
	[7] = { "Hall" },
	[8] = { "Adams" },
	[9] = { "Carter" },
	[10] = { "Mitchell" },
	[11] = { "Parker" },
	[12] = { "Evans" },
	[13] = { "Edwards" },
	[14] = { "Collins" },
	[15] = { "Stewart" },
	[16] = { "Morris" },
	[17] = { "Reed" },
	[18] = { "Moore" },
	[19] = { "Cooper" },
	[20] = { "Taylor" },
	[21] = { "Jackson" },
	[22] = { "White" },
	[23] = { "Harris" },
	[24] = { "Thompson" },
	[25] = { "Martinez" },
	[26] = { "Torres" },
	[27] = { "Watson" },
	[28] = { "Sanders" },
	[29] = { "Bennett" },
	[30] = { "Lee" },
	[31] = { "Baker" },
	[32] = { "Barnes" },
	[33] = { "Ross" },
	[34] = { "Jenkins" },
	[35] = { "Perry" },
	[36] = { "Patterson" },
	[37] = { "Hughes" },
	[38] = { "Simmons" },
	[39] = { "Foster" },
	[40] = { "Gonzalez" }
}

RegisterCommand('placa',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end

	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"policia.permissao")  then
		if args[1] then
			local user_id = vRP.getUserByRegistration(args[1])
			if user_id then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent("Notify",source,"importante","<b>Passaporte: </b>"..identity.user_id.."<br><b>Placa: </b>"..identity.registration.."<br><b>Proprietário: </b>"..identity.name.." "..identity.firstname.."<br><b>Idade: </b>"..identity.age.." anos<br><b>Telefone: </b>"..identity.phone,10000)
				end
			else
				vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"importante","<b>Passaporte: </b>"..vRP.format(parseInt(math.random(5000,9999))).."<br><b>Placa: </b>"..args[1].."<br><b>Proprietário: </b>"..plateOne[math.random(#plateOne)][1].." "..plateTwo[math.random(#plateTwo)][1].."<br><b>Telefone: </b>"..vRP.generatePhoneNumber(),10000)
			end
		else
			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
			local placa_user_id = vRP.getUserByRegistration(placa)
			if placa_user_id then
				local identity = vRP.getUserIdentity(placa_user_id)
				if identity then
					local vehicleName = vRP.vehicleName(vname)
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent("Notify",source,"importante","<b>Passaporte: </b>"..identity.user_id.."<br><b>Placa: </b>"..identity.registration.."<br><b>Proprietário: </b>"..identity.name.." "..identity.firstname.."<br><b>Modelo: </b>"..vehicleName.."<br><b>Idade: </b>"..identity.age.." anos<br><b>Telefone: </b>"..identity.phone,10000)
				end
			else
				vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"importante","<b>Passaporte: </b>"..vRP.format(parseInt(math.random(5000,9999))).."<br><b>Placa: </b>"..placa.."<br><b>Proprietário: </b>"..plateOne[math.random(#plateOne)][1].." "..plateTwo[math.random(#plateTwo)][1].."<br><b>Telefone: </b>"..vRP.generatePhoneNumber(),10000)
			end
		end
	end
end)
--RegisterCommand('placa',function(source,args,rawCommand)
--	if not exports["chat"]:statusChatServer(source) then return end
--	local user_id = vRP.getUserId(source)
--	local vida = vRPclient.getHealth(source)
--
--	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
--	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"policiacao.permissao") or vRP.hasPermission(user_id, 'liderparamedico.permissao') then
--		if args[1] then
--			local user_id = vRP.getUserByRegistration(args[1])
--			if user_id then
--				local identity = vRP.getUserIdentity(user_id)
--				local oid = math.random(500,2000)
--				if identity then
--					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
--					if identity.user_id ~= 1 then
--						TriggerClientEvent('chatMessage',source,"911",{64,64,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
--					else
--						TriggerClientEvent('chatMessage',source,"911",{64,64,255},"^1Passaporte: ^0"..oid.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
--					end
--				end
--			else
--				TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
--			end
--		else
--			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
--			local placa_user = vRP.getUserByRegistration(placa)
--			if placa then
--				if placa_user then
--					local identity = vRP.getUserIdentity(placa_user)
--					local oid = math.random(500,2000)
--					if identity then
--						local vehicleName = vRP.vehicleName(vname)
--						vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
--						if identity.user_id ~= 1 then
--							TriggerClientEvent('chatMessage',source,"911",{64,64,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Modelo: ^0"..vehicleName.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
--						else
--							TriggerClientEvent('chatMessage',source,"911",{64,64,255},"^1Passaporte: ^0"..oid.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Modelo: ^0"..vehicleName.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
--
--						end
--					end
--				else
--					TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
--				end
--			end
--		end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /informante
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("informante",function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local policiais = vRP.getUsersByPermission("policia.permissao")
	if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) then
		return
	end
	if vCLIENT.checkDistance(source,-68.35,-1208.98,28.24,2.5) then 
		if vRP.tryGetInventoryItem(user_id,"dinheirosujo",150000) then
			TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$500.000 dólares sujos</b>, pelas informações dos policiais.")
			TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..#policiais.." Policiais</b> em serviço.<br>")
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa de <b>$500.000 Dinheiro Sujo</b> para pegar essa informação.")
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ PTR ]----------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('testepm', function(source, args, rawCmd)
--	local players1 = vRP.SetadosPolicia('norte')
--	local players2 = vRP.SetadosPolicia('sul')
--	local players3 = vRP.SetadosPolicia('aluno')
--	for k, v in pairs(players1) do
--		print(k,v)
--	end
--	for k, v in pairs(players2) do
--		print(k,v)
--	end
--	for k, v in pairs(players3) do
--		print(k,v)
--	end
--end)

RegisterCommand('ptr', function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("policia.permissao")
	local policiais = 0
	local oficiais_nomes = ""
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			policiais = policiais + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..policiais.." Oficiais</b> em serviço.")
			if parseInt(policiais) > 0 then
				TriggerClientEvent("Notify",source,"importante", oficiais_nomes)
		end
	end
end)
--RegisterCommand('ptr', function(source,args,rawCommand)
--	if not exports["chat"]:statusChatServer(source) then return end
--	local user_id = vRP.getUserId(source)
--	local player = vRP.getUserSource(user_id)
--	local oficiais = vRP.getUsersByPermission("policia.permissao")
--	local paramedicos = 0
--	local oficiais_nomes = ""
--	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
--	   if not args[1] then
--		   for k,v in pairs(oficiais) do
--			   local identity = vRP.getUserIdentity(parseInt(v))
--			   oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
--			   paramedicos = paramedicos + 1
--		   end
--		   TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Oficiais</b> em serviço.")
--		   if parseInt(paramedicos) > 0 then
--			   TriggerClientEvent("Notify",source,'importante',"Oficiais em Serviço", oficiais_nomes)
--		   end
--	   else
--		   local grp = string.lower(args[1])
--		   if grp == 'sul' or grp == 'aluno' then
--		   --if grp == 'norte' or grp == 'sul' or grp == 'aluno' then
--			   local listaPtr = vRP.SetadosPolicia(grp)
--			   for k,v in pairs(listaPtr) do
--				   local identity = vRP.getUserIdentity(parseInt(k))
--				   if identity then
--					   oficiais_nomes = oficiais_nomes .. "<b>" .. parseInt(k) .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
--					   paramedicos = paramedicos + 1
--				   end
--			   end
--			   TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." oficiais " .. grp .. "</b> em serviço.")
--			   if parseInt(paramedicos) > 0 then
--				   TriggerClientEvent("Notify",source,'importante',"Oficiais em Serviço", oficiais_nomes)
--			   end
--		   end
--	   end
--	end
--end)

--RegisterCommand('ptr2', function(source,args,rawCommand)
--	if not exports["chat"]:statusChatServer(source) then return end
--	local user_id = vRP.getUserId(source)
--	local player = vRP.getUserSource(user_id)
--	local oficiais = vRP.getUsersByPermission("policiaacao.permissao")
--	local paramedicos = 0
--	local oficiais_nomes = ""
--	if vRP.hasPermission(user_id,"policiaacao.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
--		for k,v in ipairs(oficiais) do
--			local identity = vRP.getUserIdentity(parseInt(v))
--			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
--			paramedicos = paramedicos + 1
--		end
--		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Oficiais</b> em ação.")
--		if parseInt(paramedicos) > 0 then
--			TriggerClientEvent("Notify",source,'importante',"Oficiais em Ação", oficiais_nomes)
--		end
--	end
--end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[ T2 ]----------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('t2', function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
   local user_id = vRP.getUserId(source)
   local player = vRP.getUserSource(user_id)
   local oficiais = vRP.getUsersByPermission("policiaacao.permissao")
   local policiais = 0
   local oficiais_nomes = ""
   if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao")  then
	   for k,v in ipairs(oficiais) do
		   local identity = vRP.getUserIdentity(parseInt(v))
		   oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
		   policiais = policiais + 1
	   		end
	   		TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..policiais.." Oficiais</b> em toogle2.")
	   		if parseInt(policiais) > 0 then
		   		TriggerClientEvent("Notify",source,"importante", oficiais_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMS
 ----------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand('ems', function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local medicos = vRP.getUsersByPermission("medico.permissao") 
	local paramedicos = 0
	local medicos_nomes = ""
	if vRP.hasPermission(user_id,"medico.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		for k,v in ipairs(medicos) do
			local identity = vRP.getUserIdentity(parseInt(v))
			medicos_nomes = medicos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			paramedicos = paramedicos + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Medicos</b> em serviço.")
			if parseInt(paramedicos) > 0 then
				TriggerClientEvent("Notify",source,"importante", medicos_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MECS
 ----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mecs', function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local mecanicos = vRP.getUsersByPermission("mecanico.permissao")
	local paramedicos = 0
	local mecanicos_nomes = ""
	if vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		for k,v in ipairs(mecanicos) do
			local identity = vRP.getUserIdentity(parseInt(v))
			mecanicos_nomes = mecanicos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			paramedicos = paramedicos + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Mecânicos</b> em serviço.")
			if parseInt(paramedicos) > 0 then
				TriggerClientEvent("Notify",source,"importante", mecanicos_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MECS
 ----------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand('bennys', function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local mecanicos = vRP.getUsersByPermission("bennys.permissao")
	local paramedicos = 0
	local mecanicos_nomes = ""
	if vRP.hasPermission(user_id,"bennys.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		for k,v in ipairs(mecanicos) do
			local identity = vRP.getUserIdentity(parseInt(v))
			mecanicos_nomes = mecanicos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			paramedicos = paramedicos + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Bennys</b> em serviço.")
			if parseInt(paramedicos) > 0 then
				TriggerClientEvent("Notify",source,"importante", mecanicos_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /p
-----------------------------------------------------------------------------------------------------------------------------------------
local policia = {}
local acaopolicia = {}
local paramedico = {}
RegisterServerEvent('waze:1020Police')
AddEventHandler('waze:1020Police',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) then
		return
	end
	if vRP.hasPermission(user_id,"policia.permissao") then
		local policia = vRP.getUsersByPermission("policia.permissao") 
		for l,w in pairs(policia) do
			local npolicia = vRP.getUserSource(parseInt(w))
			if npolicia and npolicia ~= uplayer then
				async(function()
					local id = idgens:gen()
					policia[id] = vRPclient.addBlip(npolicia,x,y,z,153,84,"Localização de "..identity.name.." "..identity.firstname,0.5,false)
					TriggerClientEvent("Notify",npolicia,"importante","Localização recebida de <b>"..identity.name.." "..identity.firstname.."</b>.")
					vRPclient._playSound(npolicia,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					SetTimeout(60000,function() vRPclient.removeBlip(npolicia,policia[id]) idgens:free(id) end)
				end)
			end
		end
		TriggerClientEvent("Notify",source,"sucesso","Localização enviada com sucesso.")
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
	end
	if vRP.hasPermission(user_id,"medico.permissao") then
		local paramedico = vRP.getUsersByPermission("medico.permissao")
		for l,w in pairs(paramedico) do
			local nparamedico = vRP.getUserSource(parseInt(w))
			if nparamedico and nparamedico ~= uplayer then
				async(function()
					local id = idgens:gen()
					paramedico[id] = vRPclient.addBlip(nparamedico,x,y,z,153,61,"Localização de "..identity.name.." "..identity.firstname,0.5,false)
					TriggerClientEvent("Notify",nparamedico,"importante","Localização recebida de <b>"..identity.name.." "..identity.firstname.."</b>.")
					vRPclient._playSound(nparamedico,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					SetTimeout(60000,function() vRPclient.removeBlip(nparamedico,paramedico[id]) idgens:free(id) end)
				end)
			end
		end
		TriggerClientEvent("Notify",source,"sucesso","Localização enviada com sucesso.")
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.hasPermission(user_id, "policia.permissao") then
					TriggerClientEvent('chatMessage',-1,"DEPOL | "..identity.name.." "..identity.firstname.." (#"..identity.user_id..") ",{65,130,255},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.hasPermission(user_id, "medico.permissao") then
					TriggerClientEvent('chatMessage',-1,"SMC | "..identity.name.." "..identity.firstname.." (#"..identity.user_id..") ",{255,70,135},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /PD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pd',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "chatpolicia.permissao"
		local vida = vRPclient.getHealth(source)

		if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
		if vRP.hasPermission(user_id,permission,permission2) then
			local soldado = vRP.getUsersByPermission(permission,permission2)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
					--	TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{64,179,255},string.sub(rawCommand, 4))
						TriggerClientEvent('chatMessage',player,"SPD - "..identity.name.." "..identity.firstname.." (#"..identity.user_id..")",{64,179,255},string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						exports["waze-system"]:sendLogs(user_id,{ webhook = "NomedaLog", text = "Enviou uma mensagem no chat da polícia\nMensagem: "..Mensagem })
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pr',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "medico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('toogle',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local funcionais = vRP.getInventoryItemAmount(user_id,'funcionalpol')


	if vRP.hasPermission(user_id,"policia.permissao") then
		if funcionais > 0 then
			vRP.tryGetInventoryItem(user_id,'funcionalpol',funcionais)
		end
		TriggerEvent("vrp_blipsystem:serviceExit",source)
		vRP.addUserGroup(user_id,"paisanapolicia")
		--vRP.DelSetPolicia(user_id)
		TriggerClientEvent("Notify",source,'aviso',"Você saiu de serviço.")
		exports["waze-system"]:sendLogs(user_id,{ webhook = "policeToogle", text = "Saiu de serviço" })		--TriggerClientEvent('desligarRadios',source)

	elseif vRP.hasPermission(user_id,"paisanapolicia.permissao") then
		--if not args[1] then
		--	--TriggerClientEvent('Notify', source, 'negado', 'DEPOL', 'Você precisa especificar <b>norte</b>, <b>sul</b> ou <b>aluno</b>.')
		--	TriggerClientEvent('Notify', source, 'negado', 'DEPOL', 'Você precisa especificar <b>sul</b> ou <b>aluno</b>.')
		--	return
		--end

		--local grupo = string.lower(args[1])
		--if grupo == 'sul' or grupo == 'aluno' then
		--if grupo == 'norte' or grupo == 'sul' or grupo == 'aluno' then

			--vRP.AddSetPolicia(grupo, user_id)
				
			if funcionais <= 0 then
				vRP.giveInventoryItem(user_id,'funcionalpol',1)
			end
			TriggerEvent("vrp_blipsystem:serviceEnter",source,"Policial",51)
			vRP.addUserGroup(user_id,"policia")
			TriggerClientEvent('Notify', source, 'aviso', 'Você entrou em serviço como oficial <b>Policia</b>.')
			exports["waze-system"]:sendLogs(user_id,{ webhook = "policeToogle", text = "Entrou em serviço" })		--end

	elseif vRP.hasPermission(user_id,"medico.permissao") then
		TriggerEvent("vrp_blipsystem:serviceExit",source)
		vRP.addUserGroup(user_id,"paisanamedico")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
		exports["waze-system"]:sendLogs(user_id,{ webhook = "hospitalToogle", text = "Saiu de serviço" })		
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"paisanamedico.permissao") then
		TriggerEvent("vrp_blipsystem:serviceEnter",source,"Medico Sul",61)
		vRP.addUserGroup(user_id,"medico")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		exports["waze-system"]:sendLogs(user_id,{ webhook = "hospitalToogle", text = "Entrou em serviço" })

	elseif vRP.hasPermission(user_id,"mecanico.permissao") then
		vRP.addUserGroup(user_id,"paisanamecanico")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
		exports["waze-system"]:sendLogs(user_id,{ webhook = "mecToogle", text = "Saiu de serviço" })		
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"paisanamecanico.permissao") then
		vRP.addUserGroup(user_id,"mecanico")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		exports["waze-system"]:sendLogs(user_id,{ webhook = "mecToogle", text = "Entrou em serviço" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('toogle2',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local funcionais = vRP.getInventoryItemAmount(user_id,'funcionalpol')

	if vRP.hasPermission(user_id,"policia.permissao") and vRPclient.getHealth(source) > 101 then

		if funcionais <= 0 then
			vRP.giveInventoryItem(user_id,'funcionalpol',1)
		end
		--vRP.DelSetPolicia(user_id)
		vRP.addUserGroup(user_id,"policiaacao")
		TriggerEvent("vrp_blipsystem:serviceEnter",source,"Policial",25)
		TriggerClientEvent("Notify",source,'aviso',"Você entrou na ação.")
		exports["waze-system"]:sendLogs(user_id,{ webhook = "policeToogle", text = "Entrou em ação" })		--TriggerClientEvent('desligarRadios',source)

	elseif vRP.hasPermission(user_id,"policiaacao.permissao") and vRPclient.getHealth(source) > 101 then

		--if not args[1] then
		--	--TriggerClientEvent('Notify', source, 'negado', 'DEPOL', 'Você precisa especificar <b>norte</b>, <b>sul</b> ou <b>aluno</b>.')
		--	TriggerClientEvent('Notify', source, 'negado', 'DEPOL', 'Você precisa especificar <b>sul</b> ou <b>aluno</b>.')
		--	return
		--end

		--local grupo = string.lower(args[1])
		--if grupo == 'sul' or grupo == 'aluno' then
		--if grupo == 'norte' or grupo == 'sul' or grupo == 'aluno' then

			--vRP.AddSetPolicia(grupo, user_id)
			if funcionais > 0 then
				vRP.tryGetInventoryItem(user_id,'funcionalpol',funcionais)
			end
			TriggerEvent("vrp_blipsystem:serviceEnter",source,"Policial",25)
			vRP.addUserGroup(user_id,"policia")
			TriggerClientEvent("Notify",source,'aviso',"Você saiu da ação.")
			exports["waze-system"]:sendLogs(user_id,{ webhook = "policeToogle", text = "Saiu de ação" })		--end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETIDO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('detido',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
    if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") then
        local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,5)
        local motivo = vRP.prompt(source,"Motivo:","")
        if motivo == "" then
			return
		end
		local oficialid = vRP.getUserIdentity(user_id)
        if vehicle then
            local puser_id = vRP.getUserByRegistration(placa)
            local rows = vRP.query("creative/get_vehicles",{ user_id = parseInt(puser_id), vehicle = vname })
            if rows[1] then
                if parseInt(rows[1].detido) == 1 then
					if vRP.request(source, 'Esse veículo já se encontra detido, deseja soltá-lo?', 30) then
						local identity2 = vRP.getUserIdentity(puser_id)
						local nplayer = vRP.getUserSource(parseInt(puser_id))
						exports["waze-system"]:sendLogs(user_id,{ webhook = "NomedaLog", text = "Retirou o veículo "..vname.." de ("..puser_id..") "..identity2.name.." "..identity2.firstname.." da detenção pelo motivo: "..motivo })
						exports["waze-system"]:sendLogs(user_id,{ webhook = "NomedaLog", text = "Retirou o veículo "..vname.." de ("..puser_id..") "..identity2.name.." "..identity2.firstname.." da detenção pelo motivo: "..motivo })
						vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 0, time = 0 })

						TriggerClientEvent("Notify",source,"sucesso","Carro solto com sucesso.")
						TriggerClientEvent("Notify",nplayer,"importante","Seu Veículo foi <b>SOLTO</b>.<br><b>Motivo:</b> "..motivo..".")
						vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
					end
                else
                	local identity2 = vRP.getUserIdentity(puser_id)
                	local nplayer = vRP.getUserSource(parseInt(puser_id))
					exports["waze-system"]:sendLogs(user_id,{ webhook = "NomedaLog", text = "Adicionou o veículo "..vname.." de ("..puser_id..") "..identity2.name.." "..identity2.firstname.." para a detenção pelo motivo: "..motivo })
					exports["waze-system"]:sendLogs(user_id,{ webhook = "NomedaLog", text = "Adicionou o veículo "..vname.." de ("..puser_id..") "..identity2.name.." "..identity2.firstname.." para a detenção pelo motivo: "..motivo })
                    vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 1, time = parseInt(os.time()) })

					randmoney = math.random(300,600)
					vRP.giveMoney(user_id,parseInt(randmoney))
					TriggerClientEvent("Notify",source,"sucesso","Carro apreendido com sucesso.")
					TriggerClientEvent("Notify",source,"importante","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
					TriggerClientEvent("Notify",nplayer,"importante","Seu Veículo foi <b>DETIDO</b>.<br><b>Motivo:</b> "..motivo..".")
					vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
                end
            end
        end
    end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- RG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rg",function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer == nil then
					TriggerClientEvent("Notify",source,"aviso","Passaporte <b>"..vRP.format(args[1]).."</b> indisponível no momento.")
					return
				end
				local nuser_id = parseInt(args[1])
				local identity = vRP.getUserIdentity(nuser_id)
				if identity then
					local fines = vRP.getUData(nuser_id,"vRP:multas")
					local price = json.decode(fines) or 0
					local cash = vRP.getMoney(nuser_id)
					
					if vRP.hasPermission(nuser_id,"ceo.permissao") then
						local waze = math.random(500,7000)
						TriggerClientEvent("Notify",source,"importante","<b>Passaporte:</b> "..vRP.format(tostring(waze)).."<br><b>Nome:</b> "..identity.name.." "..identity.firstname.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Carteira:</b> $"..vRP.format(parseInt(cash)).."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(price)),20000)
					else
						TriggerClientEvent("Notify",source,"importante","<b>Passaporte:</b> "..vRP.format(identity.user_id).."<br><b>Nome:</b> "..identity.name.." "..identity.firstname.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Carteira:</b> $"..vRP.format(parseInt(cash)).."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(price)),20000)
					end
					
				end
			else
				local nplayer = vRPclient.getNearestPlayer(source,2)
				if nplayer then
					local nuser_id = vRP.getUserId(nplayer)
					if nuser_id then
						local identity = vRP.getUserIdentity(nuser_id)
						local data = vRP.getUserIdentity(user_id)
						if identity then
							local fines = vRP.getUData(nuser_id,"vRP:multas")
							local price = json.decode(fines) or 0
							local cash = vRP.getMoney(nuser_id)
							if vRP.hasPermission(nuser_id,"ceo.permissao") then
								local waze = math.random(500,7000)
								TriggerClientEvent("Notify",nplayer,"aviso","Seu documento está sendo verificado por <b>"..data.name.." "..data.firstname.."</b>.")
								TriggerClientEvent("Notify",source,"importante","<b>Passaporte:</b> "..vRP.format(tostring(waze)).."<br><b>Nome:</b> "..identity.name.." "..identity.firstname.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Carteira:</b> $"..vRP.format(parseInt(cash)).."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(price)),20000)
							else
								TriggerClientEvent("Notify",source,"importante","<b>Passaporte:</b> "..vRP.format(identity.user_id).."<br><b>Nome:</b> "..identity.name.." "..identity.firstname.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Carteira:</b> $"..vRP.format(parseInt(cash)).."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(price)),20000)
								TriggerClientEvent("Notify",nplayer,"aviso","Seu documento está sendo verificado por <b>"..data.name.." "..data.firstname.."</b>.")
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('al',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if not vRPclient.isHandcuffed(source) then
			if vRP.getInventoryItemAmount(user_id,"algemas") >= 1 then
				if vRPclient.isHandcuffed(nplayer) then
					vRPclient._playAnim(source,false,{"mp_arresting","a_uncuff"},false)
					SetTimeout(5000,function()
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
						TriggerClientEvent('removealgemas',nplayer)
					end)
				else
					TriggerClientEvent("cancelando",source,true)
					TriggerClientEvent('cancelando',nplayer,true)
					vRPclient._playAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)
					vRPclient._playAnim(nplayer,false,{"mp_arrest_paired","crook_p2_back_left"},false)
					SetTimeout(3500,function()
						vRPclient._stopAnim(source,false)
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent("cancelando",source,false)
						TriggerClientEvent("cancelando",nplayer,false)
						TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
						TriggerClientEvent('setalgemas',nplayer)
					end)
				end
			else
				if vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao")  then	
					if vRPclient.isHandcuffed(nplayer) then
						vRPclient._playAnim(source,false,{"mp_arresting","a_uncuff"},false)
						SetTimeout(5000,function()
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
							TriggerClientEvent('removealgemas',nplayer)
						end)
					else
						TriggerClientEvent("cancelando",source,true)
						TriggerClientEvent('cancelando',nplayer,true)
						vRPclient._playAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)
						vRPclient._playAnim(nplayer,false,{"mp_arrest_paired","crook_p2_back_left"},false)
						SetTimeout(3500,function()
							vRPclient._stopAnim(source,false)
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent("cancelando",source,false)
							TriggerClientEvent("cancelando",nplayer,false)
							TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
							TriggerClientEvent('setalgemas',nplayer)
						end)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('se',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") or vRP.hasPermission(user_id,"medico.permissao") then	
		if nplayer then
			if not vRPclient.isHandcuffed(source) then
				vCLIENT.CarregarDif(nplayer,source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:carregaradm")
AddEventHandler("vrp_policia:carregaradm",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao")  or vRP.hasPermission(user_id,"suporte.permissao") then
		if nplayer then
			if not vRPclient.isHandcuffed(source) then
				TriggerClientEvent('carregar',nplayer,source)
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CINTO 
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cinto', function(source, args, rawCmd)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") or vRP.hasPermission(user_id,"medico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('waze:PoliciaToggleCinto', nplayer, source)
		else
			TriggerClientEvent('Notify', source, 'negado', 'Não há ninguém perto de você.')
		end
	end
end)

RegisterServerEvent('waze:AvisarCintoPolicia')
AddEventHandler('waze:AvisarCintoPolicia', function(nsource, StatusCinto)
	if StatusCinto == 'semcinto' then
		TriggerClientEvent('Notify', nsource, 'sucesso', 'O cinto foi retirado do indivíduo.')
	elseif StatusCinto == 'comcinto' then
		TriggerClientEvent('Notify', nsource, 'sucesso', 'O cinto foi colocado no indivíduo.')
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rmascara',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao")  then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rmascara',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rchapeu',function(source,args,rawCommand)
	local source = source
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rchapeu',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rcapuz',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isCapuz(nplayer) then
				vRPclient.setCapuz(nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Capuz retirado com sucesso.")
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa não está com o capuz na cabeça.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cv',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 and not vRPclient.isHandcuffed(source) then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vCLIENT.putVehicle(nplayer,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rv',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 and not vRPclient.isHandcuffed(source) then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	"dinheirosujo",
	"radio",
	"algemas",
	"lockpick",
	"capuz",
	"placa",
	"c4",
	"acidobateria",
	"pecadearma",
	"alvejante",
	"alvejantemodificado",
	"materialmunicao",
	"pseudoefedrina",
	"eter",
	"anfetamina",
	"metanfetamina",
	"cocamisturada",
	"cocaina",
	"folhadecoca",
	"querosene",
	"baseado",
	--"maconha",
	"folhademaconha",
	"maconhamacerada",
	"pecadominacao",
	"lancaperfume",
	"materialmunicao",
	"fertilizante",
	"adubo",
	"molas",
	"placa-metal",
	"gatilho",
	"capsulas",
	"polvora",
	"cordas",
	"material9mm",
	"material762",
	"capsula9mm",
	"capsula762",
	"polvora762",
	"polvora9mm",
	"armacaodearma",

	"wbody|WEAPON_DAGGER",
	"wbody|WEAPON_BAT",
	"wbody|WEAPON_BOTTLE",
	"wbody|WEAPON_CROWBAR",
	"wbody|WEAPON_FLASHLIGHT",
	"wbody|WEAPON_GOLFCLUB",
	"wbody|WEAPON_HAMMER",
	"wbody|WEAPON_HATCHET",
	"wbody|WEAPON_KNUCKLE",
	"wbody|WEAPON_KNIFE",
	"wbody|WEAPON_MACHETE",
	"wbody|WEAPON_SWITCHBLADE",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_WRENCH",
	"wbody|WEAPON_BATTLEAXE",
	"wbody|WEAPON_POOLCUE",
	--"wbody|WEAPON_STONE_HATCHET",
	"wbody|WEAPON_PISTOL",
	"wbody|WEAPON_COMBATPISTOL",
	"wbody|WEAPON_CARBINERIFLE",
	"wbody|WEAPON_SAWNOFFSHOTGUN",
	"wbody|WEAPON_PUMPSHOTGUN",
	"wbody|WEAPON_STUNGUN",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_SNSPISTOL",
	"wbody|WEAPON_SPECIALCARBINE_MK2",
	"wbody|WEAPON_ASSAULTRIFLE_MK2",
	"wbody|WEAPON_FIREEXTINGUISHER",
	"wbody|WEAPON_FLARE",
	"wbody|WEAPON_HEAVYPISTOL",
	"wbody|WEAPON_PISTOL_MK2",
	"wbody|WEAPON_VINTAGEPISTOL",
	"wbody|WEAPON_MUSKET",
	"wbody|WEAPON_GUSENBERG",
	"wbody|WEAPON_ASSAULTSMG",
	"wbody|WEAPON_COMBATPDW",
	"wbody|WEAPON_COMPACTRIFLE",
	"wbody|WEAPON_CARBINERIFLE_MK2",
 	"wbody|WEAPON_MACHINEPISTOL",
	"wbody|WEAPON_SMG_MK2",
	"wammo|WEAPON_DAGGER",
	"wammo|WEAPON_BAT",
	"wammo|WEAPON_BOTTLE",
	"wammo|WEAPON_CROWBAR",
	"wammo|WEAPON_FLASHLIGHT",
	"wammo|WEAPON_GOLFCLUB",
	"wammo|WEAPON_HAMMER",
	"wammo|WEAPON_HATCHET",
	"wammo|WEAPON_KNUCKLE",
	"wammo|WEAPON_KNIFE",
	"wammo|WEAPON_MACHETE",
	"wammo|WEAPON_SWITCHBLADE",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_WRENCH",
	"wammo|WEAPON_BATTLEAXE",
	"wammo|WEAPON_POOLCUE",
	--"wammo|WEAPON_STONE_HATCHET",
	"wammo|WEAPON_PISTOL",
	"wammo|WEAPON_COMBATPISTOL",
	"wammo|WEAPON_CARBINERIFLE",
	"wammo|WEAPON_SAWNOFFSHOTGUN",
	"wammo|WEAPON_SPECIALCARBINE_MK2",
	"wammo|WEAPON_PUMPSHOTGUN",
	"wammo|WEAPON_STUNGUN",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_SNSPISTOL",
	"wammo|WEAPON_MICROSMG",
	"wammo|WEAPON_ASSAULTRIFLE_MK2",
	"wammo|WEAPON_FIREEXTINGUISHER",
	"wammo|WEAPON_FLARE",
	"wammo|WEAPON_HEAVYPISTOL",
	"wammo|WEAPON_REVOLVER",
	"wammo|WEAPON_PISTOL_MK2",
	"wammo|WEAPON_VINTAGEPISTOL",
	"wammo|WEAPON_MUSKET",
	"wammo|WEAPON_GUSENBERG",
	"wammo|WEAPON_ASSAULTSMG",
	"wammo|WEAPON_COMBATPDW",
	"wammo|WEAPON_MACHINEPISTOL",
	"wammo|WEAPON_CARBINERIFLE_MK2",
	"wammo|WEAPON_COMPACTRIFLE",
	"wammo|WEAPON_SMG_MK2"
}

RegisterCommand('apreender',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		local user_id = vRP.getUserId(source)

		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local identity = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				vRPclient.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)
				SetTimeout(5000, function()
					vRPclient.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},false)
					if vRPclient.FazendoAnim(source, "oddjobs@shop_robbery@rob_till","loop") then
						
						local nidentity = vRP.getUserIdentity(nuser_id)
						local itens_apreendidos = ''
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							end
						end
		
						local inv = vRP.getInventory(nuser_id)
						for k,v in pairs(itemlist) do
							local sub_items = { v }
							if string.sub(v,1,1) == "*" then
								local idname = string.sub(v,2)
								sub_items = {}
								for fidname,_ in pairs(inv) do
									if splitString(fidname,"|")[1] == idname then
										sub_items[#sub_items + 1] = fidname
									end
								end
							end
		
							for _,idname in pairs(sub_items) do
								local amount = vRP.getInventoryItemAmount(nuser_id,idname)
								if amount > 0 then
									if vRP.tryGetInventoryItem(nuser_id,idname,amount,true) then
										vRP.giveInventoryItem(user_id,idname,amount)
										itens_apreendidos = itens_apreendidos .. "[ITEM]: "..vRP.itemNameList(idname) .." [QUANTIDADE]: "..amount .. '\n'
									end
								end
							end
						end
						exports["waze-system"]:sendLogs(user_id,{ webhook = "adminSeize", text = "Apreendeu ("..nuser_id..") "..nidentity.name.." "..nidentity.firstname.."\nApreensão: \n"..itens_apreendidos })
						exports["waze-system"]:sendLogs(user_id,{ webhook = "policeSeize", text = "Apreendeu ("..nuser_id..") "..nidentity.name.." "..nidentity.firstname.."\nApreensão: \n"..itens_apreendidos })
						TriggerClientEvent('Notify', source, 'sucesso', 'Objetos apreendidos.')
					end
				end)
				
				TriggerClientEvent("Notify",nplayer,"importante","Todos os seus pertences foram apreendidos.")
				TriggerClientEvent("Notify",source,"importante","Apreendeu todos os pertences da pessoa.")
			end
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('atirando')
AddEventHandler('atirando',function(x,y,z)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"policiadroga.permissao") then
			local policiais = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(policiais) do
				local player = vRP.getUserSource(w)
				if player then
					TriggerClientEvent('notificacao',player,x,y,z,user_id)
				end
			end
		end
	end
end)

function src.toogle2obito()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policiaacao.permissao") then
			if vRPclient.CheckSegundosMorto(source) > 40 then
				if vRPclient.isInComa(source) then
					vRPclient.SetSegundosMorto(source, 40)
				end
			end
		end
	end
end

function src.toogle1obito()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			if vRPclient.CheckSegundosMorto(source) > 60 then
				if vRPclient.isInComa(source) then
					vRPclient.SetSegundosMorto(source, 60)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('anuncio',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"medico.permissao") or vRP.hasPermission(user_id,"news.permissao") then
			local mensagem = vRP.prompt(source,"Mensagem:","")
			if mensagem == "" then
				return
			end
			if vRP.hasPermission(user_id,"policia.permissao") then
			TriggerClientEvent("Notify",-1,"waze POLICE DEPARTMENT",mensagem.."<br><b>Mensagem enviada por:</b> "..identity.name.." "..identity.firstname.." ("..user_id..")",30000)
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminAnnounce", text = "waze Police Department\nEnviou um anúncio com a mensagem: "..mensagem })
			elseif vRP.hasPermission(user_id,"medico.permissao") then
			TriggerClientEvent("Notify",-1,"SAINT KASHI HOSPITAL",mensagem.."<br><b>Mensagem enviada por:</b> "..identity.name.." "..identity.firstname.." ("..user_id..")",30000)
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminAnnounce", text = "Saint Kashi Hospital\nEnviou um anúncio com a mensagem: "..mensagem })
			elseif vRP.hasPermission(user_id,"news.permissao") then
			TriggerClientEvent("Notify",-1,"waze NEWS",mensagem.."<br><b>Mensagem enviada por:</b> "..identity.name.." "..identity.firstname.." ("..user_id..")",30000)
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminAnnounce", text = "waze News\nEnviou um anúncio com a mensagem: "..mensagem })
			end
		end
	end
end)

function src.CheckPolice()
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,'policia.permissao')
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('polfit',function(source,args,rawCmd)
	if not exports["chat"]:statusChatServer(source) then return end
	local source = source 
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"suporte.permissao") then
			local customOutfit = vRPclient.getCustomPlayer(source)
				if customOutfit then
					vRP.prompt(source,"Preset:",json.encode(customOutfit))
			end
		end
	end
end)
------------------------------------------------------------------------------
-- 30s
------------------------------------------------------------------------------
RegisterCommand('30s', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasGroup(user_id, 'policia') or vRP.hasGroup(user_id, 'policiaacao') then
		local nsource = vRPclient.getNearestPlayer(source, 5)
		if nsource then
			local nuser_id = vRP.getUserId(nsource)
			local nidentity = vRP.getUserIdentity(nuser_id)
			TriggerClientEvent('Notify', source, "aviso", 'Solicitação dos 30 segundos enviado ao jogador mais próximo.')
			if vRP.request(nsource, 'Deseja iniciar uma contagem de <b>30 segundos<b>?', 15) then
				TriggerClientEvent('Notify', source, "aviso",  'Contagem de 30s iniciada com '.. nidentity.name .. ' ' .. nidentity.firstname .. '.')
				TriggerClientEvent('Notify', nsource, "aviso", 'Contagem de 30s iniciada com '.. identity.name .. ' ' .. identity.firstname .. '.')
				SetTimeout(30000, function()
					TriggerClientEvent('Notify', source, "aviso", 'AÇÃO VALENDO!')
					TriggerClientEvent('Notify', nsource, "aviso", 'AÇÃO VALENDO!')
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if vRP.hasGroup(user_id,"policia") then 
		vRP.addUserGroup(user_id,"paisanapolicia")
	end

	if vRP.hasGroup(user_id,"medico") then 
		vRP.addUserGroup(user_id,"paisanamedico")
	end
end)

--function src.ehPolicial()
--    local user_id = vRP.getUserId(source)
--    if vRP.hasPermission(user_id, 'policia.permissao') or vRP.hasPermission(user_id, 'paisanapolicia.permissao') then 
--        return true 
--    else
--        return false
--    end
--end