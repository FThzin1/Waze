local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local cfg = module("vrp","cfg/groups")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local waze = {}
Tunnel.bindInterface("vrp_admin",waze)
vCLIENT = Tunnel.getInterface("vrp_admin")
vGARAGE = Tunnel.getInterface("vrp_garages")

local groups = cfg.groups

local AdminsLogs = {}
local AdminsChat = {}
local cantTeleport = {}
local chatStaff = true

RegisterServerEvent('waze:LoggarAeroporto')
AddEventHandler('waze:LoggarAeroporto', function(source,x,y,z)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	exports["waze-system"]:sendLogs(user_id,{ webhook = "adminE", text = "Apertou [E] para voltar ao Hospital dos Mortos\nPosição: " .. tD(x) .. ", " .. tD(y) .. ", " .. tD(z) })
end)
--------------------------------------------------------------------------------------------------------------------------------
-- DROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped', function (reason)
	print('Player ' .. GetPlayerName(source) .. ' dropped (Reason: ' .. reason .. ')')
	if string.match(reason, 'CrashCommand') or string.match(reason, 'Reloading game') or string.match(reason, '!memcpy') then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local request = exports["waze-system"]:permanentBan({
			user_id = parseInt(user_id),
			staff_id = -1,
			reason = "Banido pelo Sistema"
		})
		vRP.setBanned(user_id, 1)
		exports["waze-system"]:sendRegister({ webhook = "adminCrash", text = "ID: "..user_id.."\nFoi banido por utilizar o comando "..reason.." (Risco de falso-positivo)" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLIST
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('waze/procurandoset', "SELECT * FROM vrp_user_data WHERE dvalue REGEXP @grupo")

RegisterCommand('setlist', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.permissao') or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then

			local resultado = vRP.query('waze/procurandoset', {grupo = args[1]})
			if resultado ~= nil then
				local result = ''
				for k, v in pairs(resultado) do 
					local identity = vRP.getUserIdentity(v.user_id)
					result = result .. v.user_id .. ' ' .. identity.name .. ' ' .. identity.firstname .. '\n'
				end
				vRP.prompt(source, args[1]..' (' .. #resultado .. '):', result)
			end
		end
	end
end)

RegisterCommand('removelist', function(source, args, rawCmd)

	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
	
			local resultado = vRP.query('waze/procurandoset', {grupo = args[1]})
			if resultado ~= nil then
				local result = ''
				for k, v in pairs(resultado) do 
					local identity = vRP.getUserIdentity(v.user_id)
					result = result .. 'group rem '..v.user_id .. ' '..args[1]..'; '
				end
				vRP.prompt(source, args[1]..' (' .. #resultado .. '):', result)
			end
		end
	end
end)

RegisterCommand('setarlist', function(source, args, rawCmd)

	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
	
			local resultado = vRP.query('waze/procurandoset', {grupo = args[1]})
			if resultado ~= nil then
				local result = ''
				for k, v in pairs(resultado) do 
					local identity = vRP.getUserIdentity(v.user_id)
					result = result .. 'group add '..v.user_id .. ' '..args[2]..'; '
				end
				vRP.prompt(source, args[1]..' (' .. #resultado .. '):', result)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DADOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dados',function(source,args,rawCommand)
    local ip = GetPlayerEndpoint(source)
    local steamhex = GetPlayerIdentifier(source)
    local ping = GetPlayerPing(source)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                local ip2 = GetPlayerEndpoint(nplayer)
                local steamhex2 = GetPlayerIdentifier(nplayer)
                local ping2 = GetPlayerPing(nplayer)
               TriggerClientEvent("Notify",source,"aviso","IP do player:"  ..ip2.."")
               TriggerClientEvent("Notify",source,"aviso","Player Hex:" ..steamhex2.."")
               TriggerClientEvent("Notify",source,"aviso","Ping do player:" ..ping2.."")
            end
        else
            TriggerClientEvent("Notify",source,"aviso","Seu IP:"  ..ip.."")
            TriggerClientEvent("Notify",source,"aviso","Sua hex:"  ..steamhex.."")
            TriggerClientEvent("Notify",source,"aviso","Seu ping:"  ..ping.."")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAR CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearchest',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] then
            local identity2 = vRP.getUserIdentity(parseInt(args[2]))
            if vRP.request(source,"Deseja limpar o baú <b>"..args[1].."</b> ?",30) then
                vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(args[1]) })
                TriggerClientEvent("Notify",source,'sucesso',"Você limpou o baú <b>"..args[1].."</b>.")
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminClearChest", text = "Limpou o baú "..args[1] })
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET HEALTH --[[ (101-400) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('sethealth',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id,"admin.permissao") then
--        if args[1] then
--            vRPclient.setHealth(source,args[1])
--		end
--	end
--end)

RegisterCommand('hp',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if user_id == 0 or user_id == 1 then
		if args[1] then
			local vida = parseInt(args[2])
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				TriggerClientEvent('waze:ExcecaoVida', nplayer)
				vRPclient.setHealth(nplayer,vida)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"mod.permissao") then
			if args[1] then

				if string.lower(args[1]) == 'delexue' then
					if user_id ~= 1 and user_id ~= 5 then
						return
					end
				end

				if string.lower(args[1]) == 'deluxe' or string.lower(args[1]) == 'porschewaze' then

					if user_id ~= 1 then 
						TriggerClientEvent('Notify', source, "negado", 'Esse carro é somente para o waze.') 
						return 
					end

				end
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCar", text = "Spawnou o veículo "..(args[1]) })
				--TriggerClientEvent('spawnarveiculo',source,args[1],identity.registration)
				vCLIENT.spawnVeh(source,args[1],identity.registration)
				TriggerEvent("setPlateEveryone",identity.registration)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('radm',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"suporte.permissao") then
		if #args == 1 then
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			local identity = vRP.getUserIdentity(user_id)
			local nidentity = vRP.getUserIdentity(nuser_id)

			if nuser_id then

				local resposta = vRP.prompt(source,"Resposta particular:","")
				if resposta == "" then
					return
				end

				for k, v in pairs(vRP.getUsersByPermission('suporte.permissao')) do
					TriggerClientEvent('chatMessage', vRP.getUserSource(v),"[ATENDIMENTO ADMIN] "..identity.name.." "..identity.firstname.." respondeu " .. nidentity.name .. " " .. nidentity.firstname .. " (" .. nuser_id .. ")",{255,80,80}, resposta)
				end
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCommon", text = "Respondeu o jogador ("..nuser_id..") "..nidentity.name.." "..nidentity.firstname.."\nMensagem: "..resposta })
				TriggerClientEvent('chatMessage',nsource,"[ATENDIMENTO ADMIN] Para responder, utilize o /call adm.",{255,80,80}, '')
				TriggerClientEvent('chatMessage',nsource,"[ATENDIMENTO ADMIN] Recebida de "..identity.name.." "..identity.firstname .. " (" .. user_id .. ")",{255,80,80}, resposta)
			end
		end
	end
end)


RegisterCommand('admins',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local ceo = vRP.getUsersByPermission("ceo.permissao")
	local ceo2 = 0
	local ceo_nomes = ""
    local admin = vRP.getUsersByPermission("adm2.permissao")
	local admin2 = 0
	local admin_nomes = ""
    local mod = vRP.getUsersByPermission("mod2.permissao")
	local mod2 = 0
	local mod_nomes = ""
    local sup = vRP.getUsersByPermission("sup2.permissao")
	local sup2 = 0
	local sup_nomes = ""
	local help = vRP.getUsersByPermission("helper.permissao")
	local help2 = 0
	local help_nomes = ""
    local aprwl = vRP.getUsersByPermission("apv2.permissao")
	local aprwl2 = 0
	local aprwl_nomes = ""
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if user_id then
            for k,v in ipairs(ceo) do
				local identity = vRP.getUserIdentity(parseInt(v))
				local cargo = waze.getUserGroupByType(parseInt(v),"gerente")
				ceo_nomes = ceo_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. " <b>("..cargo..")</b><br>"
				ceo2 = ceo2 + 1
			end
			for k,v in ipairs(admin) do
			    local identity = vRP.getUserIdentity(parseInt(v))
				local cargo = waze.getUserGroupByType(parseInt(v),"gerente")
			    admin_nomes = admin_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. " <b>("..cargo..")</b><br>"
			    admin2 = admin2 + 1
			end
			for k,v in ipairs(mod) do
			    local identity = vRP.getUserIdentity(parseInt(v))
				local cargo = waze.getUserGroupByType(parseInt(v),"gerente")
			    mod_nomes = mod_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. " <b>("..cargo..")</b><br>"
			    mod2 = mod2 + 1
			end
			for k,v in ipairs(sup) do
			    local identity = vRP.getUserIdentity(parseInt(v))
				local cargo = waze.getUserGroupByType(parseInt(v),"gerente")
			    sup_nomes = sup_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. " <b>("..cargo..")</b><br>"
			    sup2 = sup2 + 1
			end
			for k,v in ipairs(help) do
			    local identity = vRP.getUserIdentity(parseInt(v))
				local cargo = waze.getUserGroupByType(parseInt(v),"gerente")
			    help_nomes = help_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. " <b>("..cargo..")</b><br>"
			    help2 = help2 + 1
			end
			for k,v in ipairs(aprwl) do
			    local identity = vRP.getUserIdentity(parseInt(v))
				local cargo = waze.getUserGroupByType(parseInt(v),"gerente")
			    aprwl_nomes = aprwl_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. " <b>("..cargo..")</b><br>"
			    aprwl2 = aprwl2 + 1
			end
			if parseInt(ceo2) < 0 then
            TriggerClientEvent("Notify",source,"CEOS", "Atualmente <b>NENHUM</b> online.")
		    elseif parseInt(ceo2) > 0 then
				TriggerClientEvent("Notify",source,"CEOS", "Atualmente <b>"..#ceo.."</b> online.<br>"..ceo_nomes)
			end
			if parseInt(admin2) == 0 then
				TriggerClientEvent("Notify",source,"ADMINISTRADORES", "<b>Nenhum administrador disponível.</b>")
			elseif parseInt(admin2) > 0 then
				TriggerClientEvent("Notify",source,"ADMINISTRADORES", "Atualmente <b>"..#admin.."</b> online.<br>"..admin_nomes)
			end
			if parseInt(mod2) == 0 then
				TriggerClientEvent("Notify",source,"MODERADORES", "<b>Nenhum moderador disponível.</b>")
			elseif parseInt(mod2) > 0 then
				TriggerClientEvent("Notify",source,"MODERADORES", "Atualmente <b>"..#mod.."</b> online.<br>"..mod_nomes)
			end
			if parseInt(sup2) == 0 then
				TriggerClientEvent("Notify",source,"SUPORTES", "<b>Nenhum suporte disponível.</b>")
			elseif parseInt(sup2) > 0 then
				TriggerClientEvent("Notify",source,"SUPORTES", "Atualmente <b>"..#sup.."</b> online.<br>"..sup_nomes)
			end
			if parseInt(help2) == 0 then
				TriggerClientEvent("Notify",source,"HELPERS", "<b>Nenhum helper disponível.</b>")
			elseif parseInt(help2) > 0 then
				TriggerClientEvent("Notify",source,"HELPERS", "Atualmente <b>"..#help.."</b> online.<br>"..help_nomes)
			end
			if parseInt(aprwl2) == 0 then
				TriggerClientEvent("Notify",source,"APROVADORES", "<b>Nenhum aprovador disponível.</b>")
			elseif parseInt(aprwl2) > 0 then
				TriggerClientEvent("Notify",source,"APROVADORES", "Atualmente <b>"..#aprwl.."</b> online.<br>"..aprwl_nomes)
			end
        end
    end
end)

RegisterCommand('facs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local crips = vRP.getUsersByPermission("crips.permissao")
    local bloods = vRP.getUsersByPermission("bloods.permissao")
    local vagos = vRP.getUsersByPermission("vagos.permissao")
    local grove = vRP.getUsersByPermission("grove.permissao")
    local ballas = vRP.getUsersByPermission("ballas.permissao")
    local bratva = vRP.getUsersByPermission("bratva.permissao")
    local cosa = vRP.getUsersByPermission("siciliana.permissao")
    --[[ local HellAngels = vRP.getUsersByPermission("hells.permissao")
    local warlocks = vRP.getUsersByPermission("warlocks.permissao") ]]
    local lifeinvader = vRP.getUsersByPermission("lifeinvader.permissao")
    local bahamas = vRP.getUsersByPermission("bahamas.permissao")
    --[[ local scorp = vRP.getUsersByPermission("scripted.permissao") ]]
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if user_id then
			TriggerClientEvent("Notify",source,"DROGAS","<b>Total de Drogas: "..#ballas + #vagos + #grove.."<br><br><b>Ballas Online</b>: <b>"..#ballas.."<br>Vagos Online</b>: <b>"..#vagos.."<br>Groove Online</b>: <b>"..#grove.."<br>",5000)
            TriggerClientEvent("Notify",source,"ARMAS","<b>Total de Armas: "..#crips + #bloods.."<br><br><b>Crips Online</b>: <b>"..#crips.."<br>Bloods Online</b>: <b>"..#bloods.."<br>",5000)
            TriggerClientEvent("Notify",source,"MUNIÇÃO","<b>Total de Munição: "..#bratva + #cosa.."<br><br><b>Bratva Online</b>: <b>"..#bratva.."<br>Siciliana Online</b>: <b>"..#cosa.."<br>",5000)
            TriggerClientEvent("Notify",source,"LAVAGEM","<b>Total de Lavagem: "..#bahamas + #lifeinvader.."<br><br><b>Bahamas Online</b>: <b>"..#bahamas.."<br>Life Invader Online</b>: <b>"..#lifeinvader.."<br>",5000)
            TriggerClientEvent('chatMessage',source,"CRIPS ONLINE:",{0,0,255},crips)
            TriggerClientEvent('chatMessage',source,"BLOODS ONLINE:",{255,0,0},bloods)
            TriggerClientEvent('chatMessage',source,"VAGOS ONLINE:",{255,255,0},vagos)
            TriggerClientEvent('chatMessage',source,"GROVE ONLINE:",{0,255,0},grove)
            TriggerClientEvent('chatMessage',source,"BALLAS ONLINE:",{255,0,255},ballas)
            TriggerClientEvent('chatMessage',source,"MAFIA BRATVA ONLINE:",{0,0,0},bratva)
            TriggerClientEvent('chatMessage',source,"MAFIA SICILIANA ONLINE:",{255,255,255},cosa)
            --[[ TriggerClientEvent('chatMessage',source,"HELLS ANGELS ONLINE:",{233,150,122},HellAngels)
            TriggerClientEvent('chatMessage',source,"WARLOCKS ONLINE:",{176,224,230},warlocks) ]]
            TriggerClientEvent('chatMessage',source,"BAHAMAS ONLINE:",{0,250,154},bahamas)
            --[[ TriggerClientEvent('chatMessage',source,"SCRIPTED ONLINE:",{0,255,0},scorp) ]]
            TriggerClientEvent('chatMessage',source,"LIFEINVADER ONLINE:",{255,228,225},lifeinvader)
            
        end
    end
end)

------------------------------------------------------------------fACS---------------------------------------------------
--RegisterCommand('facs2', function(source,args,rawCommand)
--    local user_id = vRP.getUserId(source)
--    local player = vRP.getUserSource(user_id)
--    local crips = vRP.getUsersByPermission("crips.permissao")
--	  local crips_nomes = ""
--	  local crp = 0
--
--	 local bloods = vRP.getUsersByPermission("bloods.permissao")
--	 local bloods_nomes = ""
--	 local bld = 0
--
--	 if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
--
--		
--		for k,v in ipairs(crips) do
--            crips_nomes = crips_nomes .. "" .. v .. ", "
--            crp = crp + 1
--		end
--		----------------------------------------------------------------------
--
--		for k1,v1 in ipairs(bloods) do
--            bloods_nomes = bloods_nomes .. "" .. v1 .. ", "
--            bld = bld + 1
--		end
--
--
--        if parseInt(waze) > -1 then
--            TriggerClientEvent('chatMessage',source, "CRIPS ONLINE: ,{0,0,255}, ("..crp..") "..crips_nomes.." ")
--            TriggerClientEvent('chatMessage',source,"BLOODS ONLINE:",{255,0,0},bloods_nomes)
--		end
--    end
--end)
----------------------------------------------------------------------------------------------------------------------------------------
-- VIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vips',function(source,args,rawCommand)
    
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		local elite = vRP.getUsersByPermission("wazeelite.permissao")
        local vip = vRP.getUsersByPermission("waze.permissao")

		TriggerClientEvent('chatMessage',source,"VIPS waze ELITE ONLINE",{255, 60, 51},elite)
		TriggerClientEvent('chatMessage',source,"waze ONLINE",{51, 255, 70},vip)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('idp',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if vRP.hasPermission(user_id, 'admin.permissao') then	
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id == 1 or nuser_id == 0 then nuser_id = user_id end
			TriggerClientEvent("Notify",source,'importante',"Jogador próximo: <b>ID:"..nuser_id.."</b>.")
		else
			TriggerClientEvent("Notify",source,"aviso","<b>Nenhum Jogador Próximo</b>")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ RegisterCommand('adm', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') or vRP.hasPermission(user_id,"mod.permissao") then
        if args[1] then
            local tipo = args[1]
			if (tipo == 'normal') or (tipo == 'verm') or (tipo == 'ai') then
				
                local titulo = vRP.prompt(source, 'Título da mensagem', 'AVISO ADMIN')
				if titulo == '' then TriggerClientEvent("Notify",source,'aviso','Você não especificou um título.',10000) return	end

				local msg = vRP.prompt(source, 'Mensagem', '')
				if msg == '' then TriggerClientEvent("Notify",source,'aviso','Você não especificou uma mensagem.',10000) return end

				TriggerClientEvent('wazeUi:MostrarNotAdm', -1, {titulo, msg, tipo})
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCommon", text = "Enviou um anúncio adm com o Título: "..titulo.."\nMensagem do anúncio: "..msg })
			end
		else
			TriggerClientEvent("Notify",source,'aviso','O tipo precisa ser válido. Tipos válidos: [normal|verm|ai]',10000)
        end
    end
end) ]]

RegisterCommand('adm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id, 'admin.permissao') or vRP.hasPermission(user_id,"mod.permissao") then
			local mensagem = vRP.prompt(source,"Mensagem:","")
			if mensagem == "" then
				TriggerClientEvent("Notify",source,'aviso','Você não especificou uma mensagem.',10000)
				return
			end
			TriggerClientEvent("Notify",-1,"<b>ANÚNCIO ADMINISTRATIVO</b>","<b>"..mensagem.."</b><br>Mensagem enviada pela Administração",30000,'bottom')
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCommon", text = "Enviou um anúncio admin: "..mensagem })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD VEHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"mod.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nsource)
            local nsource = vRP.getUserSource(parseInt(args[2]))
            local identity2 = vRP.getUserIdentity(parseInt(args[2]))
            if vRP.request(source,"Deseja adicionar o veículo <b>"..vRP.vehicleName(args[1]).."</b> para o Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b> ?",30) then
                vRP.execute("creative/add_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) })
                TriggerClientEvent("Notify",source,"sucesso","Você adicionou o veículo <b>"..vRP.vehicleName(args[1]).."</b> para o Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b>.")
                if nsource then
                    TriggerClientEvent("Notify",nsource,"sucesso","Foi adicionado o veículo <b>"..vRP.vehicleName(args[1]).."</b> na sua garagem.",10000)
                end
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminGiveCar", text = "Adicionou o veículo "..vRP.vehicleName(args[1]).." na garagem do jogador ("..parseInt(args[2])..") "..identity2.name.." "..identity2.firstname })
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM VEHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"mod.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nsource)
            local nsource = vRP.getUserSource(parseInt(args[2]))
            local identity2 = vRP.getUserIdentity(parseInt(args[2]))
            if vRP.request(source,"Deseja remover o veículo <b>"..vRP.vehicleName(args[1]).."</b> do Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b> ?",30) then
    			vRP.execute("creative/rem_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1] })
                TriggerClientEvent("Notify",source,"sucesso","Você removeu o veículo <b>"..vRP.vehicleName(args[1]).."</b> do Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b>.")
					if nsource then
                    TriggerClientEvent("Notify",nsource,"aviso","Foi removido o veículo <b>"..vRP.vehicleName(args[1]).."</b> da sua garagem.",10000)
                end
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminTakeCar", text = "Removeu o veículo "..vRP.vehicleName(args[1]).." na garagem do jogador ("..parseInt(args[2])..") "..identity2.name.." "..identity2.firstname })
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('alg',function(source,args,rawCommand)
   local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
       if args[1] then
           local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("admcuff",nplayer)
            end
        else
            TriggerClientEvent("admcuff",source)
        end
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- ALGEMAR ADM 
-------------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('admalg', function(source, args, rawCmd)
--    
--	local user_id = vRP.getUserId(source)
--	if vRP.hasGroup(user_id,'admin') then
--		if args[1] then
--			local nplayer = vRP.getUserSource(parseInt(args[1]))
--			vRPclient.toggleHandcuff(nplayer)
--		else
--			vRPclient.toggleHandcuff(source)
--		end
--	end
--end)
RegisterCommand('aladm',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if nplayer then
		if not vRPclient.isHandcuffed(source) then
            if vRP.hasPermission(user_id,"admin.permissao")then
                if vRPclient.isHandcuffed(nplayer) then
                    vRPclient.toggleHandcuff(nplayer)
                    TriggerClientEvent('removealgemas',nplayer)
                else
                    vRPclient.toggleHandcuff(nplayer)
                    TriggerClientEvent('setalgemas',nplayer)
                end
            end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKIN
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand("trunkin",function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		if vRP.hasPermission(user_id,"admin.permissao") then
--			TriggerClientEvent("vrp_admin:EnterTrunk",source)
--		end
--	end
--end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- CHECKTRUNK
-------------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand("checktrunk",function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if user_id then
--        if vRP.hasPermission(user_id,"admin.permissao") then
--            local nplayer = vRPclient.getNearestPlayer(source,2)
--            if nplayer then
--                TriggerClientEvent("vrp_admin:CheckTrunk",nplayer)
--            end
--        end
--	end
--end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NEY
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ney',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nuser_id = tonumber(args[1])
    local nsource = vRP.getUserSource(nuser_id)
	if user_id then
		if vRP.hasPermission(user_id,'dev.permissao') then
			vCLIENT.neyMar(nsource)
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminNey", text = "Fez o ID "..args[1].." virar o Neymar" })
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TAPA
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tapa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if args[1] then
            if vRP.hasPermission(user_id,'dev.permissao') then
                local nsource = vRP.getUserSource(parseInt(args[1]))
                vCLIENT.makeFly(nsource)
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminSlap", text = "Deu um tabefe no ID "..args[1] })
			end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PNEUADM
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('furarpneu', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"dev.permissao") then
		if args[2] then
			local nsource = vRP.getUserSource(parseInt(args[1]))
			TriggerClientEvent('waze:FurarPneuTeleguiado',nsource, parseInt(args[2]))
		else
			TriggerClientEvent('waze:FurarPneuTeleguiado',source, parseInt(args[1]))
		end
	end
end)

RegisterServerEvent('waze:AskABCSync')
AddEventHandler('waze:AskABCSync', function(a,b)
	vCLIENT.SyncPneuFurado(-1,a,b)
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vCLIENT.applySkinAdmin(nplayer,args[2])
                TriggerClientEvent("Notify",source,"sucesso","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.")
            end
        end
    end
end)

--RegisterCommand("objetos",function(source,args,rawCommand)
--    
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id,"suporte.permissao") then
--		if user_id then
--			if not vRPclient.isInVehicle(source) then
--				local x,y,z = vRPclient.getPosition(source)
--				local data = vRP.getUserDataTable(user_id)
--				if data then
--					vRPclient._setCustomization(source,data.customization)
--					--TriggerClientEvent("syncarea",-1,x,y,z,2)
--					vCLIENT.syncArea(-1,x,y,z,2)
--					TriggerClientEvent("Notify",source,"sucesso","Você limpou todos Obejetos.")
--				end
--			end
--		end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
    TriggerClientEvent("syncdeleteobj",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if not args[1] then
			local vehicle = vRPclient.getNearestVehicle(source,7)
			if vehicle then
				TriggerClientEvent('reparar',source,vehicle)
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminFix", text = "Reparou um veículo" })
			end
		else 
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			local vehicle = vRPclient.getNearestVehicle(nsource,7)
			if vehicle then
				TriggerClientEvent('reparar',nsource,vehicle)
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminFix", text = "Reparou o veículo do ID "..args[1] })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"wazepass.permissao") then
		--if parseInt(args[1]) == 5 or parseInt(args[1]) == 388 or parseInt(args[1]) == 1270 or parseInt(args[1]) == 25 or parseInt(args[1]) == 416 or parseInt(args[1]) == 1270 or parseInt(args[1]) == 23 or parseInt(args[1]) == 2861 or parseInt(args[1]) == 199 or parseInt(args[1]) == 124 or parseInt(args[1]) == 352 or parseInt(args[1]) == 651 then 
		--	if user_id ~= -1 and user_id ~= 5 then 
		--		return 
		--	end
		--end
        if args[1] then
			if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,399)
                TriggerEvent('waze:ExcecaoGod')
                TriggerEvent('waze:ExcecaoVida')
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminGod", text = "Deu god no ID "..args[1] })
            end
		end
        else
            vRPclient.killGod(source)
			vRPclient.setHealth(source,399)
            TriggerEvent('waze:ExcecaoGod')
            TriggerEvent('waze:ExcecaoVida')
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminGod", text = "Deu god em si mesmo" })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD ALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ceo.permissao") then
    	local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
            	vRPclient.killGod(id)
				vRPclient.setHealth(id,399)
				--print(id)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"mod.permissao") then
			local vehicle = vRPclient.getNearVehicle(source,7)
			if vehicle then
				vCLIENT.vehicleHash(source,vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nuser_id = tonumber(args[1])
    local nsource = vRP.getUserSource(nuser_id)

    if not args[1] then
        if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
            vCLIENT.vehicleTuning(source)
            TriggerClientEvent("Notify",source,"sucesso","Você tunou o <b>veículo</b> Tuning sucesso.")
        else
            TriggerClientEvent("Notify",source,"negado",'Você não tem acesso a esse comando')
        end
    else
        if vRP.hasPermission(user_id,"suporte.permissao") then
            local vehicle = vRPclient.getNearestVehicle(nsource,7)
            if vehicle then
                vCLIENT.vehicleTuning2(nsource,vehicle)
                TriggerClientEvent("Notify",source,"sucesso","Você tunou o <b>veículo</b> Tuning2 sucesso.")
            end
        end
    end
end)
--RegisterCommand('tuning2',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--    local nuser_id = tonumber(args[1])
--    local nsource = vRP.getUserSource(nuser_id)
--	if vRP.hasPermission(user_id,"suporte.permissao") then
--        local vehicle = vRPclient.getNearestVehicle(nsource,7)
--        if vehicle then
--            vCLIENT.vehicleTuning2(nsource,vehicle)
--            TriggerClientEvent("Notify",source,"sucesso","Você tunou o <b>veículo</b> Tuning2 sucesso.")
--       end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAPUZADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('capuzadm', function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setCapuz(nplayer)
                vRP.closeMenu(nplayer)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCAPUZADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rcapuzadm', function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setCapuz(nplayer)
			end
		else
			vRPclient.setCapuz(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN RG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rg2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mod.permissao") or  vRP.hasPermission(user_id,"suporte.permissao")  then
        local nuser_id = parseInt(args[1])
        local identity = vRP.getUserIdentity(nuser_id)
        local bankMoney = vRP.getBankMoney(nuser_id)
        local walletMoney = vRP.getMoney(nuser_id)
        local pesquisa = PegarDatatable(nuser_id)
		if args[1] then
            if pesquisa[1] and pesquisa[1] ~= nil then

                        local result = json.decode(pesquisa[1].dvalue)
                        local grupos = ''
                        if result.groups then
                            for k , v in pairs(result.groups) do
                                grupos = grupos .. ' | <b>' .. k .. '</b>'
							end
						end    
           TriggerClientEvent("Notify",source,"importante","ID: <b>"..parseInt(nuser_id).."</b><br>Nome: <b>"..identity.name.." "..identity.firstname.."</b><br>Idade: <b>"..identity.age.."</b><br>Telefone: <b>"..identity.phone.."</b><br>Carteira: <b>"..vRP.format(parseInt(walletMoney)).."</b><br>Banco: <b>"..vRP.format(parseInt(bankMoney)).."</b><br>Sets: <b>"..grupos.."</b>",5000)    
        else
            TriggerClientEvent("Notify",source,"negado","Digite o ID desejado!")
		end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpararea',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        vCLIENT.syncArea(-1,x,y,z)
        TriggerClientEvent("Notify",source,"sucesso","Você limpou a área com sucesso.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('setreset',function(source,args,rawCommand)
--    local user_id = vRP.getUserId(source)
--    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
--        if user_id then
--            if args[1] then
--                local identity = vRP.getUserIdentity(parseInt(args[1]))
--                if vRP.request(source,"Deseja resetar o Passaporte: <b>"..parseInt(args[1]).." "..identity["name"].." "..identity["firstname"].."</b> ?",30) then
--                    local id = vRP.getUserSource(parseInt(args[1]))
--
--                    if id ~= nil then  
--                        vRP.kick(id,"Você foi expulso da cidade.")
--                    end
--
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "currentCharacterMode" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:datatable" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:multas" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:prisao" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:spawnController" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:tattoos" })
--                    TriggerClientEvent("Notify",source,"sucesso",'CIRURGIA:',"Você resetou o Passaporte: <b>"..parseInt(args[1]).." "..identity["name"].." "..identity["firstname"].."</b>.")
--                end          
--            end
--        end
--    end
--end)
RegisterCommand('setreset',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if user_id then
            if args[1] then
                local identity = vRP.getUserIdentity(parseInt(args[1]))
                local id = vRP.getUserSource(parseInt(args[1]))
                vRP.setUData(parseInt(args[1]),"vRP:datatable",json.encode(vRP.getUserDataTable(parseInt(args[1]))))
                vRP.setUData(parseInt(args[1]),"vRP:spawnController",parseInt(0))
                vRP.setUData(parseInt(args[1]),"vRP:tattoos",json.encode(vRP.getUserDataTable(parseInt(args[1])))) 
                vRP.kick(id,"Você foi kickado para Resetar a Aparência !")
                TriggerClientEvent("Notify",source,"importante","Você resetou a Aparência de(a): <b>"..parseInt(args[1]).." "..identity.name.." "..identity.firstname.."</b>.")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET NAME
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("waze/att_identidade","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, registration = @registration, age = @age WHERE user_id = @user_id")
RegisterCommand('rename', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] then
			local nuser_id = parseInt(args[1])
			--if user_id ~= 1 then 
			--	TriggerClientEvent('Notify', source, 'negado', 'Somente o bilu pode alterar isso.') 
			--	return 
			--end
			local nidentity = vRP.getUserIdentity(nuser_id)

			local pNome = vRP.prompt(source, 'Primeiro nome:', nidentity.name)
			if pNome == '' then return end

			local sNome = vRP.prompt(source, 'Segundo nome:', nidentity.firstname)
			--if sNome == '' then 
			--	return 
			--end

			-- local nRG = vRP.prompt(source, 'RG:', nidentity.registration)
			-- if nRG == '' then return end

			local nIdade = vRP.prompt(source, 'Idade:', nidentity.age)
			if nIdade == '' then return end

			vRP.execute("waze/att_identidade",{
				user_id = nuser_id,
				registration = nidentity.registration,
				firstname = sNome,
				name = pNome,
				age = nIdade
			})
			TriggerEvent("identity:atualizar",nuser_id)
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminRename", text = "Renomeou o ID "..nuser_id.."\nNome Completo: "..pNome.." "..sNome.."\nIdade: "..nIdade })
		end
	end
end)

RegisterCommand('setnum',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "ceo.permissao")  then
        local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
        local phone = vRP.prompt(source, "Novo Telefone (6 Digitos Exemplo = 777-777)", "")
        local identity = vRP.getUserIdentity(parseInt(idjogador))
        vRP.execute("vRP/update_user_identity",{
            user_id = idjogador,
            firstname = identity.firstname,
            name = identity.name,
            age = identity.age,
            registration = identity.registration,
            phone = phone
        })
		TriggerEvent("identity:atualizar",idjogador)
		exports["waze-system"]:sendLogs(user_id,{ webhook = "adminNumber", text = "Trocou o número do ID "..idjogador.."\nNovo Número: "..phone })
    end
end)

RegisterCommand('setplaca',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "ceo.permissao")  then
        local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
        local rg = vRP.prompt(source, "Novo RG (8 Digitos)", "")
        local identity = vRP.getUserIdentity(parseInt(idjogador))
        vRP.execute("vRP/update_user_identity",{
            user_id = idjogador,
            firstname = identity.firstname,
            name = identity.name,
            age = identity.age,
            registration = rg,
            phone = identity.phone
        })
		TriggerEvent("identity:atualizar",idjogador)
		exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPlate", text = "Trocou a placa do ID "..idjogador.."\nNova Placa: "..rg })
		--TriggerEvent("identity:atualizar",nuser_id)
    end
end)

RegisterCommand('setplate',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ceo.permissao") then
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		if args[1] and string.lower(args[1]) == 'id' and args[2] then
			local nuser_id = parseInt(args[2])
			local nidentity = vRP.getUserIdentity(nuser_id)
			TriggerClientEvent('waze:AdminSetPlaca',-1, vehicle, nidentity.registration)
			TriggerClientEvent('Notify', source, 'sucesso', 'PLACA SETADA: <br>ID: '.. nidentity.name .. ' ' .. nidentity.firstname .. ' (' .. nuser_id..')<br>PLACA (RG): '..nidentity.registration)
		elseif args[1] and not args[2] then
			TriggerClientEvent('waze:AdminSetPlaca',-1, vehicle, args[1])
			TriggerClientEvent('Notify', source, 'sucesso', 'PLACA SETADA: '..args[1])
			TriggerEvent("identity:atualizar",nuser_id)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cvadm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer then
			vRPclient.putInNearestVehicleAsPassenger(nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rvadm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end)

RegisterCommand('revall', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.permissao') then
		local users = vRP.getUsers()
		for k, v in pairs(users) do 
			local id = vRP.getUserSource(v)
			vRPclient._setHealth(id, 395)
		end
	end
end)

RegisterCommand('godn', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.permissao') then
		local user = vRPclient.getNearestPlayer(source, 5)
		TriggerClientEvent('waze:ExcecaoVida', user)
		vRPclient.killGod(user)
		vRPclient.setHealth(user,395)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"aprovadorwl.permissao") then
        if args[1] then
            vRP.setWhitelisted(parseInt(args[1]),true)
            TriggerClientEvent("Notify",source,"sucesso","Voce aprovou o passaporte <b>"..args[1].."</b> na whitelist.")
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminWhitelist", text = "Aprovou a whitelist do ID "..args[1] })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"aprovadorwl.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Voce retirou o passaporte <b>"..args[1].."</b> da whitelist.")
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminUnwhitelist", text = "Removeu a whitelist do ID "..args[1] })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"Você foi expulso da cidade.")
				TriggerClientEvent("Notify",source,"sucesso","Voce kickou o passaporte <b>"..args[1].."</b> da cidade.")
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminKick", text = "Expulsou o ID "..args[1].." do servidor" })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCmd)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if not vRP.hasPermission(user_id,"suporte.permissao") then 
		return 
	end

	if not args[1] then return end
    
    local banReason = vRP.prompt(source,"Motivo:","")
    if banReason == "" then return end

    local request = exports["waze-system"]:permanentBan({
        user_id = parseInt(args[1]),
        staff_id = parseInt(user_id),
        reason = tostring(banReason)
    })
    
    sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." baniu permanentemente o ID "..args[1])
	exports["waze-system"]:sendLogs(user_id,{ webhook = "adminBan", text = "Baniu permanentemente o ID "..args[1].."\nMotivo: "..banReason })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tempban",function(source,args,rawCmd)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if not vRP.hasPermission(user_id,"suporte.permissao") then 
		return 
	end

	if not args[1] then return end
    
    local banReason = vRP.prompt(source,"Motivo:","")
    if banReason == "" then return end

    local timeBan = vRP.prompt(source,"Tempo de ban em dias: (1,2,3)","")
    if timeBan == "" then return end

    exports["waze-system"]:temporaryBan({
        user_id = parseInt(args[1]),
        staff_id = parseInt(user_id),
        reason = tostring(banReason),
        timeBan = timeBan
    })
    
        sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." baniu por "..timeBan.." dias o ID "..args[1])
		exports["waze-system"]:sendLogs(user_id,{ webhook = "adminBan", text = "Baniu temporariamente o ID "..args[1].." por "..timeBan.." dias\nMotivo: "..banReason })
end)

RegisterCommand("blocklist",function(source,args,rawCmd)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if not vRP.hasPermission(user_id,"suporte.permissao") then 
		return 
	end

	if not args[1] then return end

    local timeBlock = vRP.prompt(source,"Tempo da blocklist em dias: (1,2,3)","")
    if timeBlock == "" then return end

    exports["waze-system"]:blockList({
        user_id = parseInt(args[1]),
        staff_id = parseInt(user_id),
        timeBlock = timeBlock
    })
        sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." colocou blocklist de "..timeBlock.." dias para o ID "..args[1])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCmd)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if not vRP.hasPermission(user_id,"mod.permissao") then 
		return 
	end

	if not args[1] then return end
    
    exports.oxmysql:executeSync("DELETE FROM bans WHERE user_id = ?",{ parseInt(args[1]) })
	TriggerClientEvent("Notify",source,"sucesso","Você desbaniu o jogador "..args[1].."!")
    sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." desbaniu o ID "..args[1])
	exports["waze-system"]:sendLogs(user_id,{ webhook = "adminUnban", text = "Desbaniu o ID "..args[1] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('money',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	--if user_id == 1 or user_id == 0 or user_id == 2 then
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			if string.sub(args[1], 1, 1) ~= "-" then
				vRP.giveMoney(user_id,parseInt(args[1]))
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminMoney", text = "Adicionou $"..vRP.format(parseInt(args[1])).." a sua conta bancária" })
				TriggerClientEvent('Notify', source, 'financeiro', 'Adicionado ' .. args[1] .. ' à sua conta.')
			else
				local dinheiro = string.sub(args[1],2)
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminMoney", text = "Removeu $"..vRP.format(parseInt(args[1])).." da sua conta bancária" })
				vRP.tryFullPayment(user_id, parseInt(dinheiro))
				TriggerClientEvent('Notify', source, 'financeiro', 'Debitado ' .. args[1] .. ' de sua conta.')
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"wazepass.permissao") then
		exports["waze-system"]:sendLogs(user_id,{ webhook = "adminNoclip", text = "Usou o noclip" })
		vRPclient.toggleNoclip(source)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"suporte.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			coords[#coords + 1] = parseInt(coord)
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)

RegisterCommand('motor',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('waze:RepararMotor', source, parseInt(args[1]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		local x,y,z = vRPclient.getPosition(source)
        vRP.prompt(source,"Cordenadas:",tD(x)..","..tD(y)..","..tD(z))
	end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
	end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		local lugar = vRP.prompt(source,"Lugar:","")
		local heading = vRPclient.getUserHeading(source)
		if lugar == "" then
			return
		end
		vRP.prompt(source,"Lugar:","[1] = { ['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z)..", ['h'] = "..tD(heading).." }\n},")
	end
end)

RegisterCommand('cdsr',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local x,y,z = vRPclient.getPosition(source)
        local heading = vRPclient.getUserHeading(source)
        local Numeracao = math.random(150,250)
        local numeroCol = math.random(800,1200)
        local lugar = vRP.prompt(source,"Lugar:","")
        local nomecold = vRP.prompt(source,"Nome do Cooldown (Exemplo: AeroTrevor):","")
        local minimo = vRP.prompt(source,"Minimo de Policia:","")
        local maximo = vRP.prompt(source,"Maximo de Policia:","")
        if lugar == "" and nomecold == "" and minimo == "" and maximo == "" then
            return
        end
        vRP.prompt(source,"Coordenadas:"," ['"..lugar.."'] = { -- Nome do estabelecimento \n  ['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z)..", ['h'] = "..tD(heading)..", -- Posição  \n  ['TempoRoubo'] = "..Numeracao..", -- Tempo que demorará pra terminar o roubo \n  ['Recompensa'] = math.random("..math.random(100000,190000)..","..math.random(200000,290000).."), -- Recompensa de dinheiro sujo no roubo  \n  ['TipoCooldown'] = '"..nomecold.."', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN \n  ['Cooldown'] = "..numeroCol..",  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  \n  ['ItemReq'] = 'notebook',  -- Item necessário pra iniciar o roubo, nil = não precisa de item \n  ['MinPoliciais'] = "..minimo..",  -- Mínimo de policiais em serviço pra iniciar o roubo  \n  ['MaxPoliciais'] = "..maximo..", \n  ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial \n  ['Prioridade'] = 'sul' \n},")
    end
end)


function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('aa',function(source,args,rawCommand)
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "chatadm.permissao"
		local cargo = waze.getUserGroupByType(user_id,"gerente")

		if not chatStaff and (not vRP.hasPermission(user_id,"ceo.permissao")) then
			TriggerClientEvent('Notify',source,"negado","O chat está bloqueado.")
			return
		end

		if vRP.hasPermission(user_id,permission) then
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminChat", text = "Enviou uma mensagem no chat staff\nMensagem: "..string.sub(rawCommand, 4) })
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				local chat_id = vRP.getUserId(player)
				if not AdminsChat[chat_id] then
					async(function()
						TriggerClientEvent('chatMessage',player, "["..os.date("%H:%M:%S").."] ["..cargo.."] ".. identity.name.." "..identity.firstname.." ("..identity.user_id.."):",{204, 153, 255}, string.sub(rawCommand, 4))
					end)
				end
			end
	end
end)

RegisterCommand('ac',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local permission = "admin.permissao"
	local cargo = waze.getUserGroupByType(user_id,"gerente")

	if vRP.hasPermission(user_id,permission) then
		exports["waze-system"]:sendLogs(user_id,{ webhook = "adminChat", text = "Enviou uma mensagem no chat admin\nMensagem: "..string.sub(rawCommand, 4) })
		local soldado = vRP.getUsersByPermission(permission)
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			local chat_id = vRP.getUserId(player)
			if not AdminsChat[chat_id] then
				async(function()
					TriggerClientEvent('chatMessage',player, "["..os.date("%H:%M:%S").."] ["..cargo.."] ".. identity.name.." "..identity.firstname.." ("..identity.user_id.."):",{51, 187, 255}, string.sub(rawCommand, 4))
				end)
			end
		end

	end
end)

RegisterCommand('cf',function(source,args,rawCmd)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local vida = vRPclient.getHealth(source)
    if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso morto.') return end
	if not args[1] then return; end
		if vRP.hasGroup(user_id,"bloods") then
			sendFac("BLOODS","".. identity.name.." "..identity.firstname.." (#"..identity.user_id.."):", "bloods.permissao", 255, 133, 102, rawCmd:sub(4))
		elseif vRP.hasGroup(user_id,"crips") then
			sendFac("CRIPS","".. identity.name.." "..identity.firstname.." (#"..identity.user_id.."):", "crips.permissao", 128, 223, 255, rawCmd:sub(4))
		elseif vRP.hasGroup(user_id,"ballas") then
			sendFac("BALLAS","".. identity.name.." "..identity.firstname.." (#"..identity.user_id.."):", "ballas.permissao", 210, 77, 255, rawCmd:sub(4))
		elseif vRP.hasGroup(user_id,"vagos") then
			sendFac("VAGOS","".. identity.name.." "..identity.firstname.." (#"..identity.user_id.."):", "vagos.permissao", 255, 255, 128, rawCmd:sub(4))
		elseif vRP.hasGroup(user_id,"groove") then
			sendFac("GROOVE","".. identity.name.." "..identity.firstname.." (#"..identity.user_id.."):", "grove.permissao", 92, 214, 92, rawCmd:sub(4))
		elseif vRP.hasGroup(user_id,"bahamas") then
			sendFac("BAHAMAS","".. identity.name.." "..identity.firstname.." (#"..identity.user_id.."):", "bahamas.permissao", 255, 102, 163, rawCmd:sub(4))
		elseif vRP.hasGroup(user_id,"lifeinvader") then
			sendFac("LIFE INVADER","".. identity.name.." "..identity.firstname.." (#"..identity.user_id.."):", "lifeinvader.permissao", 255, 184, 77, rawCmd:sub(4))
		elseif vRP.hasGroup(user_id,"bratva") then
			sendFac("BRATVA","".. identity.name.." "..identity.firstname.." (#"..identity.user_id.."):", "bratva.permissao", 115, 115, 115, rawCmd:sub(4))
		elseif vRP.hasGroup(user_id,"siciliana") then
			sendFac("SICILIANA","".. identity.name.." "..identity.firstname.." (#"..identity.user_id.."):", "siciliana.permissao", 242, 242, 242, rawCmd:sub(4))
	end
end)

RegisterCommand('tf',function(source,args,rawCmd)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local permission = "chatadm.permissao"
	local cargo = waze.getUserGroupByType(user_id,"gerente")
	if vRP.hasPermission(user_id,permission) then
		if not args[1] then return; end
		local soldado = vRP.getUsersByPermission(permission)
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			local chat_id = vRP.getUserId(player)
			if not AdminsChat[chat_id] then
				async(function()
					TriggerClientEvent("chatMessage",player,"[CHAT FACS] Bloods | "..identity.name.." "..identity.firstname.." (#"..identity.user_id.."):",{255, 133, 102},rawCmd:sub(4))
					TriggerClientEvent("chatMessage",player,"[CHAT FACS] Crips | "..identity.name.." "..identity.firstname.." (#"..identity.user_id.."):",{128, 223, 255},rawCmd:sub(4))
					TriggerClientEvent("chatMessage",player,"[CHAT FACS] Ballas | "..identity.name.." "..identity.firstname.." (#"..identity.user_id.."):",{210, 77, 255},rawCmd:sub(4))
					TriggerClientEvent("chatMessage",player,"[CHAT FACS] Vagos | "..identity.name.." "..identity.firstname.." (#"..identity.user_id.."):",{255, 255, 128},rawCmd:sub(4))
					TriggerClientEvent("chatMessage",player,"[CHAT FACS] Groove | "..identity.name.." "..identity.firstname.." (#"..identity.user_id.."):",{92, 214, 92},rawCmd:sub(4))
					TriggerClientEvent("chatMessage",player,"[CHAT FACS] Bahamas | "..identity.name.." "..identity.firstname.." (#"..identity.user_id.."):",{255, 102, 163},rawCmd:sub(4))
					TriggerClientEvent("chatMessage",player,"[CHAT FACS] Life Invader | "..identity.name.." "..identity.firstname.." (#"..identity.user_id.."):",{255, 184, 77},rawCmd:sub(4))
					TriggerClientEvent("chatMessage",player,"[CHAT FACS] Bratva | "..identity.name.." "..identity.firstname.." (#"..identity.user_id.."):",{115, 115, 115},rawCmd:sub(4))
					TriggerClientEvent("chatMessage",player,"[CHAT FACS] Siciliana | "..identity.name.." "..identity.firstname.." (#"..identity.user_id.."):",{242, 242, 242},rawCmd:sub(4))
				end)
			end
		end
end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('arma',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") then
		local arma = string.upper(args[1])
		if #args == 1 then
			TriggerClientEvent("Notify",source,"importante","Você pegou a arma "..string.upper(arma).."</b>.")
			vRPclient.giveWeapons(source,{[args[1]] = { ammo = 250 }})
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminWeapon", text = "Spawnou uma "..arma })
		elseif #args == 2 then
			local alvo = vRP.getUserSource(parseInt(args[2]))
			local data2 = vRP.getUserIdentity(parseInt(args[2]))
			if alvo then
				TriggerClientEvent("Notify",source,"importante","Você deu a arma "..string.upper(arma).." para o(a) <b>"..data2["name"].." "..data2["firstname"].."</b>.")
				TriggerClientEvent("Notify",alvo,"importante","Você ganhou a arma "..string.upper(arma).." do(a) <b>"..data["name"].." "..data["firstname"].."</b>.")
				vRPclient.giveWeapons(alvo,{[args[1]] = { ammo = 250 }})
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminWeapon", text = "Spawnou uma "..arma.." para o ID "..args[2] })
			else
				TriggerClientEvent('Notify',source,"negado","Especifique um ID.")
			end
		else
			TriggerClientEvent('Notify',source,"negado","Especifique uma arma. Ex: weapon_pistol, weapon_carbinerifle, etc.")
		end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOQUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('estoque',function(source,args,rawCommand)
    
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] and args[2] then
            vRP.execute("creative/set_estoque",{ vehicle = args[1], quantidade = args[2] })
			TriggerClientEvent("Notify",source,"sucesso","Você colocou mais <b>"..args[2].."</b> no estoque, para o veículo <b>"..args[1].."</b>.") 
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCommon", text = "Adicionou "..args[2].." veículos do modelo "..args[1].." no estoque da concessionária"})
        end
    end
end)

vRP.prepare('waze/get_datatable', 'SELECT * FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey')
vRP.prepare('waze/update_datatable', 'UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id AND dkey = @dkey')

function PegarDatatable(user_id)
    local pesquisa = vRP.query('waze/get_datatable', {user_id = user_id, dkey = 'vRP:datatable'})
    return pesquisa
end

function AtualizarDatatable(user_id, tabela)
    vRP.execute('waze/update_datatable', {user_id = user_id, dkey = 'vRP:datatable', dvalue = json.encode(tabela)})
end
RegisterCommand('group', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, 'admin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or user_id == 0 or user_id == 1 then
        if args[1] then
            local opcao = args[1]
            
            if opcao == 'add' then

                if args[2] then

                    if args[3] then

                        local nuser_id = parseInt(args[2])
                        local nsource = vRP.getUserSource(nuser_id)
						local grupo = args[3]


						if string.upper(args[3]) == 'DEV' or string.upper(args[3]) == 'CEO' then
							if user_id ~= 0 and user_id ~= 1 and user_id ~= 2 then
								TriggerClientEvent('Notify', source, 'negado', 'Somente DEVs podem executar comando nesses grupos.')
								return
							end
						end

						if string.upper(args[3]) == 'ADMIN' or string.upper(args[3]) == 'STARPASS' then
							if not vRP.hasPermission(user_id,"ceo.permissao") then
								TriggerClientEvent('Notify', source, 'negado', 'Somente CEOs podem executar comando nesses grupos.')
								return
							end
						end

						if string.upper(args[3]) == 'waze' or string.upper(args[3]) == 'wazeELITE' then
							if not vRP.hasPermission(user_id,"mod.permissao") then
								TriggerClientEvent('Notify', source, 'negado', 'Somente MODs podem executar comando nesses grupos.')
								return
							end
						end

                        if nsource then
							vRP.addUserGroup(nuser_id,grupo)
							TriggerClientEvent('Notify', source, 'sucesso', 'ID <b>'.. nuser_id .. '</b> adicionado ao grupo <b>'..grupo..'</b>.')
							exports["waze-system"]:sendLogs(user_id,{ webhook = "adminGroup", text = "Adicionou o ID "..nuser_id.." ao grupo "..grupo })
                            
                            sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." setou o ID "..nuser_id.." de "..grupo)
                        else
                            local pesquisa = PegarDatatable(nuser_id)
                            if pesquisa[1] and pesquisa[1] ~= nil then
                                local result = json.decode(pesquisa[1].dvalue)

                                if not result.groups[grupo] then

                                    result.groups[grupo] = true

                                    AtualizarDatatable(nuser_id, result)

									TriggerClientEvent('Notify', source, 'sucesso', 'ID <b>'.. nuser_id .. '</b> adicionado ao grupo <b>'..grupo..'</b>.')
									exports["waze-system"]:sendLogs(user_id,{ webhook = "adminGroup", text = "Adicionou o ID "..nuser_id.." ao grupo "..grupo })
                                    
                                    sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." setou o ID "..nuser_id.." de "..grupo)

                                else
                                    TriggerClientEvent('Notify', source, 'negado', 'Esse jogador já possui esse grupo.')
                                end

                            end
                        end

                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Especifique um GRUPO.')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Especifique um ID.')
                end

            elseif opcao == 'rem' then

                if args[2] then

                    if args[3] then

                        local nuser_id = parseInt(args[2])
                        local nsource = vRP.getUserSource(nuser_id)
                        local grupo = args[3]
						if string.upper(args[3]) == 'DEV' or string.upper(args[3]) == 'CEO' then
							if user_id ~= 0 and user_id ~= 1 and user_id ~= 2 then
								TriggerClientEvent('Notify', source, 'negado', 'Somente DEVs podem executar comando nesses grupos.')
								return
							end
						end

						if string.upper(args[3]) == 'ADMIN' or string.upper(args[3]) == 'STARPASS' then
							if not vRP.hasPermission(user_id,"ceo.permissao") then
								TriggerClientEvent('Notify', source, 'negado', 'Somente CEOs podem executar comando nesses grupos.')
								return
							end
						end

						if string.upper(args[3]) == 'waze' or string.upper(args[3]) == 'wazeELITE' then
							if not vRP.hasPermission(user_id,"mod.permissao") then
								TriggerClientEvent('Notify', source, 'negado', 'Somente MODs podem executar comando nesses grupos.')
								return
							end
						end

                        if nsource then
							vRP.removeUserGroup(nuser_id,grupo)
							TriggerClientEvent('Notify', source, 'sucesso', 'ID <b>'.. nuser_id .. '</b> removido do grupo <b>'..grupo..'</b>.')
								exports["waze-system"]:sendLogs(user_id,{ webhook = "adminUngroup", text = "Removeu o ID "..nuser_id.." do grupo "..grupo })
                            
                            sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." removeu o ID "..nuser_id.." de "..grupo)
                        else
                            local pesquisa = PegarDatatable(nuser_id)

                            if pesquisa[1] and pesquisa[1] ~= nil then

                                local result = json.decode(pesquisa[1].dvalue)

                                if result.groups[grupo] then

                                    result.groups[grupo] = nil

                                    AtualizarDatatable(nuser_id, result)

									TriggerClientEvent('Notify', source, 'sucesso', 'ID <b>'.. nuser_id .. '</b> removido do grupo <b>'..grupo..'</b>.')
										exports["waze-system"]:sendLogs(user_id,{ webhook = "adminUngroup", text = "Removeu o ID "..nuser_id.." do grupo "..grupo })
                                    
                                    sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." removeu o ID "..nuser_id.." de "..grupo)
                                else
                                    TriggerClientEvent('Notify', source, 'negado', 'Esse jogador não possui esse grupo.')
                                end
                            end
                        end
                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Especifique um GRUPO.')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Especifique um ID.')
                end

            elseif opcao == 'listar' then

                if args[2] then

                    local nuser_id = parseInt(args[2])

                    local pesquisa = PegarDatatable(nuser_id)

                    if pesquisa[1] and pesquisa[1] ~= nil then

                        local result = json.decode(pesquisa[1].dvalue)
                        local grupos = ''
                        if result.groups then
                            for k , v in pairs(result.groups) do
                                grupos = grupos .. ' - <b>' .. k .. '</b><br>'
                            end
                            TriggerClientEvent('Notify', source, 'aviso', 'LISTA DE SETS ID <b>'..nuser_id..'</b><br>'..grupos)
                        end
                    end

                end

            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local fundador = {-1,0,1,2,3,4}
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if cantTeleport[tplayer] == nil then
			if tplayer then
                if vRP.hasPermission(parseInt(args[1]), "blocktp.permissao") and not vRP.hasPermission(user_id,'blocktp.permissao') then
                    local ok = vRP.request(tplayer,"("..user_id..") "..identity.name.." "..identity.firstname.." quer dar /tptome em você, deseja aceitar?",15)
                    if ok then
						TriggerClientEvent('waze:ExcecaoTp', tplayer)
                        vRPclient.teleport(tplayer,x,y,z)
                        sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." deu TPTOME em "..args[1])

                    end
                else
					TriggerClientEvent('waze:ExcecaoTp', tplayer)
                    vRPclient.teleport(tplayer,x,y,z)
                    sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." deu TPTOME em "..args[1])
                end
            end
		else
			TriggerClientEvent('Notify', source, 'aviso', 'O CEO desabilitou teleportes.')
		end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    local fundador = {-1,0,1,2,3,4}
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local tplayer = vRP.getUserSource(parseInt(args[1]))
			if cantTeleport[tplayer] == nil then
            if tplayer then
                if vRP.hasPermission(parseInt(args[1]), "blocktp.permissao") and not vRP.hasPermission(user_id,'blocktp.permissao') then
                    local ok = vRP.request(tplayer,"("..user_id..") "..identity.name.." "..identity.firstname.." quer dar /tpto em você, deseja aceitar?",15)
                    if ok then
                        vRPclient.teleport(source,vRPclient.getPosition(tplayer))
                        sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." deu TP em "..args[1])
                    end
                else
                    vRPclient.teleport(source,vRPclient.getPosition(tplayer))
                    sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." deu TP em "..args[1])
                end    
            end
		else
			TriggerClientEvent('Notify', source, 'aviso', 'O CEO desabilitou teleportes.')
		end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		vCLIENT.tptoWay(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"suporte.permissao") then
        local users = vRP.getUsers()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if k ~= #users then
                players = players.." "
            end
            players = players..k
            quantidade = quantidade + 1
        end
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,153,51},players)
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,153,51},quantidade)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ZERAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('waze/get_datatable', 'SELECT * FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey')
vRP._prepare('waze/update_datatable', 'UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id AND dkey = @dkey')

RegisterCommand('limparinv',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		local tuser_id = tonumber(args[1])
		local tplayer = vRP.getUserSource(tonumber(tuser_id))
		local tplayerID = vRP.getUserId(tonumber(tplayer))
		if tplayerID ~= nil then
			local identity = vRP.getUserIdentity(user_id)
            if vRP.request(source,"Deseja limpar o inventário do Passaporte: <b>"..args[1].."</b> ?",30) then
			vRP.clearInventory(tplayerID)
            vRPclient.giveWeapons(tplayer,{},true)
			TriggerClientEvent("Notify",source,"sucesso","Limpou inventario do ID <b>"..args[1].."</b>.")
            exports["waze-system"]:sendLogs(user_id,{ webhook = "adminClear", text = "Limpou o inventário do ID "..args[1] })
			sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." limpou inventário do ID "..args[1])
		else
            local nplayer = tonumber(args[1])
            local nsource = vRP.getUserSource(nplayer)
            local pesquisa = PegarDatatable(nplayer)
			if pesquisa[1] and pesquisa[1] ~= nil then
                local result = json.decode(pesquisa[1].dvalue)
                if result.weapons then
                    result.weapons = nil
                end
                if result.inventory then
                    result.inventory = nil
                end
                AtualizarDatatable(nplayer, result)
                TriggerClientEvent('Notify', source, 'sucesso', 'Você limpou o inventario do '..args[1])
					exports["waze-system"]:sendLogs(user_id,{ webhook = "adminClear", text = "Limpou o inventário do ID "..args[1] })
                sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." limpou inventário do ID "..args[1])
                end
            end
        end
	end
end)

RegisterCommand('zerararmas', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,'ceo') or vRP.hasGroup(user_id,'admin') or vRP.hasGroup(user_id,'dev') then
		if not args[1] then TriggerClientEvent('Notify', source, "negado", 'Especifique um ID.') return end
		local nsource = vRP.getUserSource(parseInt(args[1]))
		TriggerClientEvent('waze:ZerarArmas', nsource)
		exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCommon", text = "Zerou o inventário do ID "..parseInt(args[1]) })

	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KILL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('matar',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer,0)
                TriggerClientEvent("Notify",source,"importante","Você matou o passaporte "..args[1])
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminKill", text = "Matou o ID "..args[1] })
                sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." matou o ID "..args[1])
            end
        else
            vRPclient.killGod(source)
            vRPclient.setHealth(source,0)
        end
    end
