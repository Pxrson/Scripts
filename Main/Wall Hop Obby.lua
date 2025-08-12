if game.PlaceId ~= 125822183289695 then
    game:GetService("Players").LocalPlayer:Kick("this script is only for Wall Hop Obby bozo")
    return
end

local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

local Window = Library:CreateWindow{
    Title = "Wall Hop Obby",
    SubTitle = "by pxrson",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
}

local Tabs = {
    Main = Window:CreateTab{ Title = "Main", Icon = "house" },
    Teleport = Window:CreateTab{ Title = "Teleport", Icon = "map" },
    Settings = Window:CreateTab{ Title = "Settings", Icon = "settings" }
}

local Options = Library.Options
local LocalPlayer = game:GetService("Players").LocalPlayer

local stages = {
    {Name = "0", Path = "Workspace.Stages.0", Position = Vector3.new(21, -279.5, -31)},
    {Name = "1", Path = "Workspace.Stages.1", Position = Vector3.new(37, -279.5, -31)},
    {Name = "2", Path = "Workspace.Stages.2", Position = Vector3.new(66, -264.5, -31.5)},
    {Name = "3", Path = "Workspace.Stages.3", Position = Vector3.new(87, -250.5, -31.5)},
    {Name = "4", Path = "Workspace.Stages.4", Position = Vector3.new(107, -236.5, -31.5)},
    {Name = "5", Path = "Workspace.Stages.5", Position = Vector3.new(142, -236.5, -31.5)},
    {Name = "6", Path = "Workspace.Stages.6", Position = Vector3.new(175, -236.5, -31.5)},
    {Name = "7", Path = "Workspace.Stages.7", Position = Vector3.new(201, -226.5, -31.5)},
    {Name = "8", Path = "Workspace.Stages.8", Position = Vector3.new(242, -185.5, -31.5)},
    {Name = "9", Path = "Workspace.Stages.9", Position = Vector3.new(288, -140.5, -31.5)},
    {Name = "10", Path = "Workspace.Stages.10", Position = Vector3.new(341, -140.5, -31.5)},
    {Name = "11", Path = "Workspace.Stages.11", Position = Vector3.new(388, -112.5, -31.5)},
    {Name = "12", Path = "Workspace.Stages.12", Position = Vector3.new(433, -112.5, -31.5)},
    {Name = "13", Path = "Workspace.Stages.13", Position = Vector3.new(453, -92.5, -31.5)},
    {Name = "14", Path = "Workspace.Stages.14", Position = Vector3.new(480, -60.5, -31.5)},
    {Name = "15", Path = "Workspace.Stages.15", Position = Vector3.new(520, -43.5, -31.5)},
    {Name = "16", Path = "Workspace.Stages.16", Position = Vector3.new(563, -3.5, -31.5)},
    {Name = "17", Path = "Workspace.Stages.17", Position = Vector3.new(599, -3.5, -31.5)},
    {Name = "18", Path = "Workspace.Stages.18", Position = Vector3.new(660, -15.5, -31.5)},
    {Name = "19", Path = "Workspace.Stages.19", Position = Vector3.new(679, 10.5, -31.5)},
    {Name = "20", Path = "Workspace.Stages.20", Position = Vector3.new(742, 22.5, -31.5)},
    {Name = "21", Path = "Workspace.Stages.21", Position = Vector3.new(770, -24.5, -31.5)},
    {Name = "22", Path = "Workspace.Stages.22", Position = Vector3.new(805, 16.5, -31.5)},
    {Name = "23", Path = "Workspace.Stages.23", Position = Vector3.new(835, 16.5, -31.5)},
    {Name = "24", Path = "Workspace.Stages.24", Position = Vector3.new(866, 44.5, -31.5)},
    {Name = "25", Path = "Workspace.Stages.25", Position = Vector3.new(907, 44.5, -31.5)},
    {Name = "26", Path = "Workspace.Stages.26", Position = Vector3.new(929, 67.5, -10.5)},
    {Name = "27", Path = "Workspace.Stages.27", Position = Vector3.new(982, 67.5, -10.5)},
    {Name = "28", Path = "Workspace.Stages.28", Position = Vector3.new(1004, 99.5, -10.5)},
    {Name = "29", Path = "Workspace.Stages.29", Position = Vector3.new(1024, 118.5, -10.5)},
    {Name = "30", Path = "Workspace.Stages.30", Position = Vector3.new(1044, 138.5, -10.5)},
    {Name = "31", Path = "Workspace.Stages.31", Position = Vector3.new(1086, 156.5, -10.5)},
    {Name = "32", Path = "Workspace.Stages.32", Position = Vector3.new(1136.9998779296875, 156.5, -10.5)},
    {Name = "33", Path = "Workspace.Stages.33", Position = Vector3.new(1190, 156.5, -10.5)},
    {Name = "34", Path = "Workspace.Stages.34", Position = Vector3.new(1242, 175.5, -10.5)},
    {Name = "35", Path = "Workspace.Stages.35", Position = Vector3.new(1300.9998779296875, 175.5, -10.5)},
    {Name = "36", Path = "Workspace.Stages.36", Position = Vector3.new(1351.9998779296875, 175.5, -10.5)},
    {Name = "37", Path = "Workspace.Stages.37", Position = Vector3.new(1376.9998779296875, 187.49998474121094, -10.49998664855957)},
    {Name = "38", Path = "Workspace.Stages.38", Position = Vector3.new(1433.9998779296875, 190.49998474121094, -10.49998664855957)},
    {Name = "39", Path = "Workspace.Stages.39", Position = Vector3.new(1500.9998779296875, 206.49996948242188, -10.49998664855957)},
    {Name = "40", Path = "Workspace.Stages.40", Position = Vector3.new(1574.9998779296875, 206.49996948242188, -10.49998664855957)},
    {Name = "41", Path = "Workspace.Stages.41", Position = Vector3.new(1637.9998779296875, 209.49996948242188, -10.499977111816406)},
    {Name = "42", Path = "Workspace.Stages.42", Position = Vector3.new(1693.9998779296875, 219.49996948242188, -10.499977111816406)},
    {Name = "43", Path = "Workspace.Stages.43", Position = Vector3.new(1759.9998779296875, 231.49996948242188, -10.499977111816406)},
    {Name = "44", Path = "Workspace.Stages.44", Position = Vector3.new(1834.9998779296875, 237.49996948242188, -10.499977111816406)},
    {Name = "45", Path = "Workspace.Stages.45", Position = Vector3.new(1861.9998779296875, 237.49996948242188, -10.499977111816406)},
    {Name = "46", Path = "Workspace.Stages.46", Position = Vector3.new(1883.9998779296875, 258.4999694824219, -10.499977111816406)},
    {Name = "47", Path = "Workspace.Stages.47", Position = Vector3.new(1929.4998779296875, 258.5, 2.0000228881835938)},
    {Name = "48", Path = "Workspace.Stages.48", Position = Vector3.new(1986.4998779296875, 258.5, 2.0000228881835938)},
    {Name = "49", Path = "Workspace.Stages.49", Position = Vector3.new(2032.5, 258.5, 2.4999542236328125)},
    {Name = "50", Path = "Workspace.Stages.50", Position = Vector3.new(2076.5, 262.5, 2.4999547004699707)},
    {Name = "51", Path = "Workspace.Stages.51", Position = Vector3.new(2130.5, 262.5, 2.4999547004699707)},
    {Name = "52", Path = "Workspace.Stages.52", Position = Vector3.new(2195.5, 262.5, 2.4999547004699707)},
    {Name = "53", Path = "Workspace.Stages.53", Position = Vector3.new(2276.5, 254.5, 2.4999547004699707)},
    {Name = "54", Path = "Workspace.Stages.54", Position = Vector3.new(2330.5, 264.5, 2.4999547004699707)},
    {Name = "55", Path = "Workspace.Stages.55", Position = Vector3.new(2406.5, 276.5, 2.4999547004699707)}
}

