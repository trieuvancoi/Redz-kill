-- Redz Kill Aura | Loader
local url = "https://raw.githubusercontent.com/trieuvancoi/Redz-kill/main/Main.lua"

local success, response = pcall(function()
    return game:HttpGet(url)
end)

if success and response then
    local func, err = loadstring(response)
    if func then
        func()
        print("[Redz Kill Aura] Main.lua loaded thành công!")
    else
        warn("[Redz Kill Aura] Lỗi loadstring:", err)
    end
else
    warn("[Redz Kill Aura] Không thể tải script từ GitHub")
end
