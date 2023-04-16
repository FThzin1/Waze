


fx_version "adamant"
game "gta5" 

client_scripts {
    "@vrp/lib/utils.lua",
    "client/*"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server/*"
}

files {
    "nui/*",
    "nui/**/*"
}

ui_page "nui/index.html"                                                                                    