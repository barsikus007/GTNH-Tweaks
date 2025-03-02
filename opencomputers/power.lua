event = require("event");
component = require("component")

-- #region config
local textScale = 1
local refresh = 1 / 20
local averageEUSeconds = 5
local stopValue = 0.9
local startValue = 0.8
-- #endregion config

doContinue = true

function keyPressed(event_name, player_uuid, ascii)
    local c = string.char(ascii)
    if c == 'q' then
        doContinue = false
    else
        event.register("key_down", keyPressed)
    end
end

event.register("key_down", keyPressed)


local function formatNumber(number)
    -- https://stackoverflow.com/a/10992898
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")

    -- reverse the int-string back remove an optional comma and put the
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end


--- @type table<string, Text2D>
local texts = {}
--- @type table<number>
local EUHistory = {}
local EUHistorySize = math.ceil(averageEUSeconds / refresh)
local blackColor = { 0, 0, 0 }
local redColor = { 255, 85, 85 }
local greenColor = { 85, 255, 85 }
local whiteColor = { 255, 255, 255 }
local reactorState = false
local glasses = component.glasses
local LSC = component.gt_machine
local LSCSwitch = component.redstone

---@param glasses glasses # The glasses component.
---@param key string # The key for the text.
---@param x number # The x position of the text.
---@param y number # The y position of the text.
local function createShadowText(glasses, key, x, y)
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

---@param glasses glasses # The glasses component.
local function glassesSetup(glasses)
    glasses.removeAll()
    createShadowText(glasses, "income", 0, 10)
    createShadowText(glasses, "percent", 0, 20)
    createShadowText(glasses, "storage", 0, 30)
    createShadowText(glasses, "reactor", 0, 40)
end

glassesSetup(glasses)
if startValue >= stopValue then
    print("Start value must be less than stop value")
    return
end

print("Running EU monitor... (Press q to exit)")
while doContinue do
    local storageMax = LSC.getEUMaxStored()
    local storageCurrent = LSC.getEUStored()
    local storagePercent = storageCurrent / storageMax
    EUHistory[#EUHistory + 1] = LSC.getEUInputAverage() - LSC.getEUOutputAverage()
    if #EUHistory > EUHistorySize then
        table.remove(EUHistory, 1)
    end
    local storageIncomeHistory = 0
    for i = 1, #EUHistory do
        storageIncomeHistory = storageIncomeHistory + EUHistory[i]
    end
    setShadowText("income", string.format("%s EU/t", formatNumber(math.floor(storageIncomeHistory / EUHistorySize))),
        table.unpack(storageIncomeHistory < 0 and redColor or storageIncomeHistory > 0 and greenColor or blackColor))
    setShadowText("percent", string.format("%.2f%%", storagePercent * 100))
    setShadowText("storage", string.format("%s/%s EU", formatNumber(storageCurrent), formatNumber(storageMax)))
    setShadowText("reactor", reactorState and "Reactor Enabled" or "Reactor Disabled",
        table.unpack(reactorState and greenColor or redColor))

    if storagePercent > stopValue then
        reactorState = false
        LSCSwitch.setOutput({ 0, 0, 0, 0, 0, 0 })
    end
    if storagePercent < startValue then
        reactorState = true
        LSCSwitch.setOutput({ 15, 15, 15, 15, 15, 15 })
    end
    os.sleep(refresh)
end
