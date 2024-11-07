dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

local boss = GetUpdatedEntityID()
local x, y EntityGetTransform(boss)

if GetDLDifficulty() >= 3 then
    EntityLoad("mods/divinelink/files/entities/animals/boss_wyrm/entity.xml", x, y)
end