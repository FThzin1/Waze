local cfg = module("cfg/inventory")

local itemlist = {
	["bombacaseira"] = { index = "bombacaseira", nome = "Bomba Caseira", type = "usar" },
	--["gasosavazia"] = { index = "gasosavazia", nome = "Galão de gasolina vazio", type = "usar" },
	--["gasosacheia"] = { index = "gasosacheia", nome = "Galão de gasolina cheio", type = "usar" },
	["pecadecarro"] = { index = "pecadecarro", nome = "Peça de Carro", type = "usar" },
	--["kittid"] = { index = "kittid", nome = "Kit de análise", type = "usar" },
	--["secador"] = { index = "secador", nome = "Secador", type = "usar" },
	["dinheiromolhado"] = { index = "dinheiromolhado", nome = "Dinheiro molhado", type = "usar" },
	["dinheiroempacotado"] = { index = "dinheiroempacotado", nome = "Dinheiro empacotado", type = "usar" },
	["aliancaouro"] = { index = "aliancaouro", nome = "Aliança de ouro", type = "usar" },
	["aliancaprata"] = { index = "aliancaprata", nome = "Aliança de prata", type = "usar" },
	["paraliancaouro"] = { index = "aliancaouro", nome = "Par de aliança de ouro", type = "usar" },
	["paraliancaprata"] = { index = "aliancaprata", nome = "Par de aliança de prata", type = "usar" },
	["compeletronico"] = { index = "compeletronico", nome = "Comp Eletronico", type = "usar" },
	["arame"] = { index = "arame", nome = "Arame", type = "usar" },
	["parafuso"] = { index = "parafuso", nome = "Parafuso", type = "usar" },
	["latadetinta"] = { index = "latadetinta", nome = "Lata De Tinta", type = "usar" },
	["algodao"] = { index = "algodao", nome = "Algodao", type = "usar" },
	["couro"] = { index = "couro", nome = "Couro", type = "usar" },
	["lata"] = { index = "lata", nome = "Lata", type = "usar" },
	["lanche"] = { index = "lanche", nome = "Tacos", type = "usar" },
	["caixadeuva"] = { index = "caixadeuva", nome = "Caixadeuva", type = "usar" },
	["cordas"] = { index = "cordas", nome = "Cordas", type = "usar" },
	["taurina"] = { index = "taurina", nome = "Taurina", type = "usar" },
	["cafeina"] = { index = "cafeina", nome = "Cafeina", type = "usar" },
	["ferramenta"] = { index = "ferramenta", nome = "Ferramenta", type = "usar" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda", type = "usar" },
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de Lixo", type = "usar" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia", type = "usar" },
	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de Leite", type = "usar" },
	["celular"] = { index = "celular", nome = "Celular", type = "usar" },
	["tora"] = { index = "tora", nome = "Tora de Madeira", type = "usar" },
	["alianca"] = { index = "alianca", nome = "Aliança", type = "usar" },
	["bandagem"] = { index = "bandagem", nome = "Bandagem", type = "usar" },
	["dorflex"] = { index = "dorflex", nome = "Dorflex", type = "usar" },
	["cicatricure"] = { index = "cicatricure", nome = "Cicatricure", type = "usar" },
	["dipiroca"] = { index = "dipiroca", nome = "Dipiroca", type = "usar" },
	["nocucedin"] = { index = "nocucedin", nome = "Nocucedin", type = "usar" },
	["paracetanal"] = { index = "paracetanal", nome = "Paracetanal", type = "usar" },
	["decupramim"] = { index = "decupramim", nome = "Decupramim", type = "usar" },
	["buscopau"] = { index = "buscopau", nome = "Buscopau", type = "usar" },
	["navagina"] = { index = "navagina", nome = "Navagina", type = "usar" },
	["analdor"] = { index = "analdor", nome = "Analdor", type = "usar" },
	["sefodex"] = { index = "sefodex", nome = "Sefodex", type = "usar" },
	["nokusin"] = { index = "nokusin", nome = "Nokusin", type = "usar" },
	["glicoanal"] = { index = "glicoanal", nome = "Glicoanal", type = "usar" },
	["cerveja"] = { index = "cerveja", nome = "Cerveja", type = "usar" },
	["fardo"] = { index = "fardo", nome = "Fardo de Cerveja", type = "usar" },
	["uvas"] = { index = "uvas", nome = "Uvas", type = "usar" },
	["tequila"] = { index = "tequila", nome = "Tequila", type = "usar" },
	["vodka"] = { index = "vodka", nome = "Vodka", type = "usar" },
	["whisky"] = { index = "whisky", nome = "Whisky", type = "usar" },
	["conhaque"] = { index = "conhaque", nome = "Conhaque", type = "usar" },
	["absinto"] = { index = "absinto", nome = "Absinto", type = "usar" },
	["dinheirosujo"] = { index = "dinheirosujo", nome = "Dinheiro Sujo", type = "usar" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos", type = "usar" },
	["funcionalpol"] = { index = "funcionalpol", nome = "Carteira funcional policial", type = "usar" },
	["morfina"] = { index = "morfina", nome = "Morfina", type = "usar" },
	["placa"] = { index = "placa", nome = "Placa", type = "usar" },
	["algemas"] = { index = "algemas", nome = "Algemas", type = "usar" },
	["capuz"] = { index = "capuz", nome = "Capuz", type = "usar" },
	["compattach"] = { index = "compattach", nome = "Modificador de Arma", type = "usar" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick", type = "usar" },
	["identidade"] = { index = "identidade", nome = "Identidade", type = "usar" },
	["masterpick"] = { index = "masterpick", nome = "Masterpick", type = "usar" },
	["militec"] = { index = "militec", nome = "Militec-1", type = "usar" },
	["pneus"] = { index = "pneus", nome = "Pneus", type = "usar" },
	["roupas"] = { index = "roupas", nome = "Roupas", type = "usar" },
	["isca"] = { index = "isca", nome = "Isca", type = "usar" },
	["dourado"] = { index = "dourado", nome = "Dourado", type = "usar" },
	["corvina"] = { index = "corvina", nome = "Corvina", type = "usar" },
	["salmao"] = { index = "salmao", nome = "Salmão", type = "usar" },
	["pacu"] = { index = "pacu", nome = "Pacu", type = "usar" },
	["pintado"] = { index = "pintado", nome = "Pintado", type = "usar" },
	["pirarucu"] = { index = "pirarucu", nome = "Pirarucu", type = "usar" },
	["tilapia"] = { index = "tilapia", nome = "Tilápia", type = "usar" },
	["tucunare"] = { index = "tucunare", nome = "Tucunaré", type = "usar" },
	["lambari"] = { index = "lambari", nome = "Lambari", type = "usar" },

	["material9mm"] = { index = "material9mm", nome = "Material de 9MM", type = "usar" },
	["material762"] = { index = "material762", nome = "Material de 7.62", type = "usar" },

	["capsula9mm"] = { index = "capsula9mm", nome = "Capsula de 9MM", type = "usar" },
	["capsula762"] = { index = "capsula762", nome = "Capsula de 7.62", type = "usar" },

	["polvora9mm"] = { index = "polvora9mm", nome = "Pólvora de 9MM", type = "usar" },
	["polvora762"] = { index = "polvora762", nome = "Pólvora de 7.62", type = "usar" },

	["pecadearma"] = { index = "pecadearma", nome = "Peça de Arma", type = "usar" },
	["pecadetec"] = { index = "pecadetec", nome = "Peça de TEC-9", type = "usar" },
	["pecademp5"] = { index = "pecademp5", nome = "Peça de MP5", type = "usar" },
	["pecadeak"] = { index = "pecadeak", nome = "Peça de AK", type = "usar" },
	["pecadeg3"] = { index = "pecadeg3", nome = "Peça de G3", type = "usar" },
	
	["armacaodearma"] = { index = "armacaodearma", nome = "Armação de Arma", type = "usar" },
	["armacaodetec"] = { index = "armacaodetec", nome = "Armação de TEC-9", type = "usar" },
	["armacaodemp5"] = { index = "armacaodemp5", nome = "Armação de MP5", type = "usar" },
	["armacaodeg3"] = { index = "armacaodeg3", nome = "Armação de G36", type = "usar" },
	["armacaodeak"] = { index = "armacaodeak", nome = "Armação de AK", type = "usar" },

	["materialarmas"] = { index = "materialarmas", nome = "Material de Armas", type = "usar" },
	["materialtec"] = { index = "materialtec", nome = "Material de TEC-9", type = "usar" },
	["materialmp5"] = { index = "materialmp5", nome = "Material de MP5", type = "usar" },
	["materialg3"] = { index = "materialg3", nome = "Material de G36", type = "usar" },
	["materialak"] = { index = "materialak", nome = "Material de AK", type = "usar" },

	["baseado"] = { index = "baseado", nome = "Baseado", type = "usar" },
	["energetico"] = { index = "energetico", nome = "Energético", type = "usar" },
	["mochila"] = { index = "mochila", nome = "Mochila", type = "usar" },
	--["maconha"] = { index = "maconha", nome = "Maconha", type = "usar" },
	["alvejante"] = { index = "alvejante", nome = "Alvejante", type = "usar" },
	["alvejantemodificado"] = { index = "alvejantemodificado", nome = "Alvejante Modificado", type = "usar" },
	["folhademaconha"] = { index = "folhademaconha", nome = "Folha de Maconha", type = "usar" },
	["maconhamacerada"] = { index = "maconhamacerada", nome = "Maconha Macerada", type = "usar" },
	["capsula"] = { index = "capsula", nome = "Cápsula", type = "usar" },
	["polvora"] = { index = "polvora", nome = "Pólvora", type = "usar" },
	["orgao"] = { index = "orgao", nome = "Órgão", type = "usar" },
	["etiqueta"] = { index = "etiqueta", nome = "Etiqueta", type = "usar" },
	["pendrive"] = { index = "pendrive", nome = "Pendrive", type = "usar" },
	["notebook"] = { index = "notebook", nome = "Notebook", type = "usar" },
	["relogioroubado"] = { index = "relogioroubado", nome = "Relógio Roubado", type = "usar" },
	["pulseiraroubada"] = { index = "pulseiraroubada", nome = "Pulseira Roubada", type = "usar" },
	["anelroubado"] = { index = "anelroubado", nome = "Anel Roubado", type = "usar" },
	["colarroubado"] = { index = "colarroubado", nome = "Colar Roubado", type = "usar" },
	["brincoroubado"] = { index = "brincoroubado", nome = "Brinco Roubado", type = "usar" },
	["carteiraroubada"] = { index = "carteiraroubada", nome = "Carteira Roubada", type = "usar" },
	["tabletroubado"] = { index = "tabletroubado", nome = "Tablet Roubado", type = "usar" },
	["sapatosroubado"] = { index = "sapatosroubado", nome = "Sapatos Roubado", type = "usar" },

	["folhadecoca"] = { index = "folhadecoca", nome = "Folha de Coca", type = "usar" },
	["cocamisturada"] = { index = "cocamisturada", nome = "Cocaina Misturada", type = "usar" },
	["cocaina"] = { index = "cocaina", nome = "Cocaína", type = "usar" },
	["essenciadeecstasy"] = { index = "essenciadeecstasy", nome = "Essencia de Ecstasy", type = "usar" },
	["pastadeecstasy"] = { index = "pastadeecstasy", nome = "Pasta de Ecstasy", type = "usar" },
	["ecstasy"] = { index = "ecstasy", nome = "Ecstasy", type = "usar" },

	["fungo"] = { index = "fungo", nome = "Fungo", type = "usar" },
	["bateria"] = { index = "bateria", nome = "Bateria", type = "usar" },
	["gps"] = { index = "gps", nome = "GPS", type = "usar" },
	["ticket"] = { index = "ticket", nome = "Ticket", type = "usar" },
	["cobre"] = { index = "cobre", nome = "Cobre", type = "usar" },
	["plastico"] = { index = "plastico", nome = "Plastico", type = "usar" },
	["borracha"] = { index = "borracha", nome = "Borracha", type = "usar" },
	["linha"] = { index = "linha", nome = "Linha", type = "usar" },
	["pano"] = { index = "pano", nome = "Pano", type = "usar" },
	["tecido"] = { index = "tecido", nome = "Tecido", type = "usar" },
	["vidro"] = { index = "vidro", nome = "Vidro", type = "usar" },
	["pilha"] = { index = "pilha", nome = "Pilha", type = "usar" },
	["fioeletronico"] = { index = "fioeletronico", nome = "Fio Eletronico", type = "usar" },
	["jornal"] = { index = "jornal", nome = "Jornal", type = "usar" },

    ["dietilamina"] = { index = "dietilamina", nome = "Dietilamina", type = "usar" },
    ["lancaperfume"] = { index = "lancaperfume", nome = "Lança Perfume", type = "usar" },
	["acidobateria"] = { index = "acidobateria", nome = "Ácido de Bateria", type = "usar" },
	["anfetamina"] = { index = "anfetamina", nome = "Anfetamina", type = "usar" },
	
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina", type = "usar" },
	["logsinvasao"] = { index = "logsinvasao", nome = "L. Inv. Banco", type = "usar" },
	["keysinvasao"] = { index = "keysinvasao", nome = "K. Inv. Banco", type = "usar" },
	["pendriveinformacoes"] = { index = "pendriveinformacoes", nome = "P. Info.", type = "usar" },
	["acessodeepweb"] = { index = "acessodeepweb", nome = "P. DeepWeb", type = "usar" },
	["ouro"] = { index = "ouro", nome = "Ouro", type = "usar" },
	["bronze"] = { index = "bronze", nome = "Bronze", type = "usar" },
	["ferro"] = { index = "ferro", nome = "Ferro", type = "usar" },
	["radio"] = { index = "radio", nome = "Radio", type = "usar" },
	["c4"] = { index = "c4", nome = "C4", type = "usar" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira", type = "usar" },
	["presentedenatal"] = { index = "presente", nome = "Presente de Natal", type = "usar" },
	["serra"] = { index = "serra", nome = "Serra", type = "usar" },
	["graos"] = { index = "graos", nome = "Graos", type = "usar" },
	["graosimpuros"] = { index = "graosimpuros", nome = "Graos Impuros", type = "usar" },
	["keycard"] = { index = "keycard", nome = "Keycard", type = "usar" },
	["xerelto"] = { index = "xerelto", nome = "Xerelto", type = "usar" },
	["coumadin"] = { index = "coumadin", nome = "Coumadin", type = "usar" },
	["aneldecompromisso"] = { index = "aneldecompromisso", nome = "Anel de Compromisso", type = "usar" },
	["colardeperolas"] = { index = "colardeperolas", nome = "Colar de Pérolas", type = "usar" },
	["pulseiradeouro"] = { index = "pulseiradeouro", nome = "Pulseira de Ouro", type = "usar" },
	["chocolate"] = { index = "chocolate", nome = "Chocolate", type = "usar" },
	["pirulito"] = { index = "pirulito", nome = "Pirulito", type = "usar" },
	["buque"] = { index = "buque", nome = "Buquê de Flores", type = "usar" },
	-----------------------------------------------------------
	-- ARMAS
	-----------------------------------------------------------
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga", type = "equipar" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol", type = "equipar" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa", type = "equipar" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra", type = "equipar" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna", type = "equipar" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf", type = "equipar" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo", type = "equipar" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado", type = "equipar" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês", type = "equipar" },
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca", type = "equipar" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete", type = "equipar" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete", type = "equipar" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete", type = "equipar" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo", type = "equipar" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha", type = "equipar" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca", type = "equipar" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra", type = "equipar" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911", type = "equipar" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five Seven", type = "equipar" },
	["wbody|WEAPON_SPECIALCARBINE_MK2"] = { index = "g36mk2", nome = "G36", type = "equipar" },
	["wbody|WEAPON_COMBATPDW"] = { index = "sig", nome = "Sig Sauer PM", type = "equipar" },
	["wbody|WEAPON_HEAVYPISTOL"] = { index = "desert", nome = "Desert Eagle", type = "equipar" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock 19", type = "equipar" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser", type = "equipar" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hkp7m10", nome = "HK P7M10", type = "equipar" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m1922", nome = "M1922", type = "equipar" },
	["wbody|WEAPON_REVOLVER"] = { index = "magnum44", nome = "Magnum 44", type = "equipar" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum357", nome = "Magnum 357", type = "equipar" },
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22", type = "equipar" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador", type = "equipar" },
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas", type = "equipar" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor", type = "equipar" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi", type = "equipar" },
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "CTT .40", type = "equipar" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "mtar21", nome = "MTAR-21", type = "equipar" },
	["wbody|WEAPON_SMG_MK2"] = { index = "mp5mk2", nome = "MP5 MK2", type = "equipar" },
	["wbody|WEAPON_SAWNOFFSHOTGUN"] = { index = "remington", nome = "Shotgun Sawnoff", type = "equipar" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "m4a1", nome = "M4A1", type = "equipar" },
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak103", nome = "AK-103 MK2", type = "equipar" },
	["wbody|WEAPON_PUMPSHOTGUN"] = { index = "pumpp", nome = "Escopeta PM", type = "equipar" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina", type = "equipar" },	
	["wbody|WEAPON_GUSENBERG"] = { index = "thompson", nome = "Thompson", type = "equipar" },		
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9", type = "equipar" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "aks", nome = "AKS", type = "equipar" },
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "mpx", nome = "MPX", type = "equipar" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "M.M1911", type = "recarregar" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "M.FN Five Seven", type = "recarregar" },
	["wammo|WEAPON_SPECIALCARBINE_MK2"] = { index = "m-g36mk2", nome = "M.G36", type = "recarregar" },
	["wammo|WEAPON_HEAVYPISTOL"] = { index = "m-desert", nome = "M.Desert Eagle", type = "recarregar" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "M.Glock 19", type = "recarregar" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "M.Taser", type = "recarregar" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hkp7m10", nome = "M.HK P7M10", type = "recarregar" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m1922", nome = "M.M1922", type = "recarregar" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-sig", nome = "M.Sig Sauer PM", type = "recarregar" },
	["wammo|WEAPON_REVOLVER"] = { index = "m-magnum44", nome = "M.Magnum 44", type = "recarregar" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-magnum357", nome = "M.Magnum 357", type = "recarregar" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22", type = "recarregar" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador", type = "recarregar" },
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas", type = "recarregar" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor", type = "recarregar" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "M.Uzi", type = "recarregar" },
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "M.MP5", type = "recarregar" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-mtar21", nome = "M.MTAR-21", type = "recarregar" },
	["wammo|WEAPON_SMG_MK2"] = { index = "m-mp5mk2", nome = "M.MP5 MK2", type = "recarregar" },
	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "m-shotgun", nome = "M.Shotgun PM", type = "recarregar" },
	["wammo|WEAPON_SAWNOFFSHOTGUN"] = { index = "m-remington", nome = "M.Shotgun Sawnoff", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-m4a1", nome = "M.M4A1", type = "recarregar" },
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak103", nome = "M.AK-103 MK2", type = "recarregar" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "M.Thompson", type = "recarregar" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "M.Tec-9", type = "recarregar" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-aks", nome = "M.AKS", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-mpx", nome = "M.MPX", type = "recarregar" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível", type = "recarregar" }
}

function vRP.itemNameList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].nome
	end
