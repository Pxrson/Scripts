--// free autolift gamepass
local gamepasses = game:GetService("ReplicatedStorage").gamepassIds
local player = game:GetService("Players").LocalPlayer
for _, pass in pairs(gamepasses:GetChildren()) do
    local passValue = Instance.new("IntValue")
    passValue.Name = pass.Name
    passValue.Value = pass.Value
    passValue.Parent = player.ownedGamepasses
end

