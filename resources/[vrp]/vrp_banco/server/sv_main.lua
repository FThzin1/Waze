local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

banK = {}
Tunnel.bindInterface("vrp_banco",banK)
Proxy.addInterface("vrp_banco",banK)
--[ PAGAR MULTAS ]-----------------------------------------------------------------------------------------------------------------------
--[ DEPOSITAR ]--------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco2626:depositar')
AddEventHandler('banco2626:depositar', function(amount)
	local _source = source
	local user_id = vRP.getUserId(_source)

	if amount == nil or amount <= 0 or amount > vRP.getMoney(user_id) then
		TriggerClientEvent("Notify",_source,"negado","Valor inválido")
	else
		vRP.tryDeposit(user_id, tonumber(amount))
		TriggerClientEvent("Notify",_source,"sucesso","Você depositou <b>$"..vRP.format(parseInt(amount)).." dólares</b>.")
	end
end)

--[ SACAR ]------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco2626:sacar')
AddEventHandler('banco2626:sacar', function(amount)
	local _source = source
	local user_id = vRP.getUserId(_source)

	amount = tonumber(amount)
	local getbankmoney = vRP.getBankMoney(user_id)

	if amount == nil or amount <= 0 or amount > getbankmoney then
		TriggerClientEvent("Notify",_source,"negado","Valor inválido")
	else
		vRP.tryWithdraw(user_id,amount)
		TriggerClientEvent("Notify",_source,"sucesso","Você sacou <b>$"..vRP.format(parseInt(amount)).." dólares</b>.")
	end
end)

--[ PAGAR ]------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco2626:pagar')
AddEventHandler('banco2626:pagar', function(amount)
	local _source = source
	local user_id = vRP.getUserId(_source)
	local banco = vRP.getBankMoney(user_id)

	local valor = tonumber(amount)

	if banco >= tonumber(amount) then
		local multas = vRP.getUData(user_id,"vRP:multas")
		local int = parseInt(multas)
		if int >= valor then
			if valor > 999 then
				local rounded = math.ceil(valor)
				local novamulta = int - rounded
				vRP.setUData(user_id,"vRP:multas",json.encode(novamulta))
				vRP.setBankMoney(user_id,banco-tonumber(valor))
				TriggerClientEvent("Notify",_source,"sucesso","Você pagou $"..vRP.format(parseInt(valor)).." em multas.")
				TriggerClientEvent("currentBalance226",_source)
			else
				TriggerClientEvent("Notify",_source,"aviso","Você só pode pagar multas acima de <b>$1.000</b> dólares")
			end
		else
			TriggerClientEvent("Notify",_source,"negado","Você não pode pagar mais multas do que possuí.")
		end
	else
		TriggerClientEvent("Notify",_source,"negado","Saldo inválido.")
	end
end)

--[ SALDO ]------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco2626:balance')
AddEventHandler('banco2626:balance', function()
	local _source = source
	local user_id = vRP.getUserId(_source)
	local getbankmoney = vRP.getBankMoney(user_id)
	local multasbalance = vRP.getUData(user_id,"vRP:multas")

	TriggerClientEvent("currentBalace126",_source,addComma(math.floor(getbankmoney)),multasbalance)
end)

--[ TRANSFERENCIAS ]---------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('banco2626:transferir')
AddEventHandler('banco2626:transferir', function(to,amountt)
	local _source = source
	local user_id = vRP.getUserId(_source)
	local identity = vRP.getUserIdentity(user_id)

	local _nplayer = vRP.getUserSource(parseInt(to))
	local nuser_id = vRP.getUserId(_nplayer)
	local identitynu = vRP.getUserIdentity(nuser_id)
	local banco = 0

	if nuser_id == nil then
		TriggerClientEvent("Notify",_source,"negado","Passaporte inválido ou indisponível.")
	else
		if nuser_id == user_id then
			TriggerClientEvent("Notify",_source,"negado","Você não pode transferir dinheiro para sí mesmo.")	
		else
			local banco = vRP.getBankMoney(user_id)
			local banconu = vRP.getBankMoney(nuser_id)
			
			if banco <= 0 or banco < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent("Notify",_source,"negado","Dinheiro Insuficiente")
			else
				vRP.setBankMoney(user_id,banco-tonumber(amountt))
				vRP.setBankMoney(nuser_id,banconu+tonumber(amountt))

				TriggerClientEvent("Notify",_nplayer,"importante","<b>"..identity.name.." "..identity.firstname.."</b> depositou <b>$"..vRP.format(parseInt(amountt)).." dólares</b> na sua conta.")
				TriggerClientEvent("Notify",_source,"sucesso","Você transferiu <b>$"..vRP.format(parseInt(amountt)).." dólares</b> para conta de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.")
			end
		end
	end
end)
--[ TESTE ]------------------------------------------------------------------------------------------------------------------------------
function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	if num and type(num) == "number" then
		return math.floor(num * mult + 0.5) / mult
	end
end
  
function addComma(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
		if (k==0) then
			break
		end
	end
	return formatted
end