local selectedUpgrades = {}
local ultimateUpgrades = {
    {name = "RepSpeed", title = "+5% Rep Speed"},
    {name = "PetSlot", title = "+1 Pet Slot"},
    {name = "ItemCapacity", title = "+10 Item Capacity"},
    {name = "DailySpin", title = "+1 Daily Spin"},
    {name = "ChestRewards", title = "x2 Chest Rewards"},
    {name = "QuestRewards", title = "x2 Quest Rewards"},
    {name = "MuscleMind", title = "Muscle Mind"},
    {name = "JungleSwift", title = "Jungle Swift"},
    {name = "InfernalHealth", title = "Infernal Health"},
    {name = "GalaxyGains", title = "Galaxy Gains"},
    {name = "DemonDamage", title = "Demon Damage"},
    {name = "GoldenRebirth", title = "Golden Rebirth"}
}

for _, upgrade in ipairs(ultimateUpgrades) do
    local switch = folder:AddSwitch(upgrade.title, function(bool)
        selectedUpgrades[upgrade.name] = bool
    end)
    switch:Set(false)
end

task.spawn(function()
    while true do
        for upgradeName, isEnabled in pairs(selectedUpgrades) do
            if isEnabled then
                ReplicatedStorage.rEvents.ultimatesRemote:InvokeServer("upgradeUltimate", upgradeName)
                task.wait(0.1)
            end
        end
        task.wait(1)
    end
end)