end)
--[[ Foguinho ]]
--[[ RegisterCommand('foguinho', function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"ceo.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				TriggerClientEvent('foguinho', nplayer)
			end
		else
			TriggerClientEvent('foguinho', source)
		end
	end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- TODOS CARROS DA BASE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('allcars',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local all = vRP.vehicleGlobal()
        local cars = ""
        for k,v in pairs(all) do
            cars = cars .. "," .. k
        end
        vRP.prompt(source,"Carros",cars)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD CASA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcasa',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] and args[2] then
            local nuser_id = parseInt(args[1])
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("homes/rem_allpermissions",{ home = tostring(args[2]) })
            vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = nuser_id, tax = os.time() })
            TriggerClientEvent("Notify",source,"sucesso","Voce adicionou a casa <b>"..args[2].."</b> para o Passaporte: <b>"..parseInt(args[1]).."</b>.") 
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminAddHome", text = "Adicionou a casa "..args[2].." para o ID "..args[1] })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM CASA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcasa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
            local identity2 = vRP.getUserIdentity(parseInt(args[2]))
            if vRP.request(source,"Deseja remover a casa <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b> ?",30) then
                vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(args[1]) })
                vRP.execute("creative/rem_srv_data",{ dkey = "outfit:"..tostring(args[1]) })
                vRP.execute("homes/rem_allpermissions",{ home = tostring(args[1]) })
    			TriggerClientEvent("Notify",source,"sucesso","Você removeu a casa <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b>.")
					exports["waze-system"]:sendLogs(user_id,{ webhook = "adminRemHome", text = "Removeu a casa "..tostring(args[1]).." do ID "..parseInt(args[2]) })
            end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DM (MENSAGEM PRIVADA)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dm',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] == nil then
            TriggerClientEvent("Notify",source,"negado","Necessário passar o ID após o comando, exemplo: <b>/dm 1</b>")
            return
        elseif nplayer == nil then
            TriggerClientEvent("Notify",source,"negado","O jogador não está online!")
            return
        end
        local mensagem = vRP.prompt(source,"Digite a mensagem:","")
        if mensagem == "" then
            return
        end
        TriggerClientEvent("Notify",source,"sucesso","Mensagem enviada com sucesso!")
        TriggerClientEvent('chatMessage',nplayer,"MENSAGEM DA ADMINISTRAÇÃO:",{50,205,50},mensagem)
        TriggerClientEvent("Notify",nplayer,"aviso","<b>Mensagem da Administração:</b> "..mensagem.."",30000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bigar',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("bigar",nplayer)
            end
        else
            TriggerClientEvent("bigar",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESBIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('desbigar',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("desbigar",nplayer)
            end
        else
            TriggerClientEvent("desbigar",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_ADM COBRAR
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('admcobraroffline', 'UPDATE vrp_user_moneys SET wallet = @wallet, bank = @bank WHERE user_id = @user_id')
vRP._prepare('admcobrargetinfo', 'SELECT * FROM vrp_user_moneys WHERE user_id = @user_id')
-----------------------------------------------------------------------------------------------------------------------------------------
---ADM COBRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admcobrar', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local nuser_id = parseInt(args[1])
        local nsource = vRP.getUserSource(nuser_id)
        local quantidade = tonumber(args[2])
        local identity = vRP.getUserIdentity(user_id)
        if nsource then
            vRP.tryFullPayment(nuser_id,quantidade)
            TriggerClientEvent("Notify",nsource,"financeiro","A Tropa tomou $"..vRP.format(quantidade).." de sua conta bancária.")
            TriggerClientEvent("Notify",source,"financeiro","[ONLINE] A Tropa tomou $"..vRP.format(quantidade).." da conta bancária do ID " .. args[1])
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminLessMoney", text = "Retirou $"..vRP.format(quantidade).." da conta bancária do ID "..args[1] })
        else
            local pesquisa = vRP.query('admcobrargetinfo', {user_id = nuser_id})
            local carteira, banco = parseInt(pesquisa[1].wallet), parseInt(pesquisa[1].bank)
            if carteira + banco >= quantidade then
                if carteira >= quantidade then
                    carteira = 0
                else
                    quantidade = quantidade - carteira
                    carteira = 0
                    banco = banco - quantidade
                end
                vRP.execute('admcobraroffline', {user_id = nuser_id, wallet = carteira, bank = banco})
                TriggerClientEvent("Notify",source,"financeiro","[OFFLINE] A Tropa tomou $"..vRP.format(quantidade).." da conta bancária do ID " .. args[1])
					exports["waze-system"]:sendLogs(user_id,{ webhook = "adminLessMoney", text = "Retirou $"..vRP.format(quantidade).." da conta bancária do ID "..args[1] })
            else
                TriggerClientEvent('Notify', source, 'negado', 'O jogador não possui toda essa quantia.')
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_ADM ENVIAR DINHEIRO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('admenviardinheiro', 'UPDATE vrp_user_moneys SET wallet = @wallet, bank = @bank WHERE user_id = @user_id')
vRP._prepare('admenviardinheiro', 'SELECT * FROM vrp_user_moneys WHERE user_id = @user_id')
------------------------------------------------------------------------------------------------------------------------------------------
-- ADM ENVIAR DINHEIRO
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admenviardinheiro', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local nuser_id = parseInt(args[1])
        local nsource = vRP.getUserSource(nuser_id)
        local quantidade = tonumber(args[2])
        local identity = vRP.getUserIdentity(user_id)
        if nsource then
            vRP.giveBankMoney(nuser_id,parseInt(quantidade))
            TriggerClientEvent("Notify",nsource,"financeiro","A Tropa adicionou $"..vRP.format(quantidade).." em sua conta bancária.")
            TriggerClientEvent("Notify",source,"financeiro","[ONLINE] A Tropa adicionou $"..vRP.format(quantidade).." na conta bancária do ID " .. args[1])
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminMoreMoney", text = "Adicionou $"..vRP.format(quantidade).." na conta bancária do ID "..args[1] })
        else
            local pesquisa = vRP.query('admenviardinheiro', {user_id = nuser_id})
            local carteira, banco = parseInt(pesquisa[1].wallet), parseInt(pesquisa[1].bank)
            if carteira >= quantidade then
                carteira = 0
            else
                quantidade = quantidade - carteira
                carteira = 0
                banco = banco - quantidade
            end
            vRP.execute('admenviardinheiro', {user_id = nuser_id, wallet = carteira, bank = banco})
            TriggerClientEvent("Notify",source,"financeiro","[OFFLINE] A Tropa adicionou $"..vRP.format(quantidade).." na conta bancária do ID " .. args[1])
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminMoreMoney", text = "Adicionou $"..vRP.format(quantidade).." na conta bancária do ID "..args[1] })
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------
-- LOCK ADM
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unlock', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local vehicle,vnetid,placa,vname,lock = vRPclient.vehList(source,7)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        TriggerEvent("setPlateEveryone",placa)
        vGARAGE.vehicleClientLock(-1,vnetid,lock)
        TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
        TriggerClientEvent("Notify",source,"sucesso","Veiculo trancado")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemadm",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
	if nplayer then
		if vRP.hasPermission(user_id,"admin.permissao") then
			if args[1] and args[2] and args[3] and vRP.itemNameList(args[2]) ~= nil then
				vRP.giveInventoryItem(nuser_id,args[2],parseInt(args[3]))
                TriggerClientEvent("Notify",source,"sucesso","Voce spawnou o item "..args[2].." para o ID "..args[1].."")
                TriggerClientEvent("Notify",nplayer,"sucesso","Voce recebeu o item "..args[2].."")
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminItemPlayer", text = "Spawnou x"..vRP.format(parseInt(args[3])).." "..args[2].." para o ID "..args[1]})
                sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." givou x"..vRP.format(parseInt(args[3])).." "..args[2].." para o ID "..args[1])
			end
		else
            TriggerClientEvent("Notify",source,"negado","Voce nao tem permissao para executar este comando")
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_ZERARGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
--vRP._prepare("waze/get_allUserData", "SELECT user_id, dvalue from vrp_user_data WHERE dkey LIKE 'vRP:datatable'")
----------------------------------------------------------------------------------------------------------------------------------------
-- ZERARGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('zerargrupos', function(source,args,rawCommand) 
--    local rows =  vRP.query("waze/get_allUserData")
--    if rows ~= nil then
--        for k, v in pairs(rows) do
--            local id = v.user_id
--            local data = json.decode(v.dvalue)
--            data.groups = {}
--            vRP.setUData(id, 'vRP:datatable' , json.encode( data) )
--        end
--    end
--end)
------------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('console',function(source,args,rawCommand)
    if source == 0 then
        if args[1] then
            TriggerClientEvent('chatMessage',-1,"waze CONSOLE | ",{80, 200, 120},rawCommand:sub(8))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("copypreset",function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,'admin.permissao') or vRP.hasPermission(user_id,'mod.permissao') then
        if user_id then       
            local data = vRP.getUserSource(tonumber(args[1]))
            local nsource = vRP.getUserId(data)
            local data2 = vRP.getUserIdentity(nsource)
            if data then
                local custom_outfit = vRPclient.getCustomPlayer(data)
                TriggerClientEvent("adminClothes",source,custom_outfit)
                TriggerClientEvent('Notify',source,'sucesso','Você copiou a roupa do <b>Passaporte '..vRP.format(parseInt(args[1]))..' '..data2.name..' '..data2.firstname..'</b>.') 
            end
        end
    end
end)

RegisterCommand('setpreset',function(source,args,rawCmd)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,'mod.permissao') then
        return 
    end

    if not args[1] then return end

    local nsource = vRP.getUserSource(parseInt(args[1]))
    if nsource then
        local custom_outfit = vRPclient.getCustomPlayer(source)
        TriggerClientEvent('adminClothes',nsource,custom_outfit)
        TriggerClientEvent('Notify',source,'sucesso','Você setou seu outfit para o user_id '..vRP.format(parseInt(args[1]))) 
    end
end)

--RegisterCommand('clearpreset',function(source,args,rawCommand)
--    
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id, 'admin.permissao') then
--		if args[1] then
--			local nuser_id = parseInt(args[1])
--			local nsource = vRP.getUserSource(nuser_id)
--			vRP.removeCloak(nsource)
--			TriggerClientEvent('Notify', source, 'sucesso', 'Preset zerado do ID ' .. nuser_id)
--		end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCARRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcar', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] then
			local nsource = vRP.getUserSource(parseInt(args[1]))
			TriggerClientEvent('waze:SetarDentroDocarro',source, nsource)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPINCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcar2', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		TriggerClientEvent('waze:SetarDentroDocarro2',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('marcar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nid = parseInt(args[1])
			local tplayer = vRP.getUserSource(nid)
			if tplayer then
				local x,y,z = vRPclient.getPosition(tplayer)
				TriggerClientEvent('waze:MarcarGps', source, x, y)
				vRPclient.playSound(source,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				TriggerClientEvent('chatMessage',source,"[ADMIN]",{255,0,0},"Você marcou a posição do ID " .. nid .. ".")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setinv', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,'dev') then
		if not args[1] then TriggerClientEvent('Notify', source, "negado", 'Especifique um ID.') return end
		local nuser_id = parseInt(args[1])
		local valorInv = parseInt(args[2]) 
		vRP.setExp(nuser_id, "physical", "strength", valorInv)
		exports["waze-system"]:sendLogs(user_id,{ webhook = "adminInventory", text = "Aumentou o inventário do id "..nuser_id.." para "..valorInv })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVISTAR ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistaradm',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,'mod.permissao')  then
        return 
    end

    if not args[1] then return end

    local nsource = vRP.getUserSource(parseInt(args[1]))
    if nsource == nil then
        TriggerClientEvent('Notify',source,"negado",'Usuário indisponível.')
        return 
    end


    local nuser = vRP.getUserId(nsource)

    local data = vRP.getUserDataTable(nuser)
    local weapons = vRPclient.getWeapons(nsource)

    local weaponStr = ''
    local inventoryStr = ''

    for k,v in pairs(weapons) do
        weaponStr = weaponStr..' <b>'..k..'</b> : '..vRP.format(v.ammo)..'<br>'
    end

    for k,v in pairs(data.inventory) do
        inventoryStr = inventoryStr..' <b>'..k..'</b> : '..v.amount..'<br>'
    end


    TriggerClientEvent('Notify',source,'sucesso','Informações de jogador ID: '..vRP.format(nuser)..'<br><br><b>Armas: </b><br><br>'..weaponStr..'<br><b>Inventário: </b><br><br>'..inventoryStr)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] and vRP.itemNameList(args[1]) ~= nil then

			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminItem", text = "Spawnou x"..vRP.format(parseInt(args[2])).." "..args[1] })
            sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." givou x"..vRP.format(parseInt(args[2])).." "..args[1])
		else
			TriggerClientEvent('Notify',source,"negado",'Este item não existe')
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USER VEHS [ADMIN]
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uservehs',function(source,args,rawCommand)
    
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"admin.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
					car_names[#car_names + 1] = "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>"
                    --TriggerClientEvent("Notify",source,"importante","<b>Modelo:</b> "..v.vehicle,10000)
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SETFUEL
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setfuel',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                if parseInt(args[2]) == 0 then
                    TriggerClientEvent("admfuel2",nplayer,1.0)
                elseif parseInt(args[2]) then
                    TriggerClientEvent("admfuel2",nplayer,parseInt(args[2]))
                else
                    TriggerClientEvent("admfuel2",nplayer,100.0)
                end
            end
		end	
	end
end)

vRP.prepare('wazedebugdinsujo', 'SELECT * FROM vrp_srv_data')
vRP.prepare('wazedebughousesbyid', 'SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id')
vRP.prepare('wazedebughousesbyhouse', 'SELECT * FROM vrp_homes_permissions WHERE home = @home')
RegisterCommand('printdinheiros', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'dev.permissao') then
	local query = vRP.query('wazedebugdinsujo', {})
	print('Localizando')
	for k, v in pairs (query) do
		local index, bau = v.dkey, json.decode(v.dvalue)
		if type(bau) ~= 'number' then
			for x,y in pairs(bau) do
                if string.match(x, args[1]) then
                    print(index, vRP.itemNameList(x), vRP.format(y.amount))
               		end
				end
			end
		end
	end
	print('Pesquisa finalizada')
end)

RegisterCommand('casa', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'suporte.permissao') then
		if args[1] then
			if args[1] == 'ids' then -- PRINTA A PARTIR DO NOME DA CASA
				if args[2] then
					local query = vRP.query('wazedebughousesbyhouse', {home = args[2]})
					local resultado = ''
					for k, v in pairs(query) do
						local status = 'DONO'
						if parseInt(v.owner) == 0 then 
							status = 'MORADOR'
						end
						local nuser_id = parseInt(v.user_id)
						local identity = vRP.getUserIdentity(nuser_id)
						resultado = resultado .. nuser_id .. ' ' .. identity.name .. ' ' .. identity.firstname .. ' [' .. status .. ']\n'
					end
					vRP.prompt(source, 'CASA ' .. args[2], resultado)
				end
			elseif args[1] == 'id' then -- PRINTA A PARTIR DO ID DO JOGADOR
				if args[2] then
					local nuser_id = parseInt(args[2])
					local identity = vRP.getUserIdentity(nuser_id)
					local query = vRP.query('wazedebughousesbyid', {user_id = nuser_id})
					local resultado = ''
					for k, v in pairs(query) do
						local status = 'DONO'
						local garajado = 'SIM'
						if parseInt(v.owner) == 0 then 
							status = 'MORADOR'
						end
						if parseInt(v.garage) == 0 then 
							garajado = 'NÃO'
						end

						resultado = resultado .. v.home .. ' [' .. status .. '][GARAGEM: ' .. garajado .. ']\n'
					end
					vRP.prompt(source, 'INFO CASAS ' .. nuser_id .. ' ' .. identity.name .. ' ' .. identity.firstname, resultado)
				end
			end
		end
	end
end)

vRP.prepare('waze/resetar_boneco', 'DELETE FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey')
RegisterCommand('cirurgia', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if user_id == 0 or user_id == 1 then
		if args[1] then
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			vRP.execute('waze/resetar_boneco', {user_id = nuser_id, dkey = 'vRP:spawnController'})
			TriggerClientEvent('Notify', source, 'sucesso', 'Você resetou o personagem do <b>ID ' .. vRP.format(nuser_id) .. '</b>.')
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,args,rawCommand)
    if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if user_id then
	    	if args[1] then
                if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
	    		TriggerClientEvent("vrp_showme:pressMe",-1,source,rawCommand:sub(4),{ 10,250,0,255,100 })
	    	end
	    end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET PROCURADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setproc', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.permissao') then
		if args[1] then
			if args[2] then
				local nsource = vRP.getUserSource(parseInt(args[1])) 
				local proc = parseInt(args[2])
				if proc >= 0 then
					if nsource then
						vRPclient.AdminSetStandBY(nsource,proc)
						TriggerClientEvent('Notify', source, 'aviso', 'Você definiu o tempo de procurado do <b>ID ' .. parseInt(args[1]) .. '</b> para <b>' .. vRP.format(proc) .. 's</b>.')
					else
						TriggerClientEvent('Notify', source, 'negado', 'Esse jogador se encontra <b>indisponível</b>.')
					end

				else
					TriggerClientEvent('Notify', source, 'negado', 'Você não especificou um <b>TEMPO VÁLIDO ( 0 - X )</b>.')
				end
			else
				TriggerClientEvent('Notify', source, 'negado', 'Você não especificou um <b>TEMPO VÁLIDO ( 0 - X )</b>.')
			end
		else
			TriggerClientEvent('Notify', source, 'negado', 'Você não especificou um <b>PASSAPORTE VÁLIDO</b>.')
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MODO ADM
-----------------------------------------------------------------------------------------------------------------------------------------
local players = {}
local sources = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRST SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('vRP:playerSpawn',function(user_id,source,first_spawn)
    local identity = vRP.getUserIdentity(user_id)
    local playerName = identity.name..' '..identity.firstname

    players[source] = { user_id = user_id, name = playerName }

    for k,v in pairs(sources) do
        vCLIENT.SyncPlayerlist(v,players)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER DROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped',function(user_id,source,first_spawn)
    if players[source] then
        players[source] = {}
        for k,v in pairs(sources) do
            vCLIENT.SyncPlayerlist(v,players)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
function serverSync()
    local users = vRP.getUsers()

    for k,v in pairs(users) do
        local identity = vRP.getUserIdentity(k)
        local playerName = identity.name..' '..identity.firstname
        
        players[v] = { user_id = k, name = playerName }
    end

    for k,v in pairs(sources) do
        vCLIENT.SyncPlayerlist(v,players)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCEwaze
-----------------------------------------------------------------------------------------------------------------------------------------
--AddEventHandler('onResourcewaze',function(resName)
    --if resName ~= GetCurrentResourceName() then 
      --  return 
  --  end

 --   serverSync()
--	print('SCRIPT REINICIADO, INICIANDO SINCRONIZAÇÃO.')
--end)

AddEventHandler('onResourcewaze', function(resName)

    Wait(5000)

    -- Deixa o evento somente pra essa resource
    if (GetCurrentResourceName() ~= resName) then
      return
    end

    serverSync()
	print("^3[ + ] wazeADMIN > ^7Script reiniciado, iniciando sincronização de jogadores.")

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINCOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('am',function(source, args, rawCmd)
    local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if not vRP.hasPermission(user_id,'mod.permissao') then
        return 
    end

    local Playerlist = vCLIENT.ToggleAdmmode(source)
    if Playerlist then
        sources[user_id] = source
        vCLIENT.SyncPlayerlist(source,players)
        exports["waze-system"]:sendLogs(user_id,{ webhook = "adminWall", text = "Ligou o /am" })
		sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." ligou o /am")
    else
        sources[user_id] = nil  
		exports["waze-system"]:sendLogs(user_id,{ webhook = "adminWall", text = "Desligou o /am" })
        sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." desligou o /am")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINUPDATECOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admupdate',function(source, args, rawCmd)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,'mod.permissao') then
        return 
    end

    serverSync()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINMODE DOMINAS
-----------------------------------------------------------------------------------------------------------------------------------------
function waze.getUserGroupByType(user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end

RegisterCommand('adminmode',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if vRP.hasPermission(user_id,"suporte.permissao") then
            vCLIENT.ModoDominasAd(source)
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminDomination", text = "Utilizou o /adminmode" })
            local users = {}
            local Players = vRP.getUsers()
            for k,v in pairs(Players) do
                local identity = vRP.getUserIdentity(k)
				local gerente = waze.getUserGroupByType(k,"gerente")
				local job = waze.getUserGroupByType(k,"job")
                users[v] = {
                    name = identity.name.." " ..identity.firstname, user_id = k,
					job = job,
					gerente = gerente
                }
            end
            vCLIENT.updateList(source,users)
        end
    end
end)

RegisterCommand('amreset2',function(source,args,rawCommand)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"admin.permissao") then
            vCLIENT.adminReset(source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("add",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserIdentity(user_id)
	if user_id then
		if parseInt(args[2]) > 0 then
			if args[1] == "Policia" then
				if vRP.hasGroup(user_id,"policiaftu") then
					if vRP.request(source,"Deseja adicionar o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.addUserGroup(parseInt(args[2]),"paisanapolicia")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
					end
				end
			end

			if args[1] == "Medico" then
				if vRP.hasGroup(user_id,"diretor") then
					if vRP.request(source,"Deseja adicionar o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.addUserGroup(parseInt(args[2]),"medico")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
					end
				end
			end

			if args[1] == "Mecanico" then
				if vRP.hasGroup(user_id,"chefemec") then
					if vRP.request(source,"Deseja adicionar o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.addUserGroup(parseInt(args[2]),"mecanico")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserIdentity(user_id)
    local nsource = vRP.getUserSource(parseInt(args[2]))
	if user_id then
		if parseInt(args[2]) > 0 then
			if args[1] == "Policia" then
				if vRP.hasGroup(user_id,"policiaftu") then
					if vRP.request(source,"Deseja remover o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.removeUserGroup(parseInt(args[2]),"policia")
						vRP.removeUserGroup(parseInt(args[2]),"paisanapolicia")
						vRP.clearInventory(parseInt(args[2]))
						vRPclient.giveWeapons(nsource,{},true)
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> removido com sucesso.",5000)
					end
				end
			end

			if args[1] == "Medico" then
				if vRP.hasGroup(user_id,"diretor") then
					if vRP.request(source,"Deseja remover o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.removeUserGroup(parseInt(args[2]),"medico")
						vRP.removeUserGroup(parseInt(args[2]),"paisanamedico")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> removido com sucesso.",5000)
					end
				end
			end

			if args[1] == "Mecanico" then
				if vRP.hasGroup(user_id,"chefemec") then
					if vRP.request(source,"Deseja remover o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.removeUserGroup(parseInt(args[2]),"mecanico")
						vRP.removeUserGroup(parseInt(args[2]),"paisanamecanico")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> removido com sucesso.",5000)
					end
				end
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COR FAROL
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vfarol',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if not args[1] then return end
		local carro = vRPclient.getNearestVehicle(source,7)
		local cor = tonumber(args[1])
		TriggerClientEvent('waze:CorFarolCl', source, carro, cor)
	end
end)

RegisterServerEvent("waze:SyncCorFarol")
AddEventHandler("waze:SyncCorFarol",function(index, cor)
	TriggerClientEvent("waze:SyncCorFarolCl",-1,index, cor)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SOLTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('soltar',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local nuser_id = parseInt(args[1])
		local player = vRP.getUserSource(nuser_id)
		if nuser_id then

			TriggerClientEvent('wazeprisioneiro',player,false)
			TriggerClientEvent('waze:VirarPrisioneiro',player,false)
			SetEntityCoords(GetPlayerPed(player),1847.91,2585.75,45.68)
			vRP.setUData(nuser_id,"vRP:prisao",json.encode(-1))
			TriggerClientEvent("Notify",player,"importante","Sua sentença terminou, esperamos não ve-lo novamente.")
			vRPclient.PrisionGod(player)
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCommon", text = "Soltou o ID "..nuser_id.." da prisão" })
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS DE PRISÃO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setprisao',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nuser_id = parseInt(args[1])
			if args[2] then
				local tempoPrisao = parseInt(args[2])
				vRP.setUData(nuser_id,"vRP:prisao", json.encode(tempoPrisao) )
				TriggerClientEvent('Notify', source, 'importante', 'Prisão realizada com sucesso!<br>USER ID: <b>' .. nuser_id .. '</b><br>Tempo: <b>'..tempoPrisao..'</b>')
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCommon", text = "Prendeu o jogador "..nuser_id.." por "..tempoPrisao.." minutos" })
			else
				TriggerClientEvent('Notify', source, "negado", 'Você deve especificar um tempo válido: /prisaoadm [ID] [TEMPO]')
			end
		else
			TriggerClientEvent('Notify', source, "negado", 'Você deve utilizar o comando da seguinte forma: /prisaoadm [ID] [TEMPO]')
		end
	end
end)

RegisterCommand('addprisao',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nuser_id = parseInt(args[1])
			if args[2] then
				local value = vRP.getUData(nuser_id,"vRP:prisao")
				local valorPreso = json.decode(value) or 0
				local tempoPrisao = parseInt(args[2])
				vRP.setUData(nuser_id,"vRP:prisao", json.encode(tempoPrisao+parseInt(valorPreso)) )
				TriggerClientEvent('Notify', source, 'importante', 'Prisão realizada com sucesso!<br>USER ID: <b>' .. nuser_id .. '</b><br>Tempo: <b>'..parseInt(valorPreso) .. ' + ' .. tempoPrisao .. ' = ' .. tempoPrisao + parseInt(valorPreso) ..'</b>')
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCommon", text = "Adicionou tempo a prisão do ID "..nuser_id.." de "..parseInt(valorPreso).." + "..tempoPrisao..", totalizando "..(tempoPrisao + parseInt(valorPreso)).." minutos" })
			else
				TriggerClientEvent('Notify', source, "negado", 'Você deve especificar um tempo válido: /addprisao [ID] [TEMPO]')
			end
		else
			TriggerClientEvent('Notify', source, "negado", 'Você deve utilizar o comando da seguinte forma: /addprisao [ID] [TEMPO]')
		end
	end
end)

RegisterCommand('checkprisao',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local nuser_id = parseInt(args[1])
			local value = vRP.getUData(nuser_id,"vRP:prisao")
			local valorPreso = json.decode(value) or 0
			TriggerClientEvent('Notify', source, 'importante', 'Tempo preso:<br>USER ID: <b>' .. nuser_id .. '</b><br>Tempo: <b>'..valorPreso..'</b>')
		else
			TriggerClientEvent('Notify', source, "negado", 'Você deve utilizar o comando da seguinte forma: /checkprisao [ID]')
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PINTAR CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trypintarveh")
AddEventHandler("trypintarveh",function(index, tipo, valor)
	TriggerClientEvent("syncpintarveh",-1,index, tipo, valor)
end)
RegisterCommand('pintar',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local tinta = 0
		if #args == 0 then
			TriggerClientEvent('chatMessage', source, "", {255,0,0}, "[ERRO] Utilize: /pintar [metalico - normal - perolado - fosco - metal - cromo] [nº cor]")
		elseif args[1] == "metalico" then
			tinta = 1
		elseif args[1] == "normal" then
			tinta = 0
		elseif args[1] == "perolado" then
			tinta = 2
		elseif args[1] == "fosco" then
			tinta = 3
		elseif args[1] == "metal" then
			tinta = 4
		elseif args[1] == "cromo" then
			tinta = 5
		end

		local carro = vRPclient.getNearestVehicle(source,7)
		if carro then
			TriggerClientEvent("pintarveiculo", source, carro, parseInt(tinta), parseInt(args[2]))
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCommon", text = "Pintou seu veículo" })
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR COLOR -- Cor primaria e secundária são as mesmas
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("trycorveh")
AddEventHandler("trycorveh",function(index, cor1, cor2, cor3)
	TriggerClientEvent("synccorveh",-1,index, cor1, cor2, cor3)
end)
RegisterCommand('vcor',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local fcoords = vRP.prompt(source,"Cor(r,g,b):","")
		if fcoords == "" then
			return
		end
		local cores = {}
		for cor in string.gmatch(fcoords or "255,255,255","[^,]+") do
			cores[#cores + 1] = parseInt(cor)
		end
		local carro = vRPclient.getNearestVehicle(source,7)
		if carro then
			TriggerClientEvent("carroCor", source, carro, cores[1], cores[2], cores[3])
		end
	end
end)


RegisterCommand('vercustom',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.permissao') or user_id == 0 or user_id == 1 then
		TriggerClientEvent('waze:VerCustom:MostrarCl', source)
	end
end)

RegisterServerEvent('waze:VerCustom:Mostrar')
AddEventHandler('waze:VerCustom:Mostrar', function(custom)
	local content = ""
	for k,v in pairs(custom) do
		if string.match(k, 'p') then
			content = content.. '["' .. k .. '"] = {' .. v[1] .. ', ' .. v[2] .. '}, \n' 
		else
			content = content.. '[' .. k .. '] = {' .. v[1] .. ', ' .. v[2] .. '}, \n' 
		end
	end
	vRP.prompt(source, "Customização", content)
end)

RegisterCommand('printpreset',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if not args[1] then
		local custom = vRPclient.getCustomization(source)
		local content = ""
		for k,v in pairs(custom) do
			if k == 1 then
				content = content .. 'mascara ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 3 then
				content = content .. 'maos ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 4 then
				content = content .. 'calca ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 5 then
				content = content .. 'mochila ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 6 then
				content = content .. 'sapatos ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 7 then
				content = content .. 'acessorios ' .. v[1] .. '; '
			elseif k == 8 then
				content = content .. 'blusa ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 9 then
				content = content .. 'colete ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 11 then
				content = content .. 'jaqueta ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 'p0' then
				content = content .. 'chapeu ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 'p1' then
				content = content .. 'oculos ' .. v[1] .. ' ' .. v[2] .. '; '
			end
		end
		vRP.prompt(source, 'Roupas prontas:', content)
	elseif args[1] then
		if vRP.hasPermission(user_id, 'admin.permissao') then
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			if not nsource then TriggerClientEvent('Notify', source, 'negado', 'Esse ID não está online.') return end
			local custom = vRPclient.getCustomization(nsource)
			local content = ""
			for k,v in pairs(custom) do
				if k == 1 then
					content = content .. 'mascara ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 3 then
					content = content .. 'maos ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 4 then
					content = content .. 'calca ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 5 then
					content = content .. 'mochila ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 6 then
					content = content .. 'sapatos ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 7 then
					content = content .. 'acessorios ' .. v[1] .. '; '
				elseif k == 8 then
					content = content .. 'blusa ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 9 then
					content = content .. 'colete ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 11 then
					content = content .. 'jaqueta ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 'p0' then
					content = content .. 'chapeu ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 'p1' then
					content = content .. 'oculos ' .. v[1] .. ' ' .. v[2] .. '; '
				end
			end
			vRP.prompt(source, 'Roupas prontas:', content)
		end
	end
end)

RegisterCommand('respawnar', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.permissao') then
		if args[1] then
			local nsource = vRP.getUserSource(parseInt(args[1]))
			TriggerEvent('waze:SyncDebugPlayer', nsource)
			TriggerClientEvent('Notify', source, 'aviso', 'ID ' .. parseInt(args[1]) .. ' respawnado.')
			TriggerClientEvent('Notify', nsource, 'aviso', 'Você foi respawnado.')
		end
	end
end)

RegisterServerEvent('waze:SyncDebugPlayer')
AddEventHandler('waze:SyncDebugPlayer', function(debugid)
	local source = debugid
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	vRPclient._setFriendlyFire(source,true)

	if data.customization == nil then
		data.customization = cfg.default_customization
	end

	if data.position then
		vRPclient.teleport(source,data.position.x,data.position.y,data.position.z)
	end

	if data.customization then
		vRPclient.setCustomization(source,data.customization) 
		if data.weapons then
			vRPclient.giveWeapons(source,data.weapons,true)

			if data.health then
				vRPclient.setHealth(source,data.health)
				SetTimeout(5000,function()
					if vRPclient.isInComa(source) then
						vRPclient.killComa(source)
					end
				end)
			end
		end
	end

	if data.weapons then
		vRPclient.giveWeapons(source,data.weapons,true)
	end

	if data.health then
		vRPclient.setHealth(source,data.health)
	end
end)

RegisterCommand('multar',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"suporte.permissao") then
		local id = vRP.prompt(source,"Passaporte:","")
		local valor = vRP.prompt(source,"Valor:","")
		local motivo = vRP.prompt(source,"Motivo:","")
		if id == "" or valor == "" or motivo == "" then
			return
		end
		local value = vRP.getUData(parseInt(id),"vRP:multas")
		local multas = json.decode(value) or 0
		vRP.setUData(parseInt(id),"vRP:multas",json.encode(parseInt(multas)+parseInt(valor)))
		local oficialid = vRP.getUserIdentity(user_id)
		local playerid = vRP.getUserIdentity(parseInt(id))
		local nplayer = vRP.getUserSource(parseInt(id))
		exports["waze-system"]:sendLogs(user_id,{ webhook = "adminFines", text = "Multou o jogador "..id.." "..playerid.name.." "..playerid.firstname.." em $"..vRP.format(parseInt(valor)).."\nMotivo: "..motivo })

		TriggerClientEvent("Notify",source,"sucesso","Multa aplicada com sucesso.")
	--	TriggerClientEvent("Notify",nplayer,"importante","Você foi multado em <b>$"..vRP.format(parseInt(valor)).." dólares</b>.<br><b>Motivo:</b> "..motivo..".")
		TriggerClientEvent('smartphone:createSMS', nplayer, '0811', 'Você recebeu uma multa no valor de $'..vRP.format(parseInt(valor))..' dólares. | Motivo: '..motivo..'.')
		vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OBITO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('obitoadm',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.SetSegundosMorto(nplayer, 5) 
                TriggerClientEvent('Notify',source,'sucesso','Obito concluido com sucesso')
				exports["waze-system"]:sendLogs(user_id,{ webhook = "adminDeath", text = "Deu óbito no ID "..args[1] })
                sendGame("("..user_id..") "..identity.name.." "..identity.firstname.." deu óbito no ID "..args[1])
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBITOSTREAMER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('obito2',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"streamer.permissao")  then
        if vRPclient.isInComa(source) then
            vRPclient.SetSegundosMorto(source, 25) 
            TriggerClientEvent('Notify',source,'sucesso','Obito concluido com sucesso')
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminDeath2", text = "Se deu óbito" })
        end
    else
        TriggerClientEvent('Notify',source,"negado",'Você não tem permissão para executar este comando')
    end
end)

RegisterCommand('kickall',function(source,args,rawCommand)
	if source == 0 then
		local users = vRP.getUsers()
		for k,v in pairs(users) do
			local id = vRP.getUserSource(parseInt(k))
			if id then
				vRP.kick(id,"Servidor reiniciando, voltamos em breve!\nAguarde a mensagem no discord.")
			end
			Wait(10)
		end
	end
	print("^1[GASEOUS] ^7Todos os jogadores foram expulsos.")
end)

RegisterCommand('troll', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'dev.permissao') then
		if args[1] and args[2] then
			local nuser_id = parseInt(args[2])
			local nsource = vRP.getUserSource(nuser_id)
			if nsource then
				local status = 'DESLIGADO'
				if args[1] == 'wasd' then
					local wasd = vCLIENT.CheckWasd(nsource)
					if wasd then status = 'LIGADO' end
					TriggerClientEvent('Notify', source, 'aviso', 'Troll <b>WASD</b> no ID <b>'..nuser_id..'</b> foi <b>' .. status .. '</b>' )
				elseif args[1] == 'drift' then
					local drift = vCLIENT.CheckDrift(nsource)
					if drift then status = 'LIGADO' end
					TriggerClientEvent('Notify', source, 'aviso', 'Troll <b>DRIFT</b> no ID <b>'..nuser_id..'</b> foi <b>' .. status .. '</b>' )
				else
					TriggerClientEvent('Notify', source, 'aviso', 'Opções disponíveis: wasd e drift')
				end
			else
				TriggerClientEvent('Notify', source, 'aviso', 'O jogador especificado não está disponível.')
			end
		end
	end
end)

function sendGame(message)
	local adminDisplay = vRP.getUsersByPermission("admin.permissao")
        for l,w in pairs(adminDisplay) do
        local adminSource = vRP.getUserSource(parseInt(w))
        local admin_id = vRP.getUserId(adminSource)
		    if not AdminsLogs[admin_id] then
            async(function()
            TriggerClientEvent('chatMessage',adminSource,"["..os.date("%H:%M:%S").."] "..message,{102, 204, 255})
            end)
	    end 
    end
end

function sendFac(chat, info, permissao, cor1, cor2, cor3, mensagem)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local adminDisplay = vRP.getUsersByPermission(permissao)
        for l,w in pairs(adminDisplay) do
        local adminSource = vRP.getUserSource(parseInt(w))
        local admin_id = vRP.getUserId(adminSource)
            async(function()
				TriggerClientEvent("chatMessage",adminSource,""..chat.." | "..info.."",{cor1,cor2,cor3},mensagem)
            end)
    end
end

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

function waze.sendDominas(toggle)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	local adminDisplay = vRP.getUsersByPermission("admin.permissao")
        for l,w in pairs(adminDisplay) do
        local adminSource = vRP.getUserSource(parseInt(w))
        local admin_id = vRP.getUserId(adminSource)
		    if not AdminsLogs[admin_id] then
            async(function()
            TriggerClientEvent('chatMessage',adminSource,"["..os.date("%H:%M:%S").."] ("..user_id..") "..identity.name.." "..identity.firstname.." "..toggle.." /adminmode",{102, 204, 255})
            end)
	    end 
    end
end

RegisterCommand('logs', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "admin.permissao") then
		if args[1] then
			if args[1] == 'false' then
				AdminsLogs[user_id] = true
				TriggerClientEvent('Notify', source,'sucesso', 'Você <b>desligou</b> as logs da <b>administração</b>.')
			elseif args[1] == 'true' then
				AdminsLogs[user_id] = false
				TriggerClientEvent('Notify', source,'sucesso', 'Você <b>ligou</b> as logs da <b>administração</b>.')
			end
		end
	end
end)

RegisterCommand('chat', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "chatadm.permissao") then
		if args[1] then
			if args[1] == 'off' then
				AdminsChat[user_id] = true
				TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>desligou</b> o chat da <b>staff</b>.')
			elseif args[1] == 'on' then
				AdminsChat[user_id] = false
				TriggerClientEvent('Notify', source, 'sucesso', 'Você <b>ligou</b> o chat da <b>staff</b>.')
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptoogle",function(source,args,rawCmd)
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id, "ceo.permissao") then
	if cantTeleport[source] then 
		cantTeleport[source] = nil
		TriggerClientEvent('Notify', source, 'sucesso',"Seu teleport foi ativado.")
	else
		cantTeleport[source] = true
		TriggerClientEvent('Notify', source, 'negado',"Seu teleport foi desativado.")
	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FECHARCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chatstaff",function(source,args,rawCmd)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if not vRP.hasPermission(user_id,"ceo.permissao") then
		return
	end

	if chatStaff then
		TriggerClientEvent('Notify', source, 'sucesso',"Você bloqueou o chat staff!")
		sendChat("("..user_id..") "..identity.name.." "..identity.firstname.." bloqueou o chat staff")
		chatStaff = false
	else
		TriggerClientEvent('Notify', source, 'sucesso',"Você liberou o chat staff!")
		sendChat("("..user_id..") "..identity.name.." "..identity.firstname.." liberou o chat staff")
		chatStaff = true
	end
end)

RegisterCommand('checkban', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	local bannedInfos = exports["waze-system"]:checkBan({ user_id = args[1] })
	if vRP.hasPermission(user_id, "suporte.permissao") then
		local banned_id = parseInt(args[1])
	local staff_id = parseInt(bannedInfos["request"]["staff_id"])
	local identity = vRP.getUserIdentity(staff_id)
	local nidentity = vRP.getUserIdentity(banned_id)
		if args[1] then
			if bannedInfos["request"]["type"] == "temporary" then
			    TriggerClientEvent('Notify', source, 'sucesso', "Jogador: <b>("..args[1]..") " .. nidentity.name .. " " .. nidentity.firstname .. "</b><br>Motivo: <b>"..bannedInfos["request"]["reason"].."</b><br>Expiração: <b>"..formatTempBan(bannedInfos["request"].time).."</b><br>Staff: <b>("..bannedInfos["request"]["staff_id"]..") "..identity.name.." "..identity.firstname.."")
			else
				TriggerClientEvent('Notify', source, 'sucesso', "Jogador: <b>("..args[1]..") " .. nidentity.name .. " " .. nidentity.firstname .. "</b><br>Motivo: <b>"..bannedInfos["request"]["reason"].."</b><br>Staff: <b>("..bannedInfos["request"]["staff_id"]..") "..identity.name.." "..identity.firstname.."</b>")
			end
		end
	end
end)

RegisterCommand('checkblock', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "suporte.permissao") then
	local blocked_id = parseInt(args[1])
	local blockInfos = exports["waze-system"]:checkBlock({ user_id = args[1] })
	local staff_id = parseInt(blockInfos["request"]["staff_id"])
	local nidentity = vRP.getUserIdentity(blocked_id)
		if args[1] then
			if blockInfos["request"]["type"] == "block" then
			    TriggerClientEvent('Notify', source, 'sucesso', "Jogador: <b>("..blocked_id..") " .. nidentity.name .. " " .. nidentity.firstname .. "</b><br>Expiração: <b>"..formatBlock(blockInfos["request"].time).."</b>")
			else
					TriggerClientEvent('Notify', source, 'sucesso',"XD")
			end
		end
	end
end)

function formatTempBan(seconds)
    local temp = os.date("*t", parseInt(seconds))
    local txt = temp.day .. "/" .. temp.month .. "/" .. temp.year .. " - " .. temp.hour .. ":" .. temp.min .. ":" .. temp.sec
    return txt
end

function formatBlock(seconds)
    local temp = os.date("*t", parseInt(seconds))
    local txt = temp.day .. "/" .. temp.month .. "/" .. temp.year .. " - " .. temp.hour .. ":" .. temp.min .. ":" .. temp.sec
    return txt
end


RegisterCommand("teas",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)

	exports["waze-system"]:sendLogs(user_id,{ webhook = "adminCar", text = "Spawnou o veículo "..(args[1]) })

end)