-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("barbershop",src)
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local myClothes = {}
local myOldClothes = {}
local canStartTread = false
local canUpdate = false
local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0, eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0, noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0, cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0, jawHeight = 0, chinLength = 0, chinPosition = 0, chinWidth = 0, chinShape = 0, neckWidth = 0, hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0, beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0, blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function f(n)
	n = n + 0.00000
	return n
end

local barbearias = {
	{ coords = vec3(-815.59,-182.16,37.56) },
	{ coords = vec3(139.21,-1708.96,29.30) },
	{ coords = vec3(-1282.00,-1118.86,7.00) },
	{ coords = vec3(1934.11,3730.73,32.85) },
	{ coords = vec3(1211.07,-475.00,66.21) },
	{ coords = vec3(-34.97,-150.90,57.0) },
	{ coords = vec3(-280.37,6227.01,31.70) },
	{ coords = vec3(616.12,7.97,82.79) }
}

RegisterCommand("barbearia",function(source,args)
	for i=1, #barbearias do
		local index = barbearias[i]
		local distance = #(GetEntityCoords(PlayerPedId()) - index.coords)
		if distance <= 5 then
			TriggerEvent('barbershop:OpenBarbershop')
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCHAR
-----------------------------------------------------------------------------------------------------------------------------------------
custom = currentCharacterMode
function src.setCharacter(data)
	if data then 
		custom = data
		canStartTread = true
		canUpdate = true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(data)
	myClothes = {}
	myClothes = { tonumber(data.hairModel), tonumber(data.firstHairColor), tonumber(data.secondHairColor), tonumber(data.makeupModel), tonumber(data.makeupintensity), tonumber(data.makeupcolor), tonumber(data.lipstickModel), tonumber(data.lipstickintensity), tonumber(data.lipstickColor), tonumber(data.eyebrowsModel), tonumber(data.eyebrowintensity), tonumber(data.eyebrowsColor), tonumber(data.beardModel), tonumber(data.beardintentisy), tonumber(data.beardColor), tonumber(data.blushModel), tonumber(data.blushintentisy), tonumber(data.blushColor) }

	custom.lipstickModel = tonumber(data.lipstickModel)
	custom.lipstickColor = tonumber(data.lipstickColor)
	custom.hairModel = tonumber(data.hairModel)
	custom.firstHairColor = tonumber(data.firstHairColor)
	custom.secondHairColor = tonumber(data.secondHairColor)
	custom.blushModel = tonumber(data.blushModel)
	custom.blushColor = tonumber(data.blushColor)
	custom.makeupModel = tonumber(data.makeupModel)
	custom.makeupcolor = tonumber(data.makeupcolor)
	custom.eyebrowsModel = tonumber(data.eyebrowsModel)
	custom.eyebrowsColor = tonumber(data.eyebrowsColor)
	custom.beardModel = tonumber(data.beardModel)
	custom.beardColor = tonumber(data.beardColor)

	if data.value then
		SetNuiFocus(false)
		displayBarbershop(false)
		vSERVER.updateSkin(custom)
		SendNUIMessage({ openBarbershop = false })
		myOldClothes = {}
	end

	src.defaultCustom(myClothes)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEFACIAL
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateFacial(data)
	if data then 
		custom = data 
		canUpdate = true
		canStartTread = true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate",function(data,cb)
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	if data == "left" then
		SetEntityHeading(ped,heading+10)
	elseif data == "right" then
		SetEntityHeading(ped,heading-10)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSENUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeNui",function()
	SetNuiFocus(false)
	displayBarbershop(false)
	SendNUIMessage({ openBarbershop = false })
	vSERVER.setInstance(false)
	resetCustom(myOldClothes)
	canUpdate = true
	myOldClothes = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function displayBarbershop(enable)
	local ped = PlayerPedId()
	if enable then
		SetNuiFocus(true,true)
		SendNUIMessage({ openBarbershop = true,  hairModel =  tonumber(custom.hairModel), firstHairColor =  tonumber(custom.firstHairColor), secondHairColor =  tonumber(custom.secondHairColor), makeupModel =  tonumber(custom.makeupModel), makeupintensity = 10, makeupcolor = tonumber(custom.makeupcolor), lipstickModel =  tonumber(custom.lipstickModel), lipstickintensity = 10, lipstickColor =  tonumber(custom.lipstickColor), eyebrowsModel =  tonumber(custom.eyebrowsModel), eyebrowintensity = 10, eyebrowsColor =  tonumber(custom.eyebrowsColor), beardModel =  tonumber(custom.beardModel), beardintentisy = 10, beardColor =  tonumber(custom.beardColor), blushModel =  tonumber(custom.blushModel), blushintentisy = 10, blushColor = tonumber(custom.blushColor),
	})

	myOldClothes = {
		hairModel =  tonumber(custom.hairModel), firstHairColor =  tonumber(custom.firstHairColor),secondHairColor =  tonumber(custom.secondHairColor),makeupModel =  tonumber(custom.makeupModel),makeupintensity = 10,makeupcolor = tonumber(custom.makeupcolor),lipstickModel =  tonumber(custom.lipstickModel),lipstickintensity = 10,lipstickColor =  tonumber(custom.lipstickColor),eyebrowsModel =  tonumber(custom.eyebrowsModel),eyebrowintensity = 10,eyebrowsColor =  tonumber(custom.eyebrowsColor),beardModel =  tonumber(custom.beardModel),beardintentisy = 10,beardColor =  tonumber(custom.beardColor),blushModel =  tonumber(custom.blushModel),blushintentisy = 10,blushColor = tonumber(custom.blushColor),
	}

	canUpdate = false

	FreezeEntityPosition(ped,true)
	if IsDisabledControlJustReleased(0,24) or IsDisabledControlJustReleased(0,142) then
		SendNUIMessage({ type = "click" })
	end

	SetPlayerInvincible(ped,false) -- mqcu

	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
		SetCamCoord(cam,GetEntityCoords(ped))
		SetCamRot(cam,0.0,0.0,0.0)
		SetCamActive(cam,true)
		RenderScriptCams(true,false,0,true,true)
		SetCamCoord(cam,GetEntityCoords(ped))
	end

	local x,y,z = table.unpack(GetEntityCoords(ped))
	SetCamCoord(cam,x+0.2,y+0.5,z+0.7)
	SetCamRot(cam,0.0,0.0,150.0)
	else
		FreezeEntityPosition(ped,false)
		SetPlayerInvincible(ped,false)
		RenderScriptCams(false,false,0,1,0)
		DestroyCam(cam,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function src.defaultCustom(status)
	myClothes = {}
	myClothes = { status[1], status[2], status[3], status[4], status[5], status[6], status[7], status[8], status[9], status[10], status[11], status[12], status[13], status[14], status[15], status[16], status[17], status[18] }

	local ped = PlayerPedId()
	SetPedComponentVariation(ped,2,status[1],0,2)
	SetPedHairColor(ped,status[2],status[3])
	

	SetPedHeadOverlay(ped,4,status[4],0.99)
	SetPedHeadOverlayColor(ped,4,0,0,0)

--	SetPedHeadOverlayColor(ped,4,0,status[6],status[6])

	SetPedHeadOverlay(ped,8,status[7],0.99)
	SetPedHeadOverlayColor(ped,8,2,status[9],status[9])

	SetPedHeadOverlay(ped,2,status[10],0.99)
	SetPedHeadOverlayColor(ped,2,1,status[12],status[12])

	SetPedHeadOverlay(ped,1,status[13],0.99)
	SetPedHeadOverlayColor(ped,1,1,status[15],status[15])

	SetPedHeadOverlay(ped,5,status[16],0.99)
	SetPedHeadOverlayColor(ped,5,2,status[18],status[18])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET CUSTOM
-----------------------------------------------------------------------------------------------------------------------------------------
function resetCustom(status)
	if status then 
		custom.lipstickModel = tonumber(status.lipstickModel)
		custom.lipstickColor = tonumber(status.lipstickColor)
		custom.hairModel = tonumber(status.hairModel)
		custom.firstHairColor = tonumber(status.firstHairColor)
		custom.secondHairColor = tonumber(status.secondHairColor)
		custom.blushModel = tonumber(status.blushModel)
		custom.blushColor = tonumber(status.blushColor)
		custom.makeupModel = tonumber(status.makeupModel)
		custom.eyebrowsModel = tonumber(status.eyebrowsModel)
		custom.eyebrowsColor = tonumber(status.eyebrowsColor)
		custom.beardModel = tonumber(status.beardModel)
		custom.beardColor = tonumber(status.beardColor)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:OpenBarbershop",function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		displayBarbershop(true)
		SetEntityHeading(ped,332.21)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAINTHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)
	SendNUIMessage({ openBarbershop = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,47 ,57, 70,200)
	ClearDrawOrigin()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD SYNC PED
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(5000)
		if canStartTread then
			while not IsPedModel(PlayerPedId(),"mp_m_freemode_01") and not IsPedModel(PlayerPedId(),"mp_f_freemode_01") do
				Wait(10)
			end
			if custom then
				TaskUpdateSkinOptions()
				TaskUpdateFaceOptions()
				TaskUpdateHeadOptions()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC BODY
-----------------------------------------------------------------------------------------------------------------------------------------
function TaskUpdateSkinOptions()
	local data = custom
	SetPedHeadBlendData(PlayerPedId(),data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC FACE
-----------------------------------------------------------------------------------------------------------------------------------------
function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = custom

	-- Olhos
	SetPedEyeColor(ped,data.eyesColor)
	-- Sobrancelha
	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)
	-- Nariz
	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)
	-- Bochechas
	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)
	-- Boca/Mandibula
	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)
	-- Queixo
	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)
	-- Pescoço
	SetPedFaceFeature(ped,19,data.neckWidth)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC HEAD
