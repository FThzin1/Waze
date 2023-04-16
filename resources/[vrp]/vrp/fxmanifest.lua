fx_version "bodacious"
game "gta5"

ui_page_preload "yes"
ui_page "gui/index.html"
loadscreen "loading/index.html"

client_scripts {
	"lib/utils.lua",
	"client/*"
}

server_scripts { 
	"lib/utils.lua",
	"base.lua",
	"queue.lua",
	"modules/gui.lua",
	"modules/group.lua",
	"modules/player_state.lua",
	"modules/business.lua",
	"modules/map.lua",
	"modules/money.lua",
	"modules/inventory.lua",
	"modules/identity.lua",
	"modules/aptitude.lua",
	"modules/basic_items.lua",
	--"modules/basic_skinshop.lua",
	"modules/cloakroom.lua"
}

files {
	"loading/*",
	"lib/*",
	"gui/*"
}

server_export "AddPriority"
server_export "RemovePriority"              