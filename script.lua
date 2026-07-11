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

-- === КОНТЕНЕР ДЛЯ КНОПОК (Скроллинг, если кнопок будет много) ===
local ButtonContainer = Instance.new("ScrollingFrame")
ButtonContainer.Size = UDim2.new(1, -40, 1, -70)
ButtonContainer.Position = UDim2.new(0, 20, 0, 55)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.BorderSizePixel = 0
ButtonContainer.ScrollBarThickness = 2
ButtonContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 130, 0)
ButtonContainer.CanvasSize = UDim2.new(0, 0, 0, 0) -- Авто-размер
ButtonContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
ButtonContainer.Parent = MainTab

-- Менеджер расположения кнопок в колонку (Rayfield Style)
local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 6) -- Отступ между кнопками
ListLayout.Parent = ButtonContainer

-- === КНОПКА №1 (ТВОЙ ТЕЛЕПОРТ) ===
local Button1 = Instance.new("TextButton")
Button1.Size = UDim2.new(1, 0, 0, 32) -- Маленькая по высоте, на всю ширину контейнера
Button1.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Темный фон плашки
Button1.Text = "   ⚡ Instant Win" -- Пробелы для отступа текста слева
Button1.TextSize = 14
Button1.Font = Enum.Font.GothamMedium
Button1.TextColor3 = Color3.fromRGB(255, 255, 255)
Button1.TextXAlignment = Enum.TextXAlignment.Left -- Выравнивание текста по левому краю
Button1.Parent = ButtonContainer

local B1Corner = Instance.new("UICorner")
B1Corner.CornerRadius = UDim.new(0, 6)
B1Corner.Parent = Button1

local B1Stroke = Instance.new("UIStroke")
B1Stroke.Color = Color3.fromRGB(45, 45, 45)
B1Stroke.Thickness = 1
B1Stroke.Parent = Button1

-- Эффект при наведении (как в Rayfield)
Button1.MouseEnter:Connect(function()
    Button1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    B1Stroke.Color = Color3.fromRGB(255, 130, 0)
end)
Button1.MouseLeave:Connect(function()
    Button1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    B1Stroke.Color = Color3.fromRGB(45, 45, 45)
end)

-- Логика твоей первой кнопки
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

-- === ШАБЛОН ДЛЯ ДРУГИХ КНОПОК (Кнопка №2 для примера) ===
-- Когда захочешь добавить новую функцию, просто скопируй этот блок ниже!
local Button2 = Instance.new("TextButton")
Button2.Size = UDim2.new(1, 0, 0, 32)
Button2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button2.Text = "   ⚙️ Другая функция (Заготовка)"
Button2.TextSize = 14
Button2.Font = Enum.Font.GothamMedium
Button2.TextColor3 = Color3.fromRGB(150, 150, 150) -- Серый цвет, так как пустая
Button2.TextXAlignment = Enum.TextXAlignment.Left
Button2.Parent = ButtonContainer

local B2Corner = Instance.new("UICorner")
B2Corner.CornerRadius = UDim.new(0, 6)
B2Corner.Parent = Button2

local B2Stroke = Instance.new("UIStroke")
B2Stroke.Color = Color3.fromRGB(45, 45, 45)
B2Stroke.Thickness = 1
B2Stroke.Parent = Button2

Button2.MouseButton1Click:Connect(function()
    print("Сюда ты потом вставишь новый код!")
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
