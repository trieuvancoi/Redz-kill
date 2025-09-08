-- Redz Kill Aura | Main
-- Chính thức

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Nút mở lại menu
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0,120,0,40)
ToggleButton.Position = UDim2.new(0,10,0,200)
ToggleButton.Text = "Open Menu"
ToggleButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Visible = true

-- Frame menu
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0,220,0,180)
MainFrame.Position = UDim2.new(0.5,-110,0.5,-90)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

-- Kill Aura toggle
local AuraButton = Instance.new("TextButton", MainFrame)
AuraButton.Size = UDim2.new(0,200,0,30)
AuraButton.Position = UDim2.new(0,10,0,10)
AuraButton.Text = "Kill Aura: OFF"
AuraButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
AuraButton.TextColor3 = Color3.fromRGB(255,255,255)

-- Range button
local RangeButton = Instance.new("TextButton", MainFrame)
RangeButton.Size = UDim2.new(0,200,0,30)
RangeButton.Position = UDim2.new(0,10,0,50)
RangeButton.Text = "Range: 10"
RangeButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
RangeButton.TextColor3 = Color3.fromRGB(255,255,255)

-- Max Targets button
local TargetButton = Instance.new("TextButton", MainFrame)
TargetButton.Size = UDim2.new(0,200,0,30)
TargetButton.Position = UDim2.new(0,10,0,90)
TargetButton.Text = "Max Targets: 1"
TargetButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
TargetButton.TextColor3 = Color3.fromRGB(255,255,255)

-- Close Menu button
local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Size = UDim2.new(0,200,0,30)
CloseButton.Position = UDim2.new(0,10,0,130)
CloseButton.Text = "Close Menu"
CloseButton.BackgroundColor3 = Color3.fromRGB(100,40,40)
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)

-- Biến config
local auraEnabled = false
local auraRange = 10
local maxTargets = 1

-- Chức năng
AuraButton.MouseButton1Click:Connect(function()
    auraEnabled = not auraEnabled
    AuraButton.Text = "Kill Aura: " .. (auraEnabled and "ON" or "OFF")
end)

RangeButton.MouseButton1Click:Connect(function()
    auraRange = auraRange + 5
    if auraRange > 50 then auraRange = 10 end
    RangeButton.Text = "Range: " .. auraRange
end)

TargetButton.MouseButton1Click:Connect(function()
    maxTargets = maxTargets + 1
    if maxTargets > 5 then maxTargets = 1 end
    TargetButton.Text = "Max Targets: " .. maxTargets
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

UIS.InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Kill Aura loop
RunService.Heartbeat:Connect(function()
    if auraEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local count = 0
        for _, enemy in pairs(workspace:GetDescendants()) do
            if enemy:FindFirstChild("Humanoid") 
            and enemy:FindFirstChild("HumanoidRootPart") 
            and enemy ~= LocalPlayer.Character then
                local dist = (enemy.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist <= auraRange then
                    enemy.Humanoid:TakeDamage(10) -- damage test
                    count = count + 1
                    if count >= maxTargets then break end
                end
            end
        end
    end
end)
