-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local cfg = module("vrp","cfg/groups")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
startIdentity = {}
Tunnel.bindInterface("vrp_identidade",startIdentity)
Proxy.addInterface("vrp_identidade",startIdentity)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local groups = cfg.groups
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckRelacionamento(user_id)

	local query = vRP.query('relacionamento/GetUserRelacinamento', {user_id = user_id})

	if not query or not query[1] or query[1] == nil then
		vRP.execute('relacionamento/InsertRelacionamento', {user_id = user_id, relacionamento = 0, relacionamentoCom = -1})
		return 'Solteiro(a)'
	end

    if query[1] and query[1] ~= nil then
		local row = query[1] 
		local other = ''
        if row.relacionamento == 0 then
            return 'Solteiro(a)'
		elseif row.relacionamento == 1 then
            local nomeOutro = vRP.getUserIdentity(parseInt(row.relacionamentoCom))
			if nomeOutro then
				other = nomeOutro.name .. ' ' .. nomeOutro.firstname
			end
            other = 'Namorando com ' .. other
            return other
		elseif row.relacionamento == 2 then
			local nomeOutro = vRP.getUserIdentity(parseInt(row.relacionamentoCom))
			if nomeOutro then
				other = nomeOutro.name .. ' ' .. nomeOutro.firstname
			end
            other = 'Noivado(a) com ' .. other
            return other
		elseif row.relacionamento == 3 then
            local nomeOutro = vRP.getUserIdentity(parseInt(row.relacionamentoCom))
			if nomeOutro then
				other = nomeOutro.name .. ' ' .. nomeOutro.firstname
			end
            other = 'Casado(a) com ' .. other
            return other
        end
    end
end

function startIdentity.Identidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local cash = vRP.getMoney(user_id)
		local banco = vRP.getBankMoney(user_id)
		local identity = vRP.getUserIdentity(user_id)
		local multas = vRP.getUData(user_id,"vRP:multas")
		local mymultas = json.decode(multas) or 0
		local paypal = vRP.getUData(user_id,"vRP:paypal")
		local mypaypal = json.decode(paypal) or 0
		local job = startIdentity.getUserGroupByType(user_id,"job")
		local jobdois = startIdentity.getUserGroupByType(user_id,"jobdois")
		local gerente = startIdentity.getUserGroupByType(user_id,"gerente")
		local vip = startIdentity.getUserGroupByType(user_id,"vip")
		local relacionamento = CheckRelacionamento(user_id)
		if identity then
			return vRP.format(parseInt(cash)),vRP.format(parseInt(banco)),identity.name,identity.firstname,identity.age,identity.user_id,identity.registration,identity.phone,job,jobdois,gerente,vip,vRP.format(parseInt(mymultas)),vRP.format(parseInt(mypaypal)),relacionamento
		end
	end
end

function startIdentity.GetInfos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local identity = vRP.getUserIdentity(user_id)
		local bvip = 'NORMAL'
		if vRP.hasGroup(user_id,'startelite') then
			bvip = 'startelite'
		elseif vRP.hasGroup(user_id,'start') then
			bvip = 'start'
		end

		local paypal = vRP.getUData(user_id,"vRP:paypal")
		local mypaypal = json.decode(paypal) or 0
		mypaypal = '$'..vRP.format(mypaypal)..',00'

		local carteira = vRP.getMoney(user_id)
		carteira = '$'..vRP.format(carteira)..',00'
		
		local job = startIdentity.getUserGroupByType(user_id,"job")
		
		local multas = vRP.getUData(user_id,"vRP:multas")
		local mymultas = json.decode(multas) or 0
		mymultas = '$'..vRP.format(mymultas)..',00'
		
		local banco = vRP.getBankMoney(user_id)
		banco = '$'..vRP.format(banco)..',00'


		local relacionamento = CheckRelacionamento(user_id)
		
		print('RETORNOU TUDO')
		return bvip, identity.name, identity.firstname, user_id, identity.registration, identity.phone, carteira, mypaypal, identity.age, job, mymultas, banco, relacionamento
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function startIdentity.getUserGroupByType(user_id,gtype)
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

RegisterCommand('infop', function(source, args, rawCmd)
    
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'admin.permissao') then
		if args[1] then
			local nuser_id = parseInt(args[1])
			local cash = vRP.getMoney(nuser_id)
			local banco = vRP.getBankMoney(nuser_id)
			local identity = vRP.getUserIdentity(nuser_id)
			local multas = vRP.getUData(nuser_id,"vRP:multas")
			local mymultas = json.decode(multas) or 0
			local paypal = vRP.getUData(nuser_id,"vRP:paypal")
			local mypaypal = json.decode(paypal) or 0
			local job = startIdentity.getUserGroupByType(nuser_id,"job")
			if not job or job == '' then job = 'NIL' end
			local vip = startIdentity.getUserGroupByType(nuser_id,"vip")
			if not vip or vip == '' then vip = 'NIL' end
			local vidinha = vRPclient.getHealth(vRP.getUserSource(nuser_id))
			local desmanche = 'NÃO'
			if vRP.hasGroup(nuser_id,'Desmanche') then desmanche = 'SIM' end
			local advogado = 'NÃO'
			if vRP.hasGroup(nuser_id,'Advogado') then advogado = 'SIM' end
			local relacionamento = CheckRelacionamento(nuser_id)

			TriggerClientEvent('Notify', source, 'importante', 'Passaporte: <b>' .. nuser_id .. '</b> <b>'.. identity.name .. ' ' .. identity.firstname .. '</b><br>Carteira: <b>' .. vRP.format(cash) .. '</b><br>Banco: <b>' .. vRP.format(banco) .. '</b><br>Multas: <b>' .. vRP.format(mymultas) .. '</b><br>Paypal: <b>' .. vRP.format(mypaypal) ..'</b><br>Emprego: <b>' .. job .. '</b><br>VIP: <b>' .. vip  .. '</b><br>Vida: <b>' .. vidinha .. '</b><br>Desmanche: <b>' .. desmanche .. '</b><br>Advogado: <b>' .. advogado .. '</b><br>Estado civil: <b>'.. relacionamento .. '</b>', 10000)

		end
	end
end)