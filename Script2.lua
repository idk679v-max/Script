local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

_G.SilentAim = false
_G.ESPEnabled = false
_G.FOVCircleVisible = false
_G.FOV = 150
_G.AimbotDistance = 500

-- FOV Круг
local Circle = Drawing.new("Circle")
Circle.Thickness = 1
Circle.NumSides = 64
Circle.Filled = false
Circle.Visible = false
Circle.Color = Color3.fromRGB(255, 255, 255)

-- ESP Линии (вместо квадратов)
local ESP_Lines = {}

local function UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            if not ESP_Lines[player] then
                local line = Drawing.new("Line")
                line.Visible = false
                line.Thickness = 1
                ESP_Lines[player] = line
            end
            
            local line = ESP_Lines[player]
            local rootPart = player.Character.HumanoidRootPart
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            
            -- Логика: только враги, не в лобби
            if _G.ESPEnabled and onScreen and player.Team ~= LocalPlayer.Team then
                line.Visible = true
                line.Color = Color3.fromRGB(255, 50, 50) -- Только красный
                line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y) -- Из центра низа экрана
                line.To = Vector2.new(pos.X, pos.Y)
            else
                line.Visible = false
            end
        elseif ESP_Lines[player] then
            ESP_Lines[player]:Remove()
            ESP_Lines[player] = nil
        end
    end
end

-- Silent Aim для Murder Duels
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    -- Murder Duels часто использует "Shoot" или другие эвенты. 
    -- Если не работает, замени "WeaponEvent" на имя эвента стрельбы.
    if _G.SilentAim and getnamecallmethod() == "FireServer" then
        local target = nil
        local dist = _G.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= LocalPlayer.Team then
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

RunService.RenderStepped:Connect(function()
    Circle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    Circle.Radius = _G.FOV
    Circle.Visible = _G.FOVCircleVisible
    UpdateESP()
end)

local Window = Rayfield:CreateWindow({Name = "Apelsin Hub [Murder Duels]"})
local MainTab = Window:CreateTab("Main")
MainTab:CreateToggle({Name = "Silent Aim", Callback = function(v) _G.SilentAim = v end})
MainTab:CreateSlider({Name = "FOV Size", Range = {50, 800}, Increment = 10, CurrentValue = 150, Callback = function(v) _G.FOV = v end})
local VisTab = Window:CreateTab("Visuals")
VisTab:CreateToggle({Name = "Enemy ESP (Lines)", Callback = function(v) _G.ESPEnabled = v end})
VisTab:CreateToggle({Name = "Show FOV Circle", Callback = function(v) _G.FOVCircleVisible = v end})

