local radar = {
	shown = false,
	freeze = false,
	info = "AFERINDO VELOCIDADE DO VEÍCULO A FRENTE",
	info2 = "AFERINDO VELOCIDADE DO VEÍCULO ATRÁS"
}

local vehpermitidos = {
	"fibc",
	"fibr2",
	"fbi2",
	"pddouble",
	"pddubsta3",
	"pdjackal",
	"pdxa21",
	"pdxls",
}

function IsPlayerInXVeh(veiculo)
	local lPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(lPed)
	return IsVehicleModel(vehicle,GetHashKey(veiculo))
end

function CheckVehss()
	for k , v in pairs(vehpermitidos) do
		if IsPlayerInXVeh(v) then
			return true
		end
	end	
	return false
end

RegisterCommand('radar', function(source,args,rawCmd)
	if not exports["chat"]:statusChat(source) then return end
	 if CheckVehss() then
		if radar.shown then
			radar.shown = false
		else
			radar.shown = true
		end
	 end
end)

CreateThread(function()
	while true do
		local delayThread = 1000
		local veh = GetVehiclePedIsIn(PlayerPedId())
		if radar.shown then
			delayThread = 5
			if IsControlJustPressed(1,301) and IsPedInAnyPoliceVehicle(PlayerPedId()) then
				if radar.freeze then
					radar.freeze = false
				else
					radar.freeze = true
				end
			end
			if radar.freeze == false then
				local coordA = GetOffsetFromEntityInWorldCoords(veh,0.0,1.0,1.0)
				local coordB = GetOffsetFromEntityInWorldCoords(veh,0.0,105.0,0.0)
				local frontcar = StartShapeTestCapsule(coordA,coordB,3.0,10,veh,7)
				local a,b,c,d,e = GetShapeTestResult(frontcar)

				if IsEntityAVehicle(e) then
					local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
					local fvspeed = GetEntitySpeed(e)*3.6
					local fplate = GetVehicleNumberPlateText(e)
					radar.info = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s KM/H",fplate,fmodel,math.ceil(fvspeed))
				end

				local bcoordB = GetOffsetFromEntityInWorldCoords(veh,0.0,-105.0,0.0)
				local rearcar = StartShapeTestCapsule(coordA,bcoordB,3.0,10,veh,7)
				local f,g,h,i,j = GetShapeTestResult(rearcar)

				if IsEntityAVehicle(j) then
					local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
					local bvspeed = GetEntitySpeed(j)*3.6
					local bplate = GetVehicleNumberPlateText(j)
					radar.info2 = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s KM/H",bplate,bmodel,math.ceil(bvspeed))
				end
			end
			drawTxt(radar.info,4,0.5,0.905,0.50,255,255,255,180)
			drawTxt(radar.info2,4,0.5,0.93,0.50,255,255,255,180)
		end

		if not IsPedInAnyVehicle(PlayerPedId()) and radar.shown then
			radar.shown = false
		end
		Wait(delayThread)
	end
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end