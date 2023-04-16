local noclip = false

function tvRP.toggleNoclip()
	noclip = not noclip
	local ped = PlayerPedId()
	if noclip then
		SetEntityInvincible(ped,true)
		SetEntityVisible(ped,false,false)
	else
		SetEntityInvincible(ped,false)
		SetEntityVisible(ped,true,false)
	end
	NoClip()
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading * math.pi / 180.0)
	local y = math.cos(heading * math.pi / 180.0)
	local z = math.sin(pitch * math.pi/180.0)
	local len = math.sqrt(x * x + y * y + z * z)
	if len ~= 0 then
		x = x / len
		y = y / len
		z = z / len
	end
	return x,y,z
end

function NoClip()
	while true do
		if noclip then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped) 
			local x,y,z = coords[1],coords[2],coords[3]
			local dx,dy,dz = getCamDirection()
			local speed = 1.0
			SetEntityVelocity(ped,0.0001,0.0001,0.0001)
			if IsControlPressed(0,21) then
				speed = 5.0
			end
			if IsControlPressed(0,32) then
				x = x+speed*dx
				y = y+speed*dy
				z = z+speed*dz
			end
			if IsControlPressed(0,269) then
				x = x-speed*dx
				y = y-speed*dy
				z = z-speed*dz
			end
			SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
		else
			break
		end
		Wait(15)
	end
end

local handcuffed = false
function tvRP.toggleHandcuff()
	handcuffed = not handcuffed
	SetEnableHandcuffs(PlayerPedId(),handcuffed)
	if handcuffed then
		tvRP.playAnim(true,{"mp_arresting","idle"},true)
	else
		tvRP.stopAnimActived()
		tvRP.stopAnim(true)
	end
end

function tvRP.setHandcuffed(flag)
	if handcuffed ~= flag then
		tvRP.toggleHandcuff()
	end
end

function tvRP.isHandcuffed()
	return handcuffed
end

CreateThread(function()
	while true do
		Wait(15000)
		if handcuffed then
			tvRP.playAnim(true,{"mp_arresting","idle"},true)
		end
	end
end)


local capuz = false
function tvRP.toggleCapuz()
	capuz = not capuz
	if capuz then
		tvRP.setDiv("capuz","body { background: #000000 }","")
		SetPedComponentVariation(PlayerPedId(),1,69,2,2)
	else
		tvRP.removeDiv("capuz")
		SetPedComponentVariation(PlayerPedId(),1,0,0,2)
	end
end

function tvRP.setCapuz(flag)
	if capuz ~= flag then
		tvRP.toggleCapuz()
	end
end

function tvRP.isCapuz()
	return capuz
end

local mala = false
function tvRP.toggleMalas()
	mala = not mala
	ped = PlayerPedId()
	vehicle = tvRP.getNearestVehicle(7)

	if IsEntityAVehicle(vehicle) then
		if mala then
			AttachEntityToEntity(ped,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-0.4,-0.1,60.0,-90.0,180.0,false,false,false,true,2,true)
			SetEntityVisible(ped,false)
			SetEntityInvincible(ped,true)
		else
			DetachEntity(ped,true,true)
			SetEntityVisible(ped,true)
			SetEntityInvincible(ped,false)
			SetPedToRagdoll(ped,2000,2000,0,0,0,0)
		end
		TriggerServerEvent("trymala",VehToNet(vehicle))
	end
end

RegisterNetEvent("syncmala")
AddEventHandler("syncmala",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleDoorOpen(v,5,0,0)
				Wait(1000)
				SetVehicleDoorShut(v,5,0)
			end
		end
	end
end)

function tvRP.setMalas(flag)
	if mala ~= flag then
		tvRP.toggleMalas()
	end
end

function tvRP.isMalas()
	return mala
end

function tvRP.getNoCarro()
	return IsPedInAnyVehicle(PlayerPedId())
end

function tvRP.FazendoAnim(dict, name)
	if IsEntityPlayingAnim(PlayerPedId(), dict, name, 3) then
		return true
	end
end

function tvRP.getCarroClass(vehicle)
	return GetVehicleClass(vehicle) == 0 or GetVehicleClass(vehicle) == 1 or GetVehicleClass(vehicle) == 2 or GetVehicleClass(vehicle) == 3 or GetVehicleClass(vehicle) == 4 or GetVehicleClass(vehicle) == 5 or GetVehicleClass(vehicle) == 6 or GetVehicleClass(vehicle) == 7 or GetVehicleClass(vehicle) == 9 or GetVehicleClass(vehicle) == 12
end

function tvRP.putInNearestVehicleAsPassenger(radius)
	local veh = tvRP.getNearestVehicle(radius)
	if IsEntityAVehicle(veh) then
		for i=1,math.max(GetVehicleMaxNumberOfPassengers(veh),3) do
			if IsVehicleSeatFree(veh,i) then
				SetPedIntoVehicle(PlayerPedId(),veh,i)
				return true
			end
		end
	end
	return false
end

CreateThread(function()
	while true do
		local timeDistance = 500
		if handcuffed or mala or capuz then
			timeDistance = 4
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,20,true)
			DisableControlAction(0,21,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,23,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,137,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,178,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			--DisableControlAction(0,245,true)
			--DisableControlAction(0,246,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			--DisableControlAction(0,303,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)	
		end

		Wait(timeDistance)
	end
end)