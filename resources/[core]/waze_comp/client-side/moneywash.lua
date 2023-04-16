local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
startMoneyWash = Tunnel.getInterface("vrp_lavagem",startMoneyWash)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIZAÇÃO DAS LAVAGENS DE DINHEIRO --
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ -1372.52,-625.97,30.82,"bahamas.permissao" },
	{ -1053.67,-230.53,44.03,"lifeinvader.permissao" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO PARA LAVAR O DINHEIRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('lavagem',function(source,args,rawCommand)
	if not exports["chat"]:statusChat() then return end
	local ped = PlayerPedId()
	for _,v in pairs(locais) do
		local distance = #(vec3(v[1],v[2],v[3]) - GetEntityCoords(ped))
		if distance <= 3.5 then
			if startMoneyWash.PermissaoPlayer(v[4]) then
				if startMoneyWash.ChecarPagamento() then
					if args[1] == "s" then
						if startMoneyWash.VerificarComponente("alvejante",10) then
							startMoneyWash.EnviarPagamento("lavagemsimples")
						end
					elseif args[1] == "a" then 
						if startMoneyWash.VerificarComponente("alvejantemodificado",1) then
							startMoneyWash.EnviarPagamento("lavagemavancada")
						end
					end 
				end
			end
		end
	end
end)