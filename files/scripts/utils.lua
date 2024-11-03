dofile_once("data/scripts/lib/utilities.lua")

function flipbool(boolean) -- the real function flipbool()
    return not boolean
end

---@param bool boolean
---this is the greatest function of all time, it flips a boolean. true -> false and false -> true.
function flipboolean(bool) -- honestly quite incredible.
    if string.sub(tostring(bool), 1, 1) == "t" then
        bool = false
        return bool
    elseif string.sub(tostring(bool), 1, 1) == "f" then
        bool = true
        return bool
    end
end

function GetPlayer()
    local player = EntityGetWithTag("player_unit")[1]
    return player
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
    end
end
    return false
end

function SetFileContent(toset, content)
    ModTextFileSetContent(toset, ModTextFileGetContent("mods/souls/files/set/" .. content))
end

function IsInRadiusOf(xa, ya, xb, yb, radius) -- i dont think this works, isnt needed anyway.
    if xa - xb < radius and ya - yb < radius then
        return true
    end
    return false
end

---@param entity_id integer
---@param material_name string
---@return number
function GetAmountOfMaterialInInventory(entity_id, material_name) -- stolen from https://github.com/Priskip/purgatory
    local amount = 0
    local mat_inv_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "MaterialInventoryComponent") or 0
    local count_per_material_type = ComponentGetValue2(mat_inv_comp, "count_per_material_type")

    for i,v in ipairs(count_per_material_type) do
        if v ~= 0 then
            if CellFactory_GetName(i - 1) == material_name then
                amount = v
            end
        end
    end

    return amount
end

function GetMoney()
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    return money
end

function SetMoney(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    ComponentSetValue2(comp_wallet, "money", amount)
end

function CanAfford(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    if money >= amount then
        return true
    else
        return false
    end
end

---@param spent boolean if the player's money_spent should be increased.
function ReduceMoney(amount, spent)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    local moneyspent = ComponentGetValue2(comp_wallet, "money_spent")
    if CanAfford(amount) == false then
        GamePrint("You cannot afford that.")
        return
    end
    money = money - amount
    ComponentSetValue2(comp_wallet, "money", money)
    if spent == true then
        moneyspent = moneyspent + amount
        ComponentSetValue2(comp_wallet, "money_spent", moneyspent)
    end
end

function AddMoney(amount)
    local player = EntityGetWithTag("player_unit")[1]
    local comp_wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent") or 0
    local money = ComponentGetValue2(comp_wallet, "money")
    money = money + amount
    ComponentSetValue2(comp_wallet, "money", money)
end

function HeldItem(player)
    local comp_inv = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component") or 0
    local held_item = ComponentGetValue2(comp_inv, "mActiveItem")
    return held_item
end