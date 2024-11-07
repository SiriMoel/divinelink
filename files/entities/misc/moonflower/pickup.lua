dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")
dofile_once( "data/scripts/game_helpers.lua" )

function item_pickup( entity_item, entity_who_picked, name )
	local x, y = EntityGetTransform( entity_who_picked )

	local effect = EntityLoad( "mods/divinelink/files/entities/misc/moonflower/effect.xml", x, y )
	EntityAddChild( entity_who_picked, effect )

	EntityKill( entity_item )
end