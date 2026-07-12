local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

_G.SilentAim = false
_G.ESPEnabled = false
_G.FOVCircleVisible = false
_G.FOV = 150

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
                box.Color = Color3.new(1, 1, 1)
                box.Thickness = 1
                box.Filled = false
                ESP_Objects[player] = box
            end
            
            local rootPart = player.Character.HumanoidRootPart
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            
            if _G.ESPEnabled and onScreen then
                ESP_Objects[player].Visible = true
                ESP_Objects[player].Size = Vector2.new(50, 80)
                ESP_Objects[player].Position = Vector2.new(pos.X - 25, pos.Y - 40)
            else
                ESP_Objects[player].Visible = false
            end
        elseif ESP_Objects[player] then
            ESP_Objects[player]:Remove()
            ESP_Objects[player] = nil
        end
    end
end

-- Silent Aim (Перехват выстрела)
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if _G.SilentAim and getnamecallmethod() == "FireServer" and self.Name == "WeaponEvent" then -- Имя эвента может отличаться!
        -- Логика перенаправления пули на голову ближайшего игрока
        local target = nil
        local dist = _G.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                local d = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if onScreen and d < dist then target = p.Character.Head; dist = d end
            end
        end
        if target then args[1] = target.Position end
    end
    return oldNamecall(self, unpack(args))
end)
setreadonly(mt, true)

-- Цикл
RunService.RenderStepped:Connect(function()
    Circle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    Circle.Radius = _G.FOV
    Circle.Visible = _G.FOVCircleVisible
    UpdateESP()
end)

-- Интерфейс
local Window = Rayfield:CreateWindow({Name = "Apelsin Hub"})
local MainTab = Window:CreateTab("Main")
MainTab:CreateToggle({Name = "Silent Aim", Callback = function(v) _G.SilentAim = v end})
local VisTab = Window:CreateTab("Visuals")
VisTab:CreateToggle({Name = "Enable ESP", Callback = function(v) _G.ESPEnabled = v end})
VisTab:CreateToggle({Name = "Show FOV Circle", Callback = function(v) _G.FOVCircleVisible = v end})
