fx_version 'cerulean'
game 'gta5'

-- General Info
author 'xnviscerate'
description 'Optimized, Non-Entity Based Pole Dancing Resource for Qbox'
version '1.0.0'
repository ''
license 'MIT'

-- Shared Config
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

-- Client Scripts
client_scripts {
    'client.lua'
}

-- Server Scripts
server_scripts {
    'server.lua'
}

-- Dependencies
dependencies {
    'ox_lib',
    'ox_target',
    'qbx_core'
}

-- Game Settings
lua54 'yes'