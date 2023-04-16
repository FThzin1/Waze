local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

wazeFarm = {}
Tunnel.bindInterface("waze_npc_farms", wazeFarm)
sFarm = Tunnel.getInterface("waze_npc_farms")
sDrugs = Tunnel.getInterface("waze_entrega_drogas")
sLabs = Tunnel.getInterface("waze_drogas_farm")
sPolice = Tunnel.getInterface("emp_policia")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local fBoostLigado = false

function wazeFarm.StatusBoostFarm(status)
    fBoostLigado = status
end

local LocaisRotas = { -- Local em que se pega o início da rota e a permissão pra acessar o blip
    ['bloods.permissao'] =  {-1079.67,-1679.51,4.58},
    ['crips.permissao'] =  {1272.27,-1711.76,54.78},
    ['siciliana.permissao'] =  {-1492.98,843.56,181.6},
    ['bratva.permissao'] =  {570.91,-3123.59,18.77},
    ['bahamas.permissao'] =  {-1380.78,-616.56,31.5},
   -- ['galaxy.permissao'] =  {-205.1,-283.08,26.32},
    ['lifeinvader.permissao'] =  {-1066.78,-243.74,44.03},
    ['bennys.permissao'] =  {-206.82,-1341.67,34.9},
    --['arcadius.permissao'] =  {-125.83,-638.89,168.83},
   --['jornal.permissao'] =  {-1082.3,-245.43,37.77},
    ['hells.permissao'] =  {487.02,-1304.55,29.39},
    ['warlocks.permissao'] =  {17.84,-2664.94,6.01}
}


