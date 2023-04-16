fx_version 'cerulean'
use_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server/*"
}

escrow_ignore {
	"server/*"
}

shared_scripts {
	"shared/*.lua"
}

files {
	"web-side/*",
	"web-side/**/*"
}                                                                      