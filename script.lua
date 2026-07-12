local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🍊 APELSIN HUB PRO",
    LoadingTitle = "Apelsin Hub Loading...",
    LoadingSubtitle = "by Apelsin",
    Theme = "Default"
})

local MainTab = Window:CreateTab("Main", nil) -- Вкладка Main

-- 1. Instant Win
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

-- 2. Infinite Swim
MainTab:CreateToggle({
    Name = "🏊 Infinite Swim",
    CurrentValue = false,
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

-- 3. Auto-Fill Bucket
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

-- 4. Auto-Pour
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

-- 5. Auto Chests
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

-- 6. Auto Tokens
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

Rayfield:Load() -- Обязательно для загрузки интерфейса