local RotasFarms = { -- As facções que tem matéria prima não-disputada, terão que fazer rotas pra pegar os componentes básicos

    [1] = { ['x'] = 351.26, ['y'] = -2453.23, ['z'] = 6.41 }, -- ROTA BRTAVA
    [2] = { ['x'] = 247.39, ['y'] = -1956.93, ['z'] = 23.21 },
    [3] = { ['x'] = 179.59, ['y'] = -1722.61, ['z'] = 29.4 },
    [4] = { ['x'] = 519.41, ['y'] = -1734.16, ['z'] = 30.7 },
    [5] = { ['x'] = 446.15, ['y'] = -1235.09, ['z'] = 29.97 },
    [6] = { ['x'] = 462.53, ['y'] = -694.05, ['z'] = 27.42 },
    [7] = { ['x'] = -36.28, ['y'] = -570.44, ['z'] = 38.84 },
    [8] = { ['x'] = -152.16, ['y'] = -38.18, ['z'] = 54.4 },
    [9] = { ['x'] = -753.27, ['y'] = 275.67, ['z'] = 85.76 },
    [10] = { ['x'] = -1478.2, ['y'] = -519.0, ['z'] = 34.74 },
    [11] = { ['x'] = -1084.94, ['y'] = -935.3, ['z'] = 3.09 },
    [12] = { ['x'] = -1235.39, ['y'] = -1191.63, ['z'] = 7.68 },
    [13] = { ['x'] = -862.56, ['y'] = -1227.45, ['z'] = 6.46 },
    [14] = { ['x'] = -305.05, ['y'] = -1179.77, ['z'] = 23.63 },
    [15] = { ['x'] = -583.26, ['y'] = -1767.86, ['z'] = 23.19 },
    [16] = { ['x'] = -58.5, ['y'] = -2245.08, ['z'] = 8.96 },
    [17] = { ['x'] = 191.68, ['y'] = -2226.55, ['z'] = 6.98 },
    [18] = { ['x'] = 557.55, ['y'] = -2328.01, ['z'] = 5.83 },
    [19] = { ['x'] = 719.29, ['y'] = -2102.92, ['z'] = 29.65 },
    [20] = { ['x'] = 632.66, ['y'] = -2796.62, ['z'] = 6.06 },

    [21] = {['x'] = -1886.2, ['y'] = 665.02, ['z'] = 129.83}, -- COSA
    [22] = {['x'] = -1561.47, ['y'] = -210.54, ['z'] = 55.54},
    [23] = {['x'] = -838.27, ['y'] = -161.94, ['z'] = 37.79},
    [24] = {['x'] = -657.78, ['y'] = -679.1, ['z'] = 31.48},
    [25] = {['x'] = -913.97, ['y'] = -1171.49, ['z'] = 4.91},
    [26] = {['x'] = -913.97, ['y'] = -1171.49, ['z'] = 4.91},
    [27] = {['x'] = -1200.29, ['y'] = -156.97, ['z'] = 40.09},
    [28] = {['x'] = 41.43, ['y'] = -174.62, ['z'] = 55.18},
    [29] = {['x'] = 223.75, ['y'] = 513.97, ['z'] = 140.77},
    [30]  = {['x'] = -348.91, ['y'] = 514.83, ['z'] = 120.65},
    [31]  = {['x'] = -682.21, ['y'] = 916.32, ['z'] = 232.2},
    [32]  = {['x'] = -429.45, ['y'] = 1109.42, ['z'] = 327.69},
    [33]  = {['x'] = 147.14, ['y'] = 1669.08, ['z'] = 228.74},
    [34]  = {['x'] = 803.28, ['y'] = 2174.99, ['z'] = 53.08},
    [35]  = {['x'] = 1224.67, ['y'] = 2728.68, ['z'] = 38.01},
    [36]  = {['x'] = 252.59, ['y'] = 2596.04, ['z'] = 44.9},
    [37]  = {['x'] = -324.26, ['y'] = 2818.13, ['z'] = 59.45},
    [38]  = {['x'] = -1123.36, ['y'] = 2682.59, ['z'] = 18.75},
    [39]  = {['x'] = -1889.52, ['y'] = 2051.0, ['z'] = 140.99},
    [40]  = {['x'] = -2553.47, ['y'] = 1914.88, ['z'] = 169.02},

    [41] = {['x'] = 968.03, ['y'] = -1829.15, ['z'] = 31.29}, -- CRIPS ['x'] = 1186.09, ['y'] = -1382.61, ['z'] = 35.15, ['h'] = 88.75
    [42] = {['x'] = 925.16, ['y'] = -2350.05, ['z'] = 31.82},
    [43] = {['x'] = 784.07, ['y'] = -2254.21, ['z'] = 29.5},
    [44] = {['x'] = 182.92, ['y'] = -2027.68, ['z'] = 18.28},
    [45] = {['x'] = -621.37, ['y'] = -1640.13, ['z'] = 26.11},
    [46] = {['x'] = -703.88, ['y'] = -1398.17, ['z'] = 5.5},
    [47] = {['x'] = -812.52, ['y'] = -980.46, ['z'] = 14.26},
    [48] = {['x'] = -1285.35, ['y'] = -566.73, ['z'] = 31.72},
    [49] = {['x'] = -1413.44, ['y'] = -139.03, ['z'] = 48.77},
    [50] = {['x'] = -1384.06, ['y'] = 267.73, ['z'] = 61.24},
    [51] = {['x'] = -756.42, ['y'] = 240.85, ['z'] = 75.67},
    [52] = {['x'] = -304.64, ['y'] = 104.47, ['z'] = 67.89},
    [53] = {['x'] = -84.41, ['y'] = 234.95, ['z'] = 100.57},
    [54] = {['x'] = 412.21, ['y'] = 315.06, ['z'] = 103.14},
    [55] = {['x'] = 646.39, ['y'] = 267.43, ['z'] = 103.27},
    [56] = {['x'] = 751.3, ['y'] = 224.0, ['z'] = 87.43},
    [57] = {['x'] = 896.06, ['y'] = -144.82, ['z'] = 76.87},
    [58] = {['x'] = 1249.36, ['y'] = -350.59, ['z'] = 69.21},
    [59] = {['x'] = 1154.6, ['y'] = -785.3, ['z'] = 57.6},
    [60] = {['x'] = 1213.83, ['y'] = -1256.38, ['z'] = 35.23},

    [61] = {['x'] = -1244.15, ['y'] = -1489.11, ['z'] = 4.37}, -- BLOODS
    [62] = {['x'] = -2002.24, ['y'] = -557.44, ['z'] = 12.89},
    [63] = {['x'] = -1952.99, ['y'] = -301.89, ['z'] = 43.82},
    [64] = {['x'] = -1681.26, ['y'] = -291.16, ['z'] = 51.89},
    [65] = {['x'] = -1409.12, ['y'] = -109.28, ['z'] = 51.66},
    [66] = {['x'] = -880.72, ['y'] = -194.73, ['z'] = 38.79},
    [67] = {['x'] = -509.35, ['y'] = -22.84, ['z'] = 45.61},
    [68] = {['x'] = -242.07, ['y'] = 279.84, ['z'] = 92.04},
    [69] = {['x'] = 120.89, ['y'] = 337.83, ['z'] = 112.1},
    [70] = {['x'] = 571.62, ['y'] = 194.01, ['z'] = 101.65},
    [71] = {['x'] = 418.64, ['y'] = -207.09, ['z'] = 59.92},
    [72] = {['x'] = 20.89, ['y'] = -207.76, ['z'] = 52.86},
    [73] = {['x'] = -156.43, ['y'] = -154.89, ['z'] = 43.63},
    [74] = {['x'] = -783.69, ['y'] = -390.94, ['z'] = 37.35},
    [75] = {['x'] = -827.3, ['y'] = -691.49, ['z'] = 28.06},
    [76] = {['x'] = -812.47, ['y'] = -980.6, ['z'] = 14.25},
    [77] = {['x'] = -956.44, ['y'] = -1105.35, ['z'] = 2.16},
    [78] = {['x'] = -1154.88, ['y'] = -931.27, ['z'] = 2.78},
    [79] = {['x'] = -1556.54, ['y'] = -1154.53, ['z'] = 3.92},
    [80] = {['x'] = -1392.89, ['y'] = -1326.67, ['z'] = 4.16},

    [81] = {['x'] = -297.38, ['y'] = -1332.31, ['z'] = 30.87}, -- ROTA BENNYS
    [82] = {['x'] = -428.97, ['y'] = -1728.08, ['z'] = 19.79},
    [83] = {['x'] = -41.11, ['y'] = -1675.11, ['z'] = 29.02},
    [84] = {['x'] = 215.9, ['y'] = -1389.47, ['z'] = 30.16},
    [85] = {['x'] = 788.29, ['y'] = -1770.18, ['z'] = 28.87},
    [86] = {['x'] = 264.04, ['y'] = -2506.79, ['z'] = 6.01},
    [87] = {['x'] = -43.98, ['y'] = -2519.93, ['z'] = 7.4},
    [88] = {['x'] = 557.2, ['y'] = -2716.49, ['z'] = 7.12},
    [89] = {['x'] = 858.32, ['y'] = -2496.89, ['z'] = 28.32},
    [90] = {['x'] = 1384.11, ['y'] = -2079.74, ['z'] = 52.21},
    [91] = {['x'] = 1191.96, ['y'] = -1268.19, ['z'] = 35.17},
    [92] = {['x'] = 1139.42, ['y'] = -463.81, ['z'] = 66.87},
    [93] = {['x'] = 401.79, ['y'] = -339.63, ['z'] = 46.98},
    [94] = {['x'] = -344.88, ['y'] = -175.76, ['z'] = 38.69},
    [95] = {['x'] = -967.61, ['y'] = -267.48, ['z'] = 39.02},
    [96] = {['x'] = -1011.59, ['y'] = -480.08, ['z'] = 39.98},
    [97] = {['x'] = -822.68, ['y'] = -1099.79, ['z'] = 10.92},
    [98] = {['x'] = -700.46, ['y'] = -1401.48, ['z'] = 5.5},
    [99] = {['x'] = -621.08, ['y'] = -1640.25, ['z'] = 26.14},
    [100] = {['x'] = -398.71, ['y'] = -1885.62, ['z'] = 21.54},

    [101] = {['x'] = -1336.32, ['y'] = -407.25, ['z'] = 36.51}, -- ROTA BAHAMAS
    [102] = {['x'] = -1200.22, ['y'] = -156.26, ['z'] = 40.1},
    [103] = {['x'] = 461.82, ['y'] = -277.29, ['z'] = 48.71},
    [103] = {['x'] = 1083.44, ['y'] = -351.63, ['z'] = 67.1},
    [104] = {['x'] = 1043.62, ['y'] = 190.35, ['z'] = 81.0},
    [105] = {['x'] = 2601.16, ['y'] = 2804.09, ['z'] = 33.83},
    [106] = {['x'] = 2741.96, ['y'] = 4412.74, ['z'] = 48.63},
    [107] = {['x'] = 1705.99, ['y'] = 6425.56, ['z'] = 32.77},
    [108] = {['x'] = -162.43, ['y'] = 6189.51, ['z'] = 31.44},
    [109] = {['x'] = -2218.6, ['y'] = 4229.55, ['z'] = 47.4},
    [110] = {['x'] = -3147.19, ['y'] = 1121.29, ['z'] = 20.87},
    [111] = {['x'] = -1936.51, ['y'] = 580.61, ['z'] = 119.49},
    [112] = {['x'] = -904.67, ['y'] = 780.17, ['z'] = 186.45},
    [113] = {['x'] = 655.45, ['y'] = 588.7, ['z'] = 129.06},
    [114] = {['x'] = 756.31, ['y'] = -557.79, ['z'] = 33.65},
    [115] = {['x'] = 767.04, ['y'] = -1895.48, ['z'] = 29.09},
    [116] = {['x'] = 262.08, ['y'] = -1822.19, ['z'] = 26.88},
    [117] = {['x'] = -289.11, ['y'] = -1080.96, ['z'] = 23.03},
    [118] = {['x'] = -1378.03, ['y'] = -361.05, ['z'] = 36.62},

    [119] = {['x'] = -602.0, ['y'] = -347.46, ['z'] = 35.25}, -- ROTA GALAXY
    [120] = {['x'] = -1286.07, ['y'] = -1386.67, ['z'] = 4.45},
    [121] = {['x'] = 5.82, ['y'] = -985.48, ['z'] = 29.36},
    [122] = {['x'] = 1230.94, ['y'] = -1083.36, ['z'] = 38.53},
    [123] = {['x'] = 1620.49, ['y'] = -2258.28, ['z'] = 106.68},
    [124] = {['x'] = -621.3, ['y'] = -1640.59, ['z'] = 25.98},
    [125] = {['x'] = 254.5, ['y'] = -1012.87, ['z'] = 29.27},
    [126] = {['x'] = 1533.06, ['y'] = 792.38, ['z'] = 77.55},
    [127] = {['x'] = 1210.92, ['y'] = 1857.72, ['z'] = 78.92},
    [128] = {['x'] = 46.36, ['y'] = 2789.05, ['z'] = 57.88},
    [129] = {['x'] = 1361.23, ['y'] = 3602.9, ['z'] = 34.95},
    [130] = {['x'] = 1258.7, ['y'] = 2739.79, ['z'] = 38.85},
    [131] = {['x'] = -42.28, ['y'] = 1883.37, ['z'] = 195.63},
    [132] = {['x'] = -681.38, ['y'] = 916.77, ['z'] = 232.12},
    [133] = {['x'] = -1305.59, ['y'] = 240.17, ['z'] = 58.99},
    [134] = {['x'] = -2066.58, ['y'] = -312.17, ['z'] = 13.26},
    [135] = {['x'] = 245.6, ['y'] = -677.46, ['z'] = 37.76},
    [136] = {['x'] = 561.15, ['y'] = 92.36, ['z'] = 96.06},
    [137] = {['x'] = -1197.25, ['y'] = -259.33, ['z'] = 37.76},
    [138] = {['x'] = -67.88, ['y'] = -205.93, ['z'] = 45.81},

    [139] = {['x'] = 2591.5, ['y'] = 5063.42, ['z'] = 44.92}, -- ROTA THE CREW
    [140] = {['x'] = 1679.97, ['y'] = 6432.93, ['z'] = 31.97},
    [141] = {['x'] = 412.74, ['y'] = 6606.62, ['z'] = 27.43},
    [142] = {['x'] = -369.0, ['y'] = 6057.44, ['z'] = 31.5},
    [143] = {['x'] = -841.48, ['y'] = 5400.55, ['z'] = 34.62},
    [144] = {['x'] = -2173.89, ['y'] = 4281.99, ['z'] = 49.13},
    [145] = {['x'] = -2055.42, ['y'] = 3179.62, ['z'] = 32.82},
    [146] = {['x'] = -1613.81, ['y'] = 2806.5, ['z'] = 17.72},
    [147] = {['x'] = -1129.67, ['y'] = 2692.38, ['z'] = 18.42},
    [148] = {['x'] = -35.94, ['y'] = 2871.7, ['z'] = 59.62},
    [149] = {['x'] = 712.25, ['y'] = 2532.44, ['z'] = 73.44},
    [150] = {['x'] = 1176.34, ['y'] = 2635.91, ['z'] = 37.76},
    [151] = {['x'] = 2144.12, ['y'] = 2897.0, ['z'] = 47.49},
    [152] = {['x'] = 2333.02, ['y'] = 2524.43, ['z'] = 46.22},
    [153] = {['x'] = 2745.55, ['y'] = 2788.25, ['z'] = 35.17},
    [154] = {['x'] = 2968.65, ['y'] = 3492.05, ['z'] = 71.45},
    [155] = {['x'] = 2899.6, ['y'] = 4399.33, ['z'] = 49.85},
    [156] = {['x'] = 2503.88, ['y'] = 4990.18, ['z'] = 44.21},
    [157] = {['x'] = 1350.16, ['y'] = 4389.78, ['z'] = 44.35},
    [158] = {['x'] = 2243.75, ['y'] = 5154.15, ['z'] = 57.51},

    [159] = {['x'] = -41.77, ['y'] = -227.81, ['z'] = 45.25}, -- ROTA ARCADIUS
    [160] = {['x'] = -69.17, ['y'] = 63.12, ['z'] = 71.34},
    [161] = {['x'] = 128.12, ['y'] = 342.01, ['z'] = 111.32},
    [162] = {['x'] = 225.13, ['y'] = 1170.59, ['z'] = 225.45},
    [163] = {['x'] = -126.17, ['y'] = 1896.24, ['z'] = 196.79},
    [164] = {['x'] = 791.61, ['y'] = 2176.72, ['z'] = 52.1},
    [165] = {['x'] = 265.54, ['y'] = 2598.51, ['z'] = 44.27},
    [166] = {['x'] = 189.69, ['y'] = 3094.19, ['z'] = 42.53},
    [167] = {['x'] = 387.59, ['y'] = 3584.94, ['z'] = 32.74},
    [168] = {['x'] = 911.35, ['y'] = 3644.57, ['z'] = 32.13},
    [169] = {['x'] = 1385.21, ['y'] = 3659.74, ['z'] = 34.38},
    [170] = {['x'] = 1747.16, ['y'] = 3900.76, ['z'] = 34.25},
    [171] = {['x'] = 2002.3, ['y'] = 3779.89, ['z'] = 31.63},
    [172] = {['x'] = 2392.98, ['y'] = 3320.33, ['z'] = 48.46},
    [173] = {['x'] = 2709.93, ['y'] = 3455.06, ['z'] = 56.32},
    [174] = {['x'] = 813.63, ['y'] = 544.73, ['z'] = 125.37},
    [175] = {['x'] = 646.21, ['y'] = 267.13, ['z'] = 102.71},
    [176] = {['x'] = 478.73, ['y'] = -106.99, ['z'] = 62.61},
    [177] = {['x'] = 134.75, ['y'] = -859.23, ['z'] = 30.23},
    [178] = {['x'] = 6.66, ['y'] = -705.68, ['z'] = 45.42},

    [179] = {['x'] = -41.77, ['y'] = -227.81, ['z'] = 45.25}, -- ROTA JORNAL
    [180] = {['x'] = -69.17, ['y'] = 63.12, ['z'] = 71.34},
    [181] = {['x'] = 128.12, ['y'] = 342.01, ['z'] = 111.32},
    [182] = {['x'] = 225.13, ['y'] = 1170.59, ['z'] = 225.45},
    [183] = {['x'] = -126.17, ['y'] = 1896.24, ['z'] = 196.79},
    [184] = {['x'] = 791.61, ['y'] = 2176.72, ['z'] = 52.1},
    [185] = {['x'] = 265.54, ['y'] = 2598.51, ['z'] = 44.27},
    [186] = {['x'] = 189.69, ['y'] = 3094.19, ['z'] = 42.53},
    [187] = {['x'] = 387.59, ['y'] = 3584.94, ['z'] = 32.74},
    [188] = {['x'] = 911.35, ['y'] = 3644.57, ['z'] = 32.13},
    [189] = {['x'] = 1385.21, ['y'] = 3659.74, ['z'] = 34.38},
    [190] = {['x'] = 1747.16, ['y'] = 3900.76, ['z'] = 34.25},
    [191] = {['x'] = 2002.3, ['y'] = 3779.89, ['z'] = 31.63},
    [192] = {['x'] = 2392.98, ['y'] = 3320.33, ['z'] = 48.46},
    [193] = {['x'] = 2709.93, ['y'] = 3455.06, ['z'] = 56.32},
    [194] = {['x'] = 813.63, ['y'] = 544.73, ['z'] = 125.37},
    [195] = {['x'] = 646.21, ['y'] = 267.13, ['z'] = 102.71},
    [196] = {['x'] = 478.73, ['y'] = -106.99, ['z'] = 62.61},
    [197] = {['x'] = 134.75, ['y'] = -859.23, ['z'] = 30.23},
    [198] = {['x'] = 6.66, ['y'] = -705.68, ['z'] = 45.42},

    [199] = {['x'] = 751.27, ['y'] = 223.16, ['z'] = 87.43}, -- MOTO CLUB
    [200] = {['x'] = 402.13, ['y'] = -338.85, ['z'] = 46.98},
    [201] = {['x'] = -307.87, ['y'] = -163.98, ['z'] = 40.43},
    [202] = {['x'] = -557.69, ['y'] = 187.82, ['z'] = 72.57},
    [203] = {['x'] = -956.44, ['y'] = 327.71, ['z'] = 71.47},
    [204] = {['x'] = -1470.92, ['y'] = -135.04, ['z'] = 51.09},
    [205] = {['x'] = -1877.0, ['y'] = -309.84, ['z'] = 49.24},
    [206] = {['x'] = -3031.11, ['y'] = 92.57, ['z'] = 12.35},
    [207] = {['x'] = -3157.6, ['y'] = 1095.07, ['z'] = 20.86},
    [208] = {['x'] = -2520.66, ['y'] = 2310.47, ['z'] = 33.22},
    [209] = {['x'] = -1134.91, ['y'] = 2682.42, ['z'] = 18.41},
    [210] = {['x'] = -324.34, ['y'] = 2818.16, ['z'] = 59.46},
    [211] = {['x'] = 266.74, ['y'] = 2583.99, ['z'] = 44.93},
    [212] = {['x'] = 1224.72, ['y'] = 2728.41, ['z'] = 38.01},
    [213] = {['x'] = 1690.32, ['y'] = 3581.27, ['z'] = 35.63},
    [214] = {['x'] = 2178.95, ['y'] = 3496.71, ['z'] = 45.87},
    [215] = {['x'] = 2555.8, ['y'] = 2607.45, ['z'] = 38.09},
    [216] = {['x'] = 1575.47, ['y'] = 854.31, ['z'] = 77.49},
    [217] = {['x'] = 1015.14, ['y'] = 144.04, ['z'] = 81.0},
    [218] = {['x'] = 895.2, ['y'] = -179.43, ['z'] = 74.71},

}

