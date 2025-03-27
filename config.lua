Config = {}

-- Allowed jobs for accessing stripper poles
Config.AllowedJobs = { 'bahamamamas', 'vanillaunicorn', 'dancer' }

-- Pole locations with customizable offsets
Config.Poles = {
    { name = "Pole1", coords = vector3(-1393.77, -612.25, 30.58), heading = 30.0, offset = vector3(0.0, 0.25, 0.0) },
    { name = "Pole2", coords = vector3(-1390.83, -616.81, 30.58), heading = 30.0, offset = vector3(0.0, 0.25, 0.0) },
}

-- Dance animations
Config.Dances = {
    { label = "Dance 1", animDict = "mini@strip_club@pole_dance@pole_dance1", animName = "pd_dance_01" }
}
