dofile_once("mods/souls/files/scripts/utils.lua")

local item = GetUpdatedEntityID()

local comp_cd = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "deadringer_cd") or 0
local cd = ComponentGetValue2(comp_cd, "value_int")

local comp_item = EntityGetFirstComponentIncludingDisabled(item, "ItemComponent") or 0

local player = GetPlayer()

local player_hp = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent") or 0, "hp")

if cd <= 0 then
    if player_hp < ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "player_health_old") or 0, "value_int") then
        LoadGameEffectEntityTo(player, "mods/souls/files/entities/items/deadringer/buff.xml")
        ComponentSetValue2(comp_cd, "value_int", 480)
    end
end