end

function vRP.itemIndexList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].index
	end
end

function vRP.itemTypeList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].type
	end
end

function vRP.itemBodyList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

vRP.items = {}
function vRP.defInventoryItem(idname,name,weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end


function vRP.giveInventoryItem(user_id,idname,amount,notify)
	local source = vRP.getUserSource(user_id)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry then
			entry.amount = entry.amount + amount
		else
			data.inventory[idname] = { amount = amount }
		end

		if notify == "hidden" then
		else
			TriggerClientEvent("itensNotify",source,"sucesso",""..vRP.format(amount).." "..vRP.itemNameList(idname).."",vRP.itemIndexList(idname))
		end
	end
end

function vRP.tryGetInventoryItem(user_id,idname,amount)
	local source = vRP.getUserSource(user_id)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry and entry.amount >= amount then
			entry.amount = entry.amount - amount

			if entry.amount <= 0 then
				data.inventory[idname] = nil
			end
			TriggerClientEvent("itensNotify",source,"negado",""..vRP.format(amount).." "..vRP.itemNameList(idname).."",vRP.itemIndexList(idname))
			return true
		end
	end
	return false
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3
end

--RegisterServerEvent("clearInventory")
--AddEventHandler("clearInventory",function()
--    local source = source
--    local user_id = vRP.getUserId(source)
--    if user_id then
--        local data = vRP.getUserDataTable(user_id)
--        if data then
--            data.inventory = {}
--        end
--
--        vRP.setMoney(user_id,0)
--        vRPclient._clearWeapons(source)
--        vRPclient._setHandcuffed(source,false)
--
--        if not vRP.hasPermission(user_id,"mochila.permissao") and not vRP.hasPermission(user_id, 'policiaacao.permissao') then
--            vRP.setExp(user_id,"physical","strength",20)
--        end
--    end
--end)

--RegisterServerEvent('waze:GuardarArmasMorte')
--AddEventHandler('waze:GuardarArmasMorte', function()
--    local source = source
--    local user_id = vRP.getUserId(source)
--    if user_id then
--		local weapons = vRPclient.replaceWeapons(source,{})
--        for k,v in pairs(weapons) do
--            vRP.removeWeaponTable(user_id,k)
--            vRP.giveInventoryItem(user_id,"wbody|"..k,1)
--            if v.ammo > 0 then
--                vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
--            end
--        end
--    end
--end)

RegisterServerEvent('waze:Aeroporto:Server')
AddEventHandler('waze:Aeroporto:Server', function(lugar)
	
	-- ZERA O INVENTARIO DO CARA
	local source = source
    local user_id = vRP.getUserId(source)

	::reiniciarinventario::

	local data = vRP.getUserDataTable(user_id)
	if data then
		data.inventory = {}
	end
	
	vRP.setMoney(user_id,0)
	vRPclient._clearWeapons(source)
	vRPclient._setHandcuffed(source,false)
	
	if not vRP.hasPermission(user_id,"mochila.permissao") and not vRP.hasPermission(user_id, 'policiaacao.permissao') then
		vRP.setExp(user_id,"physical","strength",20)
	end
	
	-- ENVIA O LOG PRO DISCORD
	local ped = GetPlayerPed(source)
	local x,y,z = table.unpack(GetEntityCoords(ped))
	TriggerEvent('waze:LoggarAeroporto', source, x,y,z)

	-- RESPAWNA
	local pulica = false
	if vRP.hasPermission(user_id, 'policia.permissao') or vRP.hasPermission(user_id, 'policiaacao.permissao') then
		pulica = true
	end

	--TriggerClientEvent('waze:Aeroporto:Client', source, lugar,pulica)

	local data2 = vRP.getUserDataTable(user_id)
	if #data2 > 0 then
		data2.inventory = {}
		print( 'ID ' .. user_id .. ' MORREU E O INVENTÁRIO AINDA TINHA COISA, RESETANDO DE NOVO.')
		goto reiniciarinventario
	end
	
	vRPclient.AeroportoClient(source, lugar, pulica)
end)

function vRP.clearInventory(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        data.inventory = {}
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERJOIN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
local vehglobal = {
	["blista"] = { ['name'] = "Blista", ['price'] = 60000, ['tipo'] = "carros" },
	["brioso"] = { ['name'] = "Brioso", ['price'] = 35000, ['tipo'] = "carros" },
	["emperor"] = { ['name'] = "Emperor", ['price'] = 50000, ['tipo'] = "carros" },
	["emperor2"] = { ['name'] = "Emperor 2", ['price'] = 50000, ['tipo'] = "carros" },
	["dilettante"] = { ['name'] = "Dilettante", ['price'] = 60000, ['tipo'] = "carros" },
	["issi2"] = { ['name'] = "Issi2", ['price'] = 90000, ['tipo'] = "carros" },
	["panto"] = { ['name'] = "Panto", ['price'] = 25000, ['tipo'] = "carros" },
	["prairie"] = { ['name'] = "Prairie", ['price'] = 10000, ['tipo'] = "carros" },
	["rhapsody"] = { ['name'] = "Rhapsody", ['price'] = 70000, ['tipo'] = "carros" },
	["cogcabrio"] = { ['name'] = "Cogcabrio", ['price'] = 130000, ['tipo'] = "carros" },
	["exemplar"] = { ['name'] = "Exemplar", ['price'] = 80000, ['tipo'] = "carros" },
	["f620"] = { ['name'] = "F620", ['price'] = 55000, ['tipo'] = "carros" },
	["felon"] = { ['name'] = "Felon", ['price'] = 70000, ['tipo'] = "carros" },
	["ingot"] = { ['name'] = "Ingot", ['price'] = 160000, ['tipo'] = "carros" },
	["oracle"] = { ['name'] = "Oracle", ['price'] = 60000, ['tipo'] = "carros" },
	["oracle2"] = { ['name'] = "Oracle2", ['price'] = 80000, ['tipo'] = "carros" },
	["sentinel"] = { ['name'] = "Sentinel", ['price'] = 50000, ['tipo'] = "carros" },
	["sentinel2"] = { ['name'] = "Sentinel2", ['price'] = 60000, ['tipo'] = "carros" },
	["windsor"] = { ['name'] = "Windsor", ['price'] = 150000, ['tipo'] = "carros" },
	["windsor2"] = { ['name'] = "Windsor2", ['price'] = 170000, ['tipo'] = "carros" },
	["zion"] = { ['name'] = "Zion", ['price'] = 50000, ['tipo'] = "carros" },
	["zion2"] = { ['name'] = "Zion2", ['price'] = 60000, ['tipo'] = "carros" },
	["blade"] = { ['name'] = "Blade", ['price'] = 110000, ['tipo'] = "carros" },
	["buccaneer"] = { ['name'] = "Buccaneer", ['price'] = 130000, ['tipo'] = "carros" },
	["buccaneer2"] = { ['name'] = "Buccaneer2", ['price'] = 260000, ['tipo'] = "carros" },
	["primo"] = { ['name'] = "Primo", ['price'] = 130000, ['tipo'] = "carros" },
	["chino"] = { ['name'] = "Chino", ['price'] = 130000, ['tipo'] = "carros" },
	["coquette3"] = { ['name'] = "Coquette3", ['price'] = 195000, ['tipo'] = "carros" },
	["dukes"] = { ['name'] = "Dukes", ['price'] = 150000, ['tipo'] = "carros" },
	["faction"] = { ['name'] = "Faction", ['price'] = 150000, ['tipo'] = "carros" },
	["faction3"] = { ['name'] = "Faction3", ['price'] = 350000, ['tipo'] = "carros" },
	["gauntlet"] = { ['name'] = "Gauntlet", ['price'] = 165000, ['tipo'] = "carros" },
	["gauntlet2"] = { ['name'] = "Gauntlet2", ['price'] = 165000, ['tipo'] = "carros" },
	["hermes"] = { ['name'] = "Hermes", ['price'] = 280000, ['tipo'] = "carros" },
	["hotknife"] = { ['name'] = "Hotknife", ['price'] = 180000, ['tipo'] = "carros" },
	["moonbeam"] = { ['name'] = "Moonbeam", ['price'] = 220000, ['tipo'] = "carros" },
	["moonbeam2"] = { ['name'] = "Moonbeam2", ['price'] = 250000, ['tipo'] = "carros" },
	["nightshade"] = { ['name'] = "Nightshade", ['price'] = 270000, ['tipo'] = "carros" },
	["picador"] = { ['name'] = "Picador", ['price'] = 150000, ['tipo'] = "carros" },
	["ruiner"] = { ['name'] = "Ruiner", ['price'] = 150000, ['tipo'] = "carros" },
	["sabregt"] = { ['name'] = "Sabregt", ['price'] = 260000, ['tipo'] = "carros" },
	["sabregt2"] = { ['name'] = "Sabregt2", ['price'] = 250000, ['tipo'] = "carros" },
	["slamvan"] = { ['name'] = "Slamvan", ['price'] = 180000, ['tipo'] = "carros" },
	["slamvan3"] = { ['name'] = "Slamvan3", ['price'] = 230000, ['tipo'] = "carros" },
	["stalion"] = { ['name'] = "Stalion", ['price'] = 150000, ['tipo'] = "carros" },
	["stalion2"] = { ['name'] = "Stalion2", ['price'] = 150000, ['tipo'] = "carros" },
	["tampa"] = { ['name'] = "Tampa", ['price'] = 170000, ['tipo'] = "carros" },
	["vigero"] = { ['name'] = "Vigero", ['price'] = 170000, ['tipo'] = "carros" },
	["virgo"] = { ['name'] = "Virgo", ['price'] = 150000, ['tipo'] = "carros" },
	["virgo2"] = { ['name'] = "Virgo2", ['price'] = 250000, ['tipo'] = "carros" },
	["virgo3"] = { ['name'] = "Virgo3", ['price'] = 180000, ['tipo'] = "carros" },
	["voodoo"] = { ['name'] = "Voodoo", ['price'] = 220000, ['tipo'] = "carros" },
	["voodoo2"] = { ['name'] = "Voodoo2", ['price'] = 220000, ['tipo'] = "carros" },
	["yosemite"] = { ['name'] = "Yosemite", ['price'] = 350000, ['tipo'] = "carros" },
	["bfinjection"] = { ['name'] = "Bfinjection", ['price'] = 80000, ['tipo'] = "carros" },
	["bifta"] = { ['name'] = "Bifta", ['price'] = 210000, ['tipo'] = "carros" },
	["bodhi2"] = { ['name'] = "Bodhi2", ['price'] = 170000, ['tipo'] = "carros" },
	["brawler"] = { ['name'] = "Brawler", ['price'] = 250000, ['tipo'] = "carros" },
	["trophytruck"] = { ['name'] = "Trophytruck", ['price'] = 400000, ['tipo'] = "carros" },
	["trophytruck2"] = { ['name'] = "Trophytruck2", ['price'] = 400000, ['tipo'] = "carros" },
	["dubsta3"] = { ['name'] = "Dubsta3", ['price'] = 300000, ['tipo'] = "carros" },
	["mesa3"] = { ['name'] = "Mesa3", ['price'] = 300000, ['tipo'] = "carros" },
	["rancherxl"] = { ['name'] = "Rancherxl", ['price'] = 220000, ['tipo'] = "carros" },
	["rebel2"] = { ['name'] = "Rebel2", ['price'] = 250000, ['tipo'] = "carros" },
	["riata"] = { ['name'] = "Riata", ['price'] = 250000, ['tipo'] = "carros" },
	["dloader"] = { ['name'] = "Dloader", ['price'] = 150000, ['tipo'] = "carros" },
	["sandking"] = { ['name'] = "Sandking", ['price'] = 400000, ['tipo'] = "carros" },
	["sandking2"] = { ['name'] = "Sandking2", ['price'] = 370000, ['tipo'] = "carros" },
	["baller"] = { ['name'] = "Baller", ['price'] = 400000, ['tipo'] = "carros" },
	["baller2"] = { ['name'] = "Baller2", ['price'] = 420000, ['tipo'] = "carros" },
	["baller3"] = { ['name'] = "Baller3", ['price'] = 430000, ['tipo'] = "carros" },
	["baller4"] = { ['name'] = "Baller4", ['price'] = 440000, ['tipo'] = "carros" },
	["baller5"] = { ['name'] = "Baller5", ['price'] = 450000, ['tipo'] = "carros" },
	["baller6"] = { ['name'] = "Baller6", ['price'] = 460000, ['tipo'] = "carros" },
	["bjxl"] = { ['name'] = "Bjxl", ['price'] = 110000, ['tipo'] = "carros" },
	["cavalcade"] = { ['name'] = "Cavalcade", ['price'] = 110000, ['tipo'] = "carros" },
	["cavalcade2"] = { ['name'] = "Cavalcade2", ['price'] = 130000, ['tipo'] = "carros" },
	["contender"] = { ['name'] = "Contender", ['price'] = 300000, ['tipo'] = "carros" },
	["dubsta"] = { ['name'] = "Dubsta", ['price'] = 210000, ['tipo'] = "carros" },
	["dubsta2"] = { ['name'] = "Dubsta2", ['price'] = 240000, ['tipo'] = "carros" },
	["fq2"] = { ['name'] = "Fq2", ['price'] = 110000, ['tipo'] = "carros" },
	["granger"] = { ['name'] = "Granger", ['price'] = 445000, ['tipo'] = "carros" },
	["gresley"] = { ['name'] = "Gresley", ['price'] = 150000, ['tipo'] = "carros" },
	["habanero"] = { ['name'] = "Habanero", ['price'] = 110000, ['tipo'] = "carros" },
	["seminole"] = { ['name'] = "Seminole", ['price'] = 110000, ['tipo'] = "carros" },
	["serrano"] = { ['name'] = "Serrano", ['price'] = 150000, ['tipo'] = "carros" },
	["xls"] = { ['name'] = "Xls", ['price'] = 450000, ['tipo'] = "carros" },
	["xls2"] = { ['name'] = "Xls2", ['price'] = 450000, ['tipo'] = "carros" },
	["asea"] = { ['name'] = "Asea", ['price'] = 55000, ['tipo'] = "carros" },
	["asterope"] = { ['name'] = "Asterope", ['price'] = 65000, ['tipo'] = "carros" },
	["cog552"] = { ['name'] = "Cog552", ['price'] = 400000, ['tipo'] = "carros" },
	["cognoscenti"] = { ['name'] = "Cognoscenti", ['price'] = 280000, ['tipo'] = "carros" },
	["cognoscenti2"] = { ['name'] = "Cognoscenti2", ['price'] = 400000, ['tipo'] = "carros" },
	["stanier"] = { ['name'] = "Stanier", ['price'] = 60000, ['tipo'] = "carros" },
	["stratum"] = { ['name'] = "Stratum", ['price'] = 90000, ['tipo'] = "carros" },
	["surge"] = { ['name'] = "Surge", ['price'] = 210000, ['tipo'] = "carros" },
	["tailgater"] = { ['name'] = "Tailgater", ['price'] = 110000, ['tipo'] = "carros" },
	["warrener"] = { ['name'] = "Warrener", ['price'] = 90000, ['tipo'] = "carros" },
	["washington"] = { ['name'] = "Washington", ['price'] = 130000, ['tipo'] = "carros" },
	["alpha"] = { ['name'] = "Alpha", ['price'] = 330000, ['tipo'] = "carros" },
	["banshee"] = { ['name'] = "Banshee", ['price'] = 300000, ['tipo'] = "carros" },
	["bestiagts"] = { ['name'] = "Bestiagts", ['price'] = 400000, ['tipo'] = "carros" },
	["blista2"] = { ['name'] = "Blista2", ['price'] = 55000, ['tipo'] = "carros" },
	["blista3"] = { ['name'] = "Blista3", ['price'] = 80000, ['tipo'] = "carros" },
	["buffalo"] = { ['name'] = "Buffalo", ['price'] = 300000, ['tipo'] = "carros" },
	["buffalo2"] = { ['name'] = "Buffalo2", ['price'] = 300000, ['tipo'] = "carros" },
	["buffalo3"] = { ['name'] = "Buffalo3", ['price'] = 300000, ['tipo'] = "carros" },
	["carbonizzare"] = { ['name'] = "Carbonizzare", ['price'] = 490000, ['tipo'] = "carros" },
	["comet2"] = { ['name'] = "Comet2", ['price'] = 350000, ['tipo'] = "carros" },
	["comet3"] = { ['name'] = "Comet3", ['price'] = 390000, ['tipo'] = "carros" },
	["comet5"] = { ['name'] = "Comet5", ['price'] = 400000, ['tipo'] = "carros" },
	["coquette"] = { ['name'] = "Coquette", ['price'] = 450000, ['tipo'] = "carros" },
	["elegy"] = { ['name'] = "Elegy", ['price'] = 550000, ['tipo'] = "carros" },
	["elegy2"] = { ['name'] = "Elegy2", ['price'] = 655000, ['tipo'] = "carros" },
	["feltzer2"] = { ['name'] = "Feltzer2", ['price'] = 255000, ['tipo'] = "carros" },
	["furoregt"] = { ['name'] = "Furoregt", ['price'] = 290000, ['tipo'] = "carros" },
	["fusilade"] = { ['name'] = "Fusilade", ['price'] = 210000, ['tipo'] = "carros" },
	["futo"] = { ['name'] = "Futo", ['price'] = 200000, ['tipo'] = "carros" },
	["jester"] = { ['name'] = "Jester", ['price'] = 600000, ['tipo'] = "carros" },
	["khamelion"] = { ['name'] = "Khamelion", ['price'] = 210000, ['tipo'] = "carros" },
	["kuruma"] = { ['name'] = "Kuruma", ['price'] = 330000, ['tipo'] = "carros" },
	["massacro"] = { ['name'] = "Massacro", ['price'] = 330000, ['tipo'] = "carros" },
	["massacro2"] = { ['name'] = "Massacro2", ['price'] = 330000, ['tipo'] = "carros" },
	["ninef"] = { ['name'] = "Ninef", ['price'] = 290000, ['tipo'] = "carros" },
	["ninef2"] = { ['name'] = "Ninef2", ['price'] = 290000, ['tipo'] = "carros" },
	["omnis"] = { ['name'] = "Omnis", ['price'] = 240000, ['tipo'] = "carros" },
	["pariah"] = { ['name'] = "Pariah", ['price'] = 500000, ['tipo'] = "carros" },
	["penumbra"] = { ['name'] = "Penumbra", ['price'] = 150000, ['tipo'] = "carros" },
	["raiden"] = { ['name'] = "Raiden", ['price'] = 240000, ['tipo'] = "carros" },
	["rapidgt"] = { ['name'] = "Rapidgt", ['price'] = 450000, ['tipo'] = "carros" },
	["rapidgt2"] = { ['name'] = "Rapidgt2", ['price'] = 300000, ['tipo'] = "carros" },
	["ruston"] = { ['name'] = "Ruston", ['price'] = 370000, ['tipo'] = "carros" },
	["schafter3"] = { ['name'] = "Schafter3", ['price'] = 275000, ['tipo'] = "carros" },
	["schafter4"] = { ['name'] = "Schafter4", ['price'] = 275000, ['tipo'] = "carros" },
	["schafter5"] = { ['name'] = "Schafter5", ['price'] = 275000, ['tipo'] = "carros" },
	["schwarzer"] = { ['name'] = "Schwarzer", ['price'] = 170000, ['tipo'] = "carros" },
	["sentinel3"] = { ['name'] = "Sentinel3", ['price'] = 170000, ['tipo'] = "carros" },
	["seven70"] = { ['name'] = "Seven70", ['price'] = 770000, ['tipo'] = "carros" },
	["specter"] = { ['name'] = "Specter", ['price'] = 320000, ['tipo'] = "carros" },
	["specter2"] = { ['name'] = "Specter2", ['price'] = 355000, ['tipo'] = "carros" },
	["streiter"] = { ['name'] = "Streiter", ['price'] = 250000, ['tipo'] = "carros" },
	["sultan"] = { ['name'] = "Sultan", ['price'] = 510000, ['tipo'] = "carros" },
	["surano"] = { ['name'] = "Surano", ['price'] = 310000, ['tipo'] = "carros" },
	["tampa2"] = { ['name'] = "Tampa2", ['price'] = 200000, ['tipo'] = "carros" },
	["tropos"] = { ['name'] = "Tropos", ['price'] = 170000, ['tipo'] = "carros" },
	["verlierer2"] = { ['name'] = "Verlierer2", ['price'] = 380000, ['tipo'] = "carros" },
	["btype2"] = { ['name'] = "Btype2", ['price'] = 460000, ['tipo'] = "carros" },
	["btype3"] = { ['name'] = "Btype3", ['price'] = 390000, ['tipo'] = "carros" },
	["casco"] = { ['name'] = "Casco", ['price'] = 355000, ['tipo'] = "carros" },
	["cheetah"] = { ['name'] = "Cheetah", ['price'] = 425000, ['tipo'] = "carros" },
	["coquette2"] = { ['name'] = "Coquette2", ['price'] = 285000, ['tipo'] = "carros" },
	["feltzer3"] = { ['name'] = "Feltzer3", ['price'] = 220000, ['tipo'] = "carros" },
	["gt500"] = { ['name'] = "Gt500", ['price'] = 250000, ['tipo'] = "carros" },
	["infernus2"] = { ['name'] = "Infernus2", ['price'] = 250000, ['tipo'] = "carros" },
	["jb700"] = { ['name'] = "Jb700", ['price'] = 220000, ['tipo'] = "carros" },
	["mamba"] = { ['name'] = "Mamba", ['price'] = 300000, ['tipo'] = "carros" },
	["manana"] = { ['name'] = "Manana", ['price'] = 130000, ['tipo'] = "carros" },
	["monroe"] = { ['name'] = "Monroe", ['price'] = 260000, ['tipo'] = "carros" },
	["peyote"] = { ['name'] = "Peyote", ['price'] = 150000, ['tipo'] = "carros" },
	["pigalle"] = { ['name'] = "Pigalle", ['price'] = 250000, ['tipo'] = "carros" },
	["rapidgt3"] = { ['name'] = "Rapidgt3", ['price'] = 220000, ['tipo'] = "carros" },
	["retinue"] = { ['name'] = "Retinue", ['price'] = 200000, ['tipo'] = "carros" },
	["stinger"] = { ['name'] = "Stinger", ['price'] = 220000, ['tipo'] = "carros" },
	["stingergt"] = { ['name'] = "Stingergt", ['price'] = 230000, ['tipo'] = "carros" },
	["torero"] = { ['name'] = "Torero", ['price'] = 250000, ['tipo'] = "carros" },
	["tornado"] = { ['name'] = "Tornado", ['price'] = 150000, ['tipo'] = "carros" },
	["tornado2"] = { ['name'] = "Tornado2", ['price'] = 400000, ['tipo'] = "carros" },
	["tornado6"] = { ['name'] = "Tornado6", ['price'] = 450000, ['tipo'] = "carros" },
	["turismo2"] = { ['name'] = "Turismo2", ['price'] = 420000, ['tipo'] = "carros" },
	["ztype"] = { ['name'] = "Ztype", ['price'] = 500000, ['tipo'] = "carros" },
	["adder"] = { ['name'] = "Adder", ['price'] = 1500000, ['tipo'] = "carros" },
	["autarch"] = { ['name'] = "Autarch", ['price'] = 760000, ['tipo'] = "carros" },
	["banshee2"] = { ['name'] = "Banshee2", ['price'] = 370000, ['tipo'] = "carros" },
	["bullet"] = { ['name'] = "Bullet", ['price'] = 600000, ['tipo'] = "carros" },
	["cheetah2"] = { ['name'] = "Cheetah2", ['price'] = 240000, ['tipo'] = "carros" },
	["entityxf"] = { ['name'] = "Entityxf", ['price'] = 4060000, ['tipo'] = "carros" },
	["fmj"] = { ['name'] = "Fmj", ['price'] = 520000, ['tipo'] = "carros" },
	["gp1"] = { ['name'] = "Gp1", ['price'] = 495000, ['tipo'] = "carros" },
	["infernus"] = { ['name'] = "Infernus", ['price'] = 600000, ['tipo'] = "carros" },
	["nero"] = { ['name'] = "Nero", ['price'] = 1000000, ['tipo'] = "carros" },
	["nero2"] = { ['name'] = "Nero2", ['price'] = 1200000, ['tipo'] = "carros" },
	["osiris"] = { ['name'] = "Osiris", ['price'] = 1200000, ['tipo'] = "carros" },
	["penetrator"] = { ['name'] = "Penetrator", ['price'] = 480000, ['tipo'] = "carros" },
	["pfister811"] = { ['name'] = "Pfister811", ['price'] = 530000, ['tipo'] = "carros" },
	["reaper"] = { ['name'] = "Reaper", ['price'] = 620000, ['tipo'] = "carros" },
	["sc1"] = { ['name'] = "Sc1", ['price'] = 1250000, ['tipo'] = "carros" },
	["sultanrs"] = { ['name'] = "Sultan RS", ['price'] = 1000000, ['tipo'] = "carros" },
	["t20"] = { ['name'] = "T20", ['price'] = 1900000, ['tipo'] = "carros" },
	["tempesta"] = { ['name'] = "Tempesta", ['price'] = 600000, ['tipo'] = "carros" },
	["turismor"] = { ['name'] = "Turismor", ['price'] = 620000, ['tipo'] = "carros" },
	["tyrus"] = { ['name'] = "Tyrus", ['price'] = 620000, ['tipo'] = "carros" },
	["vacca"] = { ['name'] = "Vacca", ['price'] = 620000, ['tipo'] = "carros" },
	["visione"] = { ['name'] = "Visione", ['price'] = 690000, ['tipo'] = "carros" },
	["voltic"] = { ['name'] = "Voltic", ['price'] = 440000, ['tipo'] = "carros" },
	["zentorno"] = { ['name'] = "Zentorno", ['price'] = 920000, ['tipo'] = "carros" },
	["sadler"] = { ['name'] = "Sadler", ['price'] = 180000, ['tipo'] = "carros" },
	["bison"] = { ['name'] = "Bison", ['price'] = 220000, ['tipo'] = "carros" },
	["bison2"] = { ['name'] = "Bison2", ['price'] = 180000, ['tipo'] = "carros" },
	["bobcatxl"] = { ['name'] = "Bobcatxl", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito"] = { ['name'] = "Burrito", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito2"] = { ['name'] = "Burrito2", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito3"] = { ['name'] = "Burrito3", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito4"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros" },
	["mule4"] = { ['name'] = "Mule4", ['price'] = 260000, ['tipo'] = "carros" },
	["rallytruck"] = { ['name'] = "Rallytruck", ['price'] = 6900000, ['tipo'] = "carros" },
	["minivan"] = { ['name'] = "Minivan", ['price'] = 110000, ['tipo'] = "carros" },
	["minivan2"] = { ['name'] = "Minivan2", ['price'] = 220000, ['tipo'] = "carros" },
	["paradise"] = { ['name'] = "Paradise", ['price'] = 260000, ['tipo'] = "carros" },
	["pony"] = { ['name'] = "Pony", ['price'] = 260000, ['tipo'] = "carros" },
	["pony2"] = { ['name'] = "Pony2", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo"] = { ['name'] = "Rumpo", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo2"] = { ['name'] = "Rumpo2", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo3"] = { ['name'] = "Rumpo3", ['price'] = 350000, ['tipo'] = "carros" },
	["surfer"] = { ['name'] = "Surfer", ['price'] = 100000, ['tipo'] = "carros" },
	["youga"] = { ['name'] = "Youga", ['price'] = 260000, ['tipo'] = "carros" },
	["huntley"] = { ['name'] = "Huntley", ['price'] = 110000, ['tipo'] = "carros" },
	["landstalker"] = { ['name'] = "Landstalker", ['price'] = 130000, ['tipo'] = "carros" },
	["mesa"] = { ['name'] = "Mesa", ['price'] = 200000, ['tipo'] = "carros" },
	["patriot"] = { ['name'] = "Patriot", ['price'] = 250000, ['tipo'] = "carros" },
	["radi"] = { ['name'] = "Radi", ['price'] = 110000, ['tipo'] = "carros" },
	["rocoto"] = { ['name'] = "Rocoto", ['price'] = 110000, ['tipo'] = "carros" },
	["tyrant"] = { ['name'] = "Tyrant", ['price'] = 690000, ['tipo'] = "carros" },
	["entity2"] = { ['name'] = "Entity2", ['price'] = 5050000, ['tipo'] = "carros" },
	["cheburek"] = { ['name'] = "Cheburek", ['price'] = 170000, ['tipo'] = "carros" },
	["hotring"] = { ['name'] = "Hotring", ['price'] = 300000, ['tipo'] = "carros" },
	["jester3"] = { ['name'] = "Jester3", ['price'] = 650000, ['tipo'] = "carros" },
	["flashgt"] = { ['name'] = "Flashgt", ['price'] = 370000, ['tipo'] = "carros" },
	["ellie"] = { ['name'] = "Ellie", ['price'] = 320000, ['tipo'] = "carros" },
	["michelli"] = { ['name'] = "Michelli", ['price'] = 160000, ['tipo'] = "carros" },
	["fagaloa"] = { ['name'] = "Fagaloa", ['price'] = 320000, ['tipo'] = "carros" },
	["dominator"] = { ['name'] = "Dominator", ['price'] = 230000, ['tipo'] = "carros" },
	["dominator2"] = { ['name'] = "Dominator2", ['price'] = 230000, ['tipo'] = "carros" },
	["dominator3"] = { ['name'] = "Dominator3", ['price'] = 370000, ['tipo'] = "carros" },
	["issi3"] = { ['name'] = "Issi3", ['price'] = 190000, ['tipo'] = "carros" },
	["taipan"] = { ['name'] = "Taipan", ['price'] = 620000, ['tipo'] = "carros" },
	["gb200"] = { ['name'] = "Gb200", ['price'] = 195000, ['tipo'] = "carros" },
	["stretch"] = { ['name'] = "Stretch", ['price'] = 520000, ['tipo'] = "carros" },
	["guardian"] = { ['name'] = "Guardian", ['price'] = 540000, ['tipo'] = "carros" },
	["kamacho"] = { ['name'] = "Kamacho", ['price'] = 460000, ['tipo'] = "carros" },
	["neon"] = { ['name'] = "Neon", ['price'] = 370000, ['tipo'] = "carros" },
	["cyclone"] = { ['name'] = "Cyclone", ['price'] = 920000, ['tipo'] = "carros" },
	["italigtb"] = { ['name'] = "Italigtb", ['price'] = 600000, ['tipo'] = "carros" },
	["italigtb2"] = { ['name'] = "Italigtb2", ['price'] = 610000, ['tipo'] = "carros" },
	["vagner"] = { ['name'] = "Vagner", ['price'] = 680000, ['tipo'] = "carros" },
	["xa21"] = { ['name'] = "Xa21", ['price'] = 630000, ['tipo'] = "carros" },
	["tezeract"] = { ['name'] = "Tezeract", ['price'] = 920000, ['tipo'] = "carros" },
	["prototipo"] = { ['name'] = "Prototipo", ['price'] = 1030000, ['tipo'] = "carros" },
	["patriot2"] = { ['name'] = "Patriot2", ['price'] = 550000, ['tipo'] = "carros" },
	["swinger"] = { ['name'] = "Swinger", ['price'] = 250000, ['tipo'] = "carros" },
	["clique"] = { ['name'] = "Clique", ['price'] = 360000, ['tipo'] = "carros" },
	["deveste"] = { ['name'] = "Deveste", ['price'] = 920000, ['tipo'] = "carros" },
	["deviant"] = { ['name'] = "Deviant", ['price'] = 370000, ['tipo'] = "carros" },
	["impaler"] = { ['name'] = "Impaler", ['price'] = 450000, ['tipo'] = "carros" },
	["italigto"] = { ['name'] = "Italigto", ['price'] = 1200000, ['tipo'] = "carros" },
	["schlagen"] = { ['name'] = "Schlagen", ['price'] = 690000, ['tipo'] = "carros" },
	["toros"] = { ['name'] = "Toros", ['price'] = 700000, ['tipo'] = "carros" },
	["tulip"] = { ['name'] = "Tulip", ['price'] = 320000, ['tipo'] = "carros" },
	["vamos"] = { ['name'] = "Vamos", ['price'] = 320000, ['tipo'] = "carros" },
	["freecrawler"] = { ['name'] = "Freecrawler", ['price'] = 350000, ['tipo'] = "carros" },
	["fugitive"] = { ['name'] = "Fugitive", ['price'] = 50000, ['tipo'] = "carros" },
	["glendale"] = { ['name'] = "Glendale", ['price'] = 70000, ['tipo'] = "carros" },
	["intruder"] = { ['name'] = "Intruder", ['price'] = 60000, ['tipo'] = "carros" },
	["le7b"] = { ['name'] = "Le7b", ['price'] = 900000, ['tipo'] = "carros" },
	["lurcher"] = { ['name'] = "Lurcher", ['price'] = 150000, ['tipo'] = "carros" },
	["lynx"] = { ['name'] = "Lynx", ['price'] = 650000, ['tipo'] = "carros" },
	["phoenix"] = { ['name'] = "Phoenix", ['price'] = 250000, ['tipo'] = "carros" },
	["premier"] = { ['name'] = "Premier", ['price'] = 35000, ['tipo'] = "carros" },
	["raptor"] = { ['name'] = "Raptor", ['price'] = 350000, ['tipo'] = "carros" },
	["sheava"] = { ['name'] = "Sheava", ['price'] = 700000, ['tipo'] = "carros" },
	["z190"] = { ['name'] = "Z190", ['price'] = 400000, ['tipo'] = "carros" },

	--MOTOS
	["akuma"] = { ['name'] = "Akuma", ['price'] = 6800000, ['tipo'] = "motos" },
	["avarus"] = { ['name'] = "Avarus", ['price'] = 440000, ['tipo'] = "motos" },
	["bagger"] = { ['name'] = "Bagger", ['price'] = 300000, ['tipo'] = "motos" },
	["bati"] = { ['name'] = "Bati", ['price'] = 4700000, ['tipo'] = "motos" },
	["bati2"] = { ['name'] = "Bati2", ['price'] = 4800000, ['tipo'] = "motos" },
	["bf400"] = { ['name'] = "Bf400", ['price'] = 5000000, ['tipo'] = "motos" },
	["carbonrs"] = { ['name'] = "Carbonrs", ['price'] = 370000, ['tipo'] = "motos" },
	["chimera"] = { ['name'] = "Chimera", ['price'] = 345000, ['tipo'] = "motos" },
	["cliffhanger"] = { ['name'] = "Cliffhanger", ['price'] = 310000, ['tipo'] = "motos" },
	["daemon2"]  = { ['name'] = "Daemon2", ['price'] = 240000, ['tipo'] = "motos" },
	["defiler"] = { ['name'] = "Defiler", ['price'] = 560000, ['tipo'] = "motos" },
	["diablous"] = { ['name'] = "Diablous", ['price'] = 430000, ['tipo'] = "motos" },
	["diablous2"] = { ['name'] = "Diablous2", ['price'] = 460000, ['tipo'] = "motos" },
	["double"] = { ['name'] = "Double", ['price'] = 5000000, ['tipo'] = "motos" },
	["enduro"] = { ['name'] = "Enduro", ['price'] = 300000, ['tipo'] = "motos" },
	["esskey"] = { ['name'] = "Esskey", ['price'] = 320000, ['tipo'] = "motos" },
	["faggio"] = { ['name'] = "Faggio", ['price'] = 7000, ['tipo'] = "motos" },
	["faggio2"] = { ['name'] = "Faggio2", ['price'] = 20000, ['tipo'] = "motos" },
	["faggio3"] = { ['name'] = "Faggio3", ['price'] = 8000, ['tipo'] = "motos" },
	["fcr"] = { ['name'] = "Fcr", ['price'] = 390000, ['tipo'] = "motos" },
	["fcr2"] = { ['name'] = "Fcr2", ['price'] = 390000, ['tipo'] = "motos" },
	["gargoyle"] = { ['name'] = "Gargoyle", ['price'] = 345000, ['tipo'] = "motos" },
	["hakuchou"] = { ['name'] = "Hakuchou", ['price'] = 5900000, ['tipo'] = "motos" },
	["hakuchou2"] = { ['name'] = "Hakuchou2", ['price'] = 5050000, ['tipo'] = "motos" },
	["hexer"] = { ['name'] = "Hexer", ['price'] = 250000, ['tipo'] = "motos" },
	["innovation"] = { ['name'] = "Innovation", ['price'] = 250000, ['tipo'] = "motos" },
	["lectro"] = { ['name'] = "Lectro", ['price'] = 380000, ['tipo'] = "motos" },
	["manchez"] = { ['name'] = "Manchez", ['price'] = 380000, ['tipo'] = "motos" },
	["nemesis"] = { ['name'] = "Nemesis", ['price'] = 550000, ['tipo'] = "motos" },
	["nightblade"] = { ['name'] = "Nightblade", ['price'] = 415000, ['tipo'] = "motos" },
	["pcj"] = { ['name'] = "Pcj", ['price'] = 80000, ['tipo'] = "motos" },
	["ruffian"] = { ['name'] = "Ruffian", ['price'] = 845000, ['tipo'] = "motos" },
	["sanchez"] = { ['name'] = "Sanchez", ['price'] = 185000, ['tipo'] = "motos" },
	["sanchez2"] = { ['name'] = "Sanchez2", ['price'] = 185000, ['tipo'] = "motos" },
	["sovereign"] = { ['name'] = "Sovereign", ['price'] = 285000, ['tipo'] = "motos" },
	["thrust"] = { ['name'] = "Thrust", ['price'] = 375000, ['tipo'] = "motos" },
	["vader"] = { ['name'] = "Vader", ['price'] = 345000, ['tipo'] = "motos" },
	["vindicator"] = { ['name'] = "Vindicator", ['price'] = 340000, ['tipo'] = "motos" },
	["vortex"] = { ['name'] = "Vortex", ['price'] = 1500000, ['tipo'] = "motos" },
	["wolfsbane"] = { ['name'] = "Wolfsbane", ['price'] = 290000, ['tipo'] = "motos" },
	["zombiea"] = { ['name'] = "Zombiea", ['price'] = 290000, ['tipo'] = "motos" },
	["zombieb"] = { ['name'] = "Zombieb", ['price'] = 300000, ['tipo'] = "motos" },
	["shotaro"] = { ['name'] = "Shotaro", ['price'] = 1000000, ['tipo'] = "motos" },
	["ratbike"] = { ['name'] = "Ratbike", ['price'] = 230000, ['tipo'] = "motos" },
	["blazer"] = { ['name'] = "Blazer", ['price'] = 230000, ['tipo'] = "motos" },
	["blazer4"] = { ['name'] = "Blazer4", ['price'] = 370000, ['tipo'] = "motos" },
	-- POLICIA/PARAMEDICO
	["wrcontender"] = { ['name'] = "Contender", ['price'] = 1000, ['tipo'] = "work" },
	["wrdouble"] = { ['name'] = "Double", ['price'] = 1000, ['tipo'] = "work" },
	["wrgranger"] = { ['name'] = "Granger", ['price'] = 1000, ['tipo'] = "work" },
	["wrgrowler"] = { ['name'] = "Growler", ['price'] = 1000, ['tipo'] = "work" },
	["wrkomoda"] = { ['name'] = "Komoda", ['price'] = 1000, ['tipo'] = "work" },
	["wrtrx"] = { ['name'] = "Ram 1500", ['price'] = 1000, ['tipo'] = "work" },
	["wrpolmav"] = { ['name'] = "PolMav Police", ['price'] = 1000, ['tipo'] = "work" },

	["pbus"] = { ['name'] = "PBus", ['price'] = 1000, ['tipo'] = "work" },
	["riot"] = { ['name'] = "Blindado", ['price'] = 1000, ['tipo'] = "work" },

	["seasparrow"] = { ['name'] = "Seasparrow", ['price'] = 1000, ['tipo'] = "work" },
	["ambulance"] = { ['name'] = "Ambulance", ['price'] = 1000, ['tipo'] = "work" },
	["emstalker"] = { ['name'] = "Stalker", ['price'] = 1000, ['tipo'] = "work" },
	["palmav"] = { ['name'] = "Polmav", ['price'] = 1000, ['tipo'] = "work" },

	--TRABALHO
	["youga2"] = { ['name'] = "Youga2", ['price'] = 1000, ['tipo'] = "work" },
	["felon2"] = { ['name'] = "Felon2", ['price'] = 1000, ['tipo'] = "work" },
	["coach"] = { ['name'] = "Coach", ['price'] = 1000, ['tipo'] = "work" },
	["bus"] = { ['name'] = "Ônibus", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed"] = { ['name'] = "Reboque", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck"] = { ['name'] = "Towtruck", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck2"] = { ['name'] = "Towtruck2", ['price'] = 1000, ['tipo'] = "work" },
	["ratloader"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["ratloader2"] = { ['name'] = "Ratloader2", ['price'] = 1000, ['tipo'] = "work" },
	["rubble"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["taxi"] = { ['name'] = "Taxi", ['price'] = 1000, ['tipo'] = "work" },
	["boxville4"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["trash2"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["tiptruck"] = { ['name'] = "Tiptruck", ['price'] = 1000, ['tipo'] = "work" },
	["scorcher"] = { ['name'] = "Scorcher", ['price'] = 1000, ['tipo'] = "work" },
	["tribike"] = { ['name'] = "Tribike", ['price'] = 1000, ['tipo'] = "work" },
	["tribike2"] = { ['name'] = "Tribike2", ['price'] = 1000, ['tipo'] = "work" },
	["tribike3"] = { ['name'] = "Tribike3", ['price'] = 1000, ['tipo'] = "work" },
	["fixter"] = { ['name'] = "Fixter", ['price'] = 1000, ['tipo'] = "work" },
	["cruiser"] = { ['name'] = "Cruiser", ['price'] = 1000, ['tipo'] = "work" },
	["bmx"] = { ['name'] = "Bmx", ['price'] = 1000, ['tipo'] = "work" },
	["dinghy"] = { ['name'] = "Dinghy", ['price'] = 1000, ['tipo'] = "work" },
	["jetmax"] = { ['name'] = "Jetmax", ['price'] = 1000, ['tipo'] = "work" },
	["marquis"] = { ['name'] = "Marquis", ['price'] = 1000, ['tipo'] = "work" },
	["seashark3"] = { ['name'] = "Seashark3", ['price'] = 1000, ['tipo'] = "work" },
	["speeder"] = { ['name'] = "Speeder", ['price'] = 1000, ['tipo'] = "work" },
	["speeder2"] = { ['name'] = "Speeder2", ['price'] = 1000, ['tipo'] = "work" },
	["squalo"] = { ['name'] = "Squalo", ['price'] = 1000, ['tipo'] = "work" },
	["suntrap"] = { ['name'] = "Suntrap", ['price'] = 1000, ['tipo'] = "work" },
	["toro"] = { ['name'] = "Toro", ['price'] = 1000, ['tipo'] = "work" },
	["toro2"] = { ['name'] = "Toro2", ['price'] = 1000, ['tipo'] = "work" },
	["tropic"] = { ['name'] = "Tropic", ['price'] = 1000, ['tipo'] = "work" },
	["tropic2"] = { ['name'] = "Tropic2", ['price'] = 1000, ['tipo'] = "work" },
	["phantom"] = { ['name'] = "Phantom", ['price'] = 1000, ['tipo'] = "work" },
	["packer"] = { ['name'] = "Packer", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito"] = { ['name'] = "Supervolito", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito2"] = { ['name'] = "Supervolito2", ['price'] = 1000, ['tipo'] = "work" },
	["cuban800"] = { ['name'] = "Cuban800", ['price'] = 1000, ['tipo'] = "work" },
	["mammatus"] = { ['name'] = "Mammatus", ['price'] = 1000, ['tipo'] = "work" },
	["vestra"] = { ['name'] = "Vestra", ['price'] = 1000, ['tipo'] = "work" },
	["velum2"] = { ['name'] = "Velum2", ['price'] = 1000, ['tipo'] = "work" },
	["buzzard2"] = { ['name'] = "Buzzard2", ['price'] = 1000, ['tipo'] = "work" },
	["frogger"] = { ['name'] = "Frogger", ['price'] = 1000, ['tipo'] = "work" },
	["maverick"] = { ['name'] = "Maverick", ['price'] = 1000, ['tipo'] = "work" },
	["tanker2"] = { ['name'] = "Gas", ['price'] = 1000, ['tipo'] = "work" },
	["armytanker"] = { ['name'] = "Diesel", ['price'] = 1000, ['tipo'] = "work" },
	["tvtrailer"] = { ['name'] = "Show", ['price'] = 1000, ['tipo'] = "work" },
	["trailerlogs"] = { ['name'] = "Woods", ['price'] = 1000, ['tipo'] = "work" },
	["tr4"] = { ['name'] = "Cars", ['price'] = 1000, ['tipo'] = "work" },
	["speedo"] = { ['name'] = "Speedo", ['price'] = 200000, ['tipo'] = "work" },
	["primo2"] = { ['name'] = "Primo2", ['price'] = 200000, ['tipo'] = "work" },
	["faction2"] = { ['name'] = "Faction2", ['price'] = 200000, ['tipo'] = "work" },
	["chino2"] = { ['name'] = "Chino2", ['price'] = 200000, ['tipo'] = "work" },
	["tornado5"] = { ['name'] = "Tornado5", ['price'] = 200000, ['tipo'] = "work" },
	["daemon"] = { ['name'] = "Daemon", ['price'] = 200000, ['tipo'] = "work" },
	["sanctus"] = { ['name'] = "Sanctus", ['price'] = 200000, ['tipo'] = "work" },
	["gburrito"] = { ['name'] = "GBurrito", ['price'] = 200000, ['tipo'] = "work" },
	["slamvan2"] = { ['name'] = "Slamvan2", ['price'] = 200000, ['tipo'] = "work" },
	["stafford"] = { ['name'] = "Stafford", ['price'] = 200000, ['tipo'] = "work" },
	["cog55"] = { ['name'] = "Cog55", ['price'] = 200000, ['tipo'] = "work" },
	["superd"] = { ['name'] = "Superd", ['price'] = 200000, ['tipo'] = "work" },
	["btype"] = { ['name'] = "Btype", ['price'] = 200000, ['tipo'] = "work" },
	["tractor2"] = { ['name'] = "Tractor2", ['price'] = 1000, ['tipo'] = "work" },
	["rebel"] = { ['name'] = "Rebel", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed3"] = { ['name'] = "flatbed3", ['price'] = 1000, ['tipo'] = "work" },
	["volatus"] = { ['name'] = "Volatus", ['price'] = 1000000, ['tipo'] = "work" },
	["sprinter1"] = { ['name'] = "Sprinter", ['price'] = 1000, ['tipo'] = "work" },
	["zendrack"] = { ['name'] = "Zendrack", ['price'] = 1000, ['tipo'] = "work" },
	["cargobob2"] = { ['name'] = "Cargo Bob", ['price'] = 1000000, ['tipo'] = "work" },		
	

	---IMPORTADOS ATT

	-- TUNERS
	["sultan3"] = { ['name'] = "Sultan3", ['price'] =  3000000, ['tipo'] = "import" },
	["cypher"] = { ['name'] = "Cypher", ['price'] =  2900000, ['tipo'] = "import" },
	["jester4"] = { ['name'] = "Jester4", ['price'] =  2500000, ['tipo'] = "import" },
	["comet6"] = { ['name'] = "Comet6", ['price'] =  2900000, ['tipo'] = "import" },
	["zr350"] = { ['name'] = "Zr350", ['price'] =  2000000, ['tipo'] = "import" },
	["calico"] = { ['name'] = "Calico", ['price'] =  1900000, ['tipo'] = "import" },
	["euros"] = { ['name'] = "Euros", ['price'] =  2500000, ['tipo'] = "import" },
	["growler"] = { ['name'] = "Growler", ['price'] =  1900000, ['tipo'] = "import" },
	["rt3000"] = { ['name'] = "Rt3000", ['price'] =  3500000, ['tipo'] = "import" },
	-- CAYO PERICO
	["jugular"] = { ['name'] = "Jugular", ['price'] =  4000000, ['tipo'] = "import" },
	["sultan2"] = { ['name'] = "Sultan2", ['price'] =  1900000, ['tipo'] = "import" },
	["emerus"] = { ['name'] = "Emerus", ['price'] =  6050000, ['tipo'] = "import" },
	["furia"] = { ['name'] = "Furia", ['price'] =  690000, ['tipo'] = "import" },
	["krieger"] = { ['name'] = "Krieger", ['price'] =  500000, ['tipo'] = "import" },
	["thrax"] = { ['name'] = "Thrax", ['price'] =  2000000, ['tipo'] = "import" },
	["rebla"] = { ['name'] = "Rebla", ['price'] =  4000000, ['tipo'] = "import" },

	["stryder"] = { ['name'] = "Stryder", ['price'] =  270000, ['tipo'] = "motos" },
	["manchez2"] = { ['name'] = "Manchez2", ['price'] =  120000, ['tipo'] = "motos" },
	["verus"] = { ['name'] = "Verus", ['price'] =  170000, ['tipo'] = "motos" },

	["kanjo"] = { ['name'] = "Kanjo", ['price'] =  37000, ['tipo'] = "carros" },
	["asbo"] = { ['name'] = "Asbo", ['price'] =  30000, ['tipo'] = "carros" },
	["club"] = { ['name'] = "Club", ['price'] =  20000, ['tipo'] = "carros" },
	["brioso2"] = { ['name'] = "Brioso2", ['price'] =  10000, ['tipo'] = "carros" },
	["weevil"] = { ['name'] = "Weevil", ['price'] =  12000, ['tipo'] = "carros" },
	["rrocket"] = { ['name'] = "Rrocket", ['price'] =  250000, ['tipo'] = "carros" },
	["gauntlet3"] = { ['name'] = "Gauntlet3", ['price'] =  250000, ['tipo'] = "carros" },
	["gauntlet4"] = { ['name'] = "Gauntlet4", ['price'] =  400000, ['tipo'] = "carros" },
	["gauntlet5"] = { ['name'] = "Gauntlet5", ['price'] =  290000, ['tipo'] = "carros" },
	["yosemite2"] = { ['name'] = "Yosemite2", ['price'] =  127000, ['tipo'] = "carros" },
	["yosemite3"] = { ['name'] = "Yosemite3", ['price'] =  190000, ['tipo'] = "carros" },
	["caracara2"] = { ['name'] = "Caracara2", ['price'] =  450000, ['tipo'] = "carros" },
	["everon"] = { ['name'] = "Everon", ['price'] =  460000, ['tipo'] = "carros" },
	["hellion"] = { ['name'] = "Hellion", ['price'] =  90000, ['tipo'] = "carros" },
	["outlaw"] = { ['name'] = "Outlaw", ['price'] =  50000, ['tipo'] = "carros" },
	["vagrant"] = { ['name'] = "Vagrant", ['price'] =  99000, ['tipo'] = "carros" },
	["winky"] = { ['name'] = "Winky", ['price'] =  120000, ['tipo'] = "carros" },
	["landstalker2"] = { ['name'] = "Landstalker2", ['price'] =  400000, ['tipo'] = "carros" },
	["novak"] = { ['name'] = "Novak", ['price'] =  400000, ['tipo'] = "carros" },
	["seminole2"] = { ['name'] = "Seminole2", ['price'] =  10000, ['tipo'] = "carros" },
	["glendale2"] = { ['name'] = "Glendale2", ['price'] =  370000, ['tipo'] = "carros" },
	["coquette4"] = { ['name'] = "Coquette4", ['price'] =  550000, ['tipo'] = "carros" },
	["drafter"] = { ['name'] = "Drafter", ['price'] =  400000, ['tipo'] = "carros" },
	["komoda"] = { ['name'] = "Komoda", ['price'] =  570000, ['tipo'] = "carros" },
	["imorgon"] = { ['name'] = "Imorgon", ['price'] =  380000, ['tipo'] = "carros" },
	["issi7"] = { ['name'] = "Issi7", ['price'] =  100000, ['tipo'] = "carros" },
	["locust"] = { ['name'] = "Locust", ['price'] =  200000, ['tipo'] = "carros" },
	["neo"] = { ['name'] = "Neo", ['price'] =  550000, ['tipo'] = "carros" },
	["paragon"] = { ['name'] = "Paragon", ['price'] =  650000, ['tipo'] = "carros" },
	["penumbra2"] = { ['name'] = "Penumbra2", ['price'] =  500000, ['tipo'] = "carros" },
	["sugoi"] = { ['name'] = "Sugoi", ['price'] =  540000, ['tipo'] = "carros" },
	["vstr"] = { ['name'] = "Vstr", ['price'] =  350000, ['tipo'] = "carros" },
	["veto"] = { ['name'] = "Veto", ['price'] =  10000, ['tipo'] = "carros" },
	["veto2"] = { ['name'] = "Veto2", ['price'] =  10000, ['tipo'] = "carros" },
	["peyote3"] = { ['name'] = "Peyote3", ['price'] =  103000, ['tipo'] = "carros" },
	["retinue2"] = { ['name'] = "Retinue2", ['price'] =  100000, ['tipo'] = "carros" },
	["nebula"] = { ['name'] = "Nebula", ['price'] =  10000, ['tipo'] = "carros" },
	["zion3"] = { ['name'] = "Zion3", ['price'] =  19000, ['tipo'] = "carros" },
	["s80"] = { ['name'] = "S80", ['price'] =  490000, ['tipo'] = "carros" },
	["tigon"] = { ['name'] = "Tigon", ['price'] =  1200000, ['tipo'] = "carros" },
	["zorrusso"] = { ['name'] = "Zorrusso", ['price'] =  1200000, ['tipo'] = "carros" },
	["youga3"] = { ['name'] = "Youga3", ['price'] =  890000, ['tipo'] = "carros" },
	["slamtruck"] = { ['name'] = "Slamtruck", ['price'] =  1000, ['tipo'] = "work" },
	
	--IMPORTADOS
	["bmci"] = { ['name'] = "BMW M5 F90", ['price'] = 5000000, ['tipo'] = "import" },
	["bmwm4gts"] = { ['name'] = "BMW M4 GTS", ['price'] = 5000000, ['tipo'] = "import" },
	["audirs7"] = { ['name'] = "Audi RS7", ['price'] = 5000000, ['tipo'] = "import" },

	["f800"] = { ['name'] = "BMW F800", ['price'] = 5000000, ['tipo'] = "import" },
	["mazdarx7"] = { ['name'] = "Mazda RX7", ['price'] = 3500000, ['tipo'] = "import" },
	["bmwi8"] = { ['name'] = "BMW I8", ['price'] = 5000000, ['tipo'] = "import" },
	["h2carb"] = { ['name'] = "Kawasaki H2R", ['price'] = 5000000, ['tipo'] = "import" },
	["r1"] = { ['name'] = "Yamaha R1", ['price'] = 5000000, ['tipo'] = "import" },
	["r6"] = { ['name'] = "Yamaha R6", ['price'] = 5000000, ['tipo'] = "import" },
	["765lt"] = { ['name'] = "McLaren 765LT", ['price'] = 5000000, ['tipo'] = "import" },
	["brz13"] = { ['name'] = "Subaru STI", ['price'] = 5000000, ['tipo'] = "import" },
	["rmodx6"] = { ['name'] = "BMW X6", ['price'] = 5000000, ['tipo'] = "import" },
	["gt2rsmr"] = { ['name'] = "Porsche 911 GT2 RS", ['price'] = 5000000, ['tipo'] = "import" },
	["africat"] = { ['name'] = "Honda CRF 1000", ['price'] = 5000000, ['tipo'] = "import" },
	["mlnovitec"] = { ['name'] = "Maserati Novitec", ['price'] = 5000000, ['tipo'] = "import" },
	["toyotasupra"] = { ['name'] = "Toyota Supra", ['price'] = 5000000, ['tipo'] = "import" },

	--EXCLUSIVE
	["porschewaze"] = { ['name'] = "911 Porsche", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xnsgt"] = { ['name'] = "Hennessey Venom GT", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lamborghinihuracan"] = { ['name'] = "Lamborghini Huracan", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pcx"] = { ['name'] = "Yamaha Xmax", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["f8t"] = { ['name'] = "Ferrari F8 Tributo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["golfgti7"] = { ['name'] = "Golf GTI MK7", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lancerevolutionx"] = { ['name'] = "Lancer Evolution X", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cbr1000rrr"] = { ['name'] = "CBR 1000 RRR", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["mercedesgt63"] = { ['name'] = "Mercedes AMG GT 63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r820"] = { ['name'] = "Audi R8 2020", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["teslaprior"] = { ['name'] = "Tesla Prior", ['price'] = 1000000, ['tipo'] = "exclusive" },	
	["gs1200"] = { ['name'] = "BMW GS 1200", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xt700"] = { ['name'] = "Yamaha XT-700", ['price'] = 1000000, ['tipo'] = "exclusive" },	
	["nissangtr"] = { ['name'] = "Nissan GTR 2017", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["amggt63s"] = { ['name'] = "Mercedes AMG GT 63", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissanskylinerocket"] = { ['name'] = "Nissan Skyline Rocket", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissanskyliner34"] = { ['name'] = "Nissan Skyline R34", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["tiger"] = { ['name'] = "Triumph Tiger 800", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pturismo"] = { ['name'] = "Porsche Panamera", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pcs18"] = { ['name'] = "Porsche Cayenne", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["amarok"] = { ['name'] = "Volkswagen Amarok", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ben17"] = { ['name'] = "Bentley Super Sport", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmwm8"] = { ['name'] = "BMW M8", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cb500x"] = { ['name'] = "Honda CB 500X", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lancerevolution9"] = { ['name'] = "Lancer Evolution 09", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["urus"] = { ['name'] = "Lamborghini Urus", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmwm3e36"] = { ['name'] = "BMW M3 E36", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ferrarif12"] = { ['name'] = "Ferrari F12", ['price'] = 1000000, ['tipo'] = "exclusive" },
	--Att dia 28/11/2021
	["xadv"] = { ['name'] = "PCX Cross", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lp610"] = { ['name'] = "Lamborghini Huracan Spyder", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["745le"] = { ['name'] = "BMW 745 LE", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pts21"] = { ['name'] = "Porsche Turbo S", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rs62"] = { ['name'] = "Audi RS6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["19gt500"] = { ['name'] = "Ford Mustang", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["22g63"] = { ['name'] = "Mercedes G63 AMG", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["jettagli"] = { ['name'] = "Volkswagen Jetta Gli", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["l200"] = { ['name'] = "L200 Triton HPES", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["xj6"] = { ['name'] = "Yamaha XJ6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gxa45"] = { ['name'] = "Mercedes A45S", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ocnetrongt"] = { ['name'] = "Audi Etron Gt", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["contgt20c"] = { ['name'] = "Bentley Continental GT", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["skyline"] = { ['name'] = "Nissan Skyline R34", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["sw4"] = { ['name'] = "Toyota Sw4", ['price'] = 1000000, ['tipo'] = "exclusive" },
	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleGlobal()
	return vehglobal
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleName(vname)
	return vehglobal[vname].name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEPRICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehiclePrice(vname)
	return vehglobal[vname].price
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleType(vname)
	return vehglobal[string.lower(tostring(vname))].tipo
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VAR : ANTI MULTI OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
local OpenedChest = {}

function vRP.DupOpenChest(chest, user_id)
    OpenedChest[chest] = user_id
    print('^4[!] ^0Abrindo ^4' .. chest .. ' ^0no ID ^4' .. user_id)
end

function vRP.DupCheckChest(chest, nuser_id)
    if chest ~= '' then
        if OpenedChest[chest] then
            print('^4[!] ^0Checando ^4' .. chest .. ' ^0no ID ^4' .. nuser_id .. ' ^0- ID aberto: ^4' .. OpenedChest[chest])
            if OpenedChest[chest] == nuser_id then
                return true
            end
        end
    end
    return false
end