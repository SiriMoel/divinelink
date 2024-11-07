dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

local difficulty = 0
local dotd = 0
local difficulty_image_path = ""
local image_dead = ""
local text = ""
local text_dead = ""
local hasbeenalive = false

function OnWorldPreUpdate()
    if GetPlayer() ~= nil then
        difficulty = GetDLDifficulty()
        dotd = ModSettingGet("divinelink.dotd") or 0
        difficulty_image_path = "mods/divinelink/files/gui/difficulty_" .. tostring(difficulty) .. ".png"
        if difficulty == 4 then
            text = "ff374f727ce9d6de93be0793733c321"
            text_dead = "ff374f727ce9d6de93be0793733c321"
                        image_dead = ""
        end
        if difficulty == 3 then
            text = "DIVINE LINK INTACT"
            text_dead = ""
            image_dead = "mods/divinelink/files/gui/divine_light_severed.png"
        end
        if difficulty == 2 then
            text = "Weakness."
            text_dead = "YOU ARE A FLESH AUTOMATON ANIMATED BY NEUROTRANSMITTERS"
            image_dead = ""
        end
        if difficulty == 1 then
            text = "Drink blood today!"
            text_dead = "POWER IN MISERY!!!"
            image_dead = ""
        end
    end
end

function OnWorldPostUpdate()
    local player = GetPlayer()
    if player ~= nil then
        GuiRenderWhenAlive()
        hasbeenalive = true
    elseif hasbeenalive then
        GuiRenderWhenDead()
    end
end

function GuiRenderWhenAlive()
    local gui = GuiCreate()
    GuiStartFrame(gui)

    GuiLayoutBeginHorizontal(gui, 65, 82.5)
        GuiImage(gui, gui_id, 0, 0, difficulty_image_path, 1, 1, 1)
        GuiLayoutBeginVertical(gui, 0, 0)
            GuiText(gui, 0, 0, tostring(dotd))
            GuiText(gui, 0, 0, text)
        GuiLayoutEnd(gui)
    GuiLayoutEnd(gui)

    GuiDestroy(gui)
end

function GuiRenderWhenDead()
    local gui = GuiCreate()
    GuiStartFrame(gui)

    GuiLayoutBeginVertical(gui, 10, 40)
        GuiText(gui, 0, 0, text_dead)
        GuiImage(gui, gui_id, 0, 0, image_dead, 1, 1, 1)
    GuiLayoutEnd(gui)

    GuiDestroy(gui)
end