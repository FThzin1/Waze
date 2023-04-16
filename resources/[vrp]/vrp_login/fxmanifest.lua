
fx_version 'cerulean'
game 'gta5'

shared_scripts {
  "shared.lua"
}

client_scripts {
  "@vrp/lib/utils.lua",
  'client.lua',
}

server_scripts {
  "@vrp/lib/utils.lua",
  'server.lua'
}

files {
  'nui/**/*',
  'nui/*'
}

ui_page 'nui/index.html'     