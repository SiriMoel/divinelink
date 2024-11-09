dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    local difficulty = GetDLDifficulty()

    math.randomseed(x, y + GameGetFrameNum())

    local amount = math.random(1, 4)
    for i=1,amount do
        EntityLoad("mods/divinelink/files/enlightened_attacks/bomb_bomb.xml", x, y)
    end
end