dofile_once("mods/divinelink/files/scripts/utils.lua")

local host = GetUpdatedEntityID()
local x, y = EntityGetTransform(host)

math.randomseed(x, y + GameGetFrameNum())

local opts = { "orb_dark", "orb_poly", "orb_tele", "orb_weaken", }

for i=1,3 do
    local arc = math.random(0, 100) * 0.01 * math.pi * 2
    local vel_x = math.cos(arc) * 250
    local vel_y = math.sin(arc) * 250
    local which = math.random(1,#opts)
    shoot_projectile( host, "data/entities/projectiles/" .. opts[which] .. ".xml", x, y, vel_x, vel_y)
end