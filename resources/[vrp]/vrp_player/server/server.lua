-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local Tools = module("vrp","lib/Tools")

local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_player",src)
vCLIENT = Tunnel.getInterface("vrp_player")
vPOLICE = Tunnel.getInterface("vrp_policia")
client = Tunnel.getInterface("vrp_player",client)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
statusGarmas = {}
statusPaypal = {}
local garmas_user = {}
local SendChamados = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkRoupas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,"wazeelite.permissao") or vRP.hasPermission(user_id,"waze.permissao") or vRP.hasPermission(user_id,"ceo.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Roupas Secundárias</b> na mochila.") 
			return false
		end
	end
end

--function src.checkPermVip()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		if vRP.hasPermission(user_id,"wazeelite.permissao") or vRP.hasPermission(user_id,"ceo.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
--			return true 
--		else
--			TriggerClientEvent("Notify",source,"negado","Você não possui <b>VIP waze ELITE</b>.") 
--			return false
--		end
--	end
--end

function sendChat(message)
	local adminDisplay = vRP.getUsersByPermission("suporte.permissao")
        for l,w in pairs(adminDisplay) do
        local adminSource = vRP.getUserSource(parseInt(w))
        local admin_id = vRP.getUserId(adminSource)
            async(function()
            TriggerClientEvent('chatMessage',adminSource,"["..os.date("%H:%M:%S").."] "..message,{102, 204, 255})
            end)
    end
end

function src.CheckBooster()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"booster.permissao") or vRP.hasPermission(user_id,"streamer.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Booster</b>.") 
			return false
		end
	end
end

function src.PossuiCompArma()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if --[[isBooster[user_id] or--]] vRP.getInventoryItemAmount(user_id,"compattach") >= 1 or vRP.hasPermission(user_id,"wazeelite.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") or vRP.hasPermission(user_id,"streamer.permissao") or vRP.hasPermission(user_id,"booster.permissao") or vRP.hasPermission(user_id,"waze.permissao") or vRP.hasPermission(user_id,"ceo.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
			return true 
		end
	end
end

--function src.CheckVip()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		if vRP.hasPermission(user_id,"wazeelite.permissao") or vRP.hasPermission(user_id,"ceo.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
--			return true 
--		end
--	end
--end
function src.CheckVip(qualVip)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, 'suporte.permissao') then return true end
		if qualVip == 'ambos' then
			if vRP.hasPermission(user_id, 'wazeelite.permissao') or vRP.hasPermission(user_id, 'waze.permissao') then 
				return true
			end
		elseif qualVip == 'elite' then
			if vRP.hasPermission(user_id, 'wazeelite.permissao') then 
				return true
			end
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserIdentity(user_id)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			local identity = vRP.getUserIdentity(nuser_id)
			local random = math.random(500,9999)
			if identity then
				if vRP.hasPermission(nuser_id,'ceo.permissao') then
					TriggerClientEvent("Notify",nplayer,"aviso","<b>"..data.user_id.." - "..data.name.." "..data.firstname.."</b> pegou seu ID.")
					TriggerClientEvent("Notify",source,"aviso","Passaporte: <b>("..vRP.format(random)..")</b>")
				else
					TriggerClientEvent("Notify",source,"aviso","Passaporte: <b>("..vRP.format(identity.user_id)..")</b>")
				end
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------
-- /REVISTAR
------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local vida = vRPclient.getHealth(source)

	if client.CheckEstaEmCarro(source) then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso dentro de um veículo.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if nuser_id then
		print("ID " .. user_id .. ' revistou ' .. nuser_id)
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)

		TriggerClientEvent('cancelando',source,true)
		TriggerClientEvent('cancelando',nplayer,true)
		-- TriggerClientEvent('carregar',nplayer,source)
		vRPclient._playAnim(nplayer,false,{"random@mugging3","handsup_standing_base"},true)
		TriggerClientEvent("progress",source,5000,"revistando")
		SetTimeout(5000,function()

			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k))
				else
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
				end
			end
			vRPclient._stopAnim(nplayer,false)
			TriggerClientEvent('cancelando',source,false)
			TriggerClientEvent('cancelando',nplayer,false)
			TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		end)
		TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
local salarios = {
	-- VIPS --
	{ "wazeelite.permissao",8000 },
	{ "waze.permissao",5000 },
	-- POLICIA --
	{ "policia.permissao",5000 },
	{ "policiaacao.permissao",5500 },
	-- HOSPITAL --
	{ "medico.permissao",8500 },
	-- MECANICO --
	{ "mecanico.permissao",5000 }
}

function src.WekakdjinWKKkdeinIAIASAO()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(parseInt(user_id),v[1]) then
				vRP.giveBankMoney(parseInt(user_id),v[2])
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"financeiro","Obrigado por colaborar com a cidade, seu salario de <b>$"..vRP.format(parseInt(v[2])).." dólares</b> foi depositado.",9500)
				exports["waze-system"]:sendLogs(user_id,{ webhook = "playerSalary", text = "Recebeu salário de $"..vRP.format(parseInt(v[2])).." da permissão "..v[1] })
			end
		end 
	end
end

