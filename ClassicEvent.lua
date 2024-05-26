if game.PlaceId == 17427651911 then
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remotes = ReplicatedStorage.Remotes
    local ShareWithHelperBot = ReplicatedStorage.Services.ToolHandlers.Consumable.Net.ShareWithHelperBot
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local BuriedTreasure = workspace.QuestRewards.BuriedTreasure
    local ObbyRewards = workspace.QuestRewards.ObbyRewards
    local Obbies = workspace["Obby Island"].Obbies
    local FlagStands = workspace.FlagStands
    local PlayerData = LocalPlayer.PlayerData
    local Character = LocalPlayer.Character
    local OldCF = Character.HumanoidRootPart.CFrame
    
    for i, v in workspace.QuestRewards.SecretRewards:GetChildren() do
        while v:FindFirstChild("ProximityPrompt") do
            Character.HumanoidRootPart.CFrame = v.CFrame
            fireproximityprompt(v.ProximityPrompt)
            RunService.RenderStepped:Wait()
        end
    end
    
    while true do
        local Prompt = BuriedTreasure:FindFirstChild("ProximityPrompt", true)
        
        if Prompt then
            Character.HumanoidRootPart.CFrame = Prompt.Parent.CFrame
            fireproximityprompt(Prompt)
        else
            break
        end
        
        RunService.RenderStepped:Wait()
    end
    
    for i = 2, 1, -1 do
        if not PlayerData.Quests:FindFirstChild("Obby"..i) then
            for i2 = 1, #Obbies["Obby"..i].Checkpoints:GetChildren() do
                local Base = Obbies["Obby"..i].Checkpoints[i2].Base
                
                while Base.Color == Color3.fromRGB(245, 205, 48) do
                    Character.HumanoidRootPart.CFrame = Base.CFrame
                    firetouchinterest(Character:FindFirstChild("Left Leg") or Character.LeftFoot, Base, 0)
                    RunService.RenderStepped:Wait()
                end
            end
            
            local Reward = ObbyRewards["Obby"..i.."Reward"]
            
            while Reward:FindFirstChild("ProximityPrompt") do
                Character.HumanoidRootPart.CFrame = Reward.CFrame
                fireproximityprompt(Reward.ProximityPrompt)
                RunService.RenderStepped:Wait()
            end
        end
    end
    
    while not PlayerData.Quests:FindFirstChild("CTF") or PlayerData.Quests.CTF.Value > 0 do
        local Flag = Character:FindFirstChild("Flag", true)
        
        if Flag then
            if Flag.Color == Color3.fromRGB(13, 105, 172) then
                Character.HumanoidRootPart.CFrame = FlagStands.RedFlagStand.Base.CFrame
                firetouchinterest(Character.HumanoidRootPart, FlagStands.RedFlagStand.Base, 0)
            elseif Flag.Color == Color3.fromRGB(196, 40, 28) then
                Character.HumanoidRootPart.CFrame = FlagStands.BlueFlagStand.Base.CFrame
                firetouchinterest(Character.HumanoidRootPart, FlagStands.BlueFlagStand.Base, 0)
            end
        else
            Character.HumanoidRootPart.CFrame = FlagStands.BlueFlagStand.Base.CFrame
            firetouchinterest(Character.HumanoidRootPart, FlagStands.BlueFlagStand.Base, 0)
        end
        
        RunService.RenderStepped:Wait()
    end
    
    Character.HumanoidRootPart.CFrame = OldCF
    
    for i, v in workspace.Checkpoints:GetChildren() do
        if not PlayerData.Checkpoints:FindFirstChild(v.Name) then
            firetouchinterest(Character.HumanoidRootPart, v.Checkpoint.Primary, 0)
        end
    end
    
    for i, v in workspace.Checkpoints:GetChildren() do
        while not PlayerData.Checkpoints:FindFirstChild(v.Name) do
            RunService.RenderStepped:Wait()
        end
    end
    
    if not PlayerData.Quests:FindFirstChild("Thirsty") then
        while PlayerData.Currencies.Tix.Value > 3 and PlayerData.Currencies.BeverageTokens.Value < 1 and PlayerData.Currencies.SpentBeverageTokens.Value < 1 do
            Remotes.PurchaseEventItem:InvokeServer(Remotes.PurchaseEventItem.HubItem, "VendingMachineCoin")
            RunService.RenderStepped:Wait()
        end
        
        while PlayerData.Currencies.BeverageTokens.Value > 0 and PlayerData.Currencies.SpentBeverageTokens.Value < 1 do
            Remotes.VendingMachine:InvokeServer("Bloxiade")
            RunService.RenderStepped:Wait()
        end
        
        local HelperBot
        
        for i, v in workspace:GetChildren() do
            if v.Name == "HelperBot" and v:IsA("Model") then
                HelperBot = v
                break
            end
        end
        
        if HelperBot then
            local Index
            
            for i, v in LocalPlayer.Toolbar:GetChildren() do
                if v.Value == "Bloxiade" or v.Value == "BloxyCola" or v.Value == "ChocolateMilk" or v.Value == "WitchBrew" then
                    Index = tonumber(v.Name)
                    break
                end
            end
            
            if Index then
                Remotes.ToolRequest:InvokeServer(Remotes.ToolRequest.Unequip)
                Remotes.ToolRequest:InvokeServer(Remotes.ToolRequest.Equip, Index)
                
                OldCF = Character.HumanoidRootPart.CFrame
                
                while not PlayerData.Quests:FindFirstChild("Thirsty") do
                    Character.HumanoidRootPart.CFrame = HelperBot.HumanoidRootPart.CFrame
                    ShareWithHelperBot:FireServer(LocalPlayer.Toolbar[Index], HelperBot)
                    RunService.RenderStepped:Wait()
                end
                
                Character.HumanoidRootPart.CFrame = OldCF
                Remotes.ToolRequest:InvokeServer(Remotes.ToolRequest.Unequip)
            end
        end
    end
