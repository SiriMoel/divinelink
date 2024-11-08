dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

local wyrm = GetUpdatedEntityID()
local x, y = EntityGetTransform(wyrm)
local difficulty = GetDLDifficulty()

if #EntityGetInRadiusWithTag(x, y, 3, "player_unit") > 0 then
    if difficulty == 3 then
        ChangeDifficultyDuringRun(2)
        GamePrint("DIVINE LIGHT SEVERED")
    end
end