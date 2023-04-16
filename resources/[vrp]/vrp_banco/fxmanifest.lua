



fx_version "adamant"
game "gta5"

ui_page("nui/ui.html")

client_script{
    "@vrp/lib/utils.lua",
    "client/*.lua"
}

server_script {
    "@vrp/lib/utils.lua",
	"server/*.lua"
}

files {
    "nui/*.html",
    "nui/*.css",
    "nui/**/*.png",
    "nui/**/*.ttf"
}
                                                                      