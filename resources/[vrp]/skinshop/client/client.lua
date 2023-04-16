-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface('skinshop',cnVRP)
vSERVER = Tunnel.getInterface('skinshop')
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local skinData = {}
local heading = 332.219879
local previousSkinData = {}
local customCamLocation = nil
local creatingCharacter = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
local skinData = {
	['pants'] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	['arms'] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	['t-shirt'] = { item = 1, texture = 0, defaultItem = 1, defaultTexture = 0 },
	['torso2'] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	['vest'] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	['bag'] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	['shoes'] = { item = 0, texture = 0, defaultItem = 1, defaultTexture = 0 },
	['mask'] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	['hat'] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	['glass'] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	['ear'] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	['watch'] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	['bracelet'] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
	['accessory'] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
	['decals'] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('skinshop:skinData')
AddEventHandler('skinshop:skinData',function(status)
	if status ~= 'clean' then
		skinData = status
		resetClothing(skinData)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATESHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local locateShops = {
	{ coords = vec3(75.40,-1392.92,29.37) },
	{ coords = vec3(-709.40,-153.66,37.41) },
	{ coords = vec3(-163.20,-302.03,39.73) },
	{ coords = vec3(425.58,-806.23,29.49) },
	{ coords = vec3(-822.34,-1073.49,11.32) },
	{ coords = vec3(-1193.81,-768.49,17.31) },
	{ coords = vec3(-1450.85,-238.15,49.81) },
	{ coords = vec3(4.90,6512.47,31.87) },
	{ coords = vec3(1693.95,4822.67,42.06) },
	{ coords = vec3(126.05,-223.10,54.55) },
	{ coords = vec3(614.26,2761.91,42.08) },
	{ coords = vec3(1196.74,2710.21,38.22) },
	{ coords = vec3(-3170.18,1044.54,20.86) },
	{ coords = vec3(-158.63,-1630.5,34.18) },
	{ coords = vec3(986.68,-92.84,74.85) }, -- MC
	{ coords = vec3(-1507.08,838.83,181.6) },  -- SICILIANA
	{ coords = vec3(-1049.15,-242.19,44.03) },  -- LIFE
	{ coords = vec3(-1402.35,-609.39,30.32) },  -- BAHAMAS
	{ coords = vec3(563.73,-3121.77,18.77) },  -- BRATVA
	{ coords = vec3(-1063.56,-1663.16,4.56) },  -- BLOODS
	{ coords = vec3(1274.21,-1708.04,54.78) },  -- CRIPS
	{ coords = vec3(956.34,-965.52,39.76) },  -- MECANICA
	{ coords = vec3(84.51,-1955.49,20.75) },  -- VAGOS
	{ coords = vec3(-1101.46,2710.57,19.10) },
	{ coords = vec3(619.28,11.91,82.78) }, ---- DP
	{ coords = vec3(1840.75,3690.69,34.29) }, ---- DP SANDY
	{ coords = vec3(2060.16,2992.89,-72.7) }, ---- TID
	{ coords = vec3(298.98,-598.04,43.29) },  ---HOSPITAL
	{ coords = vec3(373.32,-2044.13,22.19) }

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local idle = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and not creatingCharacter then
			local coords = GetEntityCoords(ped)

			for i=1, #locateShops do
				local index = locateShops[i]
				local distance = #(coords - index.coords)
				if distance <= 3 then
					idle = 4
					if IsControlJustPressed(0,38) then
						customCamLocation = nil
						openMenu({
							{ menu = 'character', label = 'Roupas', selected = true },
							{ menu = 'accessoires', label = 'Utilidades', selected = false }
						})
					end
				end
			end
		end

		Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETOUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('resetOutfit',function()
	resetClothing(json.decode(previousSkinData))
	skinData = json.decode(previousSkinData)
	previousSkinData = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATERIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('rotateRight',function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading+30)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('rotateLeft',function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading-30)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHINGCATEGORYS
-----------------------------------------------------------------------------------------------------------------------------------------
local clothingCategorys = {
	['arms'] = { type = 'variation', id = 3 },
	['t-shirt'] = { type = 'variation', id = 8 },
	['torso2'] = { type = 'variation', id = 11 },
	['pants'] = { type = 'variation', id = 4 },
	['vest'] = { type = 'variation', id = 9 },
	['shoes'] = { type = 'variation', id = 6 },
	['bag'] = { type = 'variation', id = 5 },
	['mask'] = { type = 'mask', id = 1 },
	['hat'] = { type = 'prop', id = 0 },
	['glass'] = { type = 'prop', id = 1 },
	['ear'] = { type = 'prop', id = 2 },
	['watch'] = { type = 'prop', id = 6 },
	['bracelet'] = { type = 'prop', id = 7 },
	['accessory'] = { type = 'variation', id = 7 },
	['decals'] = { type = 'variation', id = 10 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function GetMaxValues()
	maxModelValues = {
		['arms'] = { type = 'character', item = 0, texture = 0 },
		['t-shirt'] = { type = 'character', item = 0, texture = 0 },
		['torso2'] = { type = 'character', item = 0, texture = 0 },
		['pants'] = { type = 'character', item = 0, texture = 0 },
		['shoes'] = { type = 'character', item = 0, texture = 0 },
		['vest'] = { type = 'character', item = 0, texture = 0 },
		['accessory'] = { type = 'character', item = 0, texture = 0 },
		['decals'] = { type = 'character', item = 0, texture = 0 },
		['bag'] = { type = 'character', item = 0, texture = 0 },
		['mask'] = { type = 'accessoires', item = 0, texture = 0 },
		['hat'] = { type = 'accessoires', item = 0, texture = 0 },
		['glass'] = { type = 'accessoires', item = 0, texture = 0 },
		['ear'] = { type = 'accessoires', item = 0, texture = 0 },
		['watch'] = { type = 'accessoires', item = 0, texture = 0 },
		['bracelet'] = { type = 'accessoires', item = 0, texture = 0 }
	}

	local ped = PlayerPedId()
	for k,v in pairs(clothingCategorys) do
		if v.type == 'variation' then
			maxModelValues[k].item = GetNumberOfPedDrawableVariations(ped,v.id)
			maxModelValues[k].texture = GetNumberOfPedTextureVariations(ped,v.id,GetPedDrawableVariation(ped,v.id)) -1
		end

		if v.type == 'mask' then
			maxModelValues[k].item = GetNumberOfPedDrawableVariations(ped,v.id)
			maxModelValues[k].texture = GetNumberOfPedTextureVariations(ped,v.id,GetPedDrawableVariation(ped,v.id))
		end

		if v.type == 'overlay' then
			maxModelValues[k].item = GetNumHeadOverlayValues(v.id)
			maxModelValues[k].texture = 45
		end

		if v.type == 'prop' then
			maxModelValues[k].item = GetNumberOfPedPropDrawableVariations(ped,v.id)
			maxModelValues[k].texture = GetNumberOfPedPropTextureVariations(ped,v.id,GetPedPropIndex(ped,v.id))
		end
	end

	SendNUIMessage({ action = 'updateMax', maxValues = maxModelValues })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function openMenu(allowedMenus)
	creatingCharacter = true
	previousSkinData = json.encode(skinData)

	GetMaxValues()

	SendNUIMessage({ action = 'open', menus = allowedMenus, currentClothing = skinData })

	SetNuiFocus(true,true)
	SetCursorLocation(0.9,0.25)

	enableCam()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function enableCam()
	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
	RenderScriptCams(false,false,0,1,0)
	DestroyCam(cam,false)

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA',true)
		SetCamActive(cam,true)
		RenderScriptCams(true,false,0,true,true)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId())+180)
	end

	if customCamLocation ~= nil then
		SetCamCoord(cam,customCamLocation.x,customCamLocation.y,customCamLocation.z)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATECAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('rotateCam',function(data)
	local rotType = data.type
	local ped = PlayerPedId()
	local coords = GetOffsetFromEntityInWorldCoords(ped,0,2.0,0)

	if rotType == 'left' then
		SetEntityHeading(ped,GetEntityHeading(ped)-10)
		SetCamCoord(cam,coords.x,coords.y, coords.z+0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(ped)+180)
	else
		SetEntityHeading(ped,GetEntityHeading(ped)+10)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(ped)+180)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('setupCam',function(data)
	local value = data.value

	if value == 1 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,0.75,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.65)
	elseif value == 2 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.2)
	elseif value == 3 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+-0.5)
	else
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function disableCam()
	RenderScriptCams(false,true,250,1,0)
	DestroyCam(cam,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function closeMenu()
	SendNUIMessage({ action = 'close' })
	disableCam()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETCLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
function resetClothing(data)
	local ped = PlayerPedId()

	SetPedComponentVariation(ped,4,data['pants'].item,data['pants'].texture,2)
	SetPedComponentVariation(ped,3,data['arms'].item,data['arms'].texture,2)
	SetPedComponentVariation(ped,8,data['t-shirt'].item,data['t-shirt'].texture,2)
	SetPedComponentVariation(ped,9,data['vest'].item,data['vest'].texture,2)
	SetPedComponentVariation(ped,11,data['torso2'].item,data['torso2'].texture,2)
	SetPedComponentVariation(ped,6,data['shoes'].item,data['shoes'].texture,2)
	SetPedComponentVariation(ped,1,data['mask'].item,data['mask'].texture,2)
	SetPedComponentVariation(ped,10,data['decals'].item,data['decals'].texture,2)
	SetPedComponentVariation(ped,7,data['accessory'].item,data['accessory'].texture,2)
	SetPedComponentVariation(ped,5,data['bag'].item,data['bag'].texture,2)

	if data['hat'].item ~= -1 and data['hat'].item ~= 0 then
		SetPedPropIndex(ped,0,data['hat'].item,data['hat'].texture,2)
	else
		ClearPedProp(ped,0)
	end

	if data['glass'].item ~= -1 and data['glass'].item ~= 0 then
		SetPedPropIndex(ped,1,data['glass'].item,data['glass'].texture,2)
	else
		ClearPedProp(ped,1)
	end

	if data['ear'].item ~= -1 and data['ear'].item ~= 0 then
		SetPedPropIndex(ped,2,data['ear'].item,data['ear'].texture,2)
	else
		ClearPedProp(ped,2)
	end

	if data['watch'].item ~= -1 and data['watch'].item ~= 0 then
		SetPedPropIndex(ped,6,data['watch'].item,data['watch'].texture,2)
	else
		ClearPedProp(ped,6)
	end

	if data['bracelet'].item ~= -1 and data['bracelet'].item ~= 0 then
		SetPedPropIndex(ped,7,data['bracelet'].item,data['bracelet'].texture,2)
	else
		ClearPedProp(ped,7)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('close',function()
	disableCam()
	SetNuiFocus(false,false)
	creatingCharacter = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('updateSkin',function(data)
	ChangeVariation(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKINONINPUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('updateSkinOnInput',function(data)
	ChangeVariation(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEVARIATION
-----------------------------------------------------------------------------------------------------------------------------------------
function ChangeVariation(data)
	local ped = PlayerPedId()
	local clothingCategory = data.clothingType
	local type = data.type
	local item = data.articleNumber

	if clothingCategory == 'pants' then
		if type == 'item' then
			SetPedComponentVariation(ped,4,item,0,2)
			skinData['pants'].item = item
		elseif type == 'texture' then
			local curItem = GetPedDrawableVariation(ped,4)
			SetPedComponentVariation(ped,4,curItem,item,2)
			skinData['pants'].texture = item
		end
	elseif clothingCategory == 'arms' then
		if type == 'item' then
			SetPedComponentVariation(ped,3,item,0,2)
			skinData['arms'].item = item
		elseif type == 'texture' then
			local curItem = GetPedDrawableVariation(ped,3)
			SetPedComponentVariation(ped,3,curItem,item,2)
			skinData['arms'].texture = item
		end
	elseif clothingCategory == 't-shirt' then
		if type == 'item' then
			SetPedComponentVariation(ped,8,item,0,2)
			skinData['t-shirt'].item = item
		elseif type == 'texture' then
			local curItem = GetPedDrawableVariation(ped,8)
			SetPedComponentVariation(ped,8,curItem,item,2)
			skinData['t-shirt'].texture = item
		end
	elseif clothingCategory == 'vest' then
		if type == 'item' then
			SetPedComponentVariation(ped,9,item,0,2)
			skinData['vest'].item = item
		elseif type == 'texture' then
			SetPedComponentVariation(ped,9,skinData['vest'].item,item,2)
			skinData['vest'].texture = item
		end
	elseif clothingCategory == 'bag' then
		if type == 'item' then
			SetPedComponentVariation(ped,5,item,0,2)
			skinData['bag'].item = item
		elseif type == 'texture' then
			SetPedComponentVariation(ped,5,skinData['bag'].item,item,2)
			skinData['bag'].texture = item
		end
	elseif clothingCategory == 'decals' then
		if type == 'item' then
			SetPedComponentVariation(ped,10,item,0,2)
			skinData['decals'].item = item
		elseif type == 'texture' then
			SetPedComponentVariation(ped,10,skinData['decals'].item,item,2)
			skinData['decals'].texture = item
		end
	elseif clothingCategory == 'accessory' then
		if type == 'item' then
			SetPedComponentVariation(ped,7,item,0,2)
			skinData['accessory'].item = item
		elseif type == 'texture' then
			SetPedComponentVariation(ped,7,skinData['accessory'].item,item,2)
			skinData['accessory'].texture = item
		end
	elseif clothingCategory == 'torso2' then
		if type == 'item' then
			SetPedComponentVariation(ped,11,item,0,2)
			skinData['torso2'].item = item
		elseif type == 'texture' then
			local curItem = GetPedDrawableVariation(ped,11)
			SetPedComponentVariation(ped,11,curItem,item,2)
			skinData['torso2'].texture = item
		end
	elseif clothingCategory == 'shoes' then
		if type == 'item' then
			SetPedComponentVariation(ped,6,item,0,2)
			skinData['shoes'].item = item
		elseif type == 'texture' then
			local curItem = GetPedDrawableVariation(ped,6)
			SetPedComponentVariation(ped,6,curItem,item,2)
			skinData['shoes'].texture = item
		end
	elseif clothingCategory == 'mask' then
		if type == 'item' then
			SetPedComponentVariation(ped,1,item,0,2)
			skinData['mask'].item = item
		elseif type == 'texture' then
			local curItem = GetPedDrawableVariation(ped,1)
			SetPedComponentVariation(ped,1,curItem,item,2)
			skinData['mask'].texture = item
		end
	elseif clothingCategory == 'hat' then
		if type == 'item' then
			if item ~= -1 then
				SetPedPropIndex(ped,0,item,skinData['hat'].texture,2)
			else
				ClearPedProp(ped,0)
			end
			skinData['hat'].item = item
		elseif type == 'texture' then
			SetPedPropIndex(ped,0,skinData['hat'].item,item,2)
			skinData['hat'].texture = item
		end
	elseif clothingCategory == 'glass' then
		if type == 'item' then
			if item ~= -1 then
				SetPedPropIndex(ped,1,item,skinData['glass'].texture,2)
				skinData['glass'].item = item
			else
				ClearPedProp(ped,1)
			end
		elseif type == 'texture' then
			SetPedPropIndex(ped,1,skinData['glass'].item,item,2)
			skinData['glass'].texture = item
		end
	elseif clothingCategory == 'ear' then
		if type == 'item' then
			if item ~= -1 then
				SetPedPropIndex(ped,2,item,skinData['ear'].texture,2)
			else
				ClearPedProp(ped,2)
			end
			skinData['ear'].item = item
		elseif type == 'texture' then
			SetPedPropIndex(ped,2,skinData['ear'].item,item,2)
			skinData['ear'].texture = item
		end
	elseif clothingCategory == 'watch' then
		if type == 'item' then
			if item ~= -1 then
				SetPedPropIndex(ped,6,item,skinData['watch'].texture,2)
			else
				ClearPedProp(ped,6)
			end
			skinData['watch'].item = item
		elseif type == 'texture' then
			SetPedPropIndex(ped,6,skinData['watch'].item,item,2)
			skinData['watch'].texture = item
		end
	elseif clothingCategory == 'bracelet' then
		if type == 'item' then
			if item ~= -1 then
				SetPedPropIndex(ped,7,item,skinData['bracelet'].texture,2)
			else
				ClearPedProp(ped,7)
			end
			skinData['bracelet'].item = item
		elseif type == 'texture' then
			SetPedPropIndex(ped,7,skinData['bracelet'].item,item,2)
			skinData['bracelet'].texture = item
		end
	end

	GetMaxValues()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVECLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('saveClothing',function(data)
	SaveSkin()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function SaveSkin()
	vSERVER.updateClothes(json.encode(skinData),true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getCustomization()
	return skinData
end

RegisterNetEvent('updateOutfit')
AddEventHandler('updateOutfit',function(custom)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if custom[1] == -1 then
			SetPedComponentVariation(ped,1,0,0,2)
		else
			SetPedComponentVariation(ped,1,custom[1],custom[2],2)
		end

		if custom[3] == -1 then
			SetPedComponentVariation(ped,5,0,0,2)
		else
			SetPedComponentVariation(ped,5,custom[3],custom[4],2)
		end

		if custom[5] == -1 then
			SetPedComponentVariation(ped,7,0,0,2)
		else
			SetPedComponentVariation(ped,7,custom[5],custom[6],2)
		end

		if custom[7] == -1 then
			SetPedComponentVariation(ped,3,15,0,2)
		else
			SetPedComponentVariation(ped,3,custom[7],custom[8],2)
		end

		if custom[9] == -1 then
			if GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') then
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey('mp_f_freemode_01') then
				SetPedComponentVariation(ped,4,15,0,2)
			end
		else
			SetPedComponentVariation(ped,4,custom[9],custom[10],2)
		end

		if custom[11] == -1 then
			SetPedComponentVariation(ped,8,15,0,2)
		else
			SetPedComponentVariation(ped,8,custom[11],custom[12],2)
		end

		if custom[13] == -1 then
			if GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') then
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey('mp_f_freemode_01') then
				SetPedComponentVariation(ped,6,35,0,2)
			end
		else
			SetPedComponentVariation(ped,6,custom[13],custom[14],2)
		end

		if custom[15] == -1 then
			SetPedComponentVariation(ped,11,15,0,2)
		else
			SetPedComponentVariation(ped,11,custom[15],custom[16],2)
		end

		if custom[17] == -1 then
			SetPedComponentVariation(ped,9,0,0,2)
		else
			SetPedComponentVariation(ped,9,custom[17],custom[18],2)
		end

		if custom[19] == -1 then
			SetPedComponentVariation(ped,10,0,0,2)
		else
			SetPedComponentVariation(ped,10,custom[19],custom[20],2)
		end

		if custom[21] == -1 then
			ClearPedProp(ped,0)
		else
			SetPedPropIndex(ped,0,custom[21],custom[22],2)
		end

		if custom[23] == -1 then
			ClearPedProp(ped,1)
		else
			SetPedPropIndex(ped,1,custom[23],custom[24],2)
		end

		if custom[25] == -1 then
			ClearPedProp(ped,2)
		else
			SetPedPropIndex(ped,2,custom[25],custom[26],2)
		end

		if custom[27] == -1 then
			ClearPedProp(ped,6)
		else
			SetPedPropIndex(ped,6,custom[27],custom[28],2)
		end

		if custom[29] == -1 then
			ClearPedProp(ped,7)
		else
			SetPedPropIndex(ped,7,custom[29],custom[30],2)
		end
	end
end)