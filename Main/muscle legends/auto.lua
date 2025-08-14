--// auto speed grind (u have to equip your packs urself)
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
