dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

local entity = GetUpdatedEntityID()
local comp_this = GetUpdatedComponentID()
local x, y = EntityGetTransform(entity)

math.randomseed(x, y + GameGetFrameNum())

if GetDLDifficulty() >= 3 then
    if not EntityHasTag(entity, "DL_enlightened_checked") then
        if math.random(1, 15) == 2 then
            CreateEnlightenedEnemy(entity)
        end
        EntityAddTag(entity, "DL_enlightened_checked")
    end
end