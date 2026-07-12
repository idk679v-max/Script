local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 1. ОСНОВНОЕ ОКНО
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ApelsinHub"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 140, 0)
Stroke.Thickness = 2

-- 2. ЛЕВАЯ ПАНЕЛЬ
local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(0, 130, 1, 0)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TabBar)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "🍊 Apelsin Hub"
Title.TextColor3 = Color3.fromRGB(255, 140, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

local MainTab = Instance.new("TextButton", TabBar)
MainTab.Size = UDim2.new(0.9, 0, 0, 40)
MainTab.Position = UDim2.new(0.05, 0, 0, 60)
MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainTab.Text = "📜 Main"
MainTab.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MainTab).CornerRadius = UDim.new(0, 6)

-- 3. КОНТЕНТ
local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -140, 1, -20)
Content.Position = UDim2.new(0, 140, 0, 10)
Content.BackgroundTransparency = 1
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", Content).Padding = UDim.new(0, 8)

-- ФУНКЦИЯ КНОПОК С ИНДИКАТОРОМ
local function createToggle(text, callback)
    local active = false
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = text .. " [OFF]"
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and " [ON]" or " [OFF]")
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = active and Color3.fromRGB(255, 140, 0) or Color3.fromRGB(35, 35, 35)}):Play()
        callback(active)
    end)
end

-- 4. ЛОГИКА
createToggle("⚡ Instant Win", function(on)
    if on then
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local target = workspace:GetChildren()[9]
            if target and target:FindFirstChildOfClass("Model") then root.CFrame = target:GetPivot() end
            task.wait(1)
            if workspace:FindFirstChild("Scripted") and workspace.Scripted:FindFirstChild("VaultStart") then
                fireproximityprompt(workspace.Scripted.VaultStart.ProximityPrompt)
            end
        end
    end
end)

createToggle("🏊 Infinite Swim", function(on)
    pcall(function()
        local SwimController = require(LocalPlayer.PlayerScripts.Controllers.SwimController)
        if on then
            SwimController._swimStep = function(self, ...) self._swimMeter = self._meterMax return self:_swimStep(...) end
            SwimController._startDrown = function() end
        end
    end)
end)

createToggle("💧 Auto-Fill Bucket", function(on)
    _G.Fill = on
    task.spawn(function()
        while _G.Fill do
            local Event = game:GetService("ReplicatedStorage"):FindFirstChild("VerdantRemotes") and game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Bucket.Used"]
            if Event then Event:FireServer() end
            task.wait(0.5)
        end
    end)
end)

createToggle("💧 Auto-Pour", function(on)
    _G.Pour = on
    task.spawn(function()
        while _G.Pour do
            local Event = game:GetService("ReplicatedStorage"):FindFirstChild("VerdantRemotes") and game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Bucket.Poured"]
            if Event then pcall(function() Event:FireServer(workspace.Scripted.CheckpointParts["1"]:GetChildren()[2].Scripted.ProximityPosition.ProximityPrompt) end) end
            task.wait(0.5)
        end
    end)
end)

createToggle("🎁 Auto Chests", function(on)
    _G.Chest = on
    task.spawn(function()
        while _G.Chest do
            for _, chest in pairs(workspace.Scripted.Chests:GetChildren()) do
                if not _G.Chest then break end
                local prompt = chest:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = chest:IsA("Model") and chest:GetPivot() or chest.CFrame
                    fireproximityprompt(prompt)
                    task.wait(0.4)
                end
            end
            task.wait(1)
        end
    end)
end)

createToggle("🪙 Auto Tokens", function(on)
    _G.Token = on
    task.spawn(function()
        while _G.Token do
            pcall(function() game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Tokens.Take"]:FireServer(workspace.Scripted.CheckpointParts["1"]:GetChildren()[2].Scripted.ProximityPosition.ProximityPrompt) end)
            task.wait(0.3)
        end
    end)
end)

-- 5. КНОПКА ОТКРЫТИЯ/ЗАКРЫТИЯ
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.Text = "🍊"
ToggleButton.TextSize = 24
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)
local ToggleStroke = Instance.new("UIStroke", ToggleButton)
ToggleStroke.Color = Color3.fromRGB(255, 140, 0)
ToggleStroke.Thickness = 2

ToggleButton.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)
