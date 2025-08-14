local rockLocations = {
    {"TinyIslandRock", "Tiny Island Rock", 0},
    {"StarterIslandRock", "Starter Island Rock", 100},
    {"LegendBeachRock", "Legend Beach Rock", 5000},
    {"FrostGymRock", "Frost Gym Rock", 150000},
    {"MythicalGymRock", "Mythical Gym Rock", 400000},
    {"EternalGymRock", "Eternal Gym Rock", 750000},
    {"LegendGymRock", "Legend Gym Rock", 1000000},
    {"MuscleKingGymRock", "Muscle King Gym Rock", 5000000},
    {"AncientJungleRock", "Ancient Jungle Rock", 10000000}
}

while value do
    task.wait()
    for _, rock in ipairs(rockLocations) do
        if selectedRock == rock[2] and game.Players.LocalPlayer.Durability.Value >= rock[3] then
            for _, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                if v.Name == "neededDurability" and v.Value == rock[3] and
                   game.Players.LocalPlayer.Character and
                   game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                   game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then

                    firetouchinterest(v.Parent.Rock, game.Players.LocalPlayer.Character.RightHand, 0)
                    firetouchinterest(v.Parent.Rock, game.Players.LocalPlayer.Character.RightHand, 1)
                    firetouchinterest(v.Parent.Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                    firetouchinterest(v.Parent.Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                    
                    local player = game.Players.LocalPlayer
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        for _, tool in pairs(player.Backpack:GetChildren()) do
                            if tool.Name == "Punch" then
                                player.Character.Humanoid:EquipTool(tool)
                            end
                        end
                        player.muscleEvent:FireServer("punch", "leftHand")
                        player.muscleEvent:FireServer("punch", "rightHand")
                    end
                end
            end
        end
    end
end
