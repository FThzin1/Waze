

fx_version "cerulean"
game { "gta5" }

client_scripts {
    "@vrp/lib/utils.lua",
    "common/*",
    "common/**/*",
    "client/index.lua",
    "client/*.lua",
    "client/**/*.lua",
    "weapons/**.meta"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "common/*.lua",
    "common/**/*.lua",
    "server/*.lua",
    "server/**/*.lua",
}                           