




fx_version 'bodacious'
game 'gta5'

client_script {
    '@vrp/lib/utils.lua',
    'metas/*',
    'client/*'
}

server_script {
    '@vrp/lib/utils.lua',
    'server/*'
}                             

data_file 'WEAPONINFO_FILE_PATCH' '*.meta'