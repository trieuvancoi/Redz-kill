-- Test GUI hiển thị
local player = game.Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Name = "RedzTest"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(255,0,0)
frame.Parent = ScreenGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,0,1,0)
label.Text = "Redz Kill Aura Menu"
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1
label.Parent = frame
