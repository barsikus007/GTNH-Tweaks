event = require("event");
component = require("component")

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


--- @type table<string, Text2D>
local texts = {}
local textScale = 1

---@param glasses glasses The glasses component.
---@param key string The key for the text.
---@param x number The x position of the text.
---@param y number The y position of the text.
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

---@param key string The key for the text.
---@param text string The text to display.
---@param r number? # The red component from `0.0` to `1.0`.
---@param g number? # The green component from `0.0` to `1.0`.
---@param b number? # The blue component from `0.0` to `1.0`.
local function setShadowText(key, text, r, g, b)
    texts[key .. "shadow"].setText(text)
    texts[key].setText(text)
    if r == nil or g == nil or b == nil then
        return
    end
    texts[key .. "shadow"].setColor(r / 4, g / 4, b / 4)
    texts[key].setColor(r, g, b)
end

---@param glasses glasses The glasses component.
local function glassesSetup(glasses)
    glasses.removeAll()
    createShadowText(glasses, "income", 0, 10)
    createShadowText(glasses, "percent", 0, 20)
    createShadowText(glasses, "storage", 0, 30)
    createShadowText(glasses, "reactor", 0, 40)
end

refresh = 1 / 5
stopValue = 0.9
startValue = 0.8
if startValue >= stopValue then
    print("Start value must be less than stop value")
    return
end
reactorState = false
LSC = component.gt_machine
LSCSwitch = component.redstone
storageMax = LSC.getEUMaxStored()
glasses = component.glasses
glassesSetup(glasses)

local function formatNumber(number)
    -- https://stackoverflow.com/a/10992898
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")

    -- reverse the int-string back remove an optional comma and put the
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

local function glassesDisplayEU()
    setShadowText("income", string.format("%s EU/t", formatNumber(storageIncome)),
        storageIncome < 0 and 1 or 0, storageIncome > 0 and 1 or 0, 0)
    setShadowText("percent", string.format("%.2f%%", storagePercent * 100))
    setShadowText("storage", string.format("%s/%s EU", formatNumber(storageCurrent), formatNumber(storageMax)))
    setShadowText("reactor", reactorState and "Reactor Enabled" or "Reactor Disabled",
        (not reactorState) and 1 or 0, reactorState and 1 or 0, 0)
end

print("Running EU monitor... (Press q to exit)")
while doContinue do
    storageCurrent = LSC.getEUStored()
    storagePercent = storageCurrent / storageMax
    storageIncome = LSC.getEUInputAverage() - LSC.getEUOutputAverage()
    glassesDisplayEU()
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