--[[ function src.WekakdjinWKKkdeinIAIASAOXmas()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		vRP.giveInventoryItem(user_id,'presentedenatal',1)
			TriggerClientEvent("Notify",source,"financeiro","Importante","Você acaba de receber um presente de natal",9500)
			exports["waze-system"]:sendLogs(user_id,{ webhook = "xmas", text = "Recebeu 1x Presente de Natal (60 minutos)" })
	end
end ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trypneus")
AddEventHandler("trypneus",function(nveh)
	TriggerClientEvent("syncpneus",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Rec
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rec",function(source,args)
    if args[1] == nil then
        TriggerEvent("Notify","negado","Selecione uma opção")

    elseif args[1] == "waze" then
        wazeRecording(1)
        TriggerEvent("Notify","sucesso","Começou a gravar")

   elseif args[1] == "save" then
        StopRecordingAndSaveClip()
        TriggerEvent("Notify","sucesso","Salvou o clipe")

    elseif args[1] == "discard" then
        StopRecordingAndDiscardClip()
        TriggerEvent("Notify","sucesso","Descartou o clipe")

    elseif args[1] == "open" then
        NetworkSessionLeaveSinglePlayer()
        ActivateRockstarEditor()
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"admin.permissao") then
        DropPlayer(source,"Voce foi desconectado por ficar ausente.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SEQUESTRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.getHealth(source) <= 101 then 
			TriggerClientEvent("Notify",source,"negado","Você não pode fazer isso agora.")
			return
		end
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /camburao
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('camburao',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id, 'policia.permissao') and not vRP.hasPermission(user_id, 'admin.permissao')  then return end
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		-- if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					-- if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					-- end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		-- else
			-- TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		-- end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('call',function(source,args,rawCmd)
--	if not exports["chat"]:statusChatServer(source) then return end
--	local source = source 
--	local user_id = vRP.getUserId(source)
--	local identity = vRP.getUserIdentity(user_id)
--	local callAnswered = false
--	if user_id then
--		if args[1] ~= "adm" then
--			TriggerClientEvent("Notify",source,"negado","Você só pode utilizar este serviço para entrar em contato com a administração.",5000)
--			return
--		end
--	end
--
--	local request = vRP.prompt(source,"Descrição de seu chamado:","")
--	if request == "" then 
--		return 
--	end
--	
--	local x,y,z = vRPclient.getPosition(source)
--	local amountStaff = vRP.getUsersByPermission("chamadosadm.permissao")
--	
--	vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
--	if #amountStaff <= 0 then 
--		return 
--	end
--	
--	TriggerClientEvent("Notify",source,"sucesso","Seu chamado foi enviado.",5000)
--	for k,v in pairs(amountStaff) do
--		local player = vRP.getUserSource(parseInt(v))
--		if player then
--			local nuser_id = vRP.getUserId(player)
--			async(function()
--				vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
--				TriggerClientEvent('chatMessage',player,"ADMINISTRAÇÃO:",{19,197,43},"(#"..user_id..") "..identity["name"].." "..identity["firstname"]..": "..request)
--				local request2 = vRP.request(player,"Responder ao chamado de <b>"..identity["name"].." "..identity["firstname"].."</b>?",30)
--				if request2 then
--					if not callAnswered then
--						callAnswered = true 
--						local identity2 = vRP.getUserIdentity(nuser_id)
--						TriggerClientEvent("Notify",source,"importante","Chamado atendido pela equipe, aguarde.",5000)
--						sendInfos(identity["name"],identity["firstname"],identity2["name"],identity2["firstname"])
--						vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
--					else
--						TriggerClientEvent("Notify",player,"importante","Chamado ja atendido por outra pessoa.",5000)
--					end 
--				end
--			end)
--		end
--	end
--end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- SENDINFOS
-------------------------------------------------------------------------------------------------------------------------------------------
--function sendInfos(target,target2,name,name2)
--	local amountStaff = vRP.getUsersByPermission("chamadosadm.permissao")
--
--	if #amountStaff <= 0 then
--		return 
--	end
--
--	for k,v in pairs(amountStaff) do
--		local player = vRP.getUserSource(parseInt(v))
--		if player then
--			local nuser_id = vRP.getUserId(source)
--			async(function()
--				TriggerClientEvent('chatMessage',player,"ADMINISTRAÇÃO:",{19,197,43},"Chamado de "..target.." "..target2.." atendido por "..name.." "..name2..".",5000)
--			end) 
--		end
--	end
--end
---- CHAMADO ADMIN
local blips = {}
local AdminsBloqueados = {}

RegisterCommand('call',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local vida = vRPclient.getHealth(source)

	if string.lower(args[1]) ~= 'adm' then TriggerClientEvent('Notify', source, 'negado', 'Você só pode efetuar chamados assim para a administração.') return end

	if not SendChamados and (not vRP.hasPermission(user_id,"xxxxxx.permissao")) then
		TriggerClientEvent('Notify',source,"negado","O chamado admin está bloqueado.")
		return
	end
	
	if user_id then
		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			return
		end

		if string.match(descricao, 'limb') then
			TriggerClientEvent("Notify",source,"importante","Chamados desse tipo <b>NÃO</b> podem ser realizados.")
			return
		end

		if string.match(descricao, 'set') then
			TriggerClientEvent("Notify",source,"importante","Chamados desse tipo <b>NÃO</b> podem ser realizados.")
			return
		end
		local x,y,z = vRPclient.getPosition(source)
		local players = vRP.getUsersByPermission("chamadoadmin.permissao")
		local especialidade = "Administradores"
		
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		if #players <= 0 then
			TriggerClientEvent("Notify",source,"importante","Não há administrador disponível.")
		else
			local identitys = vRP.getUserIdentity(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
			for l,w in pairs(players) do
				local player = vRP.getUserSource(parseInt(w))
				local nuser_id = vRP.getUserId(player)
				if player and player ~= uplayer then
					if not AdminsBloqueados[nuser_id] then
						async(function()
							vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
							TriggerClientEvent('chatMessage',player,string.upper(especialidade),{19,197,43},"["..user_id.."] ^1"..identitys.name.." "..identitys.firstname.."^0: "..descricao)
							local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
							if ok then
								if not answered then
									answered = true
									local identity = vRP.getUserIdentity(nuser_id)
									TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
									TriggerEvent('waze:AvisarTodos', players, especialidade, identitys.name.." "..identitys.firstname, identity.name.." "..identity.firstname)
									vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
									vRPclient._setGPS(player,x,y)
								else
									TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
									vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
								end
							end
							local id = idgens:gen()
							blips[id] = vRPclient.addBlip(player,x,y,z,153,58,"Chamado admin",0.6,false)
							SetTimeout(120000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
						end)
					end
				end
			end
		end
	end
end)

RegisterCommand('chamados', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	--if user_id == 1 or user_id == 0 then
	if vRP.hasPermission(user_id, "chamadoadmin.permissao") then
		if args[1] then
			if args[1] == 'false' then
				AdminsBloqueados[user_id] = true
				TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>desligou</b> os chamados para <b>administração</b>.')
			elseif args[1] == 'true' then
				AdminsBloqueados[user_id] = false
				TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>ligou</b> os chamados para <b>administração</b>.')
			end
		end
	--else
		--TriggerClientEvent('Notify', source, 'negado', 'Somente bilu e bigas.')
	end
end)
RegisterCommand("tooglechamados",function(source,args,rawCmd)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if not vRP.hasPermission(user_id,"admin.permissao") then
		return
	end

	if SendChamados then
		TriggerClientEvent('Notify', source, 'sucesso',"Você  o envio de chamados admin!")
		sendChat("("..user_id..") "..identity.name.." "..identity.firstname.." bloqueou o comando /call adm")
		SendChamados = false
	else
		TriggerClientEvent('Notify', source, 'sucesso',"Você liberou o envio de chamados admin!")
		sendChat("("..user_id..") "..identity.name.." "..identity.firstname.." liberou o comando /call adm")
		SendChamados = true
	end
end)


RegisterServerEvent('waze:AvisarTodos')
AddEventHandler('waze:AvisarTodos', function(players, especialidade, nomePedinte, nomeAtendente)
	for k, v in pairs(players) do
		TriggerClientEvent('chatMessage',vRP.getUserSource(parseInt(v)),string.upper(especialidade),{19,197,43},"Chamado de ^1" .. nomePedinte .." ^0atendido por ^1" .. nomeAtendente)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.hasPermission(user_id, "mecanico.permissao") or vRP.hasPermission(user_id, "bennys.permissao") then
				TriggerClientEvent('chatMessage',-1,"Central Mecânica | "..identity.name.." "..identity.firstname.." ("..user_id..") ",{255,128,0},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mr',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "mecanico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local mec = vRP.getUsersByPermission(permission)
			for l,w in pairs(mec) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,191,128},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- bn
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bn',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"bennys.permissao") then
			local mec = vRP.getUsersByPermission("bennys.permissao")
			for l,w in pairs(mec) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{246, 255, 0},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAQUEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('saquear',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local vida = vRPclient.getHealth(source)
	local job = vRP.getUserGroupByType(user_id,"job")
	local job2 = vRP.getUserGroupByType(nuser_id,"job")
	local value = vRP.getUData(parseInt(user_id),"vRP:multas")
	local multas = json.decode(value) or 0
	if multas >= 10000 then
		TriggerClientEvent("Notify",source,"negado","Você tem multas pendentes.",10000)
		return true
	end

	if vRP.hasPermission(user_id,"policiasaque.permissao") then 
		TriggerClientEvent("Notify",source,"negado","Você não está permitido a saquear!") 
		return 
	end

	if vRP.hasPermission(user_id,"medico.permissao") or vRP.hasPermission(user_id,"paisanamedico.permissao") then
		TriggerClientEvent("Notify",source,"negado","Você não pode fazer isso sendo um paramedico.")
		return
	end

	if vRPclient.isInVehicle(source) then
		TriggerClientEvent("Notify",source,"negado","Você não pode fazer isso dentro de um carro.")
		return
	end

	local distancePrision = #(GetEntityCoords(GetPlayerPed(source)) - vec3(1698.96,2538.06,45.38))
	if distancePrision <= 145 then
		TriggerClientEvent("Notify",source,"negado","Você não pode saquear aqui.")
		return
	end

	if vida <= 101 then 
		TriggerClientEvent('Notify', source, 'negado','Você não pode fazer isso em coma.') 
		return 
	end

	if nplayer then
		if vRPclient.isInComa(nplayer) then
			local identity_user = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			local nidentity = vRP.getUserIdentity(nuser_id)
			local policia = vRP.getUsersByPermission("policia.permissao")
			local itens_saque = {}
			if #policia >= 0 then
				if vRP.request(source,"Você está em uma ação aonde permite saquear?",15) then
					local vida = vRPclient.getHealth(nplayer)
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{"amb@medic@standing@tendtodead@idle_a", "idle_a"},true)
					SetTimeout(24000,function()
						local nplayer_dps = vRPclient.getNearestPlayer(source,2)
						if client.FazendoAnim(source,"amb@medic@standing@tendtodead@idle_a", "idle_a") and nplayer_dps and nplayer_dps == nplayer then
							local ndata = vRP.getUserDataTable(nuser_id)
							if not vRP.hasPermission(nuser_id,"policiasaque.permissao") then
								if ndata ~= nil then
									if ndata.inventory ~= nil then
										for k,v in pairs(ndata.inventory) do
											if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
												vRP.giveInventoryItem(user_id,k,v.amount)
												itens_saque[#itens_saque + 1] = "[ITEM]: "..vRP.itemNameList(k).." [QUANTIDADE]: "..v.amount
											end
										end
									end
								end
								local weapons = vRPclient.replaceWeapons(nplayer,{})
								for k,v in pairs(weapons) do
									vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
											vRP.giveInventoryItem(user_id,"wbody|"..k,1)
											itens_saque[#itens_saque + 1] = "[ITEM]: "..vRP.itemNameList("wbody|"..k).." [QUANTIDADE]: 1"
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
									end
									if v.ammo > 0 then
										vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
										if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
											vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
											itens_saque[#itens_saque + 1] = "[ITEM]: "..vRP.itemNameList("wammo|"..k).." [QTD]: "..v.ammo
										end
									end
								end
								local nmoney = vRP.getMoney(nuser_id)
								if vRP.tryPayment(nuser_id,nmoney) then
									vRP.giveMoney(user_id,nmoney)
								end
								vRPclient.setStandBY(source,parseInt(120))
								vRPclient._stopAnim(source,false)
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('cancelando',nplayer,false)
								local apreendidos = table.concat(itens_saque, "\n")
								TriggerClientEvent("Notify",source,"importante","Saque concluido com sucesso.")
								exports["waze-system"]:sendLogs(user_id,{ webhook = "playerLoot", text = "Saqueou o jogador ("..nuser_id..") "..nidentity.name.." " ..nidentity.firstname .. " ("..job2..") | Set Saqueador: "..job.."\nItens Saqueados:" .. apreendidos .."\nPosição: "..x..', '..y..', '..z })
							else
								TriggerClientEvent('Notify', source, 'aviso', 'Itens que pertencem ao departamento de polícia não poderão ser roubados.')
								if ndata ~= nil then 
									if ndata.inventory ~= nil then
										for k,v in pairs(ndata.inventory) do
											if not string.match(k, 'WEAPON_COMBATPISTOL') 
											and not string.match(k, 'WEAPON_HEAVYPISTOL')
											and not string.match(k, 'WEAPON_PISTOL_MK2')
											and not string.match(k, 'WEAPON_COMBATPDW')
											and not string.match(k, 'WEAPON_SMG')
											and not string.match(k, 'WEAPON_CARBINERIFLE')
											and not string.match(k, 'WEAPON_CARBINERIFLE_MK2')
											and not string.match(k, 'WEAPON_PUMPSHOTGUN')
											and not string.match(k, 'WEAPON_FLASHLIGHT')
											and not string.match(k, 'WEAPON_NIGHTSTICK')
											and not string.match(k, 'WEAPON_STUNGUN')
											and not string.match(k, 'WEAPON_BZGAS')
											and not string.match(k, 'WEAPON_SMOKEGRENADE')
											and not string.match(k, 'WEAPON_FIREEXTINGUISHER') then
												if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
													if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
														vRP.giveInventoryItem(user_id,k,v.amount)
														itens_saque[#itens_saque + 1] = "[ITEM]: "..vRP.itemNameList(k).." [QUANTIDADE]: "..v.amount
													end
												else
													TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
												end
											else
												-- print(k .. ' É ITEM DE POLICIAL')
											end
										end
									end
								end
								local weapons = vRPclient.replaceWeapons(nplayer,{})
								for k,v in pairs(weapons) do
									if not string.match(k, 'WEAPON_COMBATPISTOL') 
									and not string.match(k, 'WEAPON_HEAVYPISTOL')
									and not string.match(k, 'WEAPON_CARBINERIFLE')
									and not string.match(k, 'WEAPON_PISTOL_MK2')
									and not string.match(k, 'WEAPON_COMBATPDW')
									and not string.match(k, 'WEAPON_SMG')
									and not string.match(k, 'WEAPON_CARBINERIFLE_MK2')
									and not string.match(k, 'WEAPON_PUMPSHOTGUN')
									and not string.match(k, 'WEAPON_FLASHLIGHT')
									and not string.match(k, 'WEAPON_NIGHTSTICK')
									and not string.match(k, 'WEAPON_STUNGUN')
									and not string.match(k, 'WEAPON_BZGAS')
									and not string.match(k, 'WEAPON_SMOKEGRENADE')
									and not string.match(k, 'WEAPON_FIREEXTINGUISHER') then
										vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
											if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
												vRP.giveInventoryItem(user_id,"wbody|"..k,1)
												itens_saque[#itens_saque + 1] = "[ITEM]: "..vRP.itemNameList("wbody|"..k).." [QUANTIDADE]: 1"
											end
										if v.ammo > 0 then
											vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
											if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
												vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
												itens_saque[#itens_saque + 1] = "[ITEM]: "..vRP.itemNameList("wammo|"..k).." [QTD]: "..v.ammo
											end
										end
									end
								end
								local nmoney = vRP.getMoney(nuser_id)
								if vRP.tryPayment(nuser_id,nmoney) then
									vRP.giveMoney(user_id,nmoney)
								end
								vRPclient.setStandBY(source,parseInt(120))
								vRPclient._stopAnim(source,false)
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('cancelando',nplayer,false)
								local apreendidos = table.concat(itens_saque, "\n")
								TriggerClientEvent("Notify",source,"importante","Saque concluido com sucesso.")
								exports["waze-system"]:sendLogs(user_id,{ webhook = "playerLoot", text = "Saqueou o jogador ("..nuser_id..") "..nidentity.name.." " ..nidentity.firstname .. " ("..job2..") | Set Saqueador: "..job.."\nItens Saqueados:" .. apreendidos .."\nPosição: "..x..', '..y..', '..z })
							end
						else
							TriggerClientEvent("Notify", source, "negado",'Negado', "Falha ao saquear o indivíduo.")
						end
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
					end)
				end
			else
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você só pode saquear quem está em coma.")
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cam",function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"policia.permissao") then
			TriggerClientEvent("waze:serviceCamera",source,tostring(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBITO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('obito',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,2)
    if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"medico.permissao") then
        if nplayer then
            if vRPclient.isInComa(nplayer) then
				vRPclient.SetSegundosMorto(nplayer, 15) 
                TriggerClientEvent('Notify',source,'sucesso','Obito concluido com sucesso')
                TriggerClientEvent('Notify',nplayer,'sucesso','O seu registro de obito foi concluido')
				exports["waze-system"]:sendLogs(user_id,{ webhook = "playerDeath", text = "Deu óbito no ID "..nplayer })
            else
                TriggerClientEvent('Notify',source,"negado",'O usuário proximo não esta desmaiado.')
            end
        else
            TriggerClientEvent('Notify',source,"negado",'Não tem ninguem perto de você')
        end
    else
        TriggerClientEvent('Notify',source,"negado",'Você não tem permissão para executar este comando')
    end
end)
---------------------
-- TIMER POLICIA
---------------------
--[[ RegisterNetEvent('PoliceTimer')
AddEventHandler('PoliceTimer', function()
    local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") then 
			vRPclient.SetSegundosMorto(user_id, 80)
		end
	end
end)
SetTimeout(87000, function()
end)  ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then	
		if user_id then
			TriggerClientEvent("setmascara",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then
			
		if user_id then
			TriggerClientEvent("setblusa",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then

		if user_id then
			TriggerClientEvent("setcolete",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setjaqueta",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then	
		if user_id then
			TriggerClientEvent("setmaos",source,args[1],args[2])
		end
	end
end)

RegisterCommand('maosd',function(source,args,rawCommand)
	--if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if user_id then
				TriggerClientEvent("setmaosd",source,args[1],args[2])
			end
		end
	end
end)

RegisterCommand('maose',function(source,args,rawCommand)
	--if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if user_id then
				TriggerClientEvent("setmaose",source,args[1],args[2])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setcalca",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setsapatos",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /chapeu
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setchapeu",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /oculos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then	
		if user_id then
			TriggerClientEvent("setoculos",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acessorios
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setacessorios",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mochila
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('mochila',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
	if not vRPclient.isHandcuffed(source) then
		if user_id then
			TriggerClientEvent("setmochila",source,args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local roupas = {
    ["mecanico"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 12,0 },
			[4] = { 39,0 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 109,0 },
			[8] = { 89,0 },
			[9] = { 14,0 },
			[10] = { -1,0 },
			[11] = { 66,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 38,0 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 2,0 },
			[8] = { 56,0 },
			[9] = { 35,0 },
			[10] = { -1,0 },
			[11] = { 59,0 }
		}
	},
    ["bennys"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 12,0 },
			[4] = { 39,1 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 109,0 },
			[8] = { 89,0 },
			[9] = { 14,0 },
			[10] = { -1,0 },
			[11] = { 66,1 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 38,1 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 2,0 },
			[8] = { 56,0 },
			[9] = { 35,0 },
			[10] = { -1,0 },
			[11] = { 59,1 }
		}
	},
	["minerador"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 99,1 },
			[4] = { 89,20 },
			[5] = { -1,0 },
			[6] = { 82,2 },
			[7] = { -1,0 },
			[8] = { 90,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 273,0 },
			["p1"] = { 23,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 114,1 },
			[4] = { 92,20 },
			[5] = { -1,0 },
			[6] = { 86,2 },
			[7] = { -1,0 },
			[8] = { 54,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 286,0 },
			["p1"] = { 25,0 }
		}
	},
    ["lixeiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 17,0 },
			[4] = { 36,0 },
			[5] = { -1,0 },
			[6] = { 27,0 },
			[7] = { -1,0 },
			[8] = { 59,0 },
			[10] = { -1,0 },
			[11] = { 57,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 35,0 },
			[5] = { -1,0 },
			[6] = { 26,0 },
			[7] = { -1,0 },
			[8] = { 36,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 50,0 }
		}
	},
	["carteiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 17,10 },
			[5] = { 40,0 },
			[6] = { 7,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 242,3 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 14,1 },
			[5] = { 40,0 },
			[6] = { 10,1 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 250,3 }
		}
	},
	["fazendeiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 37,0 },
			[4] = { 7,0 },
			[5] = { -1,0 },
			[6] = { 15,6 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 95,2 },
			["p0"] = { 105,23 },
			["p1"] = { 5,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 45,0 },
			[4] = { 25,10 },
			[5] = { -1,0 },
			[6] = { 21,1 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 171,4 },
			["p0"] = { 104,23 },
			["p1"] = { 11,2 }
		}
	},
	["lenhador"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 62,0 },
			[4] = { 89,23 },
			[5] = { -1,0 },
			[6] = { 12,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 15,0 },
			["p0"] = { 77,13 },
			["p1"] = { 23,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 71,0 },
			[4] = { 92,23 },
			[5] = { -1,0 },
			[6] = { 69,0 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 15,0 },
			["p1"] = { 25,0 }
		}
	},
	["taxista"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 11,0 },
			[4] = { 35,0 },
			[5] = { -1,0 },
			[6] = { 10,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 13,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 112,0 },
			[5] = { -1,0 },
			[6] = { 6,0 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 27,0 }
		}
	},
	["caminhoneiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 63,0 },
			[5] = { -1,0 },
			[6] = { 27,0 },
			[7] = { -1,0 },
			[8] = { 81,0 },
			[10] = { -1,0 },
			[11] = { 173,3 },
			["p1"] = { 8,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 74,5 },
			[5] = { -1,0 },
			[6] = { 9,0 },
			[7] = { -1,0 },
			[8] = { 92,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 175,3 },
			["p1"] = { 11,0 }
		}
	},
	["motocross"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 111,0 },
			[4] = { 67,3 },
			[5] = { -1,0 },
			[6] = { 47,3 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 152,0 },
			["p1"] = { 25,5 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 128,0 },
			[4] = { 69,3 },
			[5] = { -1,0 },
			[6] = { 48,3 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 149,0 },
			["p1"] = { 27,5 }
		}
	},
	-- ["mergulho"] = {
	-- 	[1885233650] = {
	-- 		[1] = { 122,0 },
	-- 		[3] = { 31,0 },
	-- 		[4] = { 94,0 },
	-- 		[5] = { -1,0 },
	-- 		[6] = { 67,0 },
	-- 		[7] = { -1,0 },
	-- 		[8] = { 123,0 },
	-- 		[9] = { -1,0 },
	-- 		[10] = { -1,0 },
	-- 		[11] = { 243,0 },			
	-- 		["p0"] = { -1,0 },
	-- 		["p1"] = { 26,0 },
	-- 		["p2"] = { -1,0 },
	-- 		["p6"] = { -1,0 },
	-- 		["p7"] = { -1,0 }
	-- 	},
	-- 	[-1667301416] = {
	-- 		[1] = { 122,0 },
	-- 		[3] = { 18,0 },
	-- 		[4] = { 97,0 },
	-- 		[5] = { -1,0 },
	-- 		[6] = { 70,0 },
	-- 		[7] = { -1,0 },
	-- 		[8] = { 153,0 },
	-- 		[9] = { -1,0 },
	-- 		[10] = { -1,0 },
	-- 		[11] = { 251,0 },
	-- 		["p0"] = { -1,0 },
	-- 		["p1"] = { 28,0 },
	-- 		["p2"] = { -1,0 },
	-- 		["p6"] = { -1,0 },
	-- 		["p7"] = { -1,0 }
	-- 	}
	-- },
	["pelado"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 21,0 },
			[5] = { -1,0 },
			[6] = { 34,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 15,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 21,0 },
			[5] = { -1,0 },
			[6] = { 35,0 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 82,0 }
		}
	},
	["paciente"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 61,0 },
			[5] = { -1,0 },
			[6] = { 16,0 },
			[7] = { -1,0 },			
			[8] = { 15,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 104,0 },			
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 57,0 },
			[5] = { -1,0 },
			[6] = { 16,0 },
			[7] = { -1,0 },		
			[8] = { 7,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 105,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["gesso1"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 4,0 },
			[4] = { 84,4 },
			[5] = { -1,0 },
			[6] = { 13,0 },
			[7] = { -1,0 },			
			[8] = { -1,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 186,4 },			
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 3,0 },
			[4] = { 86,4 },
			[5] = { -1,0 },
			[6] = { 12,0 },
			[7] = { -1,0 },		
			[8] = { 14,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 188,4 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["gesso2"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 4,0 },
			[4] = { 84,1 },
			[5] = { -1,0 },
			[6] = { 13,0 },
			[7] = { -1,0 },			
			[8] = { -1,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 186,1 },			
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 3,0 },
			[4] = { 86,1 },
			[5] = { -1,0 },
			[6] = { 12,0 },
			[7] = { -1,0 },		
			[8] = { 14,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 188,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["gesso3"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 4,0 },
			[4] = { 84,0 },
			[5] = { -1,0 },
			[6] = { 13,0 },
			[7] = { -1,0 },			
			[8] = { -1,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 186,0 },			
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 3,0 },
			[4] = { 86,0 },
			[5] = { -1,0 },
			[6] = { 12,0 },
			[7] = { -1,0 },		
			[8] = { 14,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 188,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["leiteiro"] = {
		[1885233650] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 74,0 }, -- maos
			[4] = { 89,22 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 51,0 }, -- sapato
			[7] = { -1,0 }, -- acessorios		
			[8] = { -1,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 271,0 }, -- jaqueta		
			["p0"] = { 105,22 }, -- chapeu
			["p1"] = { 23,0 }, -- oculos
		},
		[-1667301416] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 85,0 }, -- maos
			[4] = { 92,22 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 52,0 }, -- sapato
			[7] = { -1,0 },  -- acessorios		
			[8] = { -1,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 141,0 }, -- jaqueta
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { 3,9 }, -- oculos
		}
	},
	["motorista"] = {
		[1885233650] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 0,0 }, -- maos
			[4] = { 10,0 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 21,0 }, -- sapato
			[7] = { -1,0 }, -- acessorios		
			[8] = { -1,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 242,1 }, -- jaqueta		
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { 7,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 14,0 }, -- maos
			[4] = { 37,0 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 27,0 }, -- sapato
			[7] = { -1,0 },  -- acessorios		
			[8] = { -1,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 250,1 }, -- jaqueta
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { -1,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["cacador"] = {
		[1885233650] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 20,0 }, -- maos
			[4] = { 97,18 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 24,0 }, -- sapato
			[7] = { -1,0 }, -- acessorios		
			[8] = { 2,2 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 244,19 }, -- jaqueta		
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { 5,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 20,0 }, -- maos
			[4] = { 100,18 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 24,0 }, -- sapato
			[7] = { -1,0 },  -- acessorios		
			[8] = { 44,1 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 252,19 }, -- jaqueta
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { -1,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["pescador"] = {
		[1885233650] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 0,0 }, -- maos
			[4] = { 98,19 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 24,0 }, -- sapato
			[7] = { -1,0 }, -- acessorios		
			[8] = { 85,2 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 247,12 }, -- jaqueta		
			["p0"] = { 104,20 }, -- chapeu
			["p1"] = { 5,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 14,0 }, -- maos
			[4] = { 101,19 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 24,0 }, -- sapato
			[7] = { -1,0 },  -- acessorios		
			[8] = { 88,1 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 255,13 }, -- jaqueta
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { 11,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	}
}

--RegisterCommand('roupas',function(source,args,rawCommand)
--	if not exports["chat"]:statusChatServer(source) then return end
--	local user_id = vRP.getUserId(source)
--	local prisao = vRP.getUData(user_id,'vRP:prisao')
--	local tempo = json.decode(prisao) or 0
--	local vida = vRPclient.getHealth(source)
--	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
--	if vida <= 101 or vida == 200 or vida == 400 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso.') return end
--	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end
--		if not vRPclient.isHandcuffed(source) then
--			if vPOLICE.checkDistance(source,649.62,-10.52,82.79,30) or vPOLICE.checkDistance(source,308.7,-591.01,43.3,30) or vPOLICE.checkDistance(source,937.75,-970.19,39.8,30) or vPOLICE.checkDistance(source,-211.09,-1322.87,30.9,30) then
--				if args[1] then
--					local custom = roupas[tostring(args[1])]
--					if custom then
--						local old_custom = vRPclient.getCustomization(source)
--						local idle_copy = {}
--
--						idle_copy = vRP.save_idle_custom(source,old_custom)
--						idle_copy.modelhash = nil
--
--						for l,w in pairs(custom[old_custom.modelhash]) do
--							idle_copy[l] = w
--						end
--						vRPclient._playAnim(source,true,{"clothingshirt","try_shirt_positive_d"},false)
--						Wait(2500)
--						vRPclient._stopAnim(source,true)
--						vRPclient._setCustomization(source,idle_copy)
--					end
--				else
--					vRPclient._playAnim(source,true,{"clothingshirt","try_shirt_positive_d"},false)
--					Wait(2500)
--					vRPclient._stopAnim(source,true)
--					vRP.removeCloak(source)
--				end
--			else 
--				TriggerClientEvent("Notify",source,"negado",'Aviso',"Esse comando so pode ser usado somente em areas legais como <b>Delegacia,Hospital,Mecânica,Bennys</b>.")
--		end
--	end
--end)

RegisterCommand('roupas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)	
	local prisao = vRP.getUData(user_id,'vRP:prisao')
	local tempo = json.decode(prisao) or 0
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 or vida == 200 or vida == 400 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso com vida cheia.') return end
	if tempo >= 2 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso preso.') return end

		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if args[1] then
					local custom = roupas[tostring(args[1])]
					if custom then
						local old_custom = vRPclient.getCustomization(source)
						local idle_copy = {}

						idle_copy = vRP.save_idle_custom(source,old_custom)
						idle_copy.modelhash = nil

						for l,w in pairs(custom[old_custom.modelhash]) do
							idle_copy[l] = w
						end
						vRPclient._playAnim(source,true,{"clothingshirt","try_shirt_positive_d"},false)
						Wait(2500)
						vRPclient._stopAnim(source,true)
						vRPclient._setCustomization(source,idle_copy)
					end
				else
					vRPclient._playAnim(source,true,{"clothingshirt","try_shirt_positive_d"},false)
					Wait(2500)
					vRPclient._stopAnim(source,true)
					vRP.removeCloak(source)
			end
		end
	end
end)

RegisterCommand('roupas2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)
	if vRPclient.getStandBY(source) > 0 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso procurado.') return end
	if vida <= 101 or vida == 200 or vida == 400 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso com vida cheia.') return end
		if not vRPclient.isHandcuffed(source) then
			if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"medico.permissao") then
				local nplayer = vRPclient.getNearestPlayer(source,2)
				if not vRP.searchReturn(nplayer,user_id) then
					if nplayer then
						if args[1] then
							local custom = roupas[tostring(args[1])]
							if custom then
								local old_custom = vRPclient.getCustomization(nplayer)
								local idle_copy = {}

								idle_copy = vRP.save_idle_custom(nplayer,old_custom)
								idle_copy.modelhash = nil

								for l,w in pairs(custom[old_custom.modelhash]) do
									idle_copy[l] = w
								end
								vRPclient._setCustomization(nplayer,idle_copy)
							end
						else
							vRP.removeCloak(nplayer)
						end
					end
				end
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUX VEH CONTROL
----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lvc_TogDfltSrnMuted_s")
AddEventHandler("lvc_TogDfltSrnMuted_s", function(toggle)
	TriggerClientEvent("lvc_TogDfltSrnMuted_c",-1,source,toggle)
end)
RegisterServerEvent("lvc_SetLxSirenState_s")
AddEventHandler("lvc_SetLxSirenState_s", function(newstate)
	TriggerClientEvent("lvc_SetLxSirenState_c",-1,source,newstate)
end)
RegisterServerEvent("lvc_TogPwrcallState_s")
AddEventHandler("lvc_TogPwrcallState_s", function(toggle)
	TriggerClientEvent("lvc_TogPwrcallState_c",-1,source,toggle)
end)
RegisterServerEvent("lvc_SetAirManuState_s")
AddEventHandler("lvc_SetAirManuState_s", function(newstate)
	TriggerClientEvent("lvc_SetAirManuState_c",-1,source,newstate)
end)
RegisterServerEvent("lvc_TogIndicState_s")
AddEventHandler("lvc_TogIndicState_s", function(newstate)
	TriggerClientEvent("lvc_TogIndicState_c",-1,source,newstate)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PEÇA MECANICO 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fabricarplaca', function(source, args, rawCmd)
	local source = source
	local user_id = vRP.getUserId(source)
	local ped = GetPlayerPed(source)
	if vRP.hasPermission(user_id,"bennys.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		local distance = #(vec3(-196.43,-1319.26,31.09) - GetEntityCoords(ped))
		local distance2 = #(vec3(-198.92,-1315.28,31.09) - GetEntityCoords(ped))
		if distance or distance2 <= 3 then
			MecAskItem('placa')
		end
	end
end)
RegisterCommand('fabricarlata', function(source, args, rawCmd)
	local source = source
	local user_id = vRP.getUserId(source)
	local ped = GetPlayerPed(source)
	if vRP.hasPermission(user_id,"bennys.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		local distance = #(vec3(-196.43,-1319.26,31.09) - GetEntityCoords(ped))
		local distance2 = #(vec3(-198.92,-1315.28,31.09) - GetEntityCoords(ped))
		if distance or distance2 <= 3 then
			MecAskItem('latadetinta')
		end
	end
end)

function MecAskItem(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if item == 'placa' then
		if vRP.request(source, 'Você deseja fazer um kit de placa por <b>$18.000</b>?', 30) then
			if vRP.tryFullPayment(user_id, 20000) then
				TriggerClientEvent('waze:MecAnim', source, 'placa')
				Wait(15000)
				vRP.giveInventoryItem(user_id, 'placa', 1)
				TriggerClientEvent('Notify', source, 'sucesso', 'Você finalizou um kit de placa.')
			else
				TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro suficiente.')
			end
		else
			TriggerClientEvent('Notify', source, 'negado', 'Você cancelou o pedido.')
		end
	elseif item == 'latadetinta' then
		if vRP.request(source, 'Você deseja pegar uma lata de tinta por <b>$1.000</b>?', 30) then
			if vRP.tryFullPayment(user_id, 15000) then
				TriggerClientEvent('waze:MecAnim', source, 'latadetinta')
				Wait(15000)
				vRP.giveInventoryItem(user_id, 'latadetinta', 1)
				TriggerClientEvent('Notify', source, 'sucesso', 'Você montou uma lata de tinta.')
			else
				TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro suficiente.')
			end
		else
			TriggerClientEvent('Notify', source, 'negado', 'Você cancelou o pedido.')
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OFICINA CLANDESTINA
-----------------------------------------------------------------------------------------------------------------------------------------
function src.GetPlacaLivre()
	return vRP.generateRegistrationNumber(cbr)
end

function src.checkCamuflagem(tipo)
	local user_id = vRP.getUserId(source)

	if tipo == 'pintura' then

		if vRP.getInventoryItemAmount(user_id, 'latadetinta') > 0 then
			vRP.tryGetInventoryItem(user_id, 'latadetinta', 1)
			TriggerClientEvent("Notify",source,"sucesso",'Iniciando processo de troca de cor.')
			return true
		else
			TriggerClientEvent("Notify",source,"negado",'Você não possui uma lata de tinta.')
			return false
		end

	elseif tipo == 'placa' then

		if vRP.getInventoryItemAmount(user_id, 'placa') > 0 then
			vRP.tryGetInventoryItem(user_id, 'placa', 1)
			TriggerClientEvent("Notify",source,"sucesso",'Iniciando processo de clonagem de placa.')
			return true
		else
			TriggerClientEvent("Notify",source,"negado",'Você não possui um kit de placa.')
			return false
		end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TURBO
-----------------------------------------------------------------------------------------------------------------------------------------
	--if vRP.hasPermission(user_id, 'ceo.permissao') or vRP.hasPermission(user_id, 'admin.permissao') or vRP.hasPermission(user_id, 'waze.permissao')then


RegisterCommand('turbao', function(source, args, rawCmd)

	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,'dev') then
		if args[1] then 
			TriggerClientEvent('waze:LigarTurbao', source, tonumber(args[1] .. '.0'))
			 print('TURBAO EM ' .. tonumber(args[1] .. '.0'))
		else
			TriggerClientEvent('waze:LigarTurbao', source, 150.0)
		end
	end
end)

RegisterCommand('att', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if user_id == 0 or user_id == 1 then
		TriggerClientEvent('waze:attachs2', source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admcr', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.permissao') then
		if args[1] then
			local crrrrrr = parseInt(args[1])
			TriggerClientEvent('waze:Cruiser', source, crrrrrr)
		else
			TriggerClientEvent('waze:Cruiser', source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Tackle:Server:TacklePlayer')
AddEventHandler('Tackle:Server:TacklePlayer',function(Tackled,ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	TriggerClientEvent("Tackle:Client:TacklePlayer",Tackled,ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GARMAS ]-----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("waze:ZerarStatusGarmas")
AddEventHandler("waze:ZerarStatusGarmas",function()
	statusGarmas[source] = false
end)
RegisterCommand('garmas',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
    
local source = source
local user_id = vRP.getUserId(source)
local identity = vRP.getUserIdentity(user_id)
local vida = vRPclient.getHealth(source)

if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso morto.') return end
if user_id ~= nil then

	if statusGarmas[source] then TriggerClientEvent("Notify",source,"negado","Você deve esperar um tempo para guardar seus armamentos novamente.") return end 

	statusGarmas[source] = true
	TriggerClientEvent("waze:GerarDelayGarmas",source)

	garmas_user[user_id] = os.time()
	local weapons = vRPclient.replaceWeapons(source,{})

	--Wait(math.random(10000,25000))

		for k,v in pairs(weapons) do
			vRP.removeWeaponTable(user_id,k)
			vRP.giveInventoryItem(user_id,"wbody|"..k,1)
			if v.ammo > 0 then
				vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
			end
			exports["waze-system"]:sendLogs(user_id,{ webhook = "playerWeapons", text = "Guardou seu armamento\nArmas: "..vRP.itemNameList("wbody|"..k).."\nMunições: "..v.ammo })
			if v.ammo == 250 then 
				exports["waze-system"]:sendLogs(user_id,{ webhook = "playerWeapons250", text = "Guardou seu armamento (250)\nArmas: "..vRP.itemNameList("wbody|"..k).."\nMunições: "..v.ammo })
			end
		end
		vRPclient.updateWeapons(source)

		TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
	end
end)

AddEventHandler("playerDropped",function(reason)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if garmas_user[user_id] then
			local user_time_garmas = parseInt(garmas_user[user_id])
			if user_time_garmas > (os.time() - 120) then
				local adm = ""
				if (os.time() -  user_time_garmas) < 5 then
				end
				exports["waze-system"]:sendLogs(user_id,{ webhook = "playerQuit", text = "Deslogou enquanto guardava seu armamento, tempo: ".. os.time() - user_time_garmas .. "\nTipo: "..reason })
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MOLHAR DINHEIRO
-----------------------------------------------------------------------------------------------------------------------------------------
--function src.MolharDinheiro()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		local dinheirosujo = vRP.getInventoryItemAmount(user_id,"dinheirosujo")
--		local dinheiroempacotado = vRP.getInventoryItemAmount(user_id,"dinheiroempacotado")
--		local dinheiro = vRP.getMoney(user_id)
--		if dinheiroempacotado > 0 then
--			vRP.tryGetInventoryItem(user_id,"dinheiroempacotado",dinheiroempacotado)
--		end
--		if dinheirosujo > 0 then
--			vRP.tryGetInventoryItem(user_id,"dinheirosujo",dinheirosujo)
--		end
--		if dinheiro > 0 then
--			vRP.tryPayment(user_id,dinheiro)
--			vRP.giveInventoryItem(user_id, 'dinheiromolhado', dinheiro)
--		end
--	end
--end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GUARDAR MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
local delayMochila = {}
RegisterCommand('gmochila', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	local tamanhoInv = parseInt(string.format("%.2f",vRP.getInventoryMaxWeight(user_id)))
	local identity = vRP.getUserIdentity(user_id)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 or vida == 200 or vida == 400 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso com vida cheia.') return end
	if tamanhoInv == 51 or tamanhoInv == 75 or tamanhoInv == 90 then
		if vRP.getInventoryWeight(user_id) <= (math.floor(vRP.expToLevel((vRP.getExp(user_id,"physical","strength") - 650)))*3) then
			if tamanhoInv == 51 then
				if not delayMochila[user_id] or os.time() > (delayMochila[user_id] + 5) then
					delayMochila[user_id] = os.time()
					vRP.setExp(user_id,"physical","strength",20)
					vRP.giveInventoryItem(user_id,'mochila',1)
					TriggerClientEvent('Notify', source, 'sucesso', 'Você guardou uma mochila.')
					local tamanhoInvdps = parseInt(string.format("%.2f",vRP.getInventoryMaxWeight(user_id)))
					exports["waze-system"]:sendLogs(user_id,{ webhook = "playerBackpack", text = "Guardou uma mochila, "..tamanhoInv.."Kg -> " .. tamanhoInvdps.." - Peso do Inventário: "..vRP.getInventoryWeight(user_id) })
				else
					TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Você deve aguardar para utilizar o comando novamente.')
				end
			elseif tamanhoInv == 75 then
				if not delayMochila[user_id] or os.time() > (delayMochila[user_id] + 5) then
					delayMochila[user_id] = os.time()
					vRP.setExp(user_id,"physical","strength",650)
					vRP.giveInventoryItem(user_id,'mochila',1)
					TriggerClientEvent('Notify', source, 'sucesso', 'Você guardou uma mochila.')
					local tamanhoInvdps = parseInt(string.format("%.2f",vRP.getInventoryMaxWeight(user_id)))
					exports["waze-system"]:sendLogs(user_id,{ webhook = "playerBackpack", text = "Guardou uma mochila, "..tamanhoInv.."Kg -> " .. tamanhoInvdps.." - Peso do Inventário: "..vRP.getInventoryWeight(user_id) })
					else
					TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Você deve aguardar para utilizar o comando novamente.')
				end
			elseif tamanhoInv == 90 then
				if not delayMochila[user_id] or os.time() > (delayMochila[user_id] + 5) then
					delayMochila[user_id] = os.time()
					vRP.setExp(user_id,"physical","strength",1300)
					vRP.giveInventoryItem(user_id,'mochila',1)
					TriggerClientEvent('Notify', source, 'sucesso', 'Você guardou uma mochila.')
					local tamanhoInvdps = parseInt(string.format("%.2f",vRP.getInventoryMaxWeight(user_id)))
					exports["waze-system"]:sendLogs(user_id,{ webhook = "playerBackpack", text = "Guardou uma mochila, "..tamanhoInv.."Kg -> " .. tamanhoInvdps.." - Peso do Inventário: "..vRP.getInventoryWeight(user_id) })
					else
					TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Você deve aguardar para utilizar o comando novamente.')
				end
			end
		else
			TriggerClientEvent('Notify', source, 'negado', 'Esvazie a mochila o suficente antes de guardá-la.')
		end
	else
		TriggerClientEvent('Notify', source, 'negado', 'Você não possui mochila para guardar.')
	end
end)

RegisterServerEvent('waze:ReducaoPenalAbcde')
AddEventHandler('waze:ReducaoPenalAbcde', function(source,qtd)


    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0

	tempo = parseInt(tonumber(tempo))

	if tempo >= 15 then
		if vRP.hasPermission(user_id, 'waze.permissao') then
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - (qtd + 1) ) ) )
			tempo = tempo - (qtd + 1)
			TriggerClientEvent("Notify",source,"importante","[GASEOUS] Sua pena foi reduzida em <b>" .. (qtd+1) .. " meses</b>, continue os trabalhos.")
		elseif vRP.hasPermission(user_id, 'wazeelite.permissao') then
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - (qtd + 2) ) ) )
			TriggerClientEvent("Notify",source,"importante","[GASEOUS ELITE] Sua pena foi reduzida em <b>" .. (qtd+2) .. " meses</b>, continue os trabalhos.")
			tempo = tempo - (qtd + 2)
		else
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - qtd) ) )
			TriggerClientEvent("Notify",source,"importante","Sua pena foi reduzida em <b>" .. qtd .." meses</b>, continue os trabalhos.")
			tempo = tempo - qtd
		end

		if tempo < 0 then
			tempo = 0
		end
	else
		TriggerClientEvent("Notify",source,"importante","Atingiu o limite da redução de pena, não precisa mais trabalhar.")
	end

	if tempo <= 0 then
		TriggerClientEvent('wazeprisioneiro',source,false)
		TriggerClientEvent('waze:VirarPrisioneiro',source,false)
		SetEntityCoords(GetPlayerPed(source),1847.91,2585.75,45.68)
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(-1))
		TriggerClientEvent("Notify",source,"aviso","Sua sentença terminou, esperamos não vê-lo novamente.")
	else
		TriggerClientEvent("Notify",source,"aviso","Restam <b>"..parseInt(tempo).." meses</b> preso.")
	end