-----------------------------------------------------------------------------------------------------------------------------------------
function TaskUpdateHeadOptions()
	local ped = PlayerPedId()
	if canUpdate then 
		local data = custom

		-- Cabelo
		SetPedComponentVariation(ped,2,data.hairModel,0,0)
		SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)

		-- Sobrancelha
		SetPedHeadOverlay(ped,2,data.eyebrowsModel, 0.99)
		SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)

		-- Barba
		SetPedHeadOverlay(ped,1,data.beardModel,0.99)
		SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)

		-- Pelo Corporal
		SetPedHeadOverlay(ped,10,data.chestModel,0.99)
		SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)

		-- Blush
		SetPedHeadOverlay(ped,5,data.blushModel,0.99)
		SetPedHeadOverlayColor(ped,5,2,data.blushColor,data.blushColor)

		-- Battom
		SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
		SetPedHeadOverlayColor(ped,8,2,data.lipstickColor,data.lipstickColor)
		

		-- Manchas
		SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
		SetPedHeadOverlayColor(ped,0,0,0,0)

		-- Envelhecimento
		SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
		SetPedHeadOverlayColor(ped,3,0,0,0)

		-- Aspecto
		SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
		SetPedHeadOverlayColor(ped,6,0,0,0)

		-- Pele
		SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
		SetPedHeadOverlayColor(ped,7,0,0,0)

		-- Sardas
		SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
		SetPedHeadOverlayColor(ped,9,0,0,0)

		-- Maquiagem
		SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
		SetPedHeadOverlayColor(ped,4,0,data.makeupcolor,data.makeupcolor)
	end
end