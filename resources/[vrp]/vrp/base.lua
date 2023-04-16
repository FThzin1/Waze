local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")

vRP = {}
Proxy.addInterface("vRP",vRP)

tvRP = {}
Tunnel.bindInterface("vRP",tvRP)
vRPclient = Tunnel.getInterface("vRP")

vRP.users = {}
vRP.rusers = {}
vRP.user_tables = {}
vRP.user_tmp_tables = {}
vRP.user_sources = {}

local db_drivers = {}
local db_driver
local cached_prepares = {}
local cached_queries = {}
local prepared_queries = {}
local db_initialized = false

--local SoAdminsNoServer = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
function ExtractIdentifiers(src)
    local identifiers = {
        steam = "N/E",
        ip = "N/E",
        discord = "N/E",
        license = "N/E",
        xbl = "N/E",
        live = "N/E"
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- BASE.LUA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.registerDBDriver(name,on_init,on_prepare,on_query)
	if not db_drivers[name] then
		db_drivers[name] = { on_init,on_prepare,on_query }

		if name == "oxmysql" then
			db_driver = db_drivers[name]

			local ok = on_init("waze")
			if ok then
				db_initialized = true
				for _,prepare in pairs(cached_prepares) do
					on_prepare(table.unpack(prepare,1,table.maxn(prepare)))
				end

				for _,query in pairs(cached_queries) do
					query[2](on_query(table.unpack(query[1],1,table.maxn(query[1]))))
				end

				cached_prepares = nil
				cached_queries = nil
			end
		end
	end
end

function vRP.format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

function vRP.prepare(name,query)
	prepared_queries[name] = true

	if db_initialized then
		db_driver[2](name,query)
	else
		table.insert(cached_prepares,{ name,query })
	end
end

function vRP.query(name,params,mode)
	if not mode then mode = "query" end

	if db_initialized then
		return db_driver[3](name,params or {},mode)
	else
		local r = async()
		table.insert(cached_queries,{{ name,params or {},mode },r })
		return r:wait()
	end
end

function vRP.execute(name,params)
	return vRP.query(name,params,"execute")
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_BASE.LUA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/create_user","INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false); SELECT LAST_INSERT_ID() AS id")
vRP.prepare("vRP/add_identifier","INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
vRP.prepare("vRP/userid_byidentifier","SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
vRP.prepare("vRP/set_userdata","REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("vRP/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata","SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")
vRP.prepare("vRP/get_whitelisted","SELECT whitelisted FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_whitelisted","UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")
vRP.prepare("vRP/set_last_login","UPDATE vrp_users SET last_login = @last_login, ip = @ip WHERE id = @user_id")
vRP.prepare("vRP/getall","SELECT identifier FROM vrp_user_ids")


function vRP.getUserIdByIdentifier(ids)
	local rows = vRP.query("vRP/userid_byidentifier",{ identifier = ids})
	if #rows > 0 then
		return rows[1].user_id
	else
		return -1
	end
end

function vRP.getUserIdByIdentifiers(ids)
	if ids and #ids then
		for i=1,#ids do
			if (string.find(ids[i],"ip:") == nil) then
				local rows = vRP.query("vRP/userid_byidentifier",{ identifier = ids[i] })
				if #rows > 0 then
					return rows[1].user_id
				end
			end
		end

		local rows,affected = vRP.query("vRP/create_user",{})

		if #rows > 0 then
			local user_id = rows[1].id
			for l,w in pairs(ids) do
				if (string.find(w,"ip:") == nil) then
					vRP.execute("vRP/add_identifier",{ user_id = user_id, identifier = w })
				end
			end
			return user_id
		end
	end
end

function vRP.getPlayerEndpoint(player)
	return GetPlayerEP(player) or "0.0.0.0"
end

function vRP.isWhitelisted(user_id, cbr)
	local rows = vRP.query("vRP/get_whitelisted",{ user_id = user_id })
	if #rows > 0 then
		return rows[1].whitelisted
	else
		return false
	end
end

function vRP.setWhitelisted(user_id,whitelisted)
	vRP.execute("vRP/set_whitelisted",{ user_id = user_id, whitelisted = whitelisted })
end

function vRP.setUData(user_id,key,value)
	vRP.execute("vRP/set_userdata",{ user_id = parseInt(user_id), key = key, value = value })
end

function vRP.getUData(user_id,key,cbr)
	local rows = vRP.query("vRP/get_userdata",{ user_id = user_id, key = key })
	if #rows > 0 then
		return rows[1].dvalue
	else
		return ""
	end
end

function vRP.setSData(key,value)
	vRP.execute("vRP/set_srvdata",{ key = key, value = value })
end

function vRP.getSData(key, cbr)
	local rows = vRP.query("vRP/get_srvdata",{ key = key })
	if #rows > 0 then
		return rows[1].dvalue
	else
		return ""
	end
end

function vRP.getUserDataTable(user_id)
	return vRP.user_tables[user_id]
end

function vRP.getUserTmpTable(user_id)
	return vRP.user_tmp_tables[user_id]
end

function vRP.getUserId(source)
	if source ~= nil then
		local ids = GetPlayerIdentifiers(source)
		if ids ~= nil and #ids > 0 then
			return vRP.users[ids[1]]
		end
	end
	return nil
end

function vRP.getUsers()
	local users = {}
	for k,v in pairs(vRP.user_sources) do
		users[k] = v
	end
	return users
end

function vRP.getUserSource(user_id)
	return vRP.user_sources[user_id]
end

function vRP.kick(source,reason)
	DropPlayer(source,reason)
end

--vRP.prepare('waze/ConnectAdminList', 'SELECT * FROM vrp_adminlist WHERE user_id = @user_id')
--function CheckDbAdminList(user_id)
--	local query = vRP.query('waze/ConnectAdminList', {user_id = user_id})
--	if query[1] and query[1] ~= nil then
--		if query[1].user_id == user_id then
--			return true
--		end
--	end
--	return false
--end

function vRP.dropPlayer(source,motivo)
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
	local VidaQuitou = GetEntityHealth(GetPlayerPed(source))
	local status = 'VIVO'

	if VidaQuitou <= 101 then status = 'MORTO' end
	vRPclient._removePlayer(-1,source)
	if user_id then
		if user_id and source then

			local DataTable = vRP.getUserDataTable(user_id)
            local TableInv = DataTable.inventory
            local TableArmas = DataTable.weapons

			TriggerEvent("vRP:playerLeave",user_id,source)

			local wazeids = ExtractIdentifiers(source)

			local _steamID ="STEAM ID: " ..wazeids.steam
			local _licenseID ="\nLICENSE: " ..wazeids.license
			local _steamURL = ''
			local _discordID = '' 
						
			if wazeids.discord ~= 'N/E' then
				_discordID = "\nDISCORD: " ..wazeids.discord:gsub("discord:", "")..""
			end

			if wazeids.steam ~= 'N/E' then
				_steamURL ="\nURL: https://steamcommunity.com/profiles/" ..tonumber(wazeids.steam:gsub("steam:", ""),16)
			end

			if parseInt(DataTable.health) <= parseInt(101) then
				print("^8[ - ] waze Logout > ^0[ID]: "..user_id.." [HEX]: "..GetPlayerIdentifier(source)..os.date("  [HORA]: %H:%M:%S")..'\n[MOTIVO DA SAÍDA]: ' .. motivo)
				exports["waze-system"]:sendRegister({ webhook = "playerDeadIP", text = "ID: "..user_id.."\nDeslogou-se do servidor ("..motivo..")\nIP: "..GetPlayerEndpoint(source).."\nPosição: "..x..', '..y..', '..z.."\nVida: "..VidaQuitou.." | Status: "..status.."\n\nInventário: "..concatInv(TableInv).."\nArmas Equipadas: "..concatArmas(TableArmas) })
				exports["waze-system"]:sendRegister({ webhook = "playerDead", text = "ID: "..user_id.."\nDeslogou-se do servidor ("..motivo..")\nPosição: "..x..', '..y..', '..z.."\nVida: "..VidaQuitou.." | Status: "..status.."\n\nInventário: "..concatInv(TableInv).."\nArmas Equipadas: "..concatArmas(TableArmas) })
			else
				exports["waze-system"]:sendRegister({ webhook = "playerExitIP", text = "ID: "..user_id.."\nDeslogou-se do servidor ("..motivo..")\nIP: "..GetPlayerEndpoint(source).."\nPosição: "..x..', '..y..', '..z.."\nVida: "..VidaQuitou.." | Status: "..status.."\n\nInventário: "..concatInv(TableInv).."\nArmas Equipadas: "..concatArmas(TableArmas) })
				exports["waze-system"]:sendRegister({ webhook = "playerExit", text = "ID: "..user_id.."\nDeslogou-se do servidor ("..motivo..")Posição: "..x..', '..y..', '..z.."\nVida: "..VidaQuitou.." | Status: "..status.."\n\nInventário: "..concatInv(TableInv).."\nArmas Equipadas: "..concatArmas(TableArmas) })
			end
				local identity = vRP.getUserIdentity(user_id)

            if vRP.hasGroup(user_id,"policia") then
                vRP.addUserGroup(user_id,"paisanapolicia")
            elseif vRP.hasGroup(user_id,"medico") then
                vRP.addUserGroup(user_id,"paisanamedico")
            elseif vRP.hasGroup(user_id,"mecanico") then
                vRP.addUserGroup(user_id,"paisanamecanico")
            end
        end
		vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))
		print("^3[ + ] wazeSQL > ^7Os dados do jogador ^3("..user_id..") ^7foram salvos com sucesso!")
		vRP.users[vRP.rusers[user_id]] = nil
		vRP.rusers[user_id] = nil
		vRP.user_tables[user_id] = nil
		vRP.user_tmp_tables[user_id] = nil
		vRP.user_sources[user_id] = nil
	end
end

function concatInv(TableInv)
	local txt = ''
	if TableInv and type(TableInv) == 'table' then
		for k, v in pairs(TableInv) do
			txt = '\n   ' .. vRP.format(v.amount) .. 'x ' .. vRP.itemNameList(k) .. txt
		end
		if txt == '' then
			return 'MOCHILA VAZIA'
		else 
			return txt
		end
	end
	return 'ERRO AO ENCONTRAR INVENTARIO'
end

function concatArmas(TableInv)
	local txt = ''
	if TableInv and type(TableInv) == 'table' then
		for k, v in pairs(TableInv) do
			txt = '\n   ' .. vRP.itemNameList('wbody|'..k) .. ' [' .. v.ammo .. ']' .. txt
		end
		if txt == '' then
			return 'DESARMADO'
		else
			return txt
		end
	end
	return 'ERRO AO ENCONTRAR ARMAS'
end

RegisterServerEvent('waze:forceDbUpdate')
AddEventHandler('waze:forceDbUpdate',function(user_id,group)
	if vRP.user_tables[user_id] == nil then
		print('^2[ + ] waze GROUPS >^7 Jogador offline, criado temp table.')
		local sdata = vRP.getUData(user_id,"vRP:datatable")
		local data = json.decode(sdata)
		if type(data) == "table" then vRP.user_tables[user_id] = data end
	end

	local userData = vRP.getUserDataTable(user_id)

	userData["groups"][group] = nil
	vRP.setUData(user_id,"vRP:datatable",json.encode(userData))
end)


--vRP.remove_weapon_table = function(user_id,index)
--    if vRP.user_tables[user_id].weapons then
--        for k,v in pairs(vRP.user_tables[user_id].weapons) do
--            vRP.user_tables[user_id].weapons[index] = nil
--        end
--        vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))
--    end
--end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEWEAPONTABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removeWeaponTable(user_id,index)
    if vRP.user_tables[user_id]["weapons"] then
        for k,v in pairs(vRP.user_tables[user_id]["weapons"]) do
            vRP.user_tables[user_id]["weapons"][index] = nil
            vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))
        end
    end
