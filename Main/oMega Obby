local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

local Window = Library:CreateWindow{
    Title = "oMega Obby 🌟 - just teleport",
    SubTitle = "by pxrson",
    TabWidth = 160,
    Size = UDim2.fromOffset(630, 425),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Amethyst Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
}

local Tabs = {
    Teleport = Window:CreateTab{ Title = "Teleport", Icon = "phosphor-rocket-launch-bold" },
    Settings = Window:CreateTab{ Title = "Settings", Icon = "settings" }
}

local Options = Library.Options

local stageNumbers = {}
for i = 1, 727 do
    table.insert(stageNumbers, tostring(i))
end

Tabs.Teleport:CreateDropdown("StageDropdown", {
    Title = "Teleport to Stage",
    Values = stageNumbers,
    Multi = false,
    Default = 1,
    Callback = function(Value)
        local stageNum = tonumber(Value)
        if stageNum then
            local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            local spawn = game.Workspace.Stages:FindFirstChild(tostring(stageNum))
            if spawn and spawn:FindFirstChild("Spawn") then
                local offset = Vector3.new(0, 5, 0)
                char:PivotTo(spawn.Spawn.CFrame + offset)
            end
        end
    end
})

Tabs.Teleport:CreateButton{
    Title = "Teleport to End",
    Description = "Teleport to stage 727",
    Callback = function()
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local spawn = game.Workspace.Stages:FindFirstChild("727")
        if spawn and spawn:FindFirstChild("Spawn") then
            local offset = Vector3.new(0, 5, 0)
            char:PivotTo(spawn.Spawn.CFrame + offset)
        end
    end
}

Tabs.Teleport:CreateToggle("AutoSkip", {
    Title = "Unlock All Stages Instantly",
    Default = false,
    Callback = function(Value)
        if Value then
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                for i = 1, 727 do
                    local stage = game.Workspace.Stages:FindFirstChild(tostring(i))
                    if stage and stage:FindFirstChild("Spawn") then
                        firetouchinterest(humanoidRootPart, stage.Spawn, 0)
                        firetouchinterest(humanoidRootPart, stage.Spawn, 1)
                    end
                end
            end
            Options.AutoSkip:SetValue(false)
        end
    end
})

Library:Notify{
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
}

SaveManager:LoadAutoloadConfig()
SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes{}
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
