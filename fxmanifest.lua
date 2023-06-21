fx_version 'cerulean'

game 'gta5'

author 'Jozo_85#2261'

description 'Car | Free to use'

version '1.0'

ui_page 'html/hud.html'

shared_scripts {
    '@es_extended/locale.lua',
    'locales/*',
    'config.lua'
}

client_scripts {
    'Client/*',
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'Server/*'
}