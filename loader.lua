-- Redz Kill Aura | Loader
local url = "https://raw.githubusercontent.com/trieuvancoi/Redz-kill/main/Main.lua"

local success, response = pcall(function()
    return game:HttpGet(url)
end)

if success then
    loadstring(response)()
else
    warn("[Redz Kill Aura] Không thể tải script từ GitHub")
end
