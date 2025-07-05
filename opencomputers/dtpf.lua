local event = require("event")
local component = require("component")
local keyboard = require("keyboard")

local me_interface = component.me_interface
local redstone = component.redstone

local refresh = 1 / 20
local doContinue = true

local function keyPressed(event_name, producer_address, ascii, keyCode)
    if keyCode == keyboard.keys.q then
        doContinue = false
    else
        event.register("key_down", keyPressed)
    end
end

event.register("key_down", keyPressed)


print("Running DTPF monitor... (Press q to exit)")
while (doContinue) do
    if #me_interface.getFluidsInNetwork() > 1 then
        redstone.setOutput({ 15, 15, 15, 15, 15, 15 })
    else
        redstone.setOutput({ 0, 0, 0, 0, 0, 0 })
    end
    os.sleep(refresh)
end
