local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local tpfarm = {
    { permission = "vagos.permissao", join = vec3(420.2,-2064.45,22.13), exit = vec3(-1097.45,4949.7,218.65) },
    { permission = "ballas.permissao", join = vec3(116.93,-1990.38,18.49), exit = vec3(1484.66,6391.94,23.39) },
    { permission = "grove.permissao", join = vec3(-185.71,-1702.53,32.79), exit = vec3(98.59,6328.2,31.38) }
}

RegisterCommand('tpfarm', function(source, args, rawCmd)
    if not exports["chat"]:statusChatServer(source) then return end
    local source = source
    local user_id = vRP.getUserId(source)
    local ped = GetPlayerPed(source)
    local pedCoords = GetEntityCoords(ped)
    
    for i=1, #tpfarm do

        local index = tpfarm[i]
        local distanceJ = #(pedCoords - index.join) -- BASE
        local distanceE = #(pedCoords - index.exit) -- FARM
        -- TELEPORTE VAGOS
        if distanceJ <= 1.5 and vRP.hasPermission(user_id, index.permission) then
            SetEntityCoords(ped, index.exit.x,index.exit.y,index.exit.z)
        elseif distanceE <= 1.5 and vRP.hasPermission(user_id, index.permission) then
            SetEntityCoords(ped, index.join.x,index.join.y,index.join.z)
        end
    end

end)

