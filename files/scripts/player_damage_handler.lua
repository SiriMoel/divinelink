dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance )
    local player = GetUpdatedEntityID()
    local helditem = HeldItem(player)

    math.randomseed(x + GameGetFrameNum(), y + GameGetFrameNum())

    if GetDLDifficulty() == 4 and math.random(1, 25) == 2 then
        damage = damage * 2
        GamePrint("Ouch!")
    end

    if damage > 0 then
        if EntityHasTag(helditem, "dl_deadringer") then
            local comp_cd = EntityGetFirstComponentIncludingDisabled(helditem, "VariableStorageComponent", "deadringer_cd") or 0
            local cd = ComponentGetValue2(comp_cd, "value_int")
            if cd <= 0 then
                local effects_to_remove = { "WET", "OILY", "BLOODY", "RADIOACTIVE", "ON_FIRE" }
                for i,v in ipairs(effects_to_remove) do
                    EntityRemoveStainStatusEffect(player, v)
                end
                LoadGameEffectEntityTo(player, "mods/divinelink/files/entities/items/deadringer/buff.xml")
                ComponentSetValue2(comp_cd, "value_int", 900)
                GamePrint("Feigned death!")
                GamePlaySound("data/audio/Desktop/explosions.bank", "explosions/electric", x, y)
                LoadRagdoll("data/ragdolls/player/filenames.txt" , x, y-5)
                return 0, 0
            else
                return damage, critical_hit_chance
            end
        end
    end

    return damage, critical_hit_chance
end