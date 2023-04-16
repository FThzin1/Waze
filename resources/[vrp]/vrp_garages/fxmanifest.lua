




fx_version "bodacious"
game "gta5"

ui_page_preload "yes"
ui_page "nui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server/*"
}


files {
	"nui/index.html",
	"nui/jquery.js",
	"nui/css.css"
}                                                                                                  