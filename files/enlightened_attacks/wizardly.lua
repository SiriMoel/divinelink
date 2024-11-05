dofile_once("mods/divinelink/files/scripts/utils.lua")

local host = GetUpdatedEntityID()
local x, y = EntityGetTransform(host)

math.randomseed(x, y + GameGetFrameNum())

local opts = { "orb_dark", "orb_poly", "orb_tele" }

local which = math.random(1,#opts)

-- will probably redo this, this is just stolen tales code atm

local count = 3
local radius = 9

local px = 0
local py = 0

local v_px = 0
local v_py = 0

local arc = 360 / count -- idk if this is the right word but math is stupid anyways

for i=1,count do
    px = x + radius
    py = y + ( 9 * math.tan(arc) )

    v_px = px
    if math.random(1,2) == 2 then
        v_px = v_px * -1
    end
    v_py = py

    shoot_projectile( host, "data/entities/projectiles/" .. opts[which] .. ".xml", px, py, v_px, v_py)

    arc = arc + ( 360 / count )
end