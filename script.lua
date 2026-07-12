local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ApelsinHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- === ГЛАВНОЕ ОКНО ===
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 420, 0, 260)
Frame.Position = UDim2.new(0.5, -210, 0.5, -130)
Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Frame.BackgroundTransparency = 0.1
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 14)
FrameCorner.Parent = Frame

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Color3.fromRGB(255, 130, 0) -- Апельсиновый оранжевый контур
FrameStroke.Thickness = 1.5
FrameStroke.Parent = Frame

-- === ЛЕВЫЙ САЙДБАР (ДЛЯ ВКЛАДОК) ===
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.BackgroundTransparency = 0.2
Sidebar.Parent = Frame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 14)
SidebarCorner.Parent = Sidebar

-- Логотип / Название хаба
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(1, 0, 0, 50)
Logo.Text = "🍊 Apelsin Hub"
Logo.TextSize = 15
Logo.Font = Enum.Font.GothamBold
Logo.TextColor3 = Color3.fromRGB(255, 140, 0)
Logo.BackgroundTransparency = 1
Logo.Parent = Sidebar

-- Кнопка переключения на вкладку Main
local TabButton = Instance.new("TextButton")
TabButton.Size = UDim2.new(0, 100, 0, 35)
TabButton.Position = UDim2.new(0, 10, 0, 60)
TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabButton.Text = "📜 Main"
TabButton.TextSize = 14
TabButton.Font = Enum.Font.GothamBold
TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TabButton.Parent = Sidebar

local TabButtonCorner = Instance.new("UICorner")
TabButtonCorner.CornerRadius = UDim.new(0, 6)
TabButtonCorner.Parent = TabButton

-- === ОСНОВНАЯ ЗОНА ВКЛАДКИ (КОНТЕНТ) ===
local MainTab = Instance.new("Frame")
MainTab.Size = UDim2.new(1, -120, 1, 0)
MainTab.Position = UDim2.new(0, 120, 0, 0)
MainTab.BackgroundTransparency = 1
MainTab.Parent = Frame

-- Заголовок внутри вкладки
local TabTitle = Instance.new("TextLabel")
TabTitle.Size = UDim2.new(1, -20, 0, 40)
TabTitle.Position = UDim2.new(0, 20, 0, 15)
TabTitle.Text = "Main Automation"
TabTitle.TextSize = 18
TabTitle.Font = Enum.Font.GothamBold
TabTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
TabTitle.TextXAlignment = Enum.TextXAlignment.Left
TabTitle.BackgroundTransparency = 1
TabTitle.Parent = MainTab

-- === КОНТЕНЕР ДЛЯ КНОПОК ===
local ButtonContainer = Instance.new("ScrollingFrame")
ButtonContainer.Size = UDim2.new(1, -40, 1, -70)
ButtonContainer.Position = UDim2.new(0, 20, 0, 55)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.BorderSizePixel = 0
ButtonContainer.ScrollBarThickness = 2
ButtonContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 130, 0)
ButtonContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ButtonContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
ButtonContainer.Parent = MainTab

-- Менеджер расположения кнопок
local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 6)
ListLayout.Parent = ButtonContainer


-- === КНОПКА №1 (ТЕЛЕПОРТ) ===
local Button1 = Instance.new("TextButton")
Button1.Size = UDim2.new(1, 0, 0, 32)
Button1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button1.Text = "   ⚡ Instant Win"
Button1.TextSize = 14
Button1.Font = Enum.Font.GothamMedium
Button1.TextColor3 = Color3.fromRGB(255, 255, 255)
Button1.TextXAlignment = Enum.TextXAlignment.Left
Button1.Parent = ButtonContainer

local B1Corner = Instance.new("UICorner")
B1Corner.CornerRadius = UDim.new(0, 6)
B1Corner.Parent = Button1

local B1Stroke = Instance.new("UIStroke")
B1Stroke.Color = Color3.fromRGB(45, 45, 45)
B1Stroke.Thickness = 1
B1Stroke.Parent = Button1

Button1.MouseEnter:Connect(function()
    Button1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    B1Stroke.Color = Color3.fromRGB(255, 130, 0)
end)
Button1.MouseLeave:Connect(function()
    Button1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    B1Stroke.Color = Color3.fromRGB(45, 45, 45)
end)

