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

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 180)
Frame.Position = UDim2.new(0.2, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0,5)

-- Nút toggle menu
local toggleMenu = Instance.new("TextButton", ScreenGui)
toggleMenu.Size = UDim2.new(0,40,0,40)
toggleMenu.Position = UDim2.new(0,10,0,150)
toggleMenu.BackgroundColor3 = Color3.fromRGB(0,170,255)
toggleMenu.Text = "≡"
toggleMenu.TextScaled = true
toggleMenu.TextColor3 = Color3.new(1,1,1)

local menuVisible = true
toggleMenu.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    Frame.Visible = menuVisible
end)

-- Button
local function makeButton(text, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1,-10,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local toggleBtn = makeButton("Kill Aura: OFF", function()
    getgenv().KillAuraEnabled = not getgenv().KillAuraEnabled
    toggleBtn.Text = "Kill Aura: " .. (getgenv().KillAuraEnabled and "ON" or "OFF")
end)

-- Attack giả (bạn phải đổi remote game bạn)
local function attack(target)
    print("Đánh:", target.Name)
    -- ví dụ: game.ReplicatedStorage.Remotes.Attack:FireServer(target)
end

-- Vòng lặp kill aura
RunService.RenderStepped:Connect(function()
    if getgenv().KillAuraEnabled and Root then
        -- ở đây tạm chưa lọc mục tiêu, chỉ log
    end
end)
