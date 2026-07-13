local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🍊 APELSIN HUB PRO",
    LoadingTitle = "Apelsin Hub Loading...",
    LoadingSubtitle = "by Apelsin",
    Theme = "Default"
})

-- Вкладка Main
local MainTab = Window:CreateTab("Main", nil)

MainTab:CreateButton({
    Name = "⚡ Instant Win",
    Callback = function()
        local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local target = workspace:GetChildren()[9]
            if target and target:FindFirstChildOfClass("Model") then root.CFrame = target:GetPivot() end
            task.wait(1)
            if workspace:FindFirstChild("Scripted") and workspace.Scripted:FindFirstChild("VaultStart") then
                fireproximityprompt(workspace.Scripted.VaultStart.ProximityPrompt)
            end
        end
    end,
})

MainTab:CreateToggle({
    Name = "🏊 Infinite Swim",
    Callback = function(Value)
        _G.SwimActive = Value
        if Value then
            task.spawn(function()
                local success, SwimController = pcall(function() return require(game.Players.LocalPlayer.PlayerScripts.Controllers.SwimController) end)
                while _G.SwimActive and success and SwimController do
                    SwimController._swimMeter = SwimController._meterMax
                    task.wait(0.2)
                end
            end)
        end
    end,
})

MainTab:CreateToggle({
    Name = "💧 Auto-Fill Bucket",
    Callback = function(Value)
        _G.FillActive = Value
        task.spawn(function()
            while _G.FillActive do
                local Event = game:GetService("ReplicatedStorage"):FindFirstChild("VerdantRemotes") and game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Bucket.Used"]
                if Event then Event:FireServer() end
                task.wait(0.5)
            end
        end)
    end,
})

MainTab:CreateToggle({
    Name = "💧 Auto-Pour",
    Callback = function(Value)
        _G.PourActive = Value
        task.spawn(function()
            while _G.PourActive do
                local Event = game:GetService("ReplicatedStorage"):FindFirstChild("VerdantRemotes") and game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Bucket.Poured"]
                if Event then
                    pcall(function() Event:FireServer(workspace.Scripted.CheckpointParts["1"]:GetChildren()[2].Scripted.ProximityPosition.ProximityPrompt) end)
                end
                task.wait(0.5)
            end
        end)
    end,
})

MainTab:CreateToggle({
    Name = "🎁 Auto Chests",
    Callback = function(Value)
        _G.ChestActive = Value
        task.spawn(function()
            while _G.ChestActive do
                local chestsFolder = workspace:FindFirstChild("Scripted") and workspace.Scripted:FindFirstChild("Chests")
                if chestsFolder then
                    for _, chest in pairs(chestsFolder:GetChildren()) do
                        if not _G.ChestActive then break end
                        local prompt = chest:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chest:IsA("Model") and chest:GetPivot() or chest.CFrame
                            task.wait(0.2)
                            if prompt.Enabled then fireproximityprompt(prompt) end
                            task.wait(0.5)
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end,
})

MainTab:CreateToggle({
    Name = "🪙 Auto Tokens",
    Callback = function(Value)
        _G.TokenActive = Value
        task.spawn(function()
            while _G.TokenActive do
                pcall(function() game:GetService("ReplicatedStorage").VerdantRemotes["VDT_Tokens.Take"]:FireServer(workspace.Scripted.CheckpointParts["1"]:GetChildren()[2].Scripted.ProximityPosition.ProximityPrompt) end)
                task.wait(0.3)
            end
        end)
    end,
})

-- Вкладка Movement
local MovementTab = Window:CreateTab("Movement", nil)
local FlySpeed = 50
_G.FlyEnabled = false
_G.NoClipEnabled = false

local function StartFly()
    local player = game.Players.LocalPlayer
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local bg = Instance.new("BodyGyro", hrp)
    bg.Name = "ApelsinGyro"
    bg.MaxTorque = Vector3.new(1/0, 1/0, 1/0)
    bg.P = 9000
    bg.D = 100
    
    local bv = Instance.new("BodyVelocity", hrp)
    bv.Name = "ApelsinFly"
    bv.MaxForce = Vector3.new(1/0, 1/0, 1/0)
    bv.Velocity = Vector3.new(0, 0, 0)

    local UIS = game:GetService("UserInputService")
    local control = {w = false, a = false, s = false, d = false}
    
    local conn1 = UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.W then control.w = true
        elseif input.KeyCode == Enum.KeyCode.A then control.a = true
        elseif input.KeyCode == Enum.KeyCode.S then control.s = true
        elseif input.KeyCode == Enum.KeyCode.D then control.d = true end
    end)
    
    local conn2 = UIS.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then control.w = false
        elseif input.KeyCode == Enum.KeyCode.A then control.a = false
        elseif input.KeyCode == Enum.KeyCode.S then control.s = false
        elseif input.KeyCode == Enum.KeyCode.D then control.d = false end
    end)

    task.spawn(function()
        while _G.FlyEnabled do
            local cam = workspace.CurrentCamera
            local hum = player.Character and player.Character:FindFirstChild("Humanoid")
            bg.CFrame = cam.CFrame
            
            local vel = Vector3.new(0, 0, 0)
            if control.w or control.s or control.a or control.d then
                if control.w then vel = vel + cam.CFrame.LookVector end
                if control.s then vel = vel - cam.CFrame.LookVector end
                if control.a then vel = vel - cam.CFrame.RightVector end
                if control.d then vel = vel + cam.CFrame.RightVector end
            elseif hum and hum.MoveDirection.Magnitude > 0 then
                -- Стабильный расчет направления через VectorToObjectSpace
                local relativeDir = cam.CFrame:VectorToObjectSpace(hum.MoveDirection)
                vel = (cam.CFrame.LookVector * -relativeDir.Z) + (cam.CFrame.RightVector * relativeDir.X)
            end
            
            bv.Velocity = vel * FlySpeed
            task.wait()
        end
        if hrp:FindFirstChild("ApelsinFly") then hrp.ApelsinFly:Destroy() end
        if hrp:FindFirstChild("ApelsinGyro") then hrp.ApelsinGyro:Destroy() end
        conn1:Disconnect()
        conn2:Disconnect()
    end)
end

MovementTab:CreateToggle({
    Name = "✈️ Fly (IY Style)",
    Callback = function(Value)
        _G.FlyEnabled = Value
        if Value then StartFly() end
    end,
})

MovementTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 10,
    CurrentValue = 50,
    Callback = function(Value) FlySpeed = Value end,
})

MovementTab:CreateToggle({
    Name = "👻 NoClip",
    Callback = function(Value) _G.NoClipEnabled = Value end,
})

game:GetService("RunService").Stepped:Connect(function()
    if _G.NoClipEnabled then
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

Rayfield:Load()
