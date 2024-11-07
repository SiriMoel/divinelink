dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")
dofile_once("data/scripts/items/drop_money.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    GamePrint("Foe unenlightened!")

	local which = math.random(1,1000)

	if which == 2 then
		EntityLoad("mods/divinelink/files/entities/misc/moonflower/thing.xml", x, y)
	else
		do_money_drop(1, false)
	end
end