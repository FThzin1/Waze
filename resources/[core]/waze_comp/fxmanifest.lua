


fx_version 'bodacious'
game 'gta5'

ui_page "web-side/ui.html"
ui_page_preload "yes"

client_script {
    '@vrp/lib/utils.lua',
    'client-side/*'
}

server_script {
    '@vrp/lib/utils.lua',
    'server-side/*'
}                            

files {
	"web-side/*.html",
	"web-side/*.js",
	"web-side/*.css"
}                  