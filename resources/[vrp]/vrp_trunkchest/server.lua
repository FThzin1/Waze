local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_trunkchest",vRPN)
Proxy.addInterface("vrp_trunkchest",vRPN)

vCLIENT = Tunnel.getInterface("vrp_garages")

local inventory = module("vrp","cfg/inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local uchests = {}
local vchests = {}
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELAY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k,v in pairs(actived) do
			if actived[k] > 0 then
				actived[k] = v - 1

				if actived[k] <= 0 then
					actived[k] = nil
				end
			end
		end
		Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned,trunk = vRPclient.vehList(source,7)
		if vehicle then
			local placa_user_id = vRP.getUserByRegistration(placa)
			if placa_user_id then
				local myinventory = {}
				local myvehicle = {}
				local mala = "chest:u"..parseInt(placa_user_id).."veh_"..vname
				local data = vRP.getSData(mala)
				local sdata = json.decode(data) or {}
				local max_veh = inventory.chestweight[vname] or 50
				if sdata then
					for k,v in pairs(sdata) do
						myinventory[#myinventory + 1] = { amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) }
					end

					local data2 = vRP.getUserDataTable(user_id)
					if data2 and data2.inventory then
						for k,v in pairs(data2.inventory) do
							myvehicle[#myvehicle + 1] = { amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) }
						end
					end

					uchests[parseInt(user_id)] = mala
					vchests[parseInt(user_id)] = vname
				end
				vRP.DupOpenChest(uchests[user_id], user_id)
				return myinventory,myvehicle,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(sdata),parseInt(max_veh)
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local DelayTirarItem = {}
function vRPN.storeItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local nsource = vRP.getUserSource(user_id)
		local job = vRP.getUserGroupByType(user_id,"job")
		local delay = math.random(3,7)
		if (user_id and actived[user_id] and actived[user_id] == 0) or (not actived[user_id]) then
			if string.match(itemName,"dinheirosujo") or string.match(itemName,"identidade") or string.match(itemName,"uva") or string.match(itemName,"notebook") or string.match(itemName,"pendrive") or string.match(itemName,"keycard") or string.match(itemName,"moedavoid") or string.match(itemName,"gps") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item em veículos.",8000)
				return
			end

			if string.sub(tonumber(amount), 1, 1) == '-' then
				TriggerClientEvent('Notify', source, 'aviso', 'Quantia inválida (valor negativo).')
				return
			end

			if not vRP.DupCheckChest(uchests[user_id], user_id) then
				TriggerClientEvent("Notify",source,"negado","Este baú foi aberto por outra pessoa",8000)
					return
				end

			if tonumber(amount) == 0 then
				TriggerClientEvent('Notify', source, 'negado', 'Especifique a quantia a ser colocada.')
				return
			end

			local data = vRP.getSData(uchests[user_id])
			local items = json.decode(data) or {}
			if items then
				local max_veh = inventory.chestweight[vchests[user_id]] or 50

				if DelayTirarItem[user_id] and (DelayTirarItem[user_id] + delay) > os.time() then TriggerClientEvent('Notify', source, 'negado', 'Neste baú transações estão sendo feitas rápidas demais.') return end
				DelayTirarItem[user_id] = os.time()

				if tonumber(amount) then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*tonumber(amount)
					if new_weight <= parseInt(max_veh) then
						if vRP.tryGetInventoryItem(user_id,itemName,tonumber(amount)) and nsource then
							if items[itemName] ~= nil then
								items[itemName].amount = items[itemName].amount + tonumber(amount)
							else
								items[itemName] = { amount = tonumber(amount) }
							end
							exports["waze-system"]:sendLogs(user_id,{ webhook = "trunkStore", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no porta-malas do veículo "..uchests[user_id] })
							actived[parseInt(user_id)] = 2
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Porta-Malas</b> cheio.",8000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(max_veh) then
								if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) and nsource then
									if items[itemName] ~= nil then
										items[itemName].amount = items[itemName].amount + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end
									exports["waze-system"]:sendLogs(user_id,{ webhook = "trunkStore", text = "Guardou x"..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." no porta-malas do veículo "..uchests[user_id] })
									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Porta-Malas</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData(uchests[parseInt(user_id)],json.encode(items))
				TriggerClientEvent('Creative:UpdateTrunk',source,'updateMochila')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.takeItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local nsource = vRP.getUserSource(user_id)
		local job = vRP.getUserGroupByType(user_id,"job")
		local delay = math.random(3,7)
		
		if (user_id and actived[user_id] and actived[user_id] == 0) or (not actived[user_id]) then
			local data = vRP.getSData(uchests[parseInt(user_id)])
			local items = json.decode(data) or {}

			if not vRP.DupCheckChest(uchests[user_id], user_id) then
				TriggerClientEvent("Notify",source,"negado","Este baú foi aberto por outra pessoa",8000)
					return
				end
				
				if string.sub(tonumber(amount), 1, 1) == '-' then
					TriggerClientEvent('Notify', source, 'aviso', 'Quantia inválida (valor negativo).')
					return
				end
			
				if tonumber(amount) == 0 then
				TriggerClientEvent('Notify', source, 'negado', 'Especifique a quantia a ser colocada.')
				return
			end
			

			if items then
				if DelayTirarItem[user_id] and (DelayTirarItem[user_id] + delay) > os.time() then TriggerClientEvent('Notify', source, 'negado', 'Neste baú transações estão sendo feitas rápidas demais.') return end
				DelayTirarItem[user_id] = os.time()
				if tonumber(amount) then
					if items[itemName] ~= nil and items[itemName].amount >= tonumber(amount) then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemName)*tonumber(amount) <= vRP.getInventoryMaxWeight(user_id) and nsource then
							exports["waze-system"]:sendLogs(user_id,{ webhook = "trunkTake", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do porta-malas do veículo "..uchests[user_id] })
							vRP.giveInventoryItem(user_id,itemName,tonumber(amount))
							items[itemName].amount = items[itemName].amount - tonumber(amount)
							if items[itemName].amount <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				else
					if items[itemName] ~= nil and items[itemName].amount >= tonumber(amount) then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(user_id) and nsource then
							vRP.giveInventoryItem(user_id,itemName,parseInt(items[itemName].amount))
							exports["waze-system"]:sendLogs(user_id,{ webhook = "trunkTake", text = "Retirou x"..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." do porta-malas do veículo "..uchests[user_id] })							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				end
				TriggerClientEvent('Creative:UpdateTrunk',source,'updateMochila')
				vRP.setSData(uchests[parseInt(user_id)],json.encode(items))
			end
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid = vRPclient.vehList(source,7)
		if vehicle then
			vCLIENT.vehicleClientTrunk(-1,vnetid,true)
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.chestOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRPclient.isInVehicle(source) then
		local vehicle,vnetid,placa,vname,lock,banned,trunk = vRPclient.vehList(source,7)
		if vehicle then
			if lock == 1 then
				if banned then
					return
				end
				local placa_user_id = vRP.getUserByRegistration(placa)
				if placa_user_id then
					vCLIENT.vehicleClientTrunk(-1,vnetid,false)
					TriggerClientEvent("trunkchest:Open",source)
				end
			end
		end
	else
		TriggerClientEvent('Notify', source, 'negado', 'Você precisa estar fora do veículo para utilizá-lo.')
		end
	end
end