-- Загрузка библиотеки
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera

_G.AimbotEnabled = false
_G.ESPEnabled = false
_G.AimbotDistance = 500
_G.FOV = 150

-- Визуальный круг FOV
local Circle = Drawing.new("Circle")
Circle.Visible = false
Circle.Radius = 150
Circle.Color = Color3.fromRGB(255, 255, 255)
Circle.Thickness = 1

-- Логика ESP (квадраты вокруг игроков)
local function CreateESP(player)
    local esp = Drawing.new("Square")
    esp.Visible = false
    esp.Color = Color3.fromRGB(255, 255, 255)
    esp.Thickness = 1
    esp.Filled = false
    return esp
end

-- Основной цикл обновления
RunService.RenderStepped:Connect(function()
    Circle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    
    -- Аимбот логика
    if _G.AimbotEnabled then
        -- (Твоя существующая логика аимбота)
    end
    
    -- ESP логика
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not player.Character:FindFirstChild("ESP_Box") then
                local box = CreateESP(player)
                box.Name = "ESP_Box"
                box.Parent = player.Character
            end
            
            local rootPart = player.Character.HumanoidRootPart
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            
            if _G.ESPEnabled and onScreen then
                local box = player.Character:FindFirstChild("ESP_Box")
                box.Visible = true
                box.Size = Vector2.new(100, 100) -- Можно доработать под размер модели
                box.Position = Vector2.new(pos.X - 50, pos.Y - 50)
            else
                if player.Character:FindFirstChild("ESP_Box") then
                    player.Character.ESP_Box.Visible = false
                end
            end
        end
    end
end)

-- Интерфейс Rayfield
local Window = Rayfield:CreateWindow({Name = "Apelsin Hub"})

local MainTab = Window:CreateTab("Main", nil)
MainTab:CreateToggle({Name = "Enable Aimbot", Callback = function(v) _G.AimbotEnabled = v end})

local VisualTab = Window:CreateTab("Visuals", nil)
VisualTab:CreateToggle({
    Name = "Enable ESP (Boxes)",
    Callback = function(v) _G.ESPEnabled = v end
})
