local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Настройки
_G.SilentAim = false
_G.ESPEnabled = false
_G.FOVCircleVisible = false
_G.FOV = 150
_G.AimbotDistance = 500

-- Визуальный круг FOV
local Circle = Drawing.new("Circle")
Circle.Thickness = 1
Circle.NumSides = 100
Circle.Filled = false
Circle.Visible = false
Circle.Color = Color3.fromRGB(255, 255, 255)

-- ESP Квадраты
local ESP_Objects = {}

local function UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not ESP_Objects[player] then
                local box = Drawing.new("Square")
                box.Visible = false
                box.Thickness = 1
                box.Filled = false
                ESP_Objects[player] = box
            end
            
            local box = ESP_Objects[player]
            
            -- Логика цветов ESP
            if LocalPlayer.Team ~= nil and player.Team == LocalPlayer.Team then
                box.Color = Color3.fromRGB(0, 120, 255) -- Синий (Союзник)
            elseif LocalPlayer.Team ~= nil then
                box.Color = Color3.fromRGB(255, 50, 50) -- Красный (Враг)
            else
                box.Color = Color3.fromRGB(255, 255, 255) -- Белый (Нет команд)
            end
            
            local rootPart = player.Character.HumanoidRootPart
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            
            if _G.ESPEnabled and onScreen then
                local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
                local scale = 1000 / distance
                box.Visible = true
                box.Size = Vector2.new(4 * scale, 6 * scale)
                box.Position = Vector2.new(pos.X - (2 * scale), pos.Y - (3 * scale))
            else
                box.Visible = false
            end
        elseif ESP_Objects[player] then
            ESP_Objects[player]:Remove()
            ESP_Objects[player] = nil
        end
    end
end

-- Silent Aim логика
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if _G.SilentAim and getnamecallmethod() == "FireServer" then
        local target = nil
        local dist = _G.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if
                    