end)

RegisterServerEvent('waze:ReducaoPenalAbcdef')
AddEventHandler('waze:ReducaoPenalAbcdef', function(source)
    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0

	tempo = parseInt(tonumber(tempo))

	if tempo > 0 then
		if vRP.hasPermission(user_id, 'waze.permissao') then
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo -  2) ) ) 
			tempo = tempo - 2
			TriggerClientEvent("Notify",source,"importante","[VIP] Sua pena foi reduzida em <b>2 meses</b>.")
		elseif vRP.hasPermission(user_id, 'wazeelite.permissao') then
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - 3) ) ) 
			TriggerClientEvent("Notify",source,"importante","[waze Elite] Sua pena foi reduzida em <b>3 meses</b>.")
			tempo = tempo - 3
		else
			vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo - 1) ) )
			TriggerClientEvent("Notify",source,"importante","Sua pena foi reduzida em <b>1 mês</b>.")
			tempo = tempo - 1
		end
		if tempo < 0 then
			tempo = 0
		end
	end

	if tempo <= 0 then
		TriggerClientEvent('wazeprisioneiro',source,false)
		TriggerClientEvent('waze:VirarPrisioneiro',source,false)
		SetEntityCoords(GetPlayerPed(source),1847.91,2585.75,45.68)
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(-1))
		TriggerClientEvent("Notify",source,"aviso","Sua sentença terminou, esperamos não vê-lo novamente.")
	else
		TriggerClientEvent("Notify",source,"aviso","Restam <b>"..parseInt(tempo).." meses</b> preso.")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /PAYPAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("waze:ZerarStatusPaypal")
