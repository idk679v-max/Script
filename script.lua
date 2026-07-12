local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 1. Окно
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ApelsinHub"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 580) -- Увеличил размер для всех кнопок
Frame.Position = UDim2.new(0.5, -200, 0.5, -290)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true 

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 16)
local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(255, 140, 0)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🍊 APELSIN HUB PRO"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 140, 0)
Title.BackgroundTransparency = 1

-- 2. Функция для создания кнопок-переключателей
local yOffset = 50
local function createToggle(text, colorOff, callback)
    local active = false
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0, 360, 0, 45)
    btn.Position = UDim2.new(0, 20, 0, yOffset)
    btn.BackgroundColor3 = colorOff
    btn.Text = text .. " [ OFF ]"
    btn.Font = Enum.Font.GothamSemibold
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        active = not active
        local targetColor = active and Color3.fromRGB(70, 180, 70) or colorOff
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = targetColor}):Play()
        btn.Text = active and text .. " [ ON ]" or text .. " [ OFF ]"
        callback(active)
    end)
    yOffset = yOffset + 55
end

-- 3. ВСЕ КНОПКИ (УНИФИЦИРОВАННЫЕ)
createToggle("⚡ Instant Win", Color3.fromRGB(50, 50, 50), function(on)
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

createToggle("🏊 Infinite Swim", Color3.fromRGB(80, 50, 120), function(on)
    _G.SwimActive = on
    
    -- Загружаем контроллер один раз
    local success, SwimController = pcall(function() 
        return require(LocalPlayer.PlayerScripts.Controllers.SwimController) 
    end)
    
    if success and SwimController then
        if on then
            -- Метод подмены: мы не меняем функцию постоянно, 
            -- а просто "замораживаем" переменную стамины через метатаблицу или прямое присвоение
            task.spawn(function()
                while _G.SwimActive do
                    -- Просто принудительно ставим максимум, пока включено
                    SwimController._swimMeter = SwimController._meterMax
                    task.wait(0.2) 
                end
            end)
        end
    end
end)

createToggle("💧 Auto-Fill Bucket", Color3.fromRGB(40, 80, 120), function(on)
    _G.FillActive = on
    task.spawn(function()
        while _G.FillActive do
            local Event = game:GetService("ReplicatedStorage"):FindFirstChild("VerdantRemotes") and game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Bucket.Used"]
            if Event then Event:FireServer() end
            task.wait(0.5)
        end
    end)
end)

createToggle("💧 Auto-Pour", Color3.fromRGB(40, 80, 120), function(on)
    _G.PourActive = on
    task.spawn(function()
        while _G.PourActive do
            local Event = game:GetService("ReplicatedStorage"):FindFirstChild("VerdantRemotes") and game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Bucket.Poured"]
            if Event then
                pcall(function() Event:FireServer(workspace.Scripted.CheckpointParts["1"]:GetChildren()[2].Scripted.ProximityPosition.ProximityPrompt) end)
            end
            task.wait(0.5)
        end
    end)
end)

createToggle("🎁 Auto Chests", Color3.fromRGB(120, 80, 40), function(on)
    _G.ChestActive = on
    task.spawn(function()
        while _G.ChestActive do
            local chestsFolder = workspace:FindFirstChild("Scripted") and workspace.Scripted:FindFirstChild("Chests")
            if chestsFolder then
                for _, chest in pairs(chestsFolder:GetChildren()) do
                    if not _G.ChestActive then break end
                    
                    local prompt = chest:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        -- Телепорт
                        LocalPlayer.Character.HumanoidRootPart.CFrame = chest:IsA("Model") and chest:GetPivot() or chest.CFrame
                        
                        -- Ждем, чтобы сервер обработал позицию
                        task.wait(0.2)
                        
                        -- ПРАВИЛЬНЫЙ ВЫЗОВ:
                        -- Мы не просто вызываем функцию, мы имитируем событие промпта
                        if prompt.Enabled then
                            fireproximityprompt(prompt)
                        end
                        
                        task.wait(0.5) -- Пауза между сундуками
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

createToggle("🪙 Auto Tokens", Color3.fromRGB(120, 100, 40), function(on)
    _G.TokenActive = on
    task.spawn(function()
        while _G.TokenActive do
            pcall(function() game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Tokens.Take"]:FireServer(workspace.Scripted.CheckpointParts["1"]:GetChildren()[2].Scripted.ProximityPosition.ProximityPrompt) end)
            task.wait(0.3)
        end
    end)
end)

-- 4. Кнопка скрыть
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 100, 0, 35)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "🍊 UI"
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleButton.TextColor3 = Color3.fromRGB(255, 140, 0)
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 8)
ToggleButton.MouseButton1Click:Connect(function() Frame.Visible = not Frame.Visible end)
