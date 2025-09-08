-- Redz Kill Aura | Main Script
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- UI Library đơn giản
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Active = true
Frame.Draggable = true

Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50,50,50)
Title.Text = "Redz Kill Aura"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextScaled = true

Toggle.Parent = Frame
Toggle.Size = UDim2.new(1, -20, 0, 40)
Toggle.Position = UDim2.new(0, 10, 0, 50)
Toggle.Text = "Kill Aura: OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(70,70,70)
Toggle.TextColor3 = Color3.fromRGB(255,255,255)

-- Kill Aura logic
local auraEnabled = false
local range = 15

Toggle.MouseButton1Click:Connect(function()
    auraEnabled = not auraEnabled
    Toggle.Text = auraEnabled and "Kill Aura: ON" or "Kill Aura: OFF"
end)

-- Loop tấn công
spawn(function()
    while task.wait(0.2) do
        if auraEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            for _, target in ipairs(Players:GetPlayers()) do
                if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local mag = (LocalPlayer.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).magnitude
                    if mag <= range then
                        local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid:TakeDamage(10)
                        end
                    end
                end
            end
        end
    end
end)