AddEventHandler("waze:ZerarStatusPaypal",function()
	statusPaypal[source] = false
end)

RegisterCommand('paypal',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if user_id then
		if args[1] == "sacar" and parseInt(args[2]) > 0 then
			local consulta = vRP.getUData(user_id,"vRP:paypal")
			local resultado = json.decode(consulta) or ""
			local banco = vRP.getBankMoney(user_id)
			if resultado >= parseInt(args[2]) then
				if vRP.request(source,"Deseja sacar <b>$".. args[2].."</b> do paypal para sua conta bancária?",12) then
					if statusPaypal[source] then TriggerClientEvent("Notify",source,"negado","[PAYPAL] Você está realizando transações rápido demais.") return end 
					statusPaypal[source] = true
					TriggerClientEvent("waze:GerarDelayPaypal",source)
					vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado-args[2])))
					vRP.giveBankMoney(user_id,parseInt(args[2]))
					TriggerClientEvent("Notify",source,"financeiro","Efetuou o saque de <b>$"..vRP.format(parseInt(args[2])).." dólares</b> da sua conta paypal.")
					local Tempo = os.date('%X') .. ' - ' .. os.date('%x')
					local banco2 = vRP.getBankMoney(user_id)
					local consulta2 = vRP.getUData(user_id,"vRP:paypal")
					local resultado2 = json.decode(consulta2) or ""
					exports["waze-system"]:sendLogs(user_id,{ webhook = "playerPaypal", text = "Sacou $"..vRP.format(args[2]).." do PayPal\nPaypal Antes/Depois: " .. vRP.format(resultado) .. ' / ' .. vRP.format(resultado2) .. "\nBanco Antes/Depois: " .. vRP.format(banco) .. ' / ' .. vRP.format(banco2) })
				else
					TriggerClientEvent("Notify",source,"negado","Transação cancelada.")
				end
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente em sua conta paypal.")
			end
		elseif args[1] == "trans" and parseInt(args[2]) > 0 and parseInt(args[3]) > 0 then
			TriggerClientEvent("Notify",source,'negado',"Sistema de transferência do <b>paypal</b> se encontra em manutenção! Tente novamente mais tarde.")
		end
	end
