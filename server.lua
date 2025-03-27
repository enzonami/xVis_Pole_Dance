---@type table
Config = Config or {}

local activeDances = {}

-- Check if a player is allowed to use the stripper pole
local function isAllowedToDance(src)
    local player = exports.qbx_core:GetPlayer(src)

    if not player or not player.PlayerData then
        return false
    end

    local jobName = player.PlayerData.job.name
    for _, allowedJob in ipairs(Config.AllowedJobs) do
        if jobName == allowedJob then
            return true
        end
    end

    return false
end

-- Handle dance request
RegisterNetEvent('stripper_pole:requestDance', function(poleId, offset)
    local src = source

    if not isAllowedToDance(src) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Access Denied',
            description = 'You are not allowed to use the pole.',
            type = 'error'
        })
        return
    end

    local pole = Config.Poles[poleId]
    local dance = Config.Dances[1]

    -- Store the active dance
    activeDances[poleId] = { src = src, coords = pole.coords, heading = pole.heading }

    -- Confirm the dance to the initiating player
    TriggerClientEvent('stripper_pole:confirmDance', src, poleId, pole.coords, pole.heading, offset, dance.animDict, dance.animName)
end)

-- Stop a dance
RegisterNetEvent('stripper_pole:stopDance', function()
    local src = source

    for poleId, dance in pairs(activeDances) do
        if dance.src == src then
            activeDances[poleId] = nil
            TriggerClientEvent('stripper_pole:stopDance', -1, poleId)
            break
        end
    end
end)