Button1.MouseButton1Click:Connect(function()
    print("pressed button")
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = player.Character.HumanoidRootPart
        local target = workspace:GetChildren()[9]
        if target and target:GetChildren()[30] then
            rootPart.CFrame = target:GetChildren()[30].CFrame
        end
        
        task.wait(2)
        
        if workspace:FindFirstChild("Scripted") and workspace.Scripted:FindFirstChild("VaultStart") then
            local path = workspace.Scripted.VaultStart:FindFirstChild("ProximityPrompt")
            if path then
                fireproximityprompt(path)
            end
        end
    end
end)


-- === КНОПКА №2 (АВТО-СБОР ВОДЫ ПЕРЕКЛЮЧАТЕЛЬ) ===
local ToggleActive = false

local Button2 = Instance.new("TextButton")
Button2.Size = UDim2.new(1, 0, 0, 32)
Button2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button2.Text = "   💧 Auto-Fill Bucket"
Button2.TextSize = 14
Button2.Font = Enum.Font.GothamMedium
Button2.TextColor3 = Color3.fromRGB(255, 255, 255)
Button2.TextXAlignment = Enum.TextXAlignment.Left
Button2.Parent = ButtonContainer

local B2Corner = Instance.new("UICorner")
B2Corner.CornerRadius = UDim.new(0, 6)
B2Corner.Parent = Button2

local B2Stroke = Instance.new("UIStroke")
B2Stroke.Color = Color3.fromRGB(45, 45, 45)
B2Stroke.Thickness = 1
B2Stroke.Parent = Button2

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 70, 1, 0)
StatusLabel.Position = UDim2.new(1, -75, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "[ OFF ]"
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextColor3 = Color3.fromRGB(180, 70, 70)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel.Parent = Button2

Button2.MouseEnter:Connect(function()
    if not ToggleActive then
        B2Stroke.Color = Color3.fromRGB(255, 130, 0)
    end
end)
Button2.MouseLeave:Connect(function()
    if not ToggleActive then
        B2Stroke.Color = Color3.fromRGB(45, 45, 45)
    end
end)

Button2.MouseButton1Click:Connect(function()
    ToggleActive = not ToggleActive
    
    if ToggleActive then
        StatusLabel.Text = "[ ON ]"
        StatusLabel.TextColor3 = Color3.fromRGB(70, 180, 70)
        B2Stroke.Color = Color3.fromRGB(255, 130, 0)
        
        task.spawn(function()
            while ToggleActive do
                local Event = game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Bucket.Used"]
                if Event then
                    Event:FireServer()
                end
                task.wait(0.5)
            end
        end)
        
    else
        StatusLabel.Text = "[ OFF ]"
        StatusLabel.TextColor3 = Color3.fromRGB(180, 70, 70)
        B2Stroke.Color = Color3.fromRGB(45, 45, 45)
    end
end)

-- === КНОПКА №3 (АВТО-МАШИНА ПЕРЕКЛЮЧАТЕЛЬ) ===
local ToggleActive3 = false -- Важно: отдельная переменная для этой кнопки

local Button3 = Instance.new("TextButton")
Button3.Size = UDim2.new(1, 0, 0, 32)
Button3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button3.Text = "   💧 Auto-Pour" -- Исправил: было Button3Text
Button3.TextSize = 14
Button3.Font = Enum.Font.GothamMedium
Button3.TextColor3 = Color3.fromRGB(255, 255, 255)
Button3.TextXAlignment = Enum.TextXAlignment.Left
Button3.Parent = ButtonContainer

local B3Corner = Instance.new("UICorner")
B3Corner.CornerRadius = UDim.new(0, 6)
B3Corner.Parent = Button3 -- Исправил: было Button2

local B3Stroke = Instance.new("UIStroke")
B3Stroke.Color = Color3.fromRGB(45, 45, 45)
B3Stroke.Thickness = 1
B3Stroke.Parent = Button3 -- Исправил: было Button2

local StatusLabel3 = Instance.new("TextLabel") -- Исправил: отдельный лейбл
StatusLabel3.Size = UDim2.new(0, 70, 1, 0)
StatusLabel3.Position = UDim2.new(1, -75, 0, 0)
StatusLabel3.BackgroundTransparency = 1
StatusLabel3.Text = "[ OFF ]"
StatusLabel3.TextSize = 13
StatusLabel3.Font = Enum.Font.GothamBold
StatusLabel3.TextColor3 = Color3.fromRGB(180, 70, 70)
StatusLabel3.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel3.Parent = Button3 -- Исправил: было Button2

Button3.MouseEnter:Connect(function()
    if not ToggleActive3 then
        B3Stroke.Color = Color3.fromRGB(255, 130, 0)
    end
end)
Button3.MouseLeave:Connect(function()
    if not ToggleActive3 then
        B3Stroke.Color = Color3.fromRGB(45, 45, 45)
    end
end)

Button3.MouseButton1Click:Connect(function()
    ToggleActive3 = not ToggleActive3
    
    if ToggleActive3 then
        StatusLabel3.Text = "[ ON ]"
        StatusLabel3.TextColor3 = Color3.fromRGB(70, 180, 70)
        B3Stroke.Color = Color3.fromRGB(255, 130, 0)
        
        task.spawn(function()
            while ToggleActive3 do
                local Event = game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Bucket.Poured"]
                if Event then
                    -- Используем pcall, чтобы если путь сломается, скрипт не крашнулся
                    pcall(function()
                        Event:FireServer(workspace.Scripted.CheckpointParts["1"]:GetChildren()[2].Scripted.ProximityPosition.ProximityPrompt)
                    end)
                end
                task.wait(0.5)
            end
        end)
        
    else
        StatusLabel3.Text = "[ OFF ]"
        StatusLabel3.TextColor3 = Color3.fromRGB(180, 70, 70)
        B3Stroke.Color = Color3.fromRGB(45, 45, 45)
    end
end)

-- === КНОПКА №4 (AUTO CHESTS) ===
local Button4 = Instance.new("TextButton")
Button4.Size = UDim2.new(1, 0, 0, 32)
Button4.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button4.Text = "   🎁 Auto Chests"
Button4.TextSize = 14
Button4.Font = Enum.Font.GothamMedium
Button4.TextColor3 = Color3.fromRGB(255, 255, 255)
Button4.TextXAlignment = Enum.TextXAlignment.Left
Button4.Parent = ButtonContainer

local B4Corner = Instance.new("UICorner")
B4Corner.CornerRadius = UDim.new(0, 6)
B4Corner.Parent = Button4

local B4Stroke = Instance.new("UIStroke")
B4Stroke.Color = Color3.fromRGB(45, 45, 45)
B4Stroke.Thickness = 1
B4Stroke.Parent = Button4

Button4.MouseButton1Click:Connect(function()
    local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local paths = {
            workspace.Scripted.Chests.Chest,
            workspace.Scripted.Chests:GetChildren()[2],
            workspace.Scripted.Chests:GetChildren()[7],
            workspace.Scripted.Chests:GetChildren()[11],
            workspace.Scripted.Chests:GetChildren()[13],
            workspace.Scripted.Chests:GetChildren()[6],
            workspace.Scripted.Chests:GetChildren()[10],
            workspace.Scripted.Chests:GetChildren()[12],
            workspace.Scripted.Chests:GetChildren()[8],
            workspace.Scripted.Chests:GetChildren()[9],
            workspace.Scripted.Chests:GetChildren()[5],
            workspace.Scripted.Chests:GetChildren()[4],
            workspace.Scripted.Chests:GetChildren()[3]
        }
        for _, chest in pairs(paths) do
            local prompt = chest and chest:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                root.CFrame = chest:IsA("Model") and chest:GetPivot() or chest.CFrame
                task.wait(0.3)
                fireproximityprompt(prompt)
                task.wait(0.2)
            end
        end
    end
end)

-- === КНОПКА №5 (INFINITE SWIM) ===
local ToggleSwim = false
local SwimController = require(game:GetService("Players").LocalPlayer.PlayerScripts.Controllers.SwimController)
local oldSwimStep = SwimController._swimStep 

local Button5 = Instance.new("TextButton")
Button5.Size = UDim2.new(1, 0, 0, 32)
Button5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button5.Text = "   🏊 Infinite Swim"
Button5.TextSize = 14
Button5.Font = Enum.Font.GothamMedium
Button5.TextColor3 = Color3.fromRGB(255, 255, 255)
Button5.TextXAlignment = Enum.TextXAlignment.Left
Button5.Parent = ButtonContainer

local B5Corner = Instance.new("UICorner")
B5Corner.CornerRadius = UDim.new(0, 6)
B5Corner.Parent = Button5

local B5Stroke = Instance.new("UIStroke")
B5Stroke.Color = Color3.fromRGB(45, 45, 45)
B5Stroke.Thickness = 1
B5Stroke.Parent = Button5

local StatusLabel5 = Instance.new("TextLabel")
StatusLabel5.Size = UDim2.new(0, 70, 1, 0)
StatusLabel5.Position = UDim2.new(1, -75, 0, 0)
StatusLabel5.BackgroundTransparency = 1
StatusLabel5.Text = "[ OFF ]"
StatusLabel5.TextSize = 13
StatusLabel5.Font = Enum.Font.GothamBold
StatusLabel5.TextColor3 = Color3.fromRGB(180, 70, 70)
StatusLabel5.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel5.Parent = Button5

Button5.MouseButton1Click:Connect(function()
    ToggleSwim = not ToggleSwim
    
    if ToggleSwim then
        StatusLabel5.Text = "[ ON ]"
        StatusLabel5.TextColor3 = Color3.fromRGB(70, 180, 70)
        B5Stroke.Color = Color3.fromRGB(255, 130, 0)
        
        -- Патчим функцию, убирая расход стамины
        SwimController._swimStep = function(self, p71, p72, p73)
            self._swimMeter = self._meterMax
            return oldSwimStep(self, p71, p72, p73)
        end
        SwimController._startDrown = function() end 
        
    else
        StatusLabel5.Text = "[ OFF ]"
        StatusLabel5.TextColor3 = Color3.fromRGB(180, 70, 70)
        B5Stroke.Color = Color3.fromRGB(45, 45, 45)
        
        -- Возвращаем оригинал
        SwimController._swimStep = oldSwimStep
        SwimController._startDrown = function(self) end -- здесь восстанавливается дефолтная логика
    end
end)

-- === КНОПКА №6 (AUTO TOKENS) ===
local ToggleTokens = false

local Button6 = Instance.new("TextButton")
Button6.Size = UDim2.new(1, 0, 0, 32)
Button6.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button6.Text = "   🪙 Auto Tokens"
Button6.TextSize = 14
Button6.Font = Enum.Font.GothamMedium
Button6.TextColor3 = Color3.fromRGB(255, 255, 255)
Button6.TextXAlignment = Enum.TextXAlignment.Left
Button6.Parent = ButtonContainer

local B6Corner = Instance.new("UICorner")
B6Corner.CornerRadius = UDim.new(0, 6)
B6Corner.Parent = Button6

local B6Stroke = Instance.new("UIStroke")
B6Stroke.Color = Color3.fromRGB(45, 45, 45)
B6Stroke.Thickness = 1
B6Stroke.Parent = Button6

local StatusLabel6 = Instance.new("TextLabel")
StatusLabel6.Size = UDim2.new(0, 70, 1, 0)
StatusLabel6.Position = UDim2.new(1, -75, 0, 0)
StatusLabel6.BackgroundTransparency = 1
StatusLabel6.Text = "[ OFF ]"
StatusLabel6.TextSize = 13
StatusLabel6.Font = Enum.Font.GothamBold
StatusLabel6.TextColor3 = Color3.fromRGB(180, 70, 70)
StatusLabel6.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel6.Parent = Button6

Button6.MouseButton1Click:Connect(function()
    ToggleTokens = not ToggleTokens
    
    if ToggleTokens then
        StatusLabel6.Text = "[ ON ]"
        StatusLabel6.TextColor3 = Color3.fromRGB(70, 180, 70)
        B6Stroke.Color = Color3.fromRGB(255, 130, 0)
        
        task.spawn(function()
            while ToggleTokens do
                -- Прямой вызов ивента
                local Event = game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Tokens.Take"]
                local Target = workspace.Scripted.CheckpointParts["1"]:GetChildren()[2].Scripted.ProximityPosition.ProximityPrompt
                
                pcall(function()
                    Event:FireServer(Target)
                end)
                
                task.wait(0.3) -- Скорость сбора
            end
        end)
    else
        StatusLabel6.Text = "[ OFF ]"
        StatusLabel6.TextColor3 = Color3.fromRGB(180, 70, 70)
        B6Stroke.Color = Color3.fromRGB(45, 45, 45)
    end
end)


-- === КНОПКА СВЕРНУТЬ МЕНЮ ===
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 110, 0, 35)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleButton.Text = "🍊 Apelsin UI"
ToggleButton.TextSize = 13
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextColor3 = Color3.fromRGB(255, 140, 0)
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 130, 0)
ToggleStroke.Thickness = 1
ToggleStroke.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- === СКРИПТ ПЕРЕТАСКИВАНИЯ (DRAG) ===
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

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

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
