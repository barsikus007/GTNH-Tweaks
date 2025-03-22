-- Origin: https://host7.dev/oc/tpsCard.lua
-- Source: https://github.com/GTNewHorizons/OpenComputers/blob/master/src/main/scala/li/cil/oc/server/component/TpsCard.scala
local term = require("term")
local event = require("event")
local component = require("component")

local tpsCard = component.tps_card

local refresh = 1 / 10
term.clear()
local gpu = term.gpu()
gpu.set(1, 1, "Loading, please wait...")

local doContinue = true

local function keyPressed(event_name, player_uuid, ascii)
    if ascii < 256 and string.char(ascii) == 'q' then
        doContinue = false
    else
        event.register("key_down", keyPressed)
    end
end

event.register("key_down", keyPressed)


local allDimNames = tpsCard.getAllDims()

while (doContinue) do
    local count = 2
    local totalTickTime = tpsCard.getOverallTickTime()
    local allTickTimes = tpsCard.getAllTickTimes()
    local tps = tpsCard.convertTickTimeIntoTps(totalTickTime)
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

    -- local entities = tpsCard.getTileEntitiesListForDim(0)
    -- local sortedEntities = {}
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
