--// Redz Kill Aura
--// by bạn 😎

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0.5, -125, 0.4, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = ScreenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Redz Kill Aura"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundColor3 = Color3.fromRGB(20,20,20)
title.Parent = mainFrame

local killAuraBtn = Instance.new("TextButton")
killAuraBtn.Size = UDim2.new(1, 0, 0, 40)
killAuraBtn.Position = UDim2.new(0, 0, 0, 50)
killAuraBtn.Text = "Kill Aura: OFF"
killAuraBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
killAuraBtn.TextColor3 = Color3.new(1,1,1)
killAuraBtn.Parent = mainFrame

local rangeBox = Instance.new("TextBox")
rangeBox.Size = UDim2.new(1, -20, 0, 30)
rangeBox.Position = UDim2.new(0, 10, 0, 100)
rangeBox.PlaceholderText = "Khoảng cách (mặc định 15)"
rangeBox.Text = ""
rangeBox.TextColor3 = Color3.new(1,1,1)
rangeBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
rangeBox.Parent = mainFrame

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(1, 0, 0, 40)
hideButton.Position = UDim2.new(0, 0, 0, 140)
hideButton.Text = "Ẩn Menu"
hideButton.BackgroundColor3 = Color3.fromRGB(0, 0, 120)
hideButton.TextColor3 = Color3.new(1,1,1)
hideButton.Parent = mainFrame

-- Variables
local killAuraEnabled = false
local range = 15

-- Functions
killAuraBtn.MouseButton1Click:Connect(function()
    killAuraEnabled = not killAuraEnabled
    if killAuraEnabled then
        killAuraBtn.Text = "Kill Aura: ON"
        killAuraBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    else
        killAuraBtn.Text = "Kill Aura: OFF"
        killAuraBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    end
end)

rangeBox.FocusLost:Connect(function()
    local val = tonumber(rangeBox.Text)
    if val and val > 0 then
        range = val
    else
        range = 15
    end
end)

hideButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Toggle menu bằng phím RightShift
UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- Kill Aura loop
RunService.RenderStepped:Connect(function()
    if killAuraEnabled and character and character:FindFirstChild("HumanoidRootPart") then
        local root = character.HumanoidRootPart
        for _, mob in pairs(workspace:GetDescendants()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                local hrp = mob.HumanoidRootPart
                if (hrp.Position - root.Position).Magnitude <= range and mob.Humanoid.Health > 0 then
                    -- Tấn công mob (giả lập click)
                    pcall(function()
                        -- sửa hàm attack theo game bạn, ví dụ:
                        mob.Humanoid:TakeDamage(10)
                    end)
                end
            end
        end
    end
end)