end)

RegisterCommand('bhms', function(source, args, rawCmd)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	local ped = GetPlayerPed(source)
	if not vRP.hasGroup(user_id,'bahamas') and not vRP.hasGroup(user_id,'admin') then return end
	if not args[1] then
		TriggerClientEvent('Notify', source, 'negado', 'Você precisa especificar uma ação válida: entrar, sair ou lavar.')
	elseif args[1] == 'entrar' then
		if #(GetEntityCoords(ped) - vec3(-1381.3,-632.32,30.82)) < 1.5 then
			SetEntityCoords(GetPlayerPed(source),-1379.84,-630.9,30.82)
		end
	elseif args[1] == 'sair' then
		if #(GetEntityCoords(ped) - vec3(-1379.84,-630.9,30.82)) < 1.5 then
			SetEntityCoords(GetPlayerPed(source),-1381.3,-632.32,30.82)
		end
	elseif args[1] == 'lavar' then
		if #(GetEntityCoords(ped) - vec3(-1372.65,-626.53,30.82)) < 1.5 then
			local dinSujo = vRP.getInventoryItemAmount(user_id,'dinheirosujo')
			local alvejante = vRP.getInventoryItemAmount(user_id,'alvejante')
			local alvejante2 = vRP.getInventoryItemAmount(user_id,'alvejantemodificado')
			if dinSujo > 0 then
                if alvejante > 0 or alvejante2 > 0 then       
                    if args[2] == '1' then
                        if dinSujo >= 100000 then    
                            if vRP.tryGetInventoryItem(user_id,'dinheirosujo',100000) and vRP.tryGetInventoryItem(user_id,'alvejante',14) then
                                local dinLavado = parseInt(100000*0.95)
                                vRP.giveMoney(user_id,dinLavado)
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "playerBahamas", text = "Lavou $"..vRP.format(100000).." a 95%, recebendo $".. vRP.format(dinLavado) })
                                TriggerClientEvent('Notify', source,'financeiro', 'Você lavou $'..vRP.format(100000)..' a 95%, recebendo $' .. vRP.format(dinLavado)..'.')
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Faltou alvejante na sua lavagem e as notas foram perdidas.')
                            end
                        else
                            if vRP.tryGetInventoryItem(user_id,'dinheirosujo',dinSujo) and vRP.tryGetInventoryItem(user_id,'alvejante',14) then
                                local dinLavado = parseInt(dinSujo*0.95)
                                vRP.giveMoney(user_id,dinLavado)
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "playerBahamas", text = "Lavou $"..vRP.format(dinSujo).." a 95%, recebendo $".. vRP.format(dinLavado) })
                                TriggerClientEvent('Notify', source,'financeiro', 'Você lavou $'..vRP.format(dinSujo)..' a 95%, recebendo $' .. vRP.format(dinLavado)..'.')
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Faltou alvejante na sua lavagem e as notas foram perdidas.')
                            end
                        end
                    elseif args[2] == '2' then
                        if dinSujo >= 500000 then    
                            if vRP.tryGetInventoryItem(user_id,'dinheirosujo',500000) and vRP.tryGetInventoryItem(user_id,'alvejantemodificado',14) then
                                local dinLavado = parseInt(500000*0.95)
                                vRP.giveMoney(user_id,dinLavado)
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "playerBahamas", text = "Lavou $"..vRP.format(500000).." a 95%, recebendo $".. vRP.format(dinLavado) })
                                TriggerClientEvent('Notify', source,'financeiro', 'Você lavou $'..vRP.format(500000)..' a 95%, recebendo $' .. vRP.format(dinLavado)..'.')
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Faltou alvejante na sua lavagem e as notas foram perdidas.')
                            end
                        else
                            if vRP.tryGetInventoryItem(user_id,'dinheirosujo',dinSujo) and vRP.tryGetInventoryItem(user_id,'alvejantemodificado',14) then
                                local dinLavado = parseInt(dinSujo*0.95)
                                vRP.giveMoney(user_id,dinLavado)
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "playerBahamas", text = "Lavou $"..vRP.format(dinSujo).." a 95%, recebendo $".. vRP.format(dinLavado) })
                                TriggerClientEvent('Notify', source,'financeiro', 'Você lavou $'..vRP.format(dinSujo)..' a 95%, recebendo $' .. vRP.format(dinLavado)..'.')
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Faltou alvejante na sua lavagem e as notas foram perdidas.')
                            end
                        end
                    end
    
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Você não possui x14 alvejante.')
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro para lavagem.')
            end
        end
    end