elseif game.PlaceId == 11765402359 then
    local Remotes = game:GetService("ReplicatedStorage").Remotes
    
    Remotes.ClassicEventQuest3Captured:FireServer()
    
    for i = 1, 5 do
        Remotes.RequestClassicBadge:InvokeServer({badgeKey = "CLASSIC_EVENT_CHARACTER_"..i})
    end
    
    for i = 1, 10 do
        Remotes.RequestClassicBadge:InvokeServer({badgeKey = "CLASSIC_EVENT_TIX_"..string.format("%02i", i)})
    end
elseif game.PlaceId == 15101393044 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    
    for i, v in workspace.RobloxClassic_WS.BasicCurrency:GetChildren() do
        while v.Parent do
            ReplicatedStorage.RobloxClassic_RPS.Collect:FireServer(v)
            RunService.RenderStepped:Wait()
        end
    end
elseif game.PlaceId == 17576951132 then
    local RunService = game:GetService("RunService")
    local Character = game:GetService("Players").LocalPlayer.Character
    
    for i, v in workspace.Currency:GetChildren() do
        while v.Parent do
            firetouchinterest(Character.HumanoidRootPart, v, 0)
            RunService.RenderStepped:Wait()
        end
    end
elseif game.PlaceId == 1537690962 or game.PlaceId == 17579226768 then
    local RunService = game:GetService("RunService")
    local Character = game:GetService("Players").LocalPlayer.Character
    local Parts = {}
    
    for i, v in Character:GetChildren() do
        if v:IsA("BasePart") then
            table.insert(Parts, v)
        end
    end
    
    for i, v in workspace.Tix:GetChildren() do
        while v.Parent do
            firetouchinterest(Parts[math.random(#Parts)], v, 0)
            RunService.RenderStepped:Wait()
        end
    end
end
