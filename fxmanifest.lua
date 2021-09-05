fx_version 'adamant'
games { 'gta5' }

author 'Bob'
description 'Bobs Drugs'
version '0.1'

client_scripts {
	'config.lua',
    'client/functions.lua',
    'client/main.lua',
	'client/client_sell.lua',
	'client/drugmissions.lua'
}

server_scripts {
	'config.lua',
    'server/main.lua',
	'server/server_sell.lua',
	'server/timer.lua'
}