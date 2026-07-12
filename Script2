-- Загрузка библиотеки
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Основные настройки
_G.AimbotEnabled = false
_G.AimbotDistance = 500
_G.FOV = 150

-- Визуальный круг FOV
local Circle = Drawing.new("Circle")
Circle.Visible = false
Circle.Radius = 150
Circle.Color = Color3.fromRGB(255, 255, 255)
Circle.Thickness = 1

-- Логика постоянного обновления
game:GetService("RunService").RenderStepped:Connect(function()
    -- Центрируем круг
    Circle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
    
    -- Логика Аимбота
    if _G.AimbotEnabled then
        local closestPlayer = nil
        local shortestDistance = _G.AimbotDistance
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                local headPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.Head.Position)
                local dist = (Vector2.new(headPos.X, headPos.Y) - Circle.Position).Magnitude
                
                if onScreen and dist < _G.FOV and dist < shortestDistance then
                    closestPlayer = player
                    shortestDistance = dist
                end
            end
        end
        
        if closestPlayer then
            workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, closestPlayer.Character.Head.Position)
        end
    end
end)

-- Создание интерфейса
local Window = Rayfield:CreateWindow({Name = "Apelsin Hub", LoadingTitle = "Загрузка...", LoadingSubtitle = "Tora IsMe Style"})
local MainTab = Window:CreateTab("Main", nil)

MainTab:CreateToggle({
   Name = "Enable Aimbot",
   Callback = function(Value) _G.AimbotEnabled = Value end,
})

MainTab:CreateToggle({
   Name = "Show FOV Circle",
   Callback = function(Value) Circle.Visible = Value end,
})

MainTab:CreateSlider({
   Name = "FOV Radius",
   Range = {50, 500},
   CurrentValue = 150,
   Callback = function(Value) _G.FOV = Value; Circle.Radius = Value end,
})

MainTab:CreateSlider({
   Name = "Aimbot Distance",
   Range = {100, 2000},
   CurrentValue = 500,
   Callback = function(Value) _G.AimbotDistance = Value end,
})
