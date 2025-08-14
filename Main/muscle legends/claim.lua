-- claim all codes
local Event = game:GetService("ReplicatedStorage").rEvents.codeRemote

local codes = {
  "mightygems2500", -- 2500 gems
  "ultimate250", -- 250 strength
  "spacegems50", -- 5,000 gems
  "megalift50", -- 250 strength
  "speedy50", -- 250 agility
  "epicreward500", -- 500 gems
  "MillionWarriors", -- 1,500 strength
  "frostgems10", -- 10,000 gems
  "Musclestorm50", -- 1,500 strength
  "Skyagility50", -- 500 agility
  "galaxycrystal50", -- 5,000 gems
  "supermuscle100", -- 200 strength
  "superpunch100", -- 100 strength
  "launch250" -- 250 gems
}

for _, code in ipairs(codes) do
    Event:InvokeServer(code)
    wait(0.1)
end

-- claim all chest
local player = game.Players.LocalPlayer
local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

if not hrp then 
  return 
end

local chests = {
    {name = "jungleChest", pos = Vector3.new(-7911.20458984375, 5.2241363525390625, 3012.025390625)},
    {name = "goldenChest", pos = Vector3.new(-139.0132293701172, 8.253730773925781, -273.2858581542969)},
    {name = "groupRewardsCircle", pos = Vector3.new(40.05659103393555, 8.253724098205566, 412.74591064453125)},
    {name = "enchantedChest", pos = Vector3.new(-2574.909912109375, 8.253731727600098, -557.5172729492188)},
    {name = "magmaChest", pos = Vector3.new(-6713.0126953125, 8.253730773925781, -1450.0267333984375)},
    {name = "mythicalChest", pos = Vector3.new(2208.426025390625, 8.253730773925781, 910.7802734375)},
    {name = "legendsChest", pos = Vector3.new(4666.7734375, 1001.9722290039062, -3688.669921875)}
}

for i, chest in ipairs(chests) do
    if hrp then
        hrp.CFrame = CFrame.new(chest.pos)
        task.wait(0.05)

        local chestObj = workspace:FindFirstChild(chest.name)
        if chestObj and chestObj:FindFirstChild("circleInner") then
            chestObj.circleInner.CFrame = hrp.CFrame
            task.wait(0.05)
        end
    else
      break
    end
end

-- AUTO claim all gifts
while true do
    for i = 1, 8 do
        game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
    end
end
