dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    local difficulty = GetDLDifficulty()

    math.randomseed(x, y + GameGetFrameNum())

    if difficulty == 4 then
        local amount = math.random(0, 3)
        for i=1,amount do
            EntityLoad("mods/divinelink/files/entities/animals/wriggler/entity.xml", x, y)
        end
    end
end