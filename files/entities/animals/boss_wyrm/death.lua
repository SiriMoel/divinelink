dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    local drops = {
        "mods/divinelink/files/entities/misc/moonflower/thing.xml",
        "mods/divinelink/files/entities/difficulty_orbs/divinelight/thing.xml",
        "data/entities/items/pickup/safe_haven.xml",
        "data/entities/items/pickup/spell_refresh.xml",
        "data/entities/items/pickup/chest_random.xml",
        "data/entities/items/pickup/bloodmoney_10000.xml",
        -- dead ringer ?
    }

    local which = math.random(1,#drops)

    if GetDLDifficulty() >= 3 then
        EntityLoad(drops[which], x, y)
    end
end