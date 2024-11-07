dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")
dofile_once( "data/scripts/game_helpers.lua" )

function item_pickup( entity_item, entity_who_picked, name )
	GamePrintImportant( "HOPE ERADICATED", "" )

	local x, y = EntityGetTransform( entity_who_picked )
	--local child_id = EntityLoad( "data/entities/misc/orb_boss_scream.xml", x, y )
	--EntityAddChild( entity_who_picked, child_id )
	shoot_projectile( entity_who_picked, "data/entities/particles/image_emitters/orb_effect.xml", x, y, 0, 0 )
	
	ChangeDifficultyDuringRun(4)

	EntityKill( entity_item )
end