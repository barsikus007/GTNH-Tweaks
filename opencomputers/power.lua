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


function glassSetup()
    glasses.removeAll()
    textIncome = glasses.addTextLabel()
    textIncome.setPosition(0, 10)
    textIncome.setScale(1)
    textIncome.setColor(1, 1, 1)
    textPercent = glasses.addTextLabel()
    textPercent.setPosition(0, 20)
    textPercent.setScale(1)
    textPercent.setColor(1, 1, 1)
    textStorage = glasses.addTextLabel()
    textStorage.setPosition(0, 30)
    textStorage.setScale(1)
    textStorage.setColor(1, 1, 1)
    textReactor = glasses.addTextLabel()
    textReactor.setPosition(0, 40)
    textReactor.setScale(1)
    textReactor.setColor(1, 1, 1)
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
glasses = component.glasses
storageMax = LSC.getEUMaxStored()

function formatNumber(number)
    -- https://stackoverflow.com/a/10992898
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")

    -- reverse the int-string back remove an optional comma and put the
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

function glassDisplayEU()
    textIncome.setColor(storageIncome < 0 and 1 or 0, storageIncome > 0 and 1 or 0, 0)
    textReactor.setColor((not reactorState) and 1 or 0, reactorState and 1 or 0, 0)
    textIncome.setText(string.format("%s EU/t", formatNumber(storageIncome)))
    textPercent.setText(string.format("%.2f%%", storagePercent * 100))
    textStorage.setText(string.format("%s/%s EU", formatNumber(storageCurrent), formatNumber(storageMax)))
    textReactor.setText(reactorState and "Reactor Enabled" or "Reactor Disabled")
end

print("Running EU monitor... (Press q to exit)")
while doContinue do
    storageCurrent = LSC.getEUStored()
    storagePercent = storageCurrent / storageMax
    storageIncome = LSC.getEUInputAverage() - LSC.getEUOutputAverage()
    glassDisplayEU()
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
