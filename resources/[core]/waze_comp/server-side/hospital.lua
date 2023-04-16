-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-----------------------------------------------------------------------------------------------------------------------------------------
wazeHospital = {}
Tunnel.bindInterface("vrp_hospital",wazeHospital)
cHospital = Tunnel.getInterface("vrp_hospital")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TREAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tratamento',function(source,args,rawCommand)
	if not exports["chat"]:statusChatServer(source) then return end
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local nplayer = vRPclient.getNearestPlayer(source,3)
    local nuser_id = vRP.getUserId(nplayer)
    local identityu = vRP.getUserIdentity(nuser_id)
    
	if vRP.hasPermission(user_id,"medico.permissao") then
        if vRP.request(nplayer,"Deseja receber tratamento no valor de <b>$5000</b>?",30) then
            if vRP.tryFullPayment(nuser_id,5000) then
                vRP.giveBankMoney(user_id,5000)
                TriggerClientEvent('Notify',source,"sucesso","Recebeu <b>R$5000</b> de <b>"..identityu.name.. " "..identityu.firstname.."</b>.")
                if nplayer then
                    if cHospital.initTreat(nplayer) then
                        --TriggerClientEvent("waze",nplayer)
                        TriggerClientEvent("Notify",source,"sucesso","Tratamento no paciente iniciado com sucesso.",10000)
                    end
                end
            else    
                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
            end   
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function wazeHospital.checkServices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local paramedicos = vRP.getUsersByPermission("medico.permissao")
		if parseInt(#paramedicos) <= 0 then
			if vRP.tryFullPayment(user_id,2000) then
				TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$2.000 dólares</b> efetuado e o tratamento foi iniciado.",5000)
                cHospital.initTreat(source)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",5000)
			end          
        end
	end
    TriggerClientEvent("Notify",source,"aviso","Existem paramédicos em serviço no momento.")
	return false
end

function wazeHospital.checkServices2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dmla = vRP.getUsersByPermission("medico.permissao")
		if parseInt(#dmla) == 0 then
			return true
		end
	end
end

function wazeHospital.checkPolice()
    local source = source
    local user_id = vRP.getUserId(source)
	local vida = vRPclient.getHealth(source)
	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso morto.') return end
    if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") then
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("re",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local Random = math.random(0,100)
	if vRP.hasPermission(user_id,"medico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		
		if nplayer then
			if vRPclient.isInComa(nplayer) then
				local nuser_id = vRP.getUserId(nplayer)

				TriggerClientEvent("cancelando",source,true)
				vRPclient._playAnim(source,false,{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
				TriggerClientEvent("progress",source,30000)

				SetTimeout(30000,function()	
					if Random <= 50 then
						vRPclient.SetSegundosMorto(nplayer, 15) 
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("cancelando",source,false)
						TriggerClientEvent("Notify",source,"importante","Infelizmente o paciente não resistiu e faleceu.")
						TriggerClientEvent("Notify",nplayer,"aviso","Seu tempo de vida acabou aperte o <b>E</b> para morrer.")
					else
						vRPclient.killGod(nplayer)
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("cancelando",source,false)
					end
				end)

			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		else
			TriggerClientEvent("Notify",source,"importante","Chegue mais perto do paciente.")
		end
	elseif vRP.hasPermission(user_id,"ceo.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if wazeHospital.checkServices2() then
			if nplayer then
				if vRPclient.isInComa(nplayer) then
					local nuser_id = vRP.getUserId(nplayer)
	
					TriggerClientEvent("cancelando",source,true)
					vRPclient._playAnim(source,false,{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
					TriggerClientEvent("progress",source,30000)
					
					SetTimeout(30000,function()
						if Random <= 70 then
							vRPclient.SetSegundosMorto(nplayer, 15) 
							vRPclient._stopAnim(source,false)
							TriggerClientEvent("cancelando",source,false)
							TriggerClientEvent("Notify",source,"importante","Infelizmente o paciente não resistiu e faleceu.")
							TriggerClientEvent("Notify",nplayer,"aviso","Seu tempo de vida acabou aperte o <b>E</b> para morrer.")
						else
							vRPclient.killGod(nplayer)
							vRPclient._stopAnim(source,false)
							TriggerClientEvent("cancelando",source,false)
						end
					end)
				else
					TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Existem membros do Departamento Médico em serviço!")
		end 
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PULSO
-----------------------------------------------------------------------------------------------------------------------------------------
local MorteTiro = {
	'apresenta diversas perfurações próximas as veias vitais.',
	'demonstra diversos cortes profundos causados por perfurações.'
}

local MorteImpacto = {
	'possui alguns hematomas causados por impactos fortes na área craniana.',
	'possui diversos hematomas na região toráxica.'
}

local MorteNatural = {
	'entrou em coma por anemia.',
	'sofreu uma desidratação.',
	'sofreu uma hipotensão.'
}
RegisterCommand('checarpulso',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local vida = vRPclient.getHealth(source)

	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso em coma.') return end
	if user_id then
		if vRP.hasPermission(user_id, 'medico.permissao') or vRP.hasPermission(user_id, 'admin.permissao') then
			local nsource = vRPclient.getNearestPlayer(source, 5)
			if not nsource or nsource and vRPclient.getHealth(nsource) > 101 then return end -- Se não tiver ngm ele finaliza a função

			local tipoDeMorte = vRP.prompt(source, '1 = Tiro | 2 = Colisão/Impacto | 3 = Causas naturais', 'Tipo de morte')
			if tipoDeMorte ~= '1' and tipoDeMorte ~= '2' and tipoDeMorte ~= '3' then return end

			tipoDeMorte = parseInt(tipoDeMorte)

			local nidentity = vRP.getUserIdentity(vRP.getUserId(nsource))
			local nomeDaVitima = nidentity.name .. ' ' .. nidentity.firstname
			local textoDaMorte = ''
			if tipoDeMorte == 1 then
				textoDaMorte = MorteTiro[math.random(#MorteTiro)]
			elseif tipoDeMorte == 2 then
				textoDaMorte = MorteImpacto[math.random(#MorteImpacto)]
			elseif tipoDeMorte == 3 then
				textoDaMorte = MorteNatural[math.random(#MorteNatural)]
			end
			local tipo = math.random(1,2)
			local morte = 'MORTO'
			if tipo == 1 then morte = 'VIVO' end
			TriggerClientEvent('chatMessage',source,"",{},"["..string.upper(morte).."] ^3"..nomeDaVitima.." "..textoDaMorte)
			TriggerClientEvent('chatMessage',nsource,"SISTEMA",{255,0,0}, 'Seu pulso está sendo verificado por ' .. identity.name .. ' ' .. identity.firstname .. '. Aparentemente você está ' .. string.lower(morte) .. '.' )
		end
	end
end)

local delayVMochila = {}

local VendaBandagens = {}
local QtdMaxVendaBandagem = 50
local ResetVendasBandagens = os.time()
RegisterCommand('vbandagem', function(source, args, rawCmd)
	
	local PrecoDaBandagem = 5000
	local PrecoVolta = 5000

	if os.time() > (ResetVendasBandagens+84600) then
		VendaBandagens = {}
	end
	
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, 'medico.permissao') then
			if args[1] then
				if args[2] then
					local identity = vRP.getUserIdentity(user_id)
					local nuser_id = parseInt(args[1])
					local nsource = vRP.getUserSource(nuser_id)
					local nplayer = vRPclient.getNearestPlayer(source, 4)
					local nidentity = vRP.getUserIdentity(nuser_id)
					if nplayer and nsource and (nplayer == nsource) and (user_id ~= nuser_id) then
						local qtd = parseInt(args[2])
						if not VendaBandagens[nuser_id] then
							VendaBandagens[nuser_id] = 0
						end
						if VendaBandagens[nuser_id] >= QtdMaxVendaBandagem then
							TriggerClientEvent('Notify', source, 'negado', 'A pessoa atingiu o limite de bandagens diárias.')
							return
						end
						if VendaBandagens[nuser_id] + qtd <= QtdMaxVendaBandagem then
							if nsource and nuser_id then
								if vRP.hasPermission(nuser_id, 'mecanico.permissao') or vRP.hasPermission(nuser_id, 'policia.permissao') or vRP.hasPermission(nuser_id, 'policiaacao.permissao') or vRP.hasPermission(nuser_id, 'medico.permissao') then
									PrecoDaBandagem = 3500
									PrecoVolta = 500
								end
								if vRP.request(nsource, 'Deseja comprar <b>'..qtd .. ' bandagem(ns)</b> por <b>$'..vRP.format(parseInt(qtd*PrecoDaBandagem)) .. '</b>?', 15) then
									if not delayVMochila[user_id] or os.time() > (delayVMochila[user_id] + 15) then
										delayVMochila[user_id] = os.time()
										if vRP.getInventoryWeight(nuser_id) + (vRP.getItemWeight('bandagem')*qtd) <= vRP.getInventoryMaxWeight(nuser_id) then
											if vRP.tryFullPayment(nuser_id,qtd*PrecoDaBandagem) then
												vRP.giveInventoryItem(nuser_id,'bandagem',qtd)
												vRP.setBankMoney(user_id,parseInt( vRP.getBankMoney(user_id) + (qtd*PrecoVolta) ))
												VendaBandagens[nuser_id] = VendaBandagens[nuser_id] + qtd
												exports["waze-system"]:sendLogs(user_id,{ webhook = "hospitalBandage", text = "Vendeu x"..qtd.." Bandages por $"..vRP.format(parseInt(qtd*PrecoDaBandagem)).." e recebeu $"..vRP.format(parseInt(qtd*PrecoVolta))"\nBandagem vendidas para ("..nuser_id..") "..nidentity.name.." "..nidentity.firstname })
												TriggerClientEvent('Notify', source, 'sucesso', 'Você vendeu <b>' .. qtd .. '</b> bandagem(ns) para <b>' .. nidentity.name .. ' ' .. nidentity.firstname .. '</b>.')
												TriggerClientEvent('Notify', nsource, 'sucesso', 'Você comprou <b>' .. qtd .. '</b> bandagem(ns).')
											else
												TriggerClientEvent('Notify', source, 'negado', 'A pessoa não pode pagar por tudo isso.')
											end
										end
									else
										TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Você deve aguardar 15s para utilizar o comando novamente.')
									end
								end
							end
						else
							TriggerClientEvent('Notify', source, 'negado', 'A pessoa não pode comprar tudo isso.')
						end
					else
						TriggerClientEvent('Notify', source, 'negado', 'Você não pode vender para si mesmo e a pessoa deve estar próxima de você.')
					end
				else
					TriggerClientEvent('Notify', source, 'negado', 'Especifique uma quantidade.')
				end	
			else
				TriggerClientEvent('Notify', source, 'negado', 'Especifique um passaporte para quem venderá as bandagens.')
			end		
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Produzindo = {}
local TotalBandagem = 0
local TempoCooldown = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD COMPRA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if TempoCooldown > 0 then
			TempoCooldown = TempoCooldown - 1
			if TempoCooldown <= 0 then
				Produzindo = {}
				TotalBandagem = 0
			end
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAS
-----------------------------------------------------------------------------------------------------------------------------------------
function wazeHospital.k8TaPrRNMyvR4THGLHbDkAewGpXpBUY()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local paramedicos = vRP.getUsersByPermission("medico.permissao")
		if parseInt(#paramedicos) <= 0 then
		if parseInt(TotalBandagem) < 20 then
			if parseInt(Produzindo[user_id]) < 3 or not Produzindo[user_id] then
				if vRP.tryFullPayment(user_id,20000) then
					
					if parseInt(TempoCooldown) <= 0 then
						TempoCooldown = 900
					end

					TotalBandagem = parseInt(TotalBandagem) + 1
					Produzindo[user_id] = parseInt(Produzindo[user_id]) + 1
					TriggerClientEvent("cancelando",source,true)
					TriggerClientEvent("progress",source,25000)
					SetTimeout(20000,function()
						vRP.giveInventoryItem(user_id,"bandagem",5)
						TriggerClientEvent("cancelando",source,false)
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Você precisa de <b>$25.000</b> dólares",8000)
				end
			else
				TriggerClientEvent("Notify",source,"importante","Você antigiu o limite, volte daqui a <b>"..vRPclient.getTimeFunction(source,parseInt(TempoCooldown)).."</b>.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"importante","Atingiu o limite de bandagens produzidas, volte daqui a <b>"..vRPclient.getTimeFunction(source,parseInt(TempoCooldown)).."</b>.",5000)
		end
	else
		TriggerClientEvent("Notify",source,"aviso","Existem paramédicos em serviço no momento.")
	return false
	end
	end
end

function wazeHospital.treatmentPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient.killGod(source)
		vRPclient.setHealth(source,399)
        TriggerEvent('waze:ExcecaoGod')
        TriggerEvent('waze:ExcecaoVida')
	end
end