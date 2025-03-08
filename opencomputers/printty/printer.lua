bit32 = require("bit32")
local component = require("component")
local shell = require("shell")

local PNGImage = require('libPNGimage')
---@type printer3d
local printer = component.printer3d

image_title = "big §4sus"
image_input = "amogus64x.png"
file = io.open(image_input, "rb")
if file == nil then
    print("Failed to open file: " .. image_input)
    return
end
print("Load png")
local pngimage = PNGImage.newFromFileHandle(file)
file:close()
print("Png loaded")
local image_w, image_h = pngimage:getSize()
if image_w > 64 or image_h > 64 then
    return
end

local chunk_size = 16
print("Size: [" .. image_w .. ", " .. image_h .. "]")
local image_chunk_x = math.ceil(image_w / chunk_size)
local image_chunk_y = math.ceil(image_h / chunk_size)
print("Chunks: [" .. image_chunk_x .. ", " .. image_chunk_y .. "]")

local function addCuboid(start_x, end_x, y)
    print("Cuboid [" .. start_x .. ", " .. end_x .. "]; y " .. y .. "]")
    local size = 1
    local x = start_x
    local r, g, b, a = pngimage:getPixel(x, y)
    local tint = r * 0x10000 + g * 0x100 + b
    local rn, gn, bn, an = pngimage:getPixel(x + 1, y)
    local nextTint = rn * 0x10000 + gn * 0x100 + bn
    while nextTint == tint and an == a do
        x = x + 1
        -- print("while " .. x)
        size = size + 1
        if x >= end_x then
            break
        end
        rn, gn, bn, an = pngimage:getPixel(x + 1, y)
        nextTint = rn * 0x10000 + gn * 0x100 + bn
    end
    return size, tint, a
end

local function addRow(start_x, end_x, y)
    local x = start_x
    while x < end_x do
        local size, tint, alpha = addCuboid(x, end_x, image_h - y - 1)
        print("Cub size " .. size,
            ", " .. "tint " .. tint .. ", " .. "alpha " .. alpha .. ", " .. "x " .. x .. ", " .. "y " .. y)
        if alpha == 0 then
            goto continue
        end
        print("Adding shape at [" ..
            x % chunk_size ..
            ", " ..
            y % chunk_size ..
            ", " .. x % chunk_size + size .. ", " .. y % chunk_size + 1 .. "] with tint " .. tint)
        -- os.sleep(1)
        printer.addShape(x % chunk_size, y % chunk_size, 15, x % chunk_size + size, y % chunk_size + 1,
            16, "opencomputers:White", false, tint)
        ::continue::
        x = x + size
    end
end

local function printChunk(chunk_x, chunk_y)
    local chunk_y_max = (chunk_y + 1) * chunk_size - 1
    local chunk_x_max = (chunk_x + 1) * chunk_size - 1
    print("Chunk max [" .. tostring(chunk_x_max) .. ", " .. tostring(chunk_y_max) .. "]")
    printer.reset()
    printer.setLabel(image_title)
    printer.setTooltip("[" .. tostring(chunk_x) .. ", " .. tostring(chunk_y) .. "]")
    for y = chunk_y * chunk_size, chunk_y_max do
        -- print("Row " .. y + 1 .. " of " .. image_h .. " start")
        addRow(chunk_x * chunk_size, chunk_x_max, y)
        -- print("Row " .. y + 1 .. " of " .. image_h .. " done")
    end
    print("Chunk [" ..
        tostring(chunk_x) ..
        ", " .. tostring(chunk_y) .. "] of " .. "[" .. image_chunk_x - 1 .. ", " .. image_chunk_y - 1 .. "]" .. " done")
    print(printer.status())
    print("Committing successfully" and printer.commit() or "Commit failed")
    status, progress = printer.status()
    while status == "busy" do
        print("Progress: " .. tostring(progress))
        os.sleep(0.25)
        status, progress = printer.status()
    end
end


for chunk_y = 0, image_chunk_y - 1 do
    for chunk_x = 0, image_chunk_x - 1 do
        -- if chunk_y < 1 then
        --     goto continue
        -- end
        -- if chunk_x ~= 2 then
        --     goto continue
        -- end
        -- if chunk_y ~= 0 then
        --     goto continue
        -- end
        print("Chunk [" .. tostring(chunk_x) .. ", " .. tostring(chunk_y) .. "] start")
        printChunk(chunk_x, chunk_y)
        ::continue::
    end
end
