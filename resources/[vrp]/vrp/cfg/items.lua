local cfg = {}

cfg.items = {
	["bombacaseira"] = { "Bombacaseira",4.0 },
	--["gasosavazia"] = { "Galão de gasolina vazio",3 },
	--["gasosacheia"] = { "Galão de gasolina cheio",3 },
	["pecadecarro"] = { "Peça de Carro",0.1 },
	--["kittid"] = { "Kit de análise",0.1 },
	["aliancaouro"] = { "Aliança de ouro",0.7 },
	["aliancaprata"] = { "Aliança de ouro",0.7 },
	["paraliancaouro"] = { "Par de aliança de ouro",0.7 },
	["paraliancaprata"] = { "Par de aliança de prata",0.7 },
	["compeletronico"] = { "Comp Eletronico",0.5 },
	["parafuso"] = { "Parafuso",1.0 },
	["arame"] = { "Arame",1.0 },
	["latadetinta"] = { "Lata De Tinta",1.0 },
	["caixadeuva"] = { "Caixadeuva",0.8 },
	["cordas"] = { "Cordas",1 },
	["encomenda"] = { "Encomenda",1.2 },
	["sacodelixo"] = { "Saco de Lixo",2 },
	["garrafavazia"] = { "Garrafa Vazia",0.2 },
	["garrafadeleite"] = { "Garrafa de Leite",0.5 },
	["alianca"] = { "Aliança",0 },
	["bandagem"] = { "Bandagem",0.7 },
	["dorflex"] = { "Dorflex",0 },
	["cicatricure"] = { "Cicatricure",0 },
	["dipiroca"] = { "Dipiroca",0 },
	["nocucedin"] = { "Nocucedin",0 },
	["paracetanal"] = { "Paracetanal",0 },
	["decupramim"] = { "Decupramim",0 },
	["presentedenatal"] = { "Presente de Natal",1 },
	["buscopau"] = { "Buscopau",0 },
	["navagina"] = { "Navagina",0 },
	["analdor"] = { "Analdor",0 },
	["uvas"] = { "Uvas",0.5 },
	["lanche"] = { "Lanche",0.5 },
	["fardo"] = { "Fardo de Cerveja",2 },
	["sefodex"] = { "Sefodex",0 },
	["nokusin"] = { "Nokusin",0 },
	["glicoanal"] = { "Glicoanal",0 },
	["cerveja"] = { "Cerveja",0.7 },
	["tequila"] = { "Tequila",0.7 },
	["vodka"] = { "Vodka",0.7 },
	["whisky"] = { "Whisky",0.7 },
	["conhaque"] = { "Conhaque",0.7 },
	["absinto"] = { "Absinto",0.7 },
	["dinheirosujo"] = { "Dinheiro Sujo",0 },
	["dinheiroempacotado"] = { "dinheiroempacotado",0.00001 },
	["repairkit"] = { "Kit de Reparos",1 },
	["funcionalpol"] = { "Carteira funcional policial",0.1 },
	["algemas"] = { "Algemas",1 },
	["capuz"] = { "Capuz",0.5 },
	["lockpick"] = { "Lockpick",1 },
	["jornal"] = { "Jornal",0.8 },
	["masterpick"] = { "Masterpick",1 },
	["militec"] = { "Militec-1",0.8 },
	["isca"] = { "Isca",0.6 },
	["dourado"] = { "Dourado",0.6 },
	["corvina"] = { "Corvina",0.6 },
	["salmao"] = { "Salmão",0.6 },
	["pacu"] = { "Pacu",0.6 },
	["pintado"] = { "Pintado",0.6 },
	["pirarucu"] = { "Pirarucu",0.6 },
	["tilapia"] = { "Tilápia",0.6 },
	["tucunare"] = { "Tucunaré",0.6 },
	["lambari"] = { "Lambari",0.6 },
	["energetico"] = { "Energético",0.3 },
	["mochila"] = { "Mochila",0 },
	["folhademaconha"] = { "Folha de Maconha",0.8 },
	["maconhamacerada"] = { "Maconha Macerada",0.8 },
	--["maconha"] = { "Maconha",0.8 },
	["baseado"] = { "Baseado",0.6 },

	["material9mm"] = { "Material de 9MM",0.30  },
    ["material762"] = { "Material de 7.62",0.35 },

    ["capsula9mm"] = { "Capsula de 9MM",0.20 },
    ["capsula762"] = { "Capsula de 7.62",0.25  },

    ["polvora9mm"] = { "Pólvora de 9MM",0.20 },
    ["polvora762"] = { "Pólvora de 7.62",0.25 },
	
	["pecadearma"] = { "Peça de arma",0.5 },
	["pecadetec"] = { "Peça de TEC",0.5 },
	["pecademp5"] = { "Peça de MP5",0.5 },
	["pecadeak"] = { "Peça de AK",0.5 },
	["pecadeg3"] = { "Peça de G36",0.5 },

	["armacaodearma"] = { "Armacao de Arma",0.7 },
	["armacaodeak"] = { "Armaçao de AK",0.7 },
	["armacaodeg3"] = { "Armaçao de G36",0.7 },
	["armacaodemp5"] = { "Armação de MP5",0.7 },
	["armacaodetec"] = { "Armação de TEC-9",0.7 },	

	["materialarmas"] = { "Material de Arma",0.20 },
    ["materialak"] = { "Material de AK",0.35 },
    ["materialg3"] = { "Material de G36",0.30 },
    ["materialmp5"] = { "Material de MP5",0.20 },
    ["materialtec"] = { "Material de TEC-9",0.20 },

	["alvejante"] = { "Alvejante",0.2 },
	["alvejantemodificado"] = { "Alvejante Modificado",0.3 },
	["capsula"] = { "Cápsula",0.03 },
	["polvora"] = { "Pólvora",0.03 },
	["pendrive"] = { "Pendrive",0.1 },
	["notebook"] = { "Notebook",1.0 },
	["relogioroubado"] = { "Relógio Roubado",0.3 },
	["pulseiraroubada"] = { "Pulseira Roubada",0.2 },
	["anelroubado"] = { "Anel Roubado",0.2 },
	["colarroubado"] = { "Colar Roubado",0.2 },
	["brincoroubado"] = { "Brinco Roubado",0.2 },
	["carteiraroubada"] = { "Carteira Roubada",0.2 },
	["tabletroubado"] = { "Tablet Roubado",0.2 },
	["sapatosroubado"] = { "Sapatos Roubado",0.2 },
	["folhadecoca"] = { "Folha de cocaína",0.8 },
	["cocamisturada"] = { "Cocaína misturada",0.8 },
	["cocaina"] = { "Cocaína",0.6 },
	["essenciadeecstasy"] = { "Essencia de Ecstasy",0.8 },
	["pastadeecstasy"] = { "Pasta de Ecstasy",0.8 },
	["ecstasy"] = { "Ecstasy",0.8 },
	["fungo"] = { "Fungo",0.8 },
	["dietilamina"] = { "Dietilamina",0.8 },
	["lancaperfume"] = { "Lança perfume",0.8 },
	["acidobateria"] = { "Ácido de bateria",0.8 },
	["gps"] = { "GPS",0.8 },
	["ticket"] = { "Ticket",0.3 },
	["anfetamina"] = { "Anfetamina",0.8 },
	["metanfetamina"] = { "Metanfetamina",0.6 },
	["logsinvasao"] = { "Logs de Invasão",0.1 },
	["keysinvasao"] = { "Keys para Invasão",1.0 },
	["pendriveinformacoes"] = { "Pendrive com Informações",0.1 },
	["acessodeepweb"] = { "Acesso á DeepWeb",1.0 },
	["ouro"] = { "Ouro",0.25 },
	["bronze"] = { "Bronze",0.20 },
	["ferro"] = { "Ferro",0.30 },
	["radio"] = { "Radio",1.0 },
	["serra"] = { "Serra",5.0 },
	["furadeira"] = { "Furadeira",5.0 },
	["c4"] = { "C-4",5.0 },
	["roupas"] = { "Roupas",2.0 },
	["xerelto"] = { "Xerelto",0.1 },
  	["coumadin"] = { "Coumadin",0.1 },
	["identidade"] = { "Identidade",0 },
	["keycard"] = { "Keycard",0.1 },
	["placa"] = { "Placa",0.6 },
	["aneldecompromisso"] = { "Anel de Compromisso",1.0 },
	["colardeperolas"] = { "Colar de Pérolas",1.0 },
	["pulseiradeouro"] = { "Pulseira de Ouro",1.0 },
	["chocolate"] = { "Chocolate",1.0 },
	["pirulito"] = { "Pirulito",1.0 },
	["bateria"] = { "Bateria",0.3 },
	["cobre"] = { "Cobre",0.3 },
	["plastico"] = { "Plastico",0.3 },
	["borracha"] = { "Borracha",0.3 },
	["linha"] = { "Linha",0.3 },
	["pano"] = { "Pano",0.3 },
	["tecido"] = { "Tecido",0.3 },
	["algodao"] = { "Algodao",0.3 },
	["couro"] = { "Couro",0.3 },
	["vidro"] = { "Vidro",0.3 },
	["pilha"] = { "Pilha",0.3 },
	["fioeletronico"] = { "Fio Eletronico",0.3 },
	["lata"] = { "Lata",0.3 },
	["buque"] = { "Buquê de Flores",1.0 },
	["celular"] = { "Celular",1.0 },
	["wammo|WEAPON_PISTOL_MK2"] = { "M.FN Five Seven",0.05 },
	["wammo|WEAPON_COMBATPISTOL"] = { "M.Glock 19",0.05 },
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { "M.AK-103 MK2",0.05 },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { "M.MPX",0.05 },
	["wammo|WEAPON_SPECIALCARBINE_MK2"] = { "M.G36 MK2",0.05 },
	["wammo|WEAPON_MACHINEPISTOL"] = { "M.TEC-9",0.05 },
	["wammo|WEAPON_SNSPISTOL"] = { "M.HK P7M10",0.05 },
	["wammo|WEAPON_COMBATPDW"] = { "M.Sig Sauer MPX",0.05 },
	["wammo|WEAPON_ASSAULTSMG"] = { "M.MTAR-21",0.05 },
	["wammo|WEAPON_SMG"] = { "M.MP5",0.05 },
	["wammo|WEAPON_SMG_MK2"] = { "M.MP5 MK2",3 },
	["wammo|WEAPON_CARBINERIFLE"] = { "M.M4A1",0.05 },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { "M.MPX",0.05 },
	["wammo|WEAPON_HEAVYPISTOL"] = { "M.HEAVYPISTOL",0.05 },
	["wbody|WEAPON_SPECIALCARBINE_MK2"] = { "G36 MK2",3 },
	["wbody|WEAPON_COMBATPISTOL"] = { "Glock 19",1 },
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { "AK-103 MK2",5 },
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { "MPX",3 },
	["wbody|WEAPON_PISTOL_MK2"] = { "FN Five Seven",1 },
	["wbody|WEAPON_MACHINEPISTOL"] = { "TEC-9",1 },
	["wbody|WEAPON_SNSPISTOL"] = { "HK P7M10",1 },
	["wbody|WEAPON_COMBATPDW"] = { "Sig Sauer MPX",2 },
	["wbody|WEAPON_ASSAULTSMG"] = { "MTAR-21",2 },
	["wbody|WEAPON_HEAVYPISTOL"] = { "HEAVYPISTOL",1 },
	["wbody|WEAPON_SMG"] = { "MP5",2 },
	["wbody|WEAPON_SMG_MK2"] = { "MP5 MK2",2 },
	["wbody|WEAPON_CARBINERIFLE"] = { "M4A1",3 },
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { "MPX",3 },

}

local function load_item_pack(name)
	local items = module("cfg/item/"..name)
	if items then
		for k,v in pairs(items) do
			cfg.items[k] = v
		end
	end
end

load_item_pack("armamentos")

return cfg