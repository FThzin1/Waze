-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vCLIENT = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------

local chest = {
	["Staff"] = { 100000,"mod.permissao" },
	["Teste"] = { 100000,"dev.permissao" },
	-- policia
	["PoliciaSul"] = { 50000,"policia.permissao" },
	-- hospital
	["Hospital"] = { 50000,"medico.permissao" },
	-- drogas
	["Ballas"] = { 50000,"ballas.permissao" },
	["Vagos"] = { 50000,"vagos.permissao" },
    ["Grove"] = { 50000,"grove.permissao" },
	-- armas
	["Crips"] = { 50000,"crips.permissao" },
	["Bloods"] = { 50000,"bloods.permissao" },
	-- munição
	["Bratva"] = { 50000,"bratva.permissao" },
	["Siciliana"] = { 50000,"siciliana.permissao" },
	-- lavagem
	["Bahamas"] = { 50000,"bahamas.permissao" },
	["LifeInvader"] = { 50000,"lifeinvader.permissao" },
	-- desmanche
    ["Warlocks"] = { 50000,"warlocks.permissao" },
    ["HellAngels"] = { 50000,"hells.permissao" },
	-- mecanicas
	["Bennys"] = { 50000,"bennys.permissao" },
	["Mecanico"] = { 50000,"mecanico.permissao" },
	-- scorp
	["Scripted"] = { 50000,"scripted.permissao" },
	-- farms
	["Farmgroove"] = { 25000,"grove.permissao" },
	["Farmballas"] = { 25000,"ballas.permissao" },
	["Farmvagos"] = { 25000,"vagos.permissao" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDOWNTIME
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
-- CHECK ADM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CheckAdm()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"admin.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			if chestName == 'bahamas' then 
				if vRP.hasGroup(user_id,'bahamas') then 
					return true 
				end 
			end

			if chestName == 'medico' then
				if user_id == 0 or vRP.hasPermission(user_id, 'admin.permissao') then 
					return true
				else
					return false
				end
			end

			if vRP.hasPermission(user_id,chest[chestName][2]) or vRP.hasPermission(user_id, 'admin.permissao') then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
		local chestNamers = "chest:"..chestName
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				hsinventory[#hsinventory + 1] = { amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) }
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				myinventory[#myinventory + 1] = { amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) }
			end
		end
		vRP.DupOpenChest(chestName, user_id)
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(chest[tostring(chestName)][1]) 	
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local DelayTirarItem = {}
function src.storeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local source = source
		local identity = vRP.getUserIdentity(user_id)
		local job = vRP.getUserGroupByType(user_id,"job")
		local delay = math.random(2,5)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end
			
			if tonumber(amount) == 0 then
				TriggerClientEvent('Notify', source, 'negado', 'Especifique a quantia a ser colocada.')
				return
			end

			if string.sub(tonumber(amount), 1, 1) == '-' then
				TriggerClientEvent('Notify', source, 'aviso', 'Quantia inválida (valor negativo).')
				return
			end
			
			if not vRP.DupCheckChest(chestName, user_id) then
			TriggerClientEvent("Notify",source,"negado","Este baú foi aberto por outra pessoa",8000)
                return
            end

			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				-- CÓDIGO ANTIDUPE AQUI
				if DelayTirarItem[user_id] and (DelayTirarItem[user_id] + delay) > os.time() then TriggerClientEvent('Notify', source, 'negado', 'Neste baú transações estão sendo feitas rápidas demais.') return end
				DelayTirarItem[user_id] = os.time()
				if tonumber(amount) then

					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*tonumber(amount)
					if new_weight <= parseInt(chest[tostring(chestName)][1]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,tonumber(amount)) then

							if chestName == "Policia" or chestName == "Paramedico" or chestName == "PoliciaNorte" then
								exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPolice", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
							else
								if chestName == "PoliciaSul" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestPolice", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
									exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPolice", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Staff" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "adminChest", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Ballas" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBallas", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Vagos" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestVagos", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Grove" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestGroove", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Crips" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestCrips", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Bahamas" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBahamas", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Bloods" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBloods", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Siciliana" then 
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestSiciliana", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Bratva" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBratva", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "LifeInvader" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestLifeInvader", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Hospital" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestHospital", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Farmballas" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBallasFarm", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Farmgroove" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestGrooveFarm", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								elseif chestName == "Farmvagos" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestVagosFarm", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
								end
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "adminGangs", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
							end

								if items[itemName] ~= nil then
									items[itemName].amount = parseInt(items[itemName].amount) + tonumber(amount)
								else
									items[itemName] = { amount = tonumber(amount) }
								end
								actived[parseInt(user_id)] = 4
							end
						else
							TriggerClientEvent("Notify",source,"negado","<b>Baú</b> cheio.",8000)
						end
					else
						local inv = vRP.getInventory(parseInt(user_id))
						for k,v in pairs(inv) do
							if itemName == k then
								local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
								if new_weight <= parseInt(chest[tostring(chestName)][1]) then
									if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then
	
										if items[itemName] ~= nil then
											items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
										else
											items[itemName] = { amount = parseInt(v.amount) }
										end

										if chestName == "Policia" or chestName == "Paramedico" or chestName == "PoliciaNorte" then
											exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPolice", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
										else
											if chestName == "PoliciaSul" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestPolice", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
												exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPolice", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Staff" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "adminChest", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Ballas" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBallas", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Vagos" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestVagos", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Grove" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestGroove", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Crips" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestCrips", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Bahamas" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBahamas", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Bloods" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBloods", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Siciliana" then 
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestSiciliana", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Bratva" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBratva", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "LifeInvader" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestLifeInvader", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Hospital" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestHospital", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Farmballas" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBallasFarm", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Farmgroove" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestGrooveFarm", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											elseif chestName == "Farmvagos" then
												exports["waze-system"]:sendLogs(user_id,{ webhook = "chestVagosFarm", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
											end
										exports["waze-system"]:sendLogs(user_id,{ webhook = "adminGangs", text = "Guardou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." no baú "..chestName })
									end

									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Baú</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local job = vRP.getUserGroupByType(user_id,"job")
		local delay = math.random(3,7)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then

			if not vRP.DupCheckChest(chestName, user_id) then
                TriggerClientEvent('Notify', source, 'negado', 'Este baú está sendo utilizado por outra pessoa.')
                return
            end

			if string.sub(tonumber(amount), 1, 1) == '-' then
				TriggerClientEvent('Notify', source, 'aviso', 'Quantia inválida (valor negativo).')
				return
			end

			if tonumber(amount) == 0 then
				TriggerClientEvent('Notify', source, 'negado', 'Especifique a quantia a ser retirada.')
				return
			end

			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if DelayTirarItem[user_id] and (DelayTirarItem[user_id] + delay) > os.time() then TriggerClientEvent('Notify', source, 'negado', 'Neste baú transações estão sendo feitas rápidas demais.') return end
				DelayTirarItem[user_id] = os.time()
				if tonumber(amount) then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= tonumber(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*tonumber(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "Policia" or chestName == "Paramedico" or chestName == "PoliciaNorte" then
								exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPolice", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
							else
								if chestName == "PoliciaSul" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestPolice", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
									exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPolice", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Staff" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "adminChest", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Ballas" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBallas", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Vagos" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestVagos", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Grove" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestGroove", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Crips" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestCrips", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Bahamas" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBahamas", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Bloods" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBloods", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Siciliana" then 
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestSiciliana", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Bratva" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBratva", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "LifeInvader" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestLifeInvader", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Hospital" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestHospital", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Farmballas" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBallasFarm", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Farmgroove" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestGrooveFarm", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Farmvagos" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestVagosFarm", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								end
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "adminGangs", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
							end

							vRP.giveInventoryItem(parseInt(user_id),itemName,tonumber(amount))
							items[itemName].amount = parseInt(items[itemName].amount) - tonumber(amount)

							if parseInt(items[itemName].amount) <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= tonumber(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "Policia" or chestName == "Paramedico" or chestName == "PoliciaNorte" then
								exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPolice", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
							else
								if chestName == "PoliciaSul" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestPolice", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
									exports["waze-system"]:sendLogs(user_id,{ webhook = "adminPolice", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Staff" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "adminChest", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Ballas" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBallas", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Vagos" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestVagos", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Grove" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestGroove", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Crips" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestCrips", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Bahamas" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBahamas", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Bloods" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBloods", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Siciliana" then 
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestSiciliana", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Bratva" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBratva", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "LifeInvader" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestLifeInvader", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Hospital" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestHospital", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Farmballas" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestBallasFarm", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Farmgroove" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestGrooveFarm", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								elseif chestName == "Farmvagos" then
									exports["waze-system"]:sendLogs(user_id,{ webhook = "chestVagosFarm", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
								end
                                exports["waze-system"]:sendLogs(user_id,{ webhook = "adminGangs", text = "Retirou x"..vRP.format(tonumber(amount)).." "..vRP.itemNameList(itemName).." do baú "..chestName })
							end

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				end
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
			end
		end
	end
	return false
end