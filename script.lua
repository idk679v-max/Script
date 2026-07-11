local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyMenu"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "My Menu"
Title.TextSize = 22
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Parent = Frame

local ToggleButton = Instance.new("TextButton")

ToggleButton.Size = UDim2.new(0, 120, 0, 40)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.Text = "On/Off"
ToggleButton.Parent = ScreenGui

ToggleButton.MouseButton1Click:Connect(function()
Frame.Visible = not Frame.Visible
end)

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 200, 0, 40)
Button.Position = UDim2.new(0.5, -100, 0, 80)
Button.Text = "Win"
Button.TextSize = 18
Button.Parent = Frame

Button.MouseButton1Click:Connect(function()
print("pressed button")

local rootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
rootPart.CFrame = workspace:GetChildren()[9]:GetChildren()[30].CFrame

task.wait(2)

local path = workspace.Scripted.VaultStart.ProximityPrompt
fireproximityprompt(path)
end)