local playerName = game.Players.LocalPlayer.Name

Tabs.Main:CreateParagraph("Welcome", {
    Title = "Greetings!",
    Content = "Welcome, " .. playerName .. ", to my script!! This script allows you to teleport through all stages of the game easily. Use the Teleport tab to access teleportation options. Enjoy the script please!"
})

Tabs.Main:CreateSection("Random")

Tabs.Main:CreateToggle("Auto Wall Hop", {
    Title = "Auto Wall Hop (not worked on yet)",
    Description = "Automatically hops walls for you.",
    Default = false
}):OnChanged(function()
    if Options.AutoWallHop.Value then
        Library:Notify{
            Title = "Auto Wall Hop",
            Content = "Auto wall hop enabled.",
            Duration = 5
        }
        -- code
    else
        Library:Notify{
            Title = "Auto Wall Hop",
            Content = "Auto wall hop disabled.",
            Duration = 5
        }
    end
end)

Tabs.Main:CreateSection("Player")

Tabs.Main:CreateButton{
    Title = "Reset Character",
    Description = "Resets your character.",
    Callback = function()
        local character = LocalPlayer.Character
        if character then
            character:BreakJoints()
            Library:Notify{
                Title = "Reset Character",
                Content = "Character has been reset.",
                Duration = 2
            }
        else
            Library:Notify{
                Title = "Error",
                Content = "Character not found.",
                Duration = 5
            }
        end
    end
}

Tabs.Main:CreateButton{
    Title = "Leave Game",
    Description = "Leaves the game.",
    Callback = function()
        LocalPlayer:Kick("You have left the game.")
    end
}

Tabs.Main:CreateButton{
    Title = "Rejoin Game",
    Description = "Rejoins the game.",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
}

Tabs.Main:CreateButton{
    Title = "Server Hop",
    Description = "Hops to a new server.",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId

        local function serverHop()
            local servers = {}
            local req = game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=2&limit=100")
            local data = HttpService:JSONDecode(req)
            for _, v in pairs(data.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers, v.id)
                end
            end
            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], LocalPlayer)
            else
                Library:Notify{
                    Title = "Server Hop",
                    Content = "No available servers found.",
                    Duration = 5
                }
            end
        end

        serverHop()
    end
}

local teleportToStage = function(position)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
        Library:Notify{
            Title = "Teleport",
            Content = "Teleported to stage position: " .. tostring(position),
            Duration = 2
        }
    else
        Library:Notify{
            Title = "Error",
            Content = "Character or HumanoidRootPart not found.",
            Duration = 5
        }
    end
end

Tabs.Teleport:CreateSection("Auto Teleport")

Tabs.Teleport:CreateToggle("AutoTeleport", {
    Title = "Auto Teleport",
    Description = "Automatically teleports through all stages.",
    Default = false
}):OnChanged(function()
    if Options.AutoTeleport.Value then
        Library:Notify{
            Title = "Auto Teleport",
            Content = "Auto teleport started.",
            Duration = 5
        }
        task.spawn(function()
            while Options.AutoTeleport.Value and not Library.Unloaded do
                for _, stage in ipairs(stages) do
                    if not Options.AutoTeleport.Value then break end
                    teleportToStage(stage.Position)
                    task.wait(0.5)
                end
            end
        end)
    else
        Library:Notify{
            Title = "Auto Teleport",
            Content = "Auto teleport stopped.",
            Duration = 5
        }
    end
end)

Tabs.Teleport:CreateSection("Manual Teleport")

for _, stage in ipairs(stages) do
    Tabs.Teleport:CreateButton{
        Title = "Teleport to Stage " .. stage.Name,
        Description = "Teleport to " .. stage.Path,
        Callback = function()
            teleportToStage(stage.Position)
        end
    }
end

SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes{}
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()
Window:SelectTab(1)

Library:Notify{
    Title = "Wall Hop Obby",
    Content = "Script loaded, enjoy! - Made by pxrson",
    Duration = 8
}
