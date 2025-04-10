local event = require("event");
local component = require("component")
local keyboard = require("keyboard")

-- #region config
local textScale = 1
local refresh = 1 / 20
local stopValue = 0.9
local startValue = 0.8
local displayMetricNumbersIfAbove = 1e15
-- #endregion config

local doContinue = true

local function keyPressed(event_name, producer_address, ascii, keyCode)
    if keyCode == keyboard.keys.q then
        doContinue = false
    else
        event.register("key_down", keyPressed)
    end
end

event.register("key_up", keyPressed)

--- @param number number
--- @param format string?
local function formatMetricNumber(number, format)
    format = format or "%.1f"
    if math.abs(number) < 1000 then return tostring(math.floor(number)) end
    local suffixes = { "k", "M", "G", "T", "P", "E", "Z", "Y" }
    local power = 0
    while math.abs(number) > 1000 do
        number = number / 1000
        power = power + 1
    end
    return tostring(string.format(format, number)) .. suffixes[power]
end

--- @param number number
local function formatNumber(number)
    -- https://stackoverflow.com/a/10992898
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")

    -- reverse the int-string back remove an optional comma and put the
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

--- @param alfanum string
local function extractNumber(alfanum)
    return alfanum:match("([%d,]+)")
end

--- @param stringToCheck string
local function extractEnabled(stringToCheck)
    return stringToCheck:lower():match("enabled") ~= nil
end

--- @param alfanum string
local function tonumberSub(alfanum)
    local n, _ = alfanum:gsub(",", "")
    return tonumber(n)
end

---@param seconds number
---@param parts number
---@return string
local function humanifyTime(seconds, parts)
    -- https://github.com/Navatusein/GTNH-OC-LSC-Control/blob/09e07cfbded38490df448e7c9121ff4f9b1b9ee4/lib/gui-lib.lua#L137
    parts = (parts and tonumber(parts) or 4)

    local time_units = {
        { name = "y",   value = 31536000 },
        { name = "m",   value = 2592000 },
        { name = "d",   value = 86400 },
        { name = "hr",  value = 3600 },
        { name = "min", value = 60 },
        { name = "sec", value = 1 }
    }

    if seconds < 1 then return "0 sec" end

    local result = {}

    for _, unit in ipairs(time_units) do
        local unit_value = math.floor(seconds / unit.value)

        if unit_value > 0 then
            table.insert(result, unit_value .. " " .. unit.name)
            seconds = seconds % unit.value
        end

        if #result >= parts then break end
    end

    if #result == 0 then
        return seconds .. " sec"
    end

    return table.concat(result, " ")
end


--- @type table<string, Text2D>
local texts = {}
local BLACK_COLOR = { 0, 0, 0 }
local RED_COLOR = { 255, 85, 85 }
local GREEN_COLOR = { 85, 255, 85 }
local WHITE_COLOR = { 255, 255, 255 }
local ICON_OFFSET = 14
local generatorState = false
local glasses = component.glasses
local LSC = component.gt_machine
local LSCSwitch = component.redstone
local DB = component.isAvailable("database") and component.database or nil
if DB == nil then
    print("Install 'Database Upgrade' for fancy icons!")
end

---@class Item
---@field name string
---@field damage number
---@field nbt string?

---@param glasses glasses # The glasses component.
---@param key string # The key for the text.
---@param x number # The x position of the text.
---@param y number # The y position of the text.
---@param icon? Item # The icon to display.
local function createShadowText(glasses, key, x, y, icon)
    y = y * 10
    if DB ~= nil and icon ~= nil then
        DB.clear(1)
        DB.set(y / 10, icon.name, icon.damage, icon.nbt)
        local icon = glasses.addItem()
        icon.setPosition(x - 2, y - 4)
        icon.setItem(DB.address, y / 10)
        icon.setScale(0.5)
        x = x + ICON_OFFSET
    end
    texts[key .. "shadow"] = glasses.addTextLabel()
    texts[key .. "shadow"].setPosition(x + 1, y + 1)
    texts[key .. "shadow"].setScale(textScale)
    texts[key .. "shadow"].setColor(63 / 255, 63 / 255, 63 / 255)
    texts[key] = glasses.addTextLabel()
    texts[key].setPosition(x, y)
    texts[key].setScale(textScale)
    texts[key].setColor(1, 1, 1)
end

