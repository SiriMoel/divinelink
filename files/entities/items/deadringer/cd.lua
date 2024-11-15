dofile_once("mods/divinelink/files/scripts/utils.lua")

local item = GetUpdatedEntityID()

local comp_cd = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "deadringer_cd") or 0
local cd = ComponentGetValue2(comp_cd, "value_int")

local comp_item = EntityGetFirstComponentIncludingDisabled(item, "ItemComponent") or 0

if cd > 0 then
    cd = cd - 2
    ComponentSetValue2(comp_cd, "value_int", cd)
    --GamePrint(cd)
    ComponentSetValue2(comp_item, "ui_sprite", "mods/divinelink/files/entities/items/deadringer/sprite_cd.png")
else
    ComponentSetValue2(comp_item, "ui_sprite", "mods/divinelink/files/entities/items/deadringer/sprite.png")
end