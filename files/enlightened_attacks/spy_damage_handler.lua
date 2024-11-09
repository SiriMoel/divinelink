dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance )
    local entity = GetUpdatedEntityID()

    math.randomseed(x, y + GameGetFrameNum())

    if damage > 0 then
        if math.random(1,4) == 2 then
            return 0, 0
        else
            return damage, critical_hit_chance
        end
    end
    
    return damage, critical_hit_chance
end