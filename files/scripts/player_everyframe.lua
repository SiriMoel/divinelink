dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

local difficulty = GetDLDifficulty()

if difficulty == 4 then
    GamePrint("HOPE ERADICTAED")
end
if difficulty == 3 then
    GamePrint("DIVINE LIGHT")
end
if difficulty == 2 then
    GamePrint("FLESH AUTOMATON")
end
if difficulty == 1 then
    GamePrint("POWER IN MISERY")
end