dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    local difficulty = GetDLDifficulty()
    local deaths_on_this_difficulty = ModSettingGet("divinelink.dotd") or 0

    if difficulty == 4 then
        deaths_on_this_difficulty = deaths_on_this_difficulty + 1
    end
    if difficulty == 3 then
        SetDLDifficulty(2)
        deaths_on_this_difficulty = 0
    end
    if difficulty == 2 then
        deaths_on_this_difficulty = deaths_on_this_difficulty + 1
        if deaths_on_this_difficulty >= ModSettingGet("divinelink.deaths_on_flesh_automaton_before_dropping_to_power_in_misery") then
            SetDLDifficulty(1)
            deaths_on_this_difficulty = 0
        end
    end
    if difficulty == 1 then
        deaths_on_this_difficulty = deaths_on_this_difficulty + 1
    end
    ModSettingSet("divinelink.dotd", deaths_on_this_difficulty)
end