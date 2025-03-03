-- Origin: https://host7.dev/oc/tpsCard.lua
-- Source: https://github.com/GTNewHorizons/OpenComputers/blob/master/src/main/scala/li/cil/oc/server/component/TpsCard.scala
term = require("term")
event = require("event")
component = require("component")

tpsCard = component.tps_card

refresh = 1 / 10
doContinue = true
term.clear()
gpu = term.gpu()

gpu.set(1, 1, "Loading, please wait...")

function keyPressed(event_name, player_uuid, ascii)
    local c = string.char(ascii)
    if c == 'q' then
        doContinue = false
        term.clear()
    else
        event.register("key_down", keyPressed)
    end
end

event.register("key_down", keyPressed)


allDimNames = tpsCard.getAllDims()

while (doContinue) do
    count = 2
    totalTickTime = tpsCard.getOverallTickTime()
    allTickTimes = tpsCard.getAllTickTimes()
    tps = tpsCard.convertTickTimeIntoTps(totalTickTime)
    term.clear()
    for dimId, tickTime in pairs(allTickTimes) do
        local dimName = allDimNames[dimId]
        if dimName == nil then
            allDimNames = tpsCard.getAllDims()
            dimName = allDimNames[dimId]
        end
        if (tickTime > 0.3) then
            gpu.set(1, count, string.format("%s(%d) - %.3f", allDimNames[dimId], dimId, tickTime))
            count = count + 1
        end
    end

    -- entities = tpsCard.getTileEntitiesListForDim(0)
    -- sortedEntities = {}
    -- for name, count in pairs(entities) do table.insert(sortedEntities, { name, count }) end
    -- table.sort(sortedEntities, function(a, b) return a[2] > b[2] end)
    -- for _, entity in pairs(sortedEntities) do
    --     gpu.set(1, count, string.format("%s - %d", entity[1], entity[2]))
    --     count = count + 1
    --     if count > 20 then
    --         break
    --     end
    -- end

    gpu.set(1, 1, string.format("Ticktime: %.3f - TPS: %.3f", totalTickTime, tps))
    gpu.set(1, count + 1, "(Press q to exit)")
    os.sleep(refresh)
end