--local TempoDeAnimacao = 15 -- segundos
local PegandoMateriaPrima = false
local PosRota = 0
local blip = false
local PermCliente = nil
local TemPerm = false

CreateThread(function() 
   while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        -------------------------------------------------
        --- FARM DE MATÉRIAS PRIMAS PARA BLOODS/CRIPS/MÁFIAS
        -------------------------------------------------
        if not PegandoMateriaPrima then 
            for k, v in pairs(LocaisRotas) do     
                local distPonto = #(GetEntityCoords(ped) - vec3(v[1], v[2], v[3]))
                if  distPonto < 15 then
                    timeDistance = 4 
                    DrawMarker(21, v[1], v[2], v[3]-0.3, 0, 0, 0, 180.0, 0, 0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1)
                    if distPonto < 1.5 then
                        if IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 then
                            TemPerm, PermCliente = sFarm.OFlyNcqwyVnLBLqXkEnJeScFb(k)
                            if TemPerm then
                                TriggerEvent('Notify', "sucesso", 'Você iniciou a coleta de materiais.')
                                PegandoMateriaPrima = true
                                if PermCliente == 'bratva.permissao' then -- OK
                                    PosRota = 1
                                elseif PermCliente == 'siciliana.permissao' then -- OK
                                    PosRota = 21
                                elseif PermCliente == 'crips.permissao' then -- OK
                                    PosRota = 41
                                elseif PermCliente == 'bloods.permissao' then -- OK
                                    PosRota = 61
                                elseif PermCliente == 'bennys.permissao' then -- OK
                                    PosRota = 81
                                elseif PermCliente == 'bahamas.permissao' then -- OK
                                    PosRota = 101
                                elseif PermCliente == 'lifeinvader.permissao' then -- OK
                                    PosRota = 119
                                elseif PermCliente == 'warlocks.permissao' then -- OK
                                    PosRota = 139
                                elseif PermCliente == 'arcadius.permissao' then -- OK
                                    PosRota = 159
                                elseif PermCliente == 'jornal.permissao' then -- OK
                                    PosRota = 179
                                elseif PermCliente == 'hells.permissao' then -- OK
                                    PosRota = 199
                                end
                                makeBlipMarked(RotasFarms,PosRota)
                            end
                        end
                    end
                end
            end
        end

        if PegandoMateriaPrima then
            local distPonto = #(GetEntityCoords(ped) - vec3(RotasFarms[PosRota].x, RotasFarms[PosRota].y, RotasFarms[PosRota].z))
            if distPonto < 15 then
                timeDistance = 4 
                DrawMarker(21, RotasFarms[PosRota].x, RotasFarms[PosRota].y, RotasFarms[PosRota].z-0.3, 0, 0, 0, 180.0, 0, 0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1)
                if distPonto < 0.5 then
                    DT3DFarm(RotasFarms[PosRota].x, RotasFarms[PosRota].y, RotasFarms[PosRota].z, 'PRESSIONE ~r~[E] ~w~PARA COLETAR OS MATERIAIS',255,255,255)
                    if IsControlJustPressed(0, 38) then
                        if not IsPedInAnyVehicle(ped) and TemPerm then
                            if blip then
                                timeDistance = 4 
                                RemoveBlip(blips)
                                blip = false
                            end
                            if not fBoostLigado then
                                sFarm.rqkWrVlbDiRADhQwchLtLdZuk(PermCliente)
                            end
                            if fBoostLigado then
                                sFarm.rqkWrVlbDiRADhQwchLtLdBoost(PermCliente)
                            end
                            FreezeEntityPosition(PlayerPedId(), true)
                            vRP._playAnim(false,{"pickup_object","pickup_low"},false)
                            TriggerEvent('progress', 2000)
                            Wait(2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(ped)
                            if PosRota == 20 then
                                PosRota = 1
                            elseif PosRota == 40 then
                                PosRota = 21
                            elseif PosRota == 60 then
                                PosRota = 41
                            elseif PosRota == 80 then
                                PosRota = 61
                            elseif PosRota == 100 then
                                PosRota = 81
                            elseif PosRota == 118 then
                                PosRota = 101
                            elseif PosRota == 138 then
                                PosRota = 119
                            elseif PosRota == 158 then
                                PosRota = 139
                            elseif PosRota == 178 then
                                PosRota = 159
                            elseif PosRota == 198 then
                                PosRota = 179
                            elseif PosRota == 218 then
                                PosRota = 199
                            else
                                PosRota = PosRota + 1
                            end
                            makeBlipMarked(RotasFarms,PosRota)
                        end
                    end
                end
            end
        end
        Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		if PegandoMateriaPrima then
			timeDistance = 4
			if IsControlJustPressed(0,168) then
				PegandoMateriaPrima = false
				RemoveBlip(blips)
				TriggerEvent('Notify', "aviso", 'Você finalizou a coleta de materiais.')
			end
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------

function dTFarm(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function modelRequest(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(10)
	end
end

function makeBlipMarked(RotasFarms,PosRota)
    if DoesBlipExist(blips) then
        RemoveBlip(blips)
        blips = nil
    end

    blips = AddBlipForCoord(RotasFarms[PosRota].x, RotasFarms[PosRota].y, RotasFarms[PosRota].z)
    SetBlipSprite(blips,501)
    SetBlipColour(blips,5)
    SetBlipScale(blips,0.4)
    SetBlipAsShortRange(blips,false)
    SetBlipRoute(blips,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Coleta de materiais")
    EndTextCommandSetBlipName(blips)
end

function DT3DFarm(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vec3(px,py,pz) - vec3(x,y,z))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.35, 0.35)
        SetTextColour(r, g, b, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 55, 55, 55, 68)
    end
end

AddEventHandler('playerSpawned', function()
    Wait(3000)
    fBoostLigado = sFarm.GetSatusBoostFarm()
    print('O boost de rotas ilegais está: ' .. tostring(fBoostLigado))
end)