--// auto speed grind NO rebirth (equip packs urself)
for i = 1, 12 do
    task.spawn(function()
        while value do
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.083)
        end
    end)
end

--// auto join brawl
while true do
    game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
    task.wait()
end

--// auto spin wheel
while true do
    game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
end

--// auto claim all gifts
while true do
    for i = 1, 8 do
        game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
    end
end

--// auto tools
-- weight
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Weight"))
while true do
    game.Players.LocalPlayer.muscleEvent:FireServer("rep")
    task.wait()
end

-- pushups
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups"))
while true do
    game.Players.LocalPlayer.muscleEvent:FireServer("rep")
    task.wait()
end

-- handstands
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Handstands"))
while true do
    game.Players.LocalPlayer.muscleEvent:FireServer("rep")
    task.wait()
end

-- situps
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Situps"))
while true do
    game.Players.LocalPlayer.muscleEvent:FireServer("rep")
    task.wait()
end

-- punch
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Punch"))
while true do
    game.Players.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
    game.Players.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    local punchTool = game.Players.LocalPlayer.Character:FindFirstChild("Punch")
    if punchTool then
        punchTool:Activate()
    end
    task.wait()
end

--// auto eat all protein
local player = game.Players.LocalPlayer
local humanoid = player.Character.Humanoid

local tools = {"Protein Shake", "TOUGH Bar", "ULTRA Shake", "Energy Shake", "Protein Bar", "Energy Bar"} -- no egg or the other thing

while true do
    for i, tool in pairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and table.find(tools, tool.Name) then
            humanoid:EquipTool(tool)
            tool:Activate()
        end
    end
    wait(0.1)
end

--// fast rebirth (equip packs urself)
task.spawn(function()
    while true do
        local player = game.Players.LocalPlayer
        local rebirths = player.leaderstats.Rebirths.Value
        local rebirthCost = 10000 + (5000 * rebirths)

        if player.ultimatesFolder:FindFirstChild("Golden Rebirth") then
            local goldenRebirths = player.ultimatesFolder["Golden Rebirth"].Value
            rebirthCost = math.floor(rebirthCost * (1 - (goldenRebirths * 0.1)))
        end

        local machine = findMachine("Jungle Bar Lift")
        if machine and machine:FindFirstChild("interactSeat") then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = machine.interactSeat.CFrame * CFrame.new(0, 3, 0)
                task.wait(0.1)
                pressE()
            end
        end

        while player.leaderstats.Strength.Value < rebirthCost do
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.03)
        end

        if player.leaderstats.Strength.Value >= rebirthCost then
            task.wait(0.1)
            game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
        end

        task.wait(0.05)
    end
end)