---@param key string # The key for the text.
---@param text string # The text to display.
---@param r number? # The red component from `0` to `255`.
---@param g number? # The green component from `0` to `255`.
---@param b number? # The blue component from `0` to `255 `.
local function setShadowText(key, text, r, g, b)
    texts[key .. "shadow"].setText(text)
    texts[key].setText(text)
    if r == nil or g == nil or b == nil then
        return
    end
    texts[key .. "shadow"].setColor(r / 1028, g / 1028, b / 1028)
    texts[key].setColor(r / 255, g / 255, b / 255)
end

---@param DB database? # The database component.
local function fillDatabase(DB)
    if DB == nil then
        return
    end
end

---@param glasses glasses # The glasses component.
local function glassesSetup(glasses)
    glasses.removeAll()
    createShadowText(glasses, "income", 0, 1,
        { name = "universalsingularities:universal.general.singularity", damage = 20, nbt = nil })
    createShadowText(glasses, "percent", 0, 2, { name = "gregtech:gt.metaitem.01", damage = 32762, nbt = nil })
    -- "{GT.ItemCharge:"..math.ceil(storagePercent*9223372036854775807).."L}"
    createShadowText(glasses, "storage", 0, 3, { name = "gregtech:gt.metaitem.01", damage = 32609, nbt = nil })
    createShadowText(glasses, "generator", 0, 4, { name = "gregtech:gt.metaitem.01", damage = 32416, nbt = nil })
end

fillDatabase(DB)
glassesSetup(glasses)
if startValue >= stopValue then
    print("Start value must be less than stop value")
    return
end

print("Running EU monitor... (Press q to exit)")
while doContinue do
    -- for k,v in pairs(component.gt_machine.getSensorInformation()) do print(k,v) end
    local sensorData = LSC.getSensorInformation()
    local storageStoredText = extractNumber(sensorData[2])
    local storageCapacityText = extractNumber(sensorData[5])
    local EUInputAverageText = extractNumber(sensorData[10])
    local EUOutputAverageText = extractNumber(sensorData[11])
    -- local storageChargeLeftShow = sensorData[16]
    local storageChargeLeft = 0
    local wirelessEnabled = extractEnabled(sensorData[18])
    local storageLocalStored = tonumberSub(storageStoredText)
    local storageCapacity = tonumberSub(storageCapacityText)
    local EUInputAverage = tonumberSub(EUInputAverageText)
    local EUOutputAverage = tonumberSub(EUOutputAverageText)
    local storageStored = storageLocalStored
    if wirelessEnabled then
        local storageStoredWirelessText = extractNumber(sensorData[23])
        local storageCurrentWireless = tonumberSub(storageStoredWirelessText)
        storageStored = storageStored + storageCurrentWireless
    end
    local storagePercent = storageStored / storageCapacity
    local EUIncome = EUInputAverage - EUOutputAverage
    if EUIncome > 0 then
        storageChargeLeft = (storageCapacity - storageStored) / EUIncome
    elseif EUIncome < 0 then
        storageChargeLeft = storageStored / -EUIncome
    else
        storageChargeLeft = 0
    end
    storageChargeLeft = math.floor(storageChargeLeft / 20)

    local EUIncomeShow = EUIncome > displayMetricNumbersIfAbove
        and formatMetricNumber(EUIncome)
        or formatNumber(EUIncome)
    local storageLocalStoredShow = formatMetricNumber(storageLocalStored)
    local storageStoredShow = storageStored > displayMetricNumbersIfAbove
        and formatMetricNumber(storageStored)
        or storageStoredText
    local storageCapacityShow = storageCapacity > displayMetricNumbersIfAbove and
        formatMetricNumber(storageCapacity) or storageCapacityText
    local storageChargeLeftShow = humanifyTime(storageChargeLeft, 2)

    setShadowText("income", string.format("%s EU/t", EUIncomeShow),
        table.unpack(EUIncome < 0 and RED_COLOR or EUIncome > 0 and GREEN_COLOR or BLACK_COLOR))
    setShadowText("percent", string.format(storagePercent < 0.01 and "%.6f%%" or "%.2f%%", storagePercent * 100))
    setShadowText("storage",
        string.format("%s/%s EU (Local: %s EU)", storageStoredShow, storageCapacityShow, storageLocalStoredShow))
    setShadowText("generator",
        string.format("Generator %s (Dis/charge time: %s)",
            generatorState and "Enabled" or "Disabled",
            storageChargeLeftShow),
        table.unpack(generatorState and GREEN_COLOR or RED_COLOR))

    if storagePercent > stopValue then
        generatorState = false
        LSCSwitch.setOutput({ 0, 0, 0, 0, 0, 0 })
    end
    if storagePercent < startValue then
        generatorState = true
        LSCSwitch.setOutput({ 15, 15, 15, 15, 15, 15 })
    end
    os.sleep(refresh)
end
