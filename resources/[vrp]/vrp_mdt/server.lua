local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_mdt",src)

vCLIENT = Tunnel.getInterface("vrp_mdt")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookmultas = ""
local webhookprender = ""
local webhookprenderadm = ""
local webhookavisos = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("mdt/get_user_inssues","SELECT * FROM vrp_mdt WHERE user_id = @user_id")
vRP._prepare("mdt/get_user_arrest","SELECT * FROM vrp_mdt WHERE user_id = @user_id AND type = @type")
vRP._prepare("mdt/add_user_inssues","INSERT INTO vrp_mdt(user_id,type,value,data,info,officer) VALUES(@user_id,@type,@value,@data,@info,@officer); SELECT LAST_INSERT_ID() AS slot")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.infoUser(user)
	local source = source 
	if user then
		local value = vRP.getUData(parseInt(user),"vRP:multas")
		local multas = json.decode(value) or 0
		local identity = vRP.getUserIdentity(parseInt(user))
		local arrests = vRP.query("mdt/get_user_arrest",{ user_id = parseInt(user), type = "arrest" })
		local tickets = vRP.query("mdt/get_user_arrest",{ user_id = parseInt(user), type = "ticket" })
		local warnings = vRP.query("mdt/get_user_arrest",{ user_id = parseInt(user), type = "warning" })
		if identity then
			return multas,identity.name,identity.firstname,identity.registration,parseInt(identity.age),#arrests,#warnings
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH ARRESTS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.arrestsUser(user)
	local source = source
	if user then
		local data = vRP.query("mdt/get_user_arrest",{ user_id = user, type = "arrest" })
		local arrest = {}
		if data then
			for k,v in pairs(data) do
				arrest[#arrest + 1] = { data = v.data, value = v.value, info = v.info, officer = v.officer }
			end
			return arrest
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH TICKETS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.ticketsUser(user)
	local source = source
	if user then
		local data = vRP.query("mdt/get_user_arrest",{ user_id = user, type = "ticket" })
		local arrest = {}
		if data then
			for k,v in pairs(data) do
				arrest[#arrest + 1] = { data = v.data, value = v.value, info = v.info, officer = v.officer }
			end
			return arrest
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH WARNINGS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.warningsUser(user)
	local source = source
	if user then
		local data = vRP.query("mdt/get_user_arrest",{ user_id = user, type = "warning" })
		local arrest = {}
		if data then
			for k,v in pairs(data) do
				arrest[#arrest + 1] = { data = v.data, value = v.value, info = v.info, officer = v.officer }
			end
			return arrest
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARNING
-----------------------------------------------------------------------------------------------------------------------------------------
function src.warningUser(user,date,info,officer)
	if vRP.hasPermission(user_id, 'policia.permissao') or vRP.hasPermission(user_id, 'admin.permissao') then
		local user_id = vRP.getUserId(source)
		local source = source
		if user then
			local identity = vRP.getUserIdentity(parseInt(user))
			vRP.execute("mdt/add_user_inssues",{ user_id = user, type = "warning", value = 0, data = date, info = info, officer = officer })
			SendWebhookMessage(webhookavisos,"```prolog\n[OFICIAL]: "..user_id.." "..officer.."\n[==============COLOCOU UM AVISO==============] \n[PASSAPORTE]: "..user.." "..identity.name.." "..identity.firstname.." \n[AVISO]: "..info.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			TriggerClientEvent("Notify",source,"sucesso","Aviso aplicado com sucesso.",8000)
			vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TICKET
-----------------------------------------------------------------------------------------------------------------------------------------
function src.ticketUser(user,value,date,info,officer)
	local user_id = vRP.getUserId(source)
	local source = source
	if user then
		if string.sub(tostring(value), 1, 1) == '-'  then
			TriggerClientEvent("Notify",source,'negado',"É <b>proibido</b> dar multas negativas.",8000)
			return
		end
		local valor = vRP.getUData(parseInt(user),"vRP:multas")
		local multas = json.decode(valor) or 0
		local nplayer = vRP.getUserSource(parseInt(user))
		local identity = vRP.getUserIdentity(parseInt(user))
		vRP.setUData(parseInt(user),"vRP:multas",json.encode(parseInt(multas)+parseInt(value)))
		vRP.execute("mdt/add_user_inssues",{ user_id = user, type = "ticket", value = parseInt(value), data = date, info = info, officer = officer })
		SendWebhookMessage(webhookmultas,"```prolog\n[OFICIAL]: "..user_id.." "..officer.."\n[==============MULTOU==============] \n[PASSAPORTE]: "..user.." "..identity.name.." "..identity.firstname.." \n[VALOR]: $"..vRP.format(parseInt(value)).." \n[MOTIVO]: "..info.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

		randmoney = math.random(150,350)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("Notify",source,"sucesso","Multa aplicada com sucesso.",8000)
		TriggerClientEvent("Notify",source,"importante","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
		TriggerClientEvent("Notify",nplayer,"importante","Você foi multado em <b>$"..vRP.format(parseInt(value)).." dólares</b>.<br><b>Motivo:</b> "..info..".")
		vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TICKET
-----------------------------------------------------------------------------------------------------------------------------------------
function src.arrestUser(user,value,date,info,officer)
	local source = source
	local user_id = vRP.getUserId(source)
	local source = source
	local nplayer = vRP.getUserSource(parseInt(user))
	local policiaispenis = vRP.getUsersByPermission('policia.permissao')
	if vRP.hasPermission(user_id, 'policia.permissao') or vRP.hasPermission(user_id, 'admin.permissao') or vRP.hasPermission(user_id, 'policia.permissao') then	
		if user then
			local player = vRP.getUserSource(parseInt(user))
			local identity = vRP.getUserIdentity(parseInt(user))
			if player then
				local distok = vCLIENT.Distancia(source)
				if distok then
					
					if #policiaispenis > 0 and not vRP.hasPermission(user_id, 'policia.permissao') then
						TriggerClientEvent("Notify",source,'negado',"Há policiais penitenciários em serviço, chame um deles para isso.",8000)
						return
					end

					vRP.setUData(parseInt(user),"vRP:prisao",json.encode(parseInt(value)))
					vRP.execute("mdt/add_user_inssues",{ user_id = user, type = "arrest", value = parseInt(value), data = date, info = info, officer = officer })

					SendWebhookMessage(webhookprender,"```prolog\n[OFICIAL]: "..user_id.." "..officer.."\n[==============PRENDEU==============] \n[PASSAPORTE]: "..user.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: "..info.."\n[TEMPO]: "..vRP.format(parseInt(value)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					SendWebhookMessage("","```prolog\n[OFICIAL]: "..user_id.." "..officer.."\n[==============PRENDEU==============] \n[PASSAPORTE]: "..user.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: "..info.."\n[TEMPO]: "..vRP.format(parseInt(value)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					vRPclient.setHandcuffed(player,false)
					TriggerEvent('waze:ColocarRoupaPreso', user)
					TriggerClientEvent('waze:VirarPrisioneiro',player,true)
					TriggerClientEvent('waze:pecadecarro', player)
					TriggerClientEvent('waze:ExcecaoTp', player)
					TriggerClientEvent('wazeprisioneiro',player,true)
					SetEntityCoords(GetPlayerPed(player),1680.1,2513.0,46.5)
					--prison_lock(parseInt(user))
					TriggerClientEvent('removealgemas',player)
					TriggerClientEvent("vrp_sound:source",player,'jaildoor',0.7)
					TriggerClientEvent("vrp_sound:source",source,'jaildoor',0.7)

					randmoney = math.random(350,500)
					vRP.giveMoney(user_id,parseInt(randmoney))
					TriggerClientEvent("Notify",source,'sucesso',"Prisão aplicada com sucesso.",8000)
					TriggerClientEvent("Notify",source,'importante',"Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
					TriggerClientEvent("Notify",nplayer,"importante","Você foi preso por <b>"..vRP.format(parseInt(value)).." meses</b>.<br><b>Motivo:</b> "..info..".")
					vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
					-- return true
				else
					TriggerClientEvent("Notify",source,'negado',"Você deve estar próximo à secretaria para efetuar a prisão.",8000)
					-- return false
				end
			end
		end
	end
end


RegisterCommand('prender', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'suporte.permissao') then
		local passaporte = vRP.prompt(source, 'Passaporte', '') 
		if not passaporte or passaporte == '' then return end 
		
		local meses = vRP.prompt(source, 'Meses', '') 
		if not meses or meses == '' then return end 

		local motivo = vRP.prompt(source, 'Motivo', '') 
		if not motivo or motivo == '' then return end 


		passaporte = parseInt(passaporte)
		meses = parseInt(meses)
		local nsource = vRP.getUserSource(passaporte)
		local identity = vRP.getUserIdentity(user_id)
		local nidentity = vRP.getUserIdentity(passaporte)
		if nsource then
			vRP.setUData(passaporte,"vRP:prisao",json.encode(meses) )
			exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPrison", text = "Prendeu ("..passaporte..") "..nidentity.name.." "..nidentity.firstname.." por "..vRP.format(meses).." minutos\nMotivo: "..motivo })
			vRPclient.setHandcuffed(nsource,false)
			TriggerClientEvent('waze:VirarPrisioneiro',nsource,true)
			TriggerClientEvent('waze:ExcecaoTp', nsource)
			TriggerClientEvent('wazeprisioneiro',nsource,true)
			SetEntityCoords(GetPlayerPed(nsource),1680.1,2513.0,46.5)
			--prison_lock(passaporte)
			TriggerClientEvent('removealgemas',nsource)
			TriggerClientEvent("vrp_sound:source",nsource,'jaildoor',0.7)
			TriggerClientEvent("vrp_sound:source",source,'jaildoor',0.7)

			TriggerClientEvent("Notify",source,'sucesso',"Prisão aplicada com sucesso.",8000)
			TriggerClientEvent("Notify",nsource,"importante", "Você foi preso por <b>"..vRP.format(meses).." meses</b>.<br><b>Motivo:</b> "..motivo..".")
			vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
		end

	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id, 'admin.permissao') or vRP.hasPermission(user_id, 'medico.permissao')
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local player = vRP.getUserSource(parseInt(user_id))
	if player then
		SetTimeout(15000,function()
			local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
			local tempo = json.decode(value) or -1

			if tempo == -1 then
				return
			end

			if tempo > 0 then
				TriggerClientEvent('wazeprisioneiro',player,true)
				TriggerClientEvent('waze:VirarPrisioneiro',player,true)
				SetEntityCoords(GetPlayerPed(player),662.38,95.41,83.95)
			end
		end)
	end
end)

local presets = {
	['Prisoneiro'] = {
		[1885233650] = {
			[1] = { -1, 0 }, -- MASCARA // MASKS
			[3] = { 5, 0 }, -- MAOS // MALE TORSOS
			[4] = { 5, 7 }, -- CALÇA // MALE LEGS
			[5] = { -1, 0 }, -- MOCHILA // BAGS AND PARACHUTES
			[6] = { 5, 0 }, -- SAPATOS // MALE SHOES
			[7] = { -1, 0 },	-- ACESSORIOS // MALE ACCESSORIES		
			[8] = { 15, 0 }, -- CAMISETA // MALE UNDERSHIRTS
			[9] = { 0, 0 }, -- COLETE // MALE BODYARMOR
			[10] = { -1, 0 }, -- INSIGNIAS // MALE DECALS
			[11] = { 237, 0 }, -- JAQUETA // MALE TOPS
			["p0"] = { -1, 0 }, -- CHAPEU // MALE HATS
			["p1"] = { -1, 0 }, -- OCULOS // MALE GLASSES
			["p2"] = { -1, 0 }, -- BRINCOS // MALE EARS
			["p6"] = { 2, 2 }, -- MAO ESQUERDA // MALE WATCHES
			["p7"] = { -1, 0 } -- MAO DIREITA // MALE BRACELETS
		},
		[-1667301416] = {
			[1] = {-1, 0}, 
			[3] = {4, 0}, 
			[4] = {66, 6}, 
			[5] = {-1, 0}, 
			[6] = {5, 1}, 
			[7] = {-1, 0}, 
			[8] = {6, 0}, 
			[9] = {-1, 0}, 
			[10] = {0, 0}, 
			[11] = {74, 2}, 
			["p2"] = {-1, 0}, 
			["p1"] = {-1, 0}, 
			["p0"] = {-1, 0}, 
			["p6"] = {-1, 0}, 
			["p7"] = {-1, 0}
		}
    }
}

RegisterServerEvent('waze:ColocarRoupaPreso')
AddEventHandler('waze:ColocarRoupaPreso', function(user)
    local nplayer = vRP.getUserSource(parseInt(user))
    local custom = presets["Prisoneiro"]
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
end)