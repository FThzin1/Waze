local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vSERVER = Tunnel.getInterface("waze_roubos")

src = {}
Tunnel.bindInterface("waze_roubos", src)
---------------------------------------------------------------------------------------------------------
-- CONFIG
---------------------------------------------------------------------------------------------------------
local Config = {
    ['Mercado 2/20 do Sul'] = { -- Nome do estabelecimento Mercado 2
        ['x'] = 2549.26, ['y'] = 384.78, ['z'] = 108.63, ['h'] = 85.48, -- Posição 2549.26,384.78,108.63
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 3/20 do Sul'] = { -- Nome do estabelecimento Mercado 3
        ['x'] = 1159.58, ['y'] = -314.14, ['z'] = 69.21, ['h'] = 101.47, -- Posição 1159.58,-314.14,69.21
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 4/20 do Sul'] = { -- Nome do estabelecimento Mercado 4
        ['x'] = -709.68, ['y'] = -904.07, ['z'] = 19.22, ['h'] = 89.02, -- Posição -709.68,-904.07,19.22
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 5/20 do Sul'] = { -- Nome do estabelecimento Mercado 5
        ['x'] = -43.37, ['y'] = -1748.36, ['z'] = 29.43, ['h'] = 45.52, -- Posição -43.37,-1748.36,29.43
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 6/20 do Sul'] = { -- Nome do estabelecimento Mercado 6
        ['x'] = 378.26, ['y'] = 333.38, ['z'] = 103.57, ['h'] = 339.76, -- Posição 378.26,333.38,103.57
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 7/20 do Sul'] = { -- Nome do estabelecimento Mercado 7
        ['x'] = -3250.07, ['y'] = 1004.49, ['z'] = 12.84, ['h'] = 82.34, -- Posição -3250.07,1004.49,12.84
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 8/20 do Norte'] = { -- Nome do estabelecimento Mercado 8
        ['x'] = 1734.9, ['y'] = 6420.79, ['z'] = 35.04, ['h'] = 330.07, -- Posição 1734.9,6420.79,35.04
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 9/20 do Norte'] = { -- Nome do estabelecimento Mercado 9
        ['x'] = 546.37, ['y'] = 2662.84, ['z'] = 42.16, ['h'] = 187.001, -- Posição 546.37,2662.84,42.16
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 10/20 do Norte'] = { -- Nome do estabelecimento Mercado 10
        ['x'] = 1959.39, ['y'] = 3748.94, ['z'] = 32.35, ['h'] = 25.76, -- Posição 1959.39,3748.94,32.35
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 11/20 do Norte'] = { -- Nome do estabelecimento Mercado 11
        ['x'] = 2672.83, ['y'] = 3286.65, ['z'] = 55.25, ['h'] = 51.30, -- Posição 2672.83,3286.65,55.25
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 12/20 do Norte'] = { -- Nome do estabelecimento Mercado 12 
        ['x'] = 1707.88, ['y'] = 4920.41, ['z'] = 42.07, ['h'] = 327.51, -- Posição 1707.88,4920.41,42.07
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 13/20 do Sul'] = { -- Nome do estabelecimento Mercado 13
        ['x'] = -1829.13, ['y'] = 798.78, ['z'] = 138.2, ['h'] = 126.05, -- Posição -1829.13,798.78,138.2
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Loja de bebidas 2/5 do Sul'] = { -- Nome do estabelecimento Loja de Bebidas 2
        ['x'] = -2959.59, ['y'] = 387.15, ['z'] = 14.05, ['h'] = 168.66, -- Posição -2959.59,387.15,14.05
        ['TempoRoubo'] = 80,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,140000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BebidaSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Mercado 16/20 do Sul'] = { -- Nome do estabelecimento Mercado 16
        ['x'] = -3047.91, ['y'] = 585.74, ['z'] = 7.91, ['h'] = 110.44, -- Posição -3047.91,585.74,7.91
        ['TempoRoubo'] = 120,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(150000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MercadoSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Loja de bebidas 4/5 do Sul'] = { -- Nome do estabelecimento Loja de Bebidas 4
        ['x'] = 1126.87, ['y'] = -980.14, ['z'] = 45.42, ['h'] = 8.67, -- Posição 1126.87,-980.14,45.42
        ['TempoRoubo'] = 80,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,140000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BebidaSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Loja de bebidas 3/5 do Norte'] = { -- Nome do estabelecimento Loja de Bebidas 3
        ['x'] = 1169.3, ['y'] = 2717.75, ['z'] = 37.16, ['h'] = 266.23, -- Posição 1169.3,2717.75,37.16
        ['TempoRoubo'] = 80,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,140000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BebidaNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Loja de bebidas 5/5 do Sul'] = { -- Nome do estabelecimento Loja de Bebidas 5
        ['x'] = -1478.98, ['y'] = -375.55, ['z'] = 39.17, ['h'] = 226.18, -- Posição -1478.98,-375.55,39.17
        ['TempoRoubo'] = 80,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,140000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BebidaSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Loja de bebidas 1/5 do Sul'] = { -- Nome do estabelecimento Loja de Bebidas 5
        ['x'] = -1220.83, ['y'] = -915.93, ['z'] = 11.33, ['h'] = 121.12, -- Posição -1220.83,-915.93,11.33
        ['TempoRoubo'] = 80,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,120000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BebidaSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Norte 1/11'] = { -- Nome do estabelecimento Ammunation 1
        ['x'] = 1693.12, ['y'] = 3762.0, ['z'] = 34.71, ['h'] = 225.96, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 90,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Norte 4/11'] = { -- Nome do estabelecimento Ammunation 4
        ['x'] = -330.8, ['y'] = 6085.94, ['z'] = 31.46, ['h'] = 228.74, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 90,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Norte 7/11'] = { -- Nome do estabelecimento Ammunation 7
        ['x'] = -1118.15, ['y'] = 2700.75, ['z'] = 18.56, ['h'] = 219.94, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 90,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Norte 8/11'] = { -- Nome do estabelecimento Ammunation 8
        ['x'] = 2566.65, ['y'] = 292.51, ['z'] = 108.74, ['h'] = 356.02, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 90,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Norte 9/11'] = { -- Nome do estabelecimento Ammunation 9
        ['x'] = -3173.13, ['y'] = 1089.62, ['z'] = 20.84, ['h'] = 250.12, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 90,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Sul 2/11'] = { -- Nome do estabelecimento Ammunation 2
        ['x'] = 253.53, ['y'] = -51.75, ['z'] = 69.95, ['h'] = 64.84, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 90,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Sul 3/11'] = { -- Nome do estabelecimento Ammunation 3
        ['x'] = 841.02, ['y'] = -1035.41, ['z'] = 28.2, ['h'] = 350.73, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 90,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Sul 5/11'] = { -- Nome do estabelecimento
        ['x'] = -661.02, ['y'] = -933.44, ['z'] = 21.83, ['h'] = 179.32, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 90,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Sul 6/11'] = { -- Nome do estabelecimento Ammunation 6
        ['x'] = -1304.3, ['y'] = -395.85, ['z'] = 36.7, ['h'] = 74.02, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 90,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Sul 10/11'] = { -- Nome do estabelecimento Ammunation 10
        ['x'] = 23.83, ['y'] = -1105.86, ['z'] = 29.8, ['h'] = 163.49, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 65,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Sul 11/11'] = { -- Nome do estabelecimento Ammunation 11
        ['x'] = 808.94, ['y'] = -2159.18, ['z'] = 29.62, ['h'] = 356.63, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 65,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Barbearia Sul 1/7'] = { -- Nome do estabelecimento Barbearia 1
        ['x'] = -822.02, ['y'] = -183.29, ['z'] = 37.57, ['h'] = 208.59, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(30000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BarbeSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Barbearia Sul 2/7'] = { -- Nome do estabelecimento Barbearia 2
        ['x'] = 134.45, ['y'] = -1707.76, ['z'] = 29.3, ['h'] = 137.39, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(30000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BarbeSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Barbearia Sul 3/7'] = { -- Nome do estabelecimento Barbearia 3
        ['x'] = -1284.15, ['y'] = -1115.09, ['z'] = 7.0, ['h'] = 93.56, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(30000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BarbeSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Barbearia Norte 4/7'] = { -- Nome do estabelecimento Barbearia 4
        ['x'] = 1930.57, ['y'] = 3728.04, ['z'] = 32.85, ['h'] = 207.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(30000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BarbeNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Barbearia Sul 5/7'] = { -- Nome do estabelecimento Barbearia 5
        ['x'] = 1211.46, ['y'] = -470.61, ['z'] = 66.21, ['h'] = 24.23, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(30000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BarbeSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Barbearia Sul 6/7'] = { -- Nome do estabelecimento Barbearia 6
        ['x'] = -30.54, ['y'] = -151.87, ['z'] = 57.08, ['h'] = 324.1, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(30000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BarbeSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Barbearia Norte 7/7'] = { -- Nome do estabelecimento Barbearia 7
        ['x'] = -277.71, ['y'] = 6230.63, ['z'] = 31.7, ['h'] = 48.08, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(30000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BarbeNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Teatro'] = { -- Nome do estabelecimento
        ['x'] = -1117.16, ['y'] = -503.12, ['z'] = 35.81, ['h'] = 119.74, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(120000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Teatro', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 11,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Prefeitura'] = { -- Nome do estabelecimento Prefeitura
        ['x'] = 2469.38, ['y'] = -420.0, ['z'] = 93.4, ['h'] = 271.4, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(260000,520000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Prefeitura', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 10,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Porto'] = { -- Nome do estabelecimento Porto
        ['x'] = 247.69, ['y'] = -3315.71, ['z'] = 5.8, ['h'] = 2.56, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(240000,320000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Porto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1400,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 12,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 18,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Fazenda'] = { -- Nome do estabelecimento Fazenda
        ['x'] = 1459.92, ['y'] = 1133.96, ['z'] = 114.33, ['h'] = 128.29, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(200000,290000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fazenda', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 16,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Observatório'] = { -- Nome do estabelecimento Observatorio
        ['x'] = 670.66, ['y'] = 581.14, ['z'] = 130.47, ['h'] = 254.06, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(250000,450000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Observatorio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 10,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 16,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Moto club do Norte'] = { -- Nome do estabelecimento Moto club do Norte
        ['x'] = 66.61, ['y'] = 3726.71, ['z'] = 39.72, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 170,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(200000,400000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'McNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 2000,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'norte'
    },
    ['Moto club do Sul'] = { -- Nome do estabelecimento Moto club do Sul
        ['x'] = 978.63, ['y'] = -91.92, ['z'] = 74.85, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 120,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(200000,400000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'McSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1300,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Bar Hookies'] = { -- Nome do estabelecimento Bar Hookies
        ['x'] = -2195.12, ['y'] = 4288.74, ['z'] = 49.18, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(90000,110000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BarHookies', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1400,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 4,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Aeroporto Abandonado'] = { -- Nome do estabelecimento Aeroporto Abandonado
        ['x'] = 2403.72, ['y'] = 3128.07, ['z'] = 48.16, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(100000,150000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AeroAbandonado', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1800,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Industria'] = { -- Nome do estabelecimento Industria
        ['x'] = 2748.32, ['y'] = 1453.84, ['z'] = 24.5, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(200000,270000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Industria', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 2000,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Vinhedo'] = { -- Nome do estabelecimento Vinhedo
        ['x'] = -1886.55, ['y'] = 2050.35, ['z'] = 140.99, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(120000,240000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Vinhedo', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Universidade'] = { -- Nome do estabelecimento Universidade
        ['x'] = -1667.55, ['y'] = 189.7, ['z'] = 61.76, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 120,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(180000,230000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Universidade', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1400,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Galpão'] = { -- Nome do estabelecimento Galpao
        ['x'] =  589.5, ['y'] = -468.68, ['z'] = 24.75, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 120,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(180000,230000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Galpao', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1400,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Joalheria'] = { -- Nome do estabelecimento Joalheria
        ['x'] = -631.37, ['y'] = -230.1, ['z'] = 38.06, ['h'] = 212.57, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 600,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(400000,600000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Joalheria', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 5500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 12,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Açougue do Sul'] = { -- Nome do estabelecimento Acougue
        ['x'] = 968.74, ['y'] = -2160.42, ['z'] = 29.48, ['h'] = 79.52, -- Posição 968.74,-2160.42,29.48
        ['TempoRoubo'] = 160,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(200000,350000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AçougueSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 2000,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 11,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 16,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Pista de Pouso Trevor'] = { -- Nome do estabelecimento Pista de Pouso do Trevor
        ['x'] = 1700.93, ['y'] = 3293.71, ['z'] = 48.93, ['h'] = 298.85, -- Posição
        ['TempoRoubo'] = 120,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(150000,280000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AeroTrevor', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Resort'] = { -- Nome do estabelecimento Resort
        ['x'] = -2953.17, ['y'] = 49.19, ['z'] = 11.61, ['h'] = 155.99, -- Posição
        ['TempoRoubo'] = 120,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(150000,280000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Resort', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1800,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 10,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 16,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Fort Zancudo'] = { -- Nome do estabelecimento Fort Zancudo
        ['x'] = -2357.13, ['y'] = 3251.32, ['z'] = 101.46, ['h'] = 149.3, -- Posição
        ['TempoRoubo'] = 160,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(250000,450000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Zancudo', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 5100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 20,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 22,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Reserva Nacional de Niobio'] = { -- Nome do estabelecimento Reserva Nacional de Niobio
        ['x'] = 3536.93, ['y'] = 3668.57, ['z'] = 28.13, ['h'] = 353.41, -- Posição
        ['TempoRoubo'] = 900,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(2500000,3000000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Niobio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 9999999999,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 13,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 24,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Vanilla'] = { -- Nome do estabelecimento Vanilla
        ['x'] = 95.41, ['y'] = -1293.36, ['z'] = 29.28, ['h'] = 303.1, -- Posição
        ['TempoRoubo'] = 100,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(130000,240000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Vanilla', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Delegacia de Paleto'] = { -- Nome do estabelecimento Delegacia de Paleto
        ['x'] = -450.81, ['y'] = 6011.2, ['z'] = 31.72, ['h'] = 135.86, -- Posição -450.81,6011.2,31.72
        ['TempoRoubo'] = 350,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(180000,310000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'DelegaciaNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 5100,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 14,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 16,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Yellow Jack Bar'] = { -- Nome do estabelecimento Yellow Jack Bar
        ['x'] = 1982.39, ['y'] = 3053.46, ['z'] = 47.22, ['h'] = 60.72, -- Posição 1982.39,3053.46,47.22
        ['TempoRoubo'] = 180,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(150000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Yellow', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Comedy Club'] = { -- Nome do estabelecimento Comedy Club
        ['x'] = -424.62, ['y'] = 284.1, ['z'] = 83.2, ['h'] = 82.21, -- Posição
        ['TempoRoubo'] = 90, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(111263,234857), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'ComedyClub', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1300,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'
    },
    ['Millars Boat'] = { -- Nome do estabelecimento Millars Boat
        ['x'] = 1308.84, ['y'] = 4362.02, ['z'] = 41.55, ['h'] = 258.08, -- Posição
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(90000,120000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MillarsBoat', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1066,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Pier'] = { -- Nome do estabelecimento Pier
        ['x'] = -1645.59, ['y'] = -1078.5, ['z'] = 13.16, ['h'] = 70.45, -- Posição
        ['TempoRoubo'] = 182, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(182936,280805), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Pier', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 863,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Liquors Ace'] = { -- Nome do estabelecimento Liquors Ace 
        ['x'] = 1395.3, ['y'] = 3614.04, ['z'] = 35.02, ['h'] = 10.56, -- Posição
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(90000, 110000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'LiquorsAce', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1158,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },  
    ['Madeireira'] = { -- Nome do estabelecimento Madeireira
        ['x'] = -560.65, ['y'] = 5282.74, ['z'] = 73.06, ['h'] = 346.56, -- Posição
        ['TempoRoubo'] = 150, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(184892,244789), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Madeireira', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 832,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Delegacia de Sandy Shores'] = { -- Nome do estabelecimento Delegacia de Sandy Shores
        ['x'] = 1849.94, ['y'] = 3686.25, ['z'] = 34.27, ['h'] = 140.99, -- Posição
        ['TempoRoubo'] = 150, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000,290000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'DelegaciaSandy', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1108,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 10,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 12, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Bayview Lodge'] = { -- Nome do estabelecimento Bayview Lodge
        ['x'] = -695.53, ['y'] = 5802.28, ['z'] = 17.34, ['h'] = 230.48, -- Posição
        ['TempoRoubo'] = 171, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(182082,231391), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BayviewLodge', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 858,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Pink Hotel'] = { -- Nome do estabelecimento Pink Hotel
        ['x'] = -1306.15, ['y'] = 336.28, ['z'] = 65.51, ['h'] = 218.26, -- Posição
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(177580,211148), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'PinkHotel', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Highway'] = { -- Nome do estabelecimento Flecca Bank Highway
        ['x'] = -2956.37, ['y'] = 482.00, ['z'] = 15.69, ['h'] = 357.97, -- Posição
        ['TempoRoubo'] = 150, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 13,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Center'] = { -- Nome do estabelecimento Fleeca Bank Center']
        ['x'] = 147.16, ['y'] = -1046.36, ['z'] = 29.36, ['h'] = 247.07, -- Posição
        ['TempoRoubo'] = 150, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 13,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Top'] = { -- Nome do estabelecimento Fleeca Bank Top
        ['x'] = -1210.38, ['y'] = -336.55, ['z'] = 37.79, ['h'] = 297.11, -- Posição
        ['TempoRoubo'] = 150, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 13,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Paleto'] = { -- Nome do estabelecimento Fleeca Bank Paleto
        ['x'] = -104.0, ['y'] = 6477.61, ['z'] = 31.63, ['h'] = 137.43, -- Posição
        ['TempoRoubo'] = 150, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 13,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Banco Central'] = { -- Nome do estabelecimento Banco Central
        ['x'] = 264.48, ['y'] = 219.81, ['z'] = 101.69, ['h'] = 288.85, -- Posição
        ['TempoRoubo'] = 150, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(1900000,2500000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Central', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 3600,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 13,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Motocross'] = { -- Nome do estabelecimento Motocross
        ['x'] = 849.32, ['y'] = 2383.65, ['z'] = 54.16, ['h'] = 264.02, -- Posição
        ['TempoRoubo'] = 201, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(111695,287391), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Motocross', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 900,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 12,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Stay Frost'] = { -- Nome do estabelecimento Stay Frost
        ['x'] = 1075.35, ['y'] = -2330.57, ['z'] = 30.3, -- Posição
        ['TempoRoubo'] = 130, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(180085,241171), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'StayFrost ', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 869,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Estabulo'] = { -- Nome do estabelecimento Estabulo
        ['x'] = 1219.85, ['y'] = 333.3, ['z'] = 82.0, ['h'] = 291.57, -- Posição
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(141852,222725), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Estabulo', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1126,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Posto'] = { -- Nome do estabelecimento Posto
    	['x'] = 1200.38, ['y'] = -1277.13, ['z'] = 35.38, ['h'] = 169.99, -- Posição
    	['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
    	['Recompensa'] = math.random(170626,271194), -- Recompensa de dinheiro sujo no roubo
    	['TipoCooldown'] = 'Posto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
    	['Cooldown'] = 808,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
    	['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
    	['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
    	['MaxPoliciais'] = 7, 
    	['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
    	['Prioridade'] = 'sul' 
    },
    ['Barney'] = { -- Nome do estabelecimento Barney
        ['x'] = 2526.25, ['y'] = 2586.57, ['z'] = 38.76, ['h'] = 79.43, -- Posição
        ['TempoRoubo'] = 220, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(108973,254761), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Barney', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 843,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Mini Fazenda '] = { -- Nome do estabelecimento Mini Fazenda
        ['x'] = 803.25, ['y'] = 2174.99, ['z'] = 53.08, ['h'] = 146.71, -- Posição
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(163482,243143), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MiniFazenda', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 933,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Departamento Abandonado'] = { -- Nome do estabelecimento Departamento Abandonado
        ['x'] = 433.96, ['y'] = 3573.44, ['z'] = 33.24, ['h'] = 159.14, -- Posição
        ['TempoRoubo'] = 167, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(116007,285265), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'DepAbandonado ', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 981,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Auditorio'] = { -- Nome do estabelecimento Auditorio
        ['x'] = 185.03, ['y'] = 1214.12, ['z'] = 225.6, ['h'] = 24.83, -- Posição
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(114969,209352), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Auditorio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1014,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Rua Sem Fio'] = { -- Nome do estabelecimento Rua Sem Fim
        ['x'] = 1373.04, ['y'] = -569.0, ['z'] = 74.18, ['h'] = 290.13, -- Posição
        ['TempoRoubo'] = 194, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(106177,264204), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'RuasFio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 907,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Caixa da Água'] = { -- Nome do estabelecimento Caixa da Agua
        ['x'] = -99.44, ['y'] = -2231.79, ['z'] = 7.82, ['h'] = 29.5, -- Posição
        ['TempoRoubo'] = 130, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(126109,233363), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'CaixadAgua', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 938,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Mecanica Abandonada'] = { -- Nome do estabelecimento Mecanica Abandonada
        ['x'] = -1142.26, ['y'] = -1992.97, ['z'] = 13.17, ['h'] = 140.35, -- Posição
        ['TempoRoubo'] = 244, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(187504,284977), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MecAbandonada', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 965,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Shipping Services'] = { -- Nome do estabelecimento Shipping Services
        ['x'] = 182.01, ['y'] = 2780.33, ['z'] = 45.68, ['h'] = 11.64, -- Posição
        ['TempoRoubo'] = 156, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(189874,236288), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'ShippingServices', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 857,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Mansão da Playboy'] = { -- Nome do estabelecimento Roubo a Mansão da Playboy
        ['x'] = -1537.18, ['y'] = 130.9, ['z'] = 57.38, ['h'] = 303.39, -- Posição
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000 ,202581), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Playboy', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 817,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 12, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Hay Day'] = { -- Nome do estabelecimento Roubo ao Hay Day
        ['x'] = -50.22, ['y'] = 1911.1, ['z'] = 195.71, ['h'] = 272.35, -- Posição  
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(102444,277292), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'HayDay', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 855,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Parking Bilgeco'] = { -- Nome do estabelecimento Parking Bilgeco
        ['x'] = 1092.67, ['y'] = -2251.53, ['z'] = 31.24, ['h'] = 69.06, -- Posição
        ['TempoRoubo'] = 199, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(165292,277597), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'ParkingBilgeco', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 823,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Trailer Magic'] = { -- Nome do estabelecimento Trailer Magic
        ['x'] = 2336.14, ['y'] = 2566.63, ['z'] = 47.73, ['h'] = 64.79, -- Posição
        ['TempoRoubo'] = 150, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000,266262), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'TrailerMagic', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1133,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Auto Parts'] = { -- Nome do estabelecimento Auto Parts
        ['x'] = 820.37, ['y'] = -808.43, ['z'] = 26.4, ['h'] = 78.7, -- Posição
        ['TempoRoubo'] = 174, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(144431,230709), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AutoParts', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 926,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Palacio'] = { -- Nome do estabelecimento Palacio
        ['x'] = -406.63, ['y'] = 1086.3, ['z'] = 327.71, -- Posição  
        ['TempoRoubo'] = 140, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(130369,252097), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Palacio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 891,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'
    },
    ['Delegacia da Praca'] = { -- Nome do estabelecimento Delegacia Da Praca
        ['x'] = 442.0, ['y'] = -978.42, ['z'] = 30.7, ['h'] = 221.64, -- Posição  
        ['TempoRoubo'] = 174, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(300000,320000), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'DPdaPraca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 975,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 13,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Colheita'] = {-- Nome do estabelecimento Colheita
        ['x'] = -121.52, ['y'] = 1918.49, ['z'] = 197.34, ['h'] = 91.91, -- Posição  
        ['TempoRoubo'] = 160, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000,255594), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Colheita', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 820,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'
    },
    ['Estadio'] = { -- Nome do estabelecimento Estadio
        ['x'] = -244.18, ['y'] = -2028.77, ['z'] = 29.95, ['h'] = 54.91, -- Posição  
        ['TempoRoubo'] = 130, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(159008,228888), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Estadio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1067,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Festa Junina']={ -- Nome do estabelecimento Festa Junina
        ['x'] = 391.26, ['y'] = -355.98, ['z'] = 48.03, ['h'] = 64.84, -- Posição  
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(123969,228963), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'FestaJunina', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1161,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Dinossauro'] = { -- Nome do estabelecimento Dinossauro
        ['x'] = 2561.91, ['y'] = 2590.5, ['z'] = 38.09, -- Posição
        ['TempoRoubo'] = 150, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(220000,290000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Dinossauro', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'
	},
    ['Mansao'] = { -- Nome do estabelecimento Mansao
        ['x'] = -699.39, ['y'] = 47.2, ['z'] = 44.04, ['h'] = 19.03, -- Posição  
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(112398,272194), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Mansao', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 955,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Pista de Skate'] = { -- Nome do estabelecimento Pista de Skate
        ['x'] = -950.94, ['y'] = -720.36, ['z'] = 19.92, ['h'] = 357.15, -- Posição  
        ['TempoRoubo'] = 130, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(150100,222417), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'PistaSkate', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 886,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Mini Porto'] = { -- Nome do estabelecimento Mini Porto
        ['x'] = -424.25, ['y'] = -2789.88, ['z'] = 6.54, ['h'] = 143.94, -- Posição  
        ['TempoRoubo'] = 180, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(168841,226068), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'MiniPorto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1165,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Cypress'] = { -- Nome do estabelecimento Cypress
        ['x'] = 1019.19, ['y'] = -2511.57, ['z'] = 28.49, ['h'] = 265.24, -- Posição  
        ['TempoRoubo'] = 160, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(157939,239979), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Cypress', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 894,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    }, 
    ['Departamento de Cargas'] = { -- Nome do estabelecimento Departamento de Cargas
        ['x'] = 1197.16, ['y'] = -3253.57, ['z'] = 7.1, ['h'] = 268.72, -- Posição  
        ['TempoRoubo'] = 153, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(137669,226925), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'DepartamentoCargas', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1041,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Motel abandonado'] = { -- Nome do estabelecimento Motel abandonado
        ['x'] = 1508.29, ['y'] = 3560.82, ['z'] = 35.31, -- Posição  
        ['TempoRoubo'] = 153, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(137669,226925), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'motelabandonado', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1041,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Chafariz'] = { -- Nome do estabelecimento Chafariz
        ['x'] = -830.48, ['y'] = -420.34, ['z'] = 36.77, -- Posição  
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(130000,260000), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Chafariz', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1041,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Clube de Tenis'] = { -- Nome do estabelecimento Clube de Tenis
        ['x'] = 445.67, ['y'] = -223.23, ['z'] = 56.02, -- Posição  
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(137669,260000), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Clubedetenis', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1041,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Mini industria'] = { -- Nome do estabelecimento Mini industria
        ['x'] = 455.91, ['y'] = -1948.67, ['z'] = 24.72, -- Posição  
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000,300000), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Miniindustria', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1041,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fabrica'] = { -- Nome do estabelecimento Fabrica
        ['x'] = 282.75, ['y'] = 2845.17, ['z'] = 43.65, -- Posição  
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(160000,300000), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Fabrica', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1041,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 14, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['AladdinS Cave'] = { -- Nome do estabelecimento 
        ['x'] = 794.34, ['y'] = -102.75, ['z'] = 82.04, ['h'] = 333.92, -- Posição
        ['TempoRoubo'] = 95, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(170000,281824), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AladdinSCave', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1145,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    }, 
    ['Japão'] = { -- Nome do estabelecimento 
        ['x'] = -582.12, ['y'] = -1020.7, ['z'] = 22.33, ['h'] = 76.51, -- Posição
        ['TempoRoubo'] = 100, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000,300000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Japao', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 842,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Machine Maintenance'] = { -- Nome do estabelecimento 
        ['x'] = -671.84, ['y'] = -1185.69, ['z'] = 10.62, -- Posição
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000,286323), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MachineMaintenance ', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 873,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    }, 
    ['Hidrelétrica'] = { -- Nome do estabelecimento 
        ['x'] = 729.41, ['y'] = -1974.33, ['z'] = 29.3, ['h'] = 81.62, -- Posição
        ['TempoRoubo'] = 162, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(220000,282549), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Hidreletrica', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1083,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Lixão'] = { -- Nome do estabelecimento 
        ['x'] = -557.36, ['y'] = -1646.66, ['z'] = 19.16, ['h'] = 71.03, -- Posição
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(240000,274131), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Lixao', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1087,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Crastenburg Hotel'] = { -- Nome do estabelecimento 
        ['x'] = -877.45, ['y'] = -2177.65, ['z'] = 9.81, ['h'] = 317.03, -- Posição
        ['TempoRoubo'] = 170, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(260000,320000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'CrastenburgHotel', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1300,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Galpões'] = { -- Nome do estabelecimento 
        ['x'] = -1668.63, ['y'] = -3103.14, ['z'] = 13.95, ['h'] = 139.98, -- Posição
        ['TempoRoubo'] = 227, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(270000,350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Galpoes', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1189,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Pousada'] = { -- Nome do estabelecimento 
        ['x'] = -711.69, ['y'] = -1299.38, ['z'] = 5.41, ['h'] = 230.52, -- Posição
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000,290000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Pousada', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1086,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Mini Shopping'] = { -- Nome do estabelecimento 
        ['x'] = -3152.61, ['y'] = 1110.38, ['z'] = 20.88, ['h'] = 80.11, -- Posição
        ['TempoRoubo'] = 189, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(162186,206674), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'MiniShopping', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1024,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Depósito'] = { -- Nome do estabelecimento 
        ['x'] = 1694.18, ['y'] = -1596.29, ['z'] = 113.82, ['h'] = 289.34, -- Posição
        ['TempoRoubo'] = 180, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000,280775), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Deposito', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 856,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['You Tool'] = { -- Nome do estabelecimento 
        ['x'] = 2710.01, ['y'] = 3455.02, ['z'] = 56.32, ['h'] = 340.79, -- Posição
        ['TempoRoubo'] = 90, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(164441,257277), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Youtool', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1091,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Campo de Golf'] = { -- Nome do estabelecimento 
       ['x'] = -1366.1, ['y'] = 56.82, ['z'] = 54.1, ['h'] = 340.79, -- Posição
        ['TempoRoubo'] = 90, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(200000,260000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Campodegolf', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1091,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fontinelle s'] = { -- Nome do estabelecimento 
       ['x'] = -1123.66, ['y'] = 2682.49, ['z'] = 18.76, ['h'] = 340.79, -- Posição
        ['TempoRoubo'] = 90, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(180000,260000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'fontinelles', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1091,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Los Santos Customs'] = { -- Nome do estabelecimento 
       ['x'] = 731.46, ['y'] = -1097.39, ['z'] = 23.08, ['h'] = 340.79, -- Posição
        ['TempoRoubo'] = 90, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(220000,260000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'lossantoscustoms', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1091,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Hipermercado'] = { -- Nome do estabelecimento 
       ['x'] = 1134.93, ['y'] = -789.18, ['z'] = 57.61, ['h'] = 340.79,-- Posição
        ['TempoRoubo'] = 90, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(220000,260000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'hipermercado', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1091,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
   ['Cemiterio'] = { -- Nome do estabelecimento 
      ['x'] = -1684.83, ['y'] = -291.41, ['z'] = 51.9, ['h'] = 340.79, -- Posição
        ['TempoRoubo'] = 90, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(220000,260000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'cemiterio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1091,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
   ['Hotel'] = { -- Nome do estabelecimento 
      ['x'] = -1380.34, ['y'] = 349.62, ['z'] = 64.25, ['h'] = 340.79,-- Posição
        ['TempoRoubo'] = 110, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(240000,340000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'hotel', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
   ['Hotel Abandonado'] = { -- Nome do estabelecimento 
      ['x'] = -963.68, ['y'] = -1428.93, ['z'] = 7.77,-- Posição
        ['TempoRoubo'] = 80, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(220000,300000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'hotel', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
   ['Posto dos Ballas'] = { -- Nome do estabelecimento 
      ['x'] = 179.23, ['y'] = -1722.16, ['z'] = 29.4,-- Posição
        ['TempoRoubo'] = 60, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(220000,270000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Postoballas', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
   ['Taco Bell'] = { -- Nome do estabelecimento 
      ['x'] = 55.74, ['y'] = -1585.98, ['z'] = 29.6,-- Posição
        ['TempoRoubo'] = 60, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(250000,300000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Taco', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
   ['Vila'] = { -- Nome do estabelecimento 
       ['x'] = -345.57, ['y'] = 34.54, ['z'] = 47.86,-- Posição
        ['TempoRoubo'] = 80, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(220000,270000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Vila', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
   ['Antena'] = { -- Nome do estabelecimento 
       ['x'] = 720.78, ['y'] = 1291.64, ['z'] = 360.3,
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(150000,250000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Antena', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'
    },
   ['Casa Do Michael'] = { -- Nome do estabelecimento 
        ['x'] = -810.69, ['y'] = 167.92, ['z'] = 72.23,
        ['TempoRoubo'] = 120, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(150000,250000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Casadomichael', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1200,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'
    }
    ['Hornys'] = { -- Nome do estabelecimento 
        ['x'] = 1249.05, ['y'] = -350.47, ['z'] = 69.21,
        ['TempoRoubo'] = 70, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(90000,125000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Hornys', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 700,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'
    } 
---------------------------------------------------------------------------------------------------------
-- CÓDIGO
---------------------------------------------------------------------------------------------------------
local Roubando = false
local TempoRoubando = 0
local Recompensa = 0
local DelayPuxar = 0
local Estabelecimento = ''

CreateThread(function() 
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        if not Roubando then
            for k , v in pairs(Config) do
                local dist = #(pedCoords - vec3(v.x, v.y, v.z))
                if dist < 15 then
                    timeDistance = 4
                    DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 180.0, 0, 0, 0.15, 0.15, 0.15, 150,0,0,150, 1, 0, 0, 1)
                    if dist < 1.5 then
                        DrawText3Ds(v.x, v.y, v.z, '~r~[E] ~w~ASSALTAR')
                        if IsControlJustPressed(0,38) then
                            if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
                                if DelayPuxar <= 0 then
                                    --if not vRP.getNearestPlayer(5) then
                                       -- TriggerEvent('Notify', 'aviso', 'AVISO!', 'Tentando assaltar, aguarde...')
                                        DelayPuxar = math.random(10,45)

                                        if vSERVER.CheckCooldown(v.TipoCooldown, v.Cooldown, v.ItemReq, v.MinPoliciais, v.PermDosPm, k, v.x, v.y, v.z,v.MaxPoliciais, v.Prioridade) then
                                            FreezeEntityPosition(ped, true)
                                            Roubando = true
                                            TempoRoubando = v.TempoRoubo
                                            Recompensa = v.Recompensa
                                            Estabelecimento = k
                                            SetEntityHeading(ped, v.h)
                                        end
                                    --else
                                       -- TriggerEvent('Notify', 'aviso', 'AVISO!', 'Não pode haver mais de uma pessoa próxima ao roubo.')
                                   -- end
                                end
                            end
                        end
                    end
                end
            end
        else
            
            if Roubando and TempoRoubando <= 0 then
                vSERVER.nIOUGBAIksdnklajbIUYVBEW(Estabelecimento, Recompensa)
                TempoRoubando = 0 
                Roubando = false
                Recompensa = 0
                Estabelecimento = ''
                FreezeEntityPosition(ped, false)
                ClearPedTasks(ped)
                TriggerEvent('Notify', 'aviso' , 'AVISO ASSALTO!', 'O <b>assalto</b> foi <b>concluído</b>.')
            end

        end

        if TempoRoubando > 0 then
            timeDistance = 4
            drawTxt('TEMPO DE ASSALTO RESTANDO: ~r~' .. TempoRoubando .. 's', 4,0.5,0.93,0.45,255,255,255,80)
            drawTxt('PRESSIONE ~r~F7 ~w~PARA CANCELAR O ~r~ASSALTO', 4,0.5,0.96,0.45,255,255,255,80)

            if IsControlJustPressed(0,168) or not IsEntityPlayingAnim(ped,"anim@heists@ornate_bank@grab_cash", "grab",3) then
                TempoRoubando = 0
                Roubando = false
                Recompensa = 0
                Estabelecimento = ''
                FreezeEntityPosition(ped, false)
                ClearPedTasks(ped)
                TriggerEvent('Notify', 'aviso' , 'AVISO ASSALTO!', 'O <b>assalto</b> foi <b>cancelado</b>.')
            end

        end
        Wait(timeDistance)
    end
end)

CreateThread(function() 
    while true do
        Wait(1000)
        if Roubando then
            if TempoRoubando > 0 then
                TempoRoubando = TempoRoubando - 1
            end
        end

        if DelayPuxar > 0 then
            DelayPuxar = DelayPuxar - 1
        end
    end
end)

function src.SetMochila()
    SetPedComponentVariation(PlayerPedId(),5,21,0,2)
	SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
end


---------------------------------------------------------------------------------------------------------
-- FUNCOES
---------------------------------------------------------------------------------------------------------

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

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(6)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end