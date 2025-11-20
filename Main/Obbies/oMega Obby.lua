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
    Teleport = Window:CreateTab{Title = "Teleport", Icon = "phosphor-rocket-launch-bold"},
    Settings = Window:CreateTab{Title = "Settings", Icon = "settings"}
}

local Options = Library.Options
local StageNumbers = {}

for i = 1, 727 do
    table.insert(StageNumbers, tostring(i))
end

Tabs.Teleport:CreateDropdown("StageDropdown", {
    Title = "Teleport to Stage",
    Values = StageNumbers,
    Multi = false,
    Default = 1,
    Callback = function(Value)
        local StageNum = tonumber(Value)
        if StageNum then
            local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            local Stage = game.Workspace.Stages:FindFirstChild(tostring(StageNum))
            if Stage and Stage:FindFirstChild("Spawn") then
                local Offset = Vector3.new(0, 5, 0)
                Character:PivotTo(Stage.Spawn.CFrame + Offset)
            end
        end
    end
})

Tabs.Teleport:CreateButton{
    Title = "Teleport to End",
    Description = "Teleport to stage 727",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local Stage = game.Workspace.Stages:FindFirstChild("727")
        if Stage and Stage:FindFirstChild("Spawn") then
            local Offset = Vector3.new(0, 5, 0)
            Character:PivotTo(Stage.Spawn.CFrame + Offset)
        end
    end
}

Tabs.Teleport:CreateToggle("AutoSkip", {
    Title = "Unlock All Stages Instantly",
    Default = false,
    Callback = function(Value)
        if Value then
            local Player = game.Players.LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            
            if HumanoidRootPart then
                for i = 1, 727 do
                    local Stage = game.Workspace.Stages:FindFirstChild(tostring(i))
                    if Stage and Stage:FindFirstChild("Spawn") then
                        firetouchinterest(HumanoidRootPart, Stage.Spawn, 0)
                        firetouchinterest(HumanoidRootPart, Stage.Spawn, 1)
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