end)

RegisterCommand('life', function(source, args, rawCmd)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	local ped = GetPlayerPed(source)
    if not vRP.hasGroup(user_id,'lifeinvader') and not vRP.hasGroup(user_id,'admin') then return end
    if not args[1] then
        TriggerClientEvent('Notify', source, 'negado', 'Você precisa especificar uma ação válida: entrar, sair ou lavar.')
	elseif args[1] == 'entrar' then
		if #(GetEntityCoords(ped) - vec3(1455.54,1132.16,114.34)) < 1.5 then
			SetEntityCoords(GetPlayerPed(source),1455.54,1133.98,114.34)
		end
	elseif args[1] == 'sair' then
		if #(GetEntityCoords(ped) - vec3(1455.54,1133.98,114.34)) < 1.5 then
			SetEntityCoords(GetPlayerPed(source),1455.54,1132.16,114.34)
		end
    elseif args[1] == 'lavar' then
        if #(GetEntityCoords(ped) - vec3(-1053.81,-230.68,44.03)) < 1.5 then
            local dinSujo = vRP.getInventoryItemAmount(user_id,'dinheirosujo')
            local alvejante = vRP.getInventoryItemAmount(user_id,'alvejante')
            local alvejante2 = vRP.getInventoryItemAmount(user_id,'alvejantemodificado')
            if dinSujo > 0 then
                if alvejante > 0 or alvejante2 > 0 then       
                    if args[2] == '1' then
                        if dinSujo >= 100000 then    
                            if vRP.tryGetInventoryItem(user_id,'dinheirosujo',100000) and vRP.tryGetInventoryItem(user_id,'alvejante',14) then
                                local dinLavado = parseInt(100000*0.95)
                                vRP.giveMoney(user_id,dinLavado)
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "playerLifeInvader", text = "Lavou $"..vRP.format(100000).." a 95%, recebendo $".. vRP.format(dinLavado) })
                                TriggerClientEvent('Notify', source,'financeiro', 'Você lavou $'..vRP.format(100000)..' a 95%, recebendo $' .. vRP.format(dinLavado)..'.')
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Faltou alvejante na sua lavagem e as notas foram perdidas.')
                            end
                        else
                            if vRP.tryGetInventoryItem(user_id,'dinheirosujo',dinSujo) and vRP.tryGetInventoryItem(user_id,'alvejante',14) then
                                local dinLavado = parseInt(dinSujo*0.95)
                                vRP.giveMoney(user_id,dinLavado)
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "playerLifeInvader", text = "Lavou $"..vRP.format(dinSujo).." a 95%, recebendo $".. vRP.format(dinLavado) })
                                TriggerClientEvent('Notify', source,'financeiro', 'Você lavou $'..vRP.format(dinSujo)..' a 95%, recebendo $' .. vRP.format(dinLavado)..'.')
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Faltou alvejante na sua lavagem e as notas foram perdidas.')
                            end
                        end
                    elseif args[2] == '2' then
                        if dinSujo >= 500000 then    
                            if vRP.tryGetInventoryItem(user_id,'dinheirosujo',500000) and vRP.tryGetInventoryItem(user_id,'alvejantemodificado',14) then
                                local dinLavado = parseInt(500000*0.95)
                                vRP.giveMoney(user_id,dinLavado)
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "playerLifeInvader", text = "Lavou $"..vRP.format(500000).." a 95%, recebendo $".. vRP.format(dinLavado) })
                                TriggerClientEvent('Notify', source,'financeiro', 'Você lavou $'..vRP.format(500000)..' a 95%, recebendo $' .. vRP.format(dinLavado)..'.')
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Faltou alvejante na sua lavagem e as notas foram perdidas.')
                            end
                        else
                            if vRP.tryGetInventoryItem(user_id,'dinheirosujo',dinSujo) and vRP.tryGetInventoryItem(user_id,'alvejantemodificado',14) then
                                local dinLavado = parseInt(dinSujo*0.95)
                                vRP.giveMoney(user_id,dinLavado)
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "playerLifeInvader", text = "Lavou $"..vRP.format(dinSujo).." a 95%, recebendo $".. vRP.format(dinLavado) })
                                TriggerClientEvent('Notify', source,'financeiro', 'Você lavou $'..vRP.format(dinSujo)..' a 95%, recebendo $' .. vRP.format(dinLavado)..'.')
                            else
                                TriggerClientEvent('Notify', source, 'negado', 'Faltou alvejante na sua lavagem e as notas foram perdidas.')
                            end
                        end
                    end
    
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Você não possui x14 alvejante.')
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro para lavagem.')
            end
        end
    end
