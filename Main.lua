-- Redz Kill Aura | Main
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

repeat task.wait() until LocalPlayer.Character
local Character = LocalPlayer.Character
local Root = Character:WaitForChild("HumanoidRootPart")

-- Config
getgenv().KillAuraEnabled = false
getgenv().KillAuraRange = 25
getgenv().KillAuraMaxTargets = 3
getgenv().KillPlayers = true
getgenv().KillMobs = true

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 220)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0, 5)

local function makeButton(text, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local toggleBtn = makeButton("Kill Aura: OFF", function()
    getgenv().KillAuraEnabled = not getgenv().KillAuraEnabled
    toggleBtn.Text = "Kill Aura: " .. (getgenv().KillAuraEnabled and "ON" or "OFF")
    toggleBtn.BackgroundColor3 = getgenv().KillAuraEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
end)

local rangeBtn = makeButton("Range: "..getgenv().KillAuraRange, function()
    getgenv().KillAuraRange = getgenv().KillAuraRange + 5
    if getgenv().KillAuraRange > 50 then getgenv().KillAuraRange = 5 end
    rangeBtn.Text = "Range: "..getgenv().KillAuraRange
end)

local maxBtn = makeButton("Max Targets: "..getgenv().KillAuraMaxTargets, function()
    getgenv().KillAuraMaxTargets = getgenv().KillAuraMaxTargets + 1
    if getgenv().KillAuraMaxTargets > 5 then getgenv().KillAuraMaxTargets = 1 end
    maxBtn.Text = "Max Targets: "..getgenv().KillAuraMaxTargets
end)

local playersBtn = makeButton("Đánh Player: "..(getgenv().KillPlayers and "ON" or "OFF"), function()
    getgenv().KillPlayers = not getgenv().KillPlayers
    playersBtn.Text = "Đánh Player: "..(getgenv().KillPlayers and "ON" or "OFF")
end)

local mobsBtn = makeButton("Đánh Quái: "..(getgenv().KillMobs and "ON" or "OFF"), function()
    getgenv().KillMobs = not getgenv().KillMobs
    mobsBtn.Text = "Đánh Quái: "..(getgenv().KillMobs and "ON" or "OFF")
end)

-- Nút ẩn menu
local toggleMenuBtn = makeButton("Ẩn Menu", function()
    Frame.Visible = not Frame.Visible
end)

-- Tìm mục tiêu
local function getTargets()
    local found = {}

    -- Player
    if getgenv().KillPlayers then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (plr.Character.HumanoidRootPart.Position - Root.Position).Magnitude
                if dist <= getgenv().KillAuraRange and plr.Character:FindFirstChild("Humanoid").Health > 0 then
                    table.insert(found, plr.Character)
                end
            end
        end
    end

    -- Quái (giả sử folder tên "Enemies")
    if getgenv().KillMobs and workspace:FindFirstChild("Enemies") then
        for _, mob in ipairs(workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                local dist = (mob.HumanoidRootPart.Position - Root.Position).Magnitude
                if dist <= getgenv().KillAuraRange and mob.Humanoid.Health > 0 then
                    table.insert(found, mob)
                end
            end
        end
    end

    -- Giới hạn số lượng
    local limited = {}
    for i = 1, math.min(getgenv().KillAuraMaxTargets, #found) do
        table.insert(limited, found[i])
    end
    return limited
end

-- Hàm đánh (thay bằng remote game bạn)
local function attack(target)
    -- ví dụ: game.ReplicatedStorage.Remotes.Attack:FireServer(target)
    print("Đánh:", target.Name)
end

-- Loop Kill Aura
RunService.RenderStepped:Connect(function()
    pcall(function()
        if getgenv().KillAuraEnabled and Root then
            local targets = getTargets()
            for _, t in ipairs(targets) do
                attack(t)
            end
        end
    end)
end)
