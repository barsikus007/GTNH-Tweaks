local term = require("term")
local event = require("event")
local component = require("component")
local keyboard = require("keyboard")
local sides = require("sides")

local refresh = 1 / 2
term.clear()
local gpu = term.gpu()
gpu.set(1, 1, "Loading, please wait...")

local doContinue = true
local bufferAddress = "1ae646c3-662b-41a3-878c-0ec7d37f4150"

local function keyPressed(event_name, producer_address, ascii, keyCode)
    if keyCode == keyboard.keys.q then
        doContinue = false
    else
        event.register("key_down", keyPressed)
    end
end

event.register("key_down", keyPressed)



while (doContinue) do
    local amounts = {}
    local totalAmount = 0
    local count = 1
    local buffer = component.proxy(bufferAddress)
    print(buffer.address)
    local transposers = component.list("transposer")
    -- term.clear()
    for address, _ in pairs(transposers) do
        if address == bufferAddress then
            goto continue
        end
        ---@type transposer
        local transposer = component.proxy(address)
        local fluids = transposer.getFluidInTank(sides.up)
        local side = sides.up
        if not next(fluids) then
            fluids = transposer.getFluidInTank(sides.down)
            side = sides.down
        end
        local fluid = fluids[1]
        -- antimatter
        amounts[address] = { amount = fluid.amount, side = side }
        totalAmount = totalAmount + fluid.amount
        ::continue::
    end
    for address, info in pairs(amounts) do
        local amountToBuffer = math.modf(totalAmount / 16) - info.amount
        if amountToBuffer == 0 then
            goto continue
        end
        
        print('amountToBuffer: ', amountToBuffer);
        ---@type transposer
        local transposer = component.proxy(address)
        transposer.transferFluid(info.side, sides.up, -amountToBuffer, buffer.address)
        -- component.transposer.
        ::continue::
    end

    -- gpu.set(1, count + 1, "(Press q to exit)")
    os.sleep(refresh)
end
