wcfg = {
    comando = "airdrop",
    perm = "admin.permissao",
    radius = 200,
    nomedoevento = "~b~EVENTO: ~w~Waze Airdrop",
    timesafe = 5000, -- 1000 = 1 Segundo,
    timepick = 5000,
    airdrops = {
        ["wazedrop1"] =  {nome = "Waze Ford", locate = {x = -208.12,y = -538.8,z = 34.75}, item = {
            {'wbody|WEAPON_PISTOL_MK2',2,4},
            {'wbody|WEAPON_SPECIALCARBINE',2,4},
            {'bandagem',2,4}
        } },
        ["wazedrop2"] =  {nome = "Waze Rush", locate = {x = 1,y = 2,z = 3}, item = {} },
        ["wazedrop3"] =  {nome = "Waze Bohr", locate = {x = 1,y = 2,z = 3}, item = {} },
        ["wazedrop4"] =  {nome = "Waze XV", locate = {x = 1,y = 2,z = 3}, item = {} },
        ["wazedrop5"] =  {nome = "Waze Atomic", locate = {x = 1,y = 2,z = 3}, item = {} },
    }
} 