end

function task_save_datatables()
	SetTimeout(30 * 1000,task_save_datatables)
	TriggerEvent("vRP:save")
	for k,v in pairs(vRP.user_tables) do
		vRP.setUData(k,"vRP:datatable",json.encode(v))
	end
end

async(function()
	task_save_datatables()
end)

--wazerr = true
--
--RegisterServerEvent('waze:rr')
--AddEventHandler('waze:rr',function(var)
--	wazerr = var
--	if not var then
--		repeat
--			Wait(5000)
--			print('[waze RP] Servidor entrou em reinicio!')
--		until wazerr
--	end
--end)

AddEventHandler("queue:playerConnecting",function(source,ids,name,setKickReason,deferrals)
	deferrals.defer()
	local source = source
	local ids = ids

    local user_id = vRP.getUserIdByIdentifiers(ids)

    if not user_id then
        deferrals.done("Você teve um problema de identidade (user_id).")
		TriggerEvent("Queue:removeQueue",ids)
        return
    end

	
	local bannedInfos = exports["waze-system"]:checkBan({ user_id = user_id })
    if not bannedInfos.canJoin then
        if bannedInfos["request"]["reason"] then
            if bannedInfos["request"]["type"] == "temporary" then
                deferrals.done("\n\n[ ERRO DE CONEXÃO ]\n\nVocê foi banido temporariamente do servidor.\n\nData de expiração: "..formatTempBan(bannedInfos["request"].time).."\nSeu ID: "..user_id.."\nMotivo: "..bannedInfos["request"]["reason"].."\n\nAcha que seu banimento foi injusto? Abra um ticket para recorrer.")
            else
                deferrals.done("\n\n[ ERRO DE CONEXÃO ]\n\nVocê foi banido do servidor.\n\nSeu ID: "..user_id.."\nMotivo: "..bannedInfos["request"]["reason"].."\n\nAcha que seu banimento foi injusto? Abra um ticket para recorrer.")
            end
            TriggerEvent("Queue:removeQueue", ids)
        else
            deferrals.done("\n\n[ ERRO DE CONEXÃO ]\n\nVocê foi banido do servidor.\n\nSeu ID: "..user_id.."\n\nAcha que seu banimento foi injusto? Abra um ticket para recorrer.")
            TriggerEvent("Queue:removeQueue", ids)
        end

        print("^1[ CONEXÃO ] ^7O jogador de ID "..user_id.." tentou-se conectar estando banido ("..bannedInfos["request"]["reason"]..").")
        return
    end
	--if not wazerr then
	--	deferrals.done("O SERVIDOR ESTÁ EM PROCESSO DE REINICIALIZAÇÃO! \nMAIS INFORMAÇÕES: [ https://discord.gg/wazerp ]")
	--	TriggerEvent("queue:playerConnectingRemoveQueues",ids)
	--	return
	--end
	
	--if SoAdminsNoServer then
	--	if not CheckDbAdminList(user_id) then
	--		deferrals.done("[SERVIDOR TRAVADO SO PARA OS ADMIN].")
	--		TriggerEvent("queue:playerConnectingRemoveQueues",ids)
	--		return
	--	end
	--end

	if ids ~= nil and #ids > 0 then
		deferrals.update("Carregando identidades.")
		local user_id = vRP.getUserIdByIdentifiers(ids)
		if user_id then
			local nsource = vRP.getUserSource(user_id)
			if(nsource~=nil)then
				if(GetPlayerName(nsource)~=nil)then
					deferrals.done("Você está bugado, reinicie o fivem!") --MQCU
					TriggerEvent("queue:playerConnectingRemoveQueues",ids)
					return
				end
			end
			deferrals.update("Carregando banimentos.")
				deferrals.update("Carregando whitelist.")
				if vRP.isWhitelisted(user_id) then
					if vRP.rusers[user_id] == nil then
						deferrals.update("Carregando banco de dados.")
						local sdata = vRP.getUData(user_id,"vRP:datatable")

						vRP.users[ids[1]] = user_id
						vRP.rusers[user_id] = ids[1]
						vRP.user_tables[user_id] = {}
						vRP.user_tmp_tables[user_id] = {}
						vRP.user_sources[user_id] = source

						local data = json.decode(sdata)
						if type(data) == "table" then vRP.user_tables[user_id] = data end

						local tmpdata = vRP.getUserTmpTable(user_id)
						tmpdata.spawns = 0

						vRP.execute("vRP/set_last_login",{ user_id = user_id, last_login = os.date("%d.%m.%Y"), ip = GetPlayerEndpoint(source) or '0.0.0.0' })

						TriggerEvent("vRP:playerJoin",user_id,source,name)

						local wazeids = ExtractIdentifiers(source)

						local _steamID ="STEAM ID: " ..wazeids.steam
						local _licenseID ="\nLICENSE: " ..wazeids.license
						local _steamURL = ''
						local _discordID = '' 
						
						if wazeids.discord ~= 'N/E' then
							_discordID = "\nDISCORD: " ..wazeids.discord:gsub("discord:", "")..""
						end

						if wazeids.steam ~= 'N/E' then
							_steamURL ="\nURL: https://steamcommunity.com/profiles/" ..tonumber(wazeids.steam:gsub("steam:", ""),16)
						end

						print("^2[ + ] waze Login > ^0[ID]: "..user_id.." [HEX]: "..GetPlayerIdentifier(source)..os.date(" [HORA]: %H:%M:%S"))
						exports["waze-system"]:sendRegister({ webhook = "playerJoinIP", text = "ID: "..user_id.."\nLogou-se ao servidor\nIP: "..GetPlayerEndpoint(source).."\nIdentificador: "..GetPlayerIdentifier(source).."\n\nIdentificadores:\n".._steamID.._discordID.._licenseID.._steamURL })
						exports["waze-system"]:sendRegister({ webhook = "playerJoin", text = "ID: "..user_id.."\nLogou-se ao servidor\nIdentificador: "..GetPlayerIdentifier(source).."\n\nIdentificadores:\n".._steamID.._discordID.._licenseID.._steamURL })
						deferrals.done()
					else
						local tmpdata = vRP.getUserTmpTable(user_id)
						tmpdata.spawns = 0

						TriggerEvent("vRP:playerRejoin",user_id,source,name)
						deferrals.done()
					end
				else
					deferrals.done("Solicite sua whitelist em nosso Discord! [ https://discord.gg/waze ][ ID: "..user_id.." ]")
					TriggerEvent("queue:playerConnectingRemoveQueues",ids)
				end
		    else
			deferrals.done("Ocorreu um problema de identificação.")
			TriggerEvent("queue:playerConnectingRemoveQueues",ids)
		end
	else
		deferrals.done("Ocorreu um problema de identidade.")
		TriggerEvent("queue:playerConnectingRemoveQueues",ids)
	end
end)

AddEventHandler("playerDropped",function(reason)
	local source = source
	vRP.dropPlayer(source,reason)
end)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned",function()
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.user_sources[user_id] = source
		local tmp = vRP.getUserTmpTable(user_id)
		tmp.spawns = tmp.spawns+1
		local first_spawn = (tmp.spawns == 1)

		if first_spawn then
			for k,v in pairs(vRP.user_sources) do
				vRPclient._addPlayer(source,v)
			end
			vRPclient._addPlayer(-1,source)
			Tunnel.setDestDelay(source,0)
		end
		TriggerEvent("vRP:playerSpawn",user_id,source,first_spawn)
	end
end)

function vRP.getDayHours(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)

    if days > 0 then
        return string.format("<b>%d Dias</b> e <b>%d Horas</b>",days,hours)
    else
        return string.format("<b>%d Horas</b>",hours)
    end
end

function vRP.getMinSecs(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds/60)
    seconds = seconds - minutes * 60

    if minutes > 0 then
        return string.format("<b>%d Minutos</b> e <b>%d Segundos</b>",minutes,seconds)
    else
        return string.format("<b>%d Segundos</b>",seconds)
    end
end

--RegisterCommand('travarservidor', function(source, args, rawCmd)
--    
--	local user_id = vRP.getUserId(source)
--		if vRP.hasPermission(user_id, 'waze.permissao') then
--			if args[1] then
--				if parseInt(args[1]) == 0 then
--					SoAdminsNoServer = false
--					print('SERVIDOR LIBERADO PARA TODOS!')
--				elseif parseInt(args[1]) == 1 then
--					SoAdminsNoServer = true
--					print('SERVIDOR BLOQUEADO SÓ PARA ADEMIRES!')
--				--end
--			end
--		end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FORMATTEMPBAN
-----------------------------------------------------------------------------------------------------------------------------------------
function formatTempBan(seconds)
    local temp = os.date("*t", parseInt(seconds))
    local txt = temp.day .. "/" .. temp.month .. "/" .. temp.year .. " - " .. temp.hour .. ":" .. temp.min .. ":" .. temp.sec
    return txt
end