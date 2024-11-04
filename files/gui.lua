dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

local difficulty = 0
local dotd = 0
local difficulty_image_path = ""

function OnWorldPreUpdate()
    if GetPlayer() ~= nil then
        difficulty = GetDLDifficulty()
        dotd = ModSettingGet("divinelink.dotd") or 0
        difficulty_image_path = "mods/divinelink/files/gui/difficulty_" .. tostring(difficulty) .. ".png"
    end
end

function OnWorldPostUpdate()
    local player = GetPlayer()
    if player ~= nil then
        GuiRender()
    end
end

function GuiRender()
    local gui = GuiCreate()
    GuiStartFrame(gui)

    -- idk where to put it yet
    GuiLayoutBeginHorizontal(gui, 65, 82.5)
        GuiImage(gui, gui_id, 0, 0, difficulty_image_path, 1, 1, 1)
        --GuiText(gui, 0, 0, tostring(difficulty) .. " ")
        GuiText(gui, 0, 0, tostring(dotd) .. " ")
    GuiLayoutEnd(gui)

    GuiDestroy(gui)
end