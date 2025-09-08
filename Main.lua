-- Redz Kill Aura | Main Script (Updated)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 220, 0, 180)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "Redz Kill Aura"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextScaled = true

local Toggle = Instance.new("TextButton")
Toggle.Parent = Frame
Toggle.Size = UDim2.new(1,-20,0,30)
Toggle.Position = UDim2.new(0,10,0,40)
Toggle.BackgroundColor3 = Color3.fromRGB(70,70,70)
Toggle.Text = "Kill Aura: OFF"
Toggle.TextColor3 = Color3.fromRGB(255,255,255)

local RangeBox = Instance.new("TextBox")
RangeBox.Parent = Frame
RangeBox.Size = UDim2.new(1,-20,0,30)
RangeBox.Position = UDim2.new(0,10,0,80)
RangeBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
RangeBox.PlaceholderText = "Range (mặc định 15)"
RangeBox.Text = "15"
RangeBox.TextColor3 = Color3.fromRGB(255,255,255)

local MaxTargetsBox = Instance.new("TextBox")
MaxTargetsBox.Parent = Frame
MaxTargetsBox.Size = UDim2.new(1,-20,0,30)
MaxTargetsBox.Position = UDim2.new(0,10,0,120)
MaxTargetsBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
MaxTargetsBox.PlaceholderText = "Max Targets (mặc định 3)"
MaxTargetsBox.Text = "3"
MaxTargetsBox.TextColor3 = Color3.fromRGB(255,255,255)

-- Toggle UI
local ToggleUI = Instance.new("TextButton")
ToggleUI.Parent = ScreenGui
ToggleUI.Size = UDim2.new(0,80,0,30)
ToggleUI.Position = UDim2.new(0,10,0,10)
ToggleUI.Text = "Menu"
ToggleUI.BackgroundColor3 = Color3.fromRGB(100,100,100)
ToggleUI.TextColor3 = Color3.fromRGB(255,255,255)

ToggleUI.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- Dragging menu
local dragging, dragInput, dragStart, startPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- Kill Aura logic
local enabled = false

Toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    Toggle.Text = enabled and "Kill Aura: ON" or "Kill Aura: OFF"
end)

RunService.RenderStepped:Connect(function()
    if enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local range = tonumber(RangeBox.Text) or 15
        local maxTargets = tonumber(MaxTargetsBox.Text) or 3
        local hitCount = 0

        for _, model in ipairs(workspace:GetDescendants()) do
            if hitCount >= maxTargets then break end
            if model:IsA("Model") and model:FindFirstChild("Humanoid") and model:FindFirstChild("HumanoidRootPart") then
                local hum = model.Humanoid
                if hum.Health > 0 and model ~= LocalPlayer.Character then
                    local distance = (model.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if distance <= range then
                        hum:TakeDamage(10)
                        hitCount += 1
                    end
                end
            end
        end
    end
end)
