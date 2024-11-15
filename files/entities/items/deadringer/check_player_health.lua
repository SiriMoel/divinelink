dofile_once("mods/divinelink/files/scripts/utils.lua")

local item = GetUpdatedEntityID()

local player = GetPlayer()

local player_hp = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent") or 0, "hp")

ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "player_health_old") or 0, "value_int", player_hp)