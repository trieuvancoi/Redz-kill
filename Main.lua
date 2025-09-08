-- Redz Kill Aura | Main Script

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- UI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local Hide = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Active = true
Frame.Draggable = true

Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.Text = "Redz Kill Aura"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextScaled = true

Toggle.Parent = Frame
Toggle.Size = UDim2.new(1, -20, 0, 40)
Toggle.Position = UDim2.new(0, 10, 0, 50)
Toggle.Text = "Kill Aura: OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.TextScaled = true

Hide.Parent = Frame
Hide.Size = UDim2.new(1, -20, 0, 30)
Hide.Position = UDim2.new(0, 10, 0, 100)
Hide.Text = "Ẩn Menu"
Hide.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
Hide.TextColor3 = Color3.fromRGB(255, 255, 255)
Hide.TextScaled = true

-- Kill Aura logic
local auraEnabled = false
local range = 15 -- khoảng cách đánh

Toggle.MouseButton1Click:Connect(function()
    auraEnabled = not auraEnabled
    if auraEnabled then
        Toggle.Text = "Kill Aura: ON"
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    else
        Toggle.Text = "Kill Aura: OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    end
end)

Hide.MouseButton1Click:Connect(function()
    Frame.Visible = false
    -- Phím K để hiện lại menu
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.K then
            Frame.Visible = not Frame.Visible
        end
    end)
end)

-- Loop đánh
task.spawn(function()
    while task.wait(0.2) do
        if auraEnabled then
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("Humanoid") then
                    local mag = (target.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if mag <= range and target.Character.Humanoid.Health > 0 then
                        game:GetService("ReplicatedStorage").Remotes.Combat:FireServer(target.Character.Humanoid)
                    end
                end
            end
        end
    end
end)
