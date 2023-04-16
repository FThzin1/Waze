




fx_version "bodacious"
game "gta5"

ui_page 'html/ui.html'
ui_page_preload 'yes'

files {
	'html/ui.html',
	'html/main.css',
	'html/app.js',
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server/*"
}                                                                                                  