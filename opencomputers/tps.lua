-- https://host7.dev/oc/tpsCard.lua
term = require("term");
event = require("event");
component = require("component");

tpsCard = component.tps_card;
gpu = component.gpu;

doContinue = true
term.clear()

gpu.set(1, 1, "Loading, please wait...")

function keyPressed(event_name, player_uuid, ascii)
    local c = string.char(ascii)
    if c=='q' then
        doContinue = false
    else
        event.register("key_down", keyPressed)
    end
end

event.register("key_down", keyPressed)


dimNames = {}

allTickTimes = tpsCard.getAllTickTimes()
for dimId, tickTime in pairs(allTickTimes) do
    dimName = tpsCard.getNameForDim(dimId)
    dimNames[dimId] = dimName
    gpu.set(1, 2, "                                                                     ")
    gpu.set(1, 2, "Loading dim "..dimName)
end

while(doContinue) do
    allTickTimes = tpsCard.getAllTickTimes()
    count = 2
    totalTickTime = 0
    term.clear()
    for dimId, tickTime in pairs(allTickTimes) do
        totalTickTime = totalTickTime + tickTime
        if(tickTime > 0.3) then
            gpu.set(1, count, tostring(dimNames[dimId]).."("..tostring(dimId)..") - "..tostring(tonumber(string.format("%.3f", tickTime))))
            count = count + 1
        end
    end

    tps = tonumber(string.format("%.3f", tpsCard.convertTickTimeIntoTps(totalTickTime)))
    gpu.set(1, 1, "Ticktime: ".. tonumber(string.format("%.3f", totalTickTime)) .. " - TPS: " ..tostring(tps))
    os.sleep(0.1)
end