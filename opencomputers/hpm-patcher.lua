local hpm_file_path = "/usr/bin/hpm.lua"
local hpm_file = io.open(hpm_file_path, "r")
if hpm_file == nil then
    print("hpm not installed: " .. hpm_file_path)
    return
end
---@type string
local hpm_file_content = hpm_file:read("*a")
hpm_file:close()

print("Patching hpm.lua")
print("Replacing http with https")
oldLen = #hpm_file_content
hpm_file_content = hpm_file_content:gsub(
    "yY=function%(EyljhkFp,uGDn542,DQ%)\n",
    'yY=function(EyljhkFp,uGDn542,DQ) EyljhkFp=EyljhkFp:gsub("http://","https://")\n')
newLen = #hpm_file_content

if oldLen == newLen then
    print("Nothing to patch in hpm.lua")
    return
end
print(oldLen .. " -> " .. newLen)

local hpm_file = io.open(hpm_file_path, "w")
if hpm_file == nil then
    print("Failed to open file for writing: " .. hpm_file_path)
    return
end
hpm_file:write(hpm_file_content)
hpm_file:close()