end)

RegisterCommand('fac', function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	local crips = vRP.getUsersByPermission("crips.permissao")
	local crips2 = 0
	local crips_nomes = ""
	if vRP.hasPermission(user_id,"crips.permissao") then
		for k,v in ipairs(crips) do
			local identity = vRP.getUserIdentity(parseInt(v))
			crips_nomes = crips_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			crips2 = crips2 + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..crips2.."</b> membros dos Crips online.")
			if parseInt(crips2) > 0 then
				TriggerClientEvent("Notify",source,"importante", crips_nomes)
		end
	end
	local bloods = vRP.getUsersByPermission("bloods.permissao")
	local bloods2 = 0
	local bloods_nomes = ""
	if vRP.hasPermission(user_id,"bloods.permissao") then
		for k,v in ipairs(bloods) do
			local identity = vRP.getUserIdentity(parseInt(v))
			bloods_nomes = bloods_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			bloods2 = bloods2 + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..bloods2.."</b> membros dos Bloods online.")
			if parseInt(bloods2) > 0 then
				TriggerClientEvent("Notify",source,"importante", bloods_nomes)
		end
	end
	local vagos = vRP.getUsersByPermission("vagos.permissao")
	local vagos2 = 0
	local vagos_nomes = ""
	if vRP.hasPermission(user_id,"vagos.permissao") then
		for k,v in ipairs(vagos) do
			local identity = vRP.getUserIdentity(parseInt(v))
			vagos_nomes = vagos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			vagos2 = vagos2 + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..vagos2.."</b> membros dos Vagos online.")
			if parseInt(vagos2) > 0 then
				TriggerClientEvent("Notify",source,"importante", vagos_nomes)
		end
	end
	local grove = vRP.getUsersByPermission("grove.permissao")
	local grove2 = 0
	local grove_nomes = ""
	if vRP.hasPermission(user_id,"grove.permissao") then
		for k,v in ipairs(grove) do
			local identity = vRP.getUserIdentity(parseInt(v))
			grove_nomes = grove_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			grove2 = grove2 + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..grove2.."</b> membros dos Groove online.")
			if parseInt(grove2) > 0 then
				TriggerClientEvent("Notify",source,"importante", grove_nomes)
		end
	end
	local ballas = vRP.getUsersByPermission("ballas.permissao")
	local ballas2 = 0
	local ballas_nomes = ""
	if vRP.hasPermission(user_id,"ballas.permissao") then
		for k,v in ipairs(ballas) do
			local identity = vRP.getUserIdentity(parseInt(v))
			ballas_nomes = ballas_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			ballas2 = ballas2 + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..ballas2.."</b> membros dos Ballas online.")
			if parseInt(ballas2) > 0 then
				TriggerClientEvent("Notify",source,"importante", ballas_nomes)
		end
	end
	local lifeinvader = vRP.getUsersByPermission("lifeinvader.permissao")
	local lifeinvader2 = 0
	local lifeinvader_nomes = ""
	if vRP.hasPermission(user_id,"lifeinvader.permissao") then
		for k,v in ipairs(lifeinvader) do
			local identity = vRP.getUserIdentity(parseInt(v))
			lifeinvader_nomes = lifeinvader_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			lifeinvader2 = lifeinvader2 + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..lifeinvader2.."</b> membros da Life Invader online.")
			if parseInt(lifeinvader2) > 0 then
				TriggerClientEvent("Notify",source,"importante", lifeinvader_nomes)
		end
	end
	local bahamas = vRP.getUsersByPermission("bahamas.permissao")
	local bahamas2 = 0
	local bahamas_nomes = ""
	if vRP.hasPermission(user_id,"bahamas.permissao") then
		for k,v in ipairs(bahamas) do
			local identity = vRP.getUserIdentity(parseInt(v))
			bahamas_nomes = bahamas_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			bahamas2 = bahamas2 + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..bahamas2.."</b> membros do Bahamas online.")
			if parseInt(bahamas2) > 0 then
				TriggerClientEvent("Notify",source,"importante", bahamas_nomes)
		end
	end
	local bratva = vRP.getUsersByPermission("bratva.permissao")
	local bratva2 = 0
	local bratva_nomes = ""
	if vRP.hasPermission(user_id,"bratva.permissao") then
		for k,v in ipairs(bratva) do
			local identity = vRP.getUserIdentity(parseInt(v))
			bratva_nomes = bratva_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			bratva2 = bratva2 + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..bratva2.."</b> membros da Bratva online.")
			if parseInt(bratva2) > 0 then
				TriggerClientEvent("Notify",source,"importante", bratva_nomes)
		end
	end
	local siciliana = vRP.getUsersByPermission("siciliana.permissao")
	local siciliana2 = 0
	local siciliana_nomes = ""
	if vRP.hasPermission(user_id,"siciliana.permissao") then
		for k,v in ipairs(siciliana) do
			local identity = vRP.getUserIdentity(parseInt(v))
			siciliana_nomes = siciliana_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			siciliana2 = siciliana2 + 1
			end
			TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..siciliana2.."</b> membros da Siciliana online.")
			if parseInt(siciliana2) > 0 then
				TriggerClientEvent("Notify",source,"importante", siciliana_nomes)
		end
	end
end)

RegisterNetEvent('waze:WeaponsDeath')
AddEventHandler('waze:WeaponsDeath', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if not vRP.hasPermission(user_id,"policia.permissao") and not vRP.hasPermission(user_id,"policiaacao.permissao") then 
			local weapons = vRPclient.replaceWeapons(source,{})
			for k,v in pairs(weapons) do
				Wait(math.random(3500,8500))
				vRP.removeWeaponTable(user_id,k)
				vRP.giveInventoryItem(user_id,"wbody|"..k,1)
				if v.ammo > 0 then
					vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
				end
			end
		end
	end
end)