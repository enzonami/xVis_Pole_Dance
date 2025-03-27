
-- Start the dance animation at the stripper pole
local function startDance(poleId, coords, heading, offset, animDict, animName)
    local ped = PlayerPedId()

    -- Apply the configurable offset
    local adjustedCoords = vector3(
        coords.x + offset.x * math.cos(math.rad(heading)) - offset.y * math.sin(math.rad(heading)),
        coords.y + offset.x * math.sin(math.rad(heading)) + offset.y * math.cos(math.rad(heading)),
        coords.z + offset.z
    )

    -- Move the player to the adjusted coordinates and set heading
    SetEntityCoordsNoOffset(ped, adjustedCoords.x, adjustedCoords.y, adjustedCoords.z, false, false, false)
    SetEntityHeading(ped, heading)

    -- Load the animation dictionary and play the animation using a synchronized scene
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(100)
    end

    local scene = NetworkCreateSynchronisedScene(adjustedCoords.x, adjustedCoords.y, adjustedCoords.z, 0.0, 0.0, heading, 2, true, false, 1.0, 0, 1.0)
    NetworkAddPedToSynchronisedScene(ped, scene, animDict, animName, 8.0, -8.0, 1, 0, 0.0, 0)
    NetworkStartSynchronisedScene(scene)
end

-- Add targeting zones
CreateThread(function()
    for poleId, pole in ipairs(Config.Poles) do
        exports.ox_target:addSphereZone({
            name = 'stripper_pole_' .. poleId,
            coords = pole.coords,
            radius = 1.5,
            debug = false,
            options = {
                {
                    name = 'start_dance_' .. poleId,
                    icon = 'fa-solid fa-dance',
                    label = 'Start Dancing',
                    onSelect = function()
                        -- Trigger server event to request dance
                        TriggerServerEvent('stripper_pole:requestDance', poleId, pole.offset or vector3(0.0, 0.25, 0.0))
                    end
                }
            }
        })
    end
end)

-- Listen for server confirmation to start the dance
RegisterNetEvent('stripper_pole:confirmDance', function(poleId, coords, heading, offset, animDict, animName)
    startDance(poleId, coords, heading, offset, animDict, animName)
end)
