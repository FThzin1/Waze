-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = Proxy.getInterface("vRP")
sIdentity = Tunnel.getInterface("vrp_identidade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
RegisterCommand("IIidentidade",function(source,args)
    menuactive = not menuactive
    if menuactive then
        local carteira,banco,nome,sobrenome,idade,user_id,identidade,telefone,job,jobdois,gerente,vip,multas,paypal,relacionamento = sIdentity.Identidade()

        local set = ""

        if set ~= "" then
			job = '<div class='id1'> <h1>Emprego: </h1> <p id='set'></p> </div>'
		end
        
        SendNUIMessage({ test = true, passaporte = user_id, nome = nome, sobrenome = sobrenome, idade = idade, identidade = identidade, telefone = telefone, set = job, set2 = jobdois, vip = vip, carteira = carteira, banco = banco, relacionamento = relacionamento, paypal = paypal, multas = bmultas, bgerente = bgerente })
    else
        SendNUIMessage({ test = false})
    end
end)

RegisterKeyMapping("IIidentidade","Identidade","keyboard","f11")
