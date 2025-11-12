-- discord: .pxrson
-- beware of ping getting to high, might ruin your grind !!
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local Character, Humanoid, Hand, Punch, Animator
local LastAttack, LastRespawn, LastCheck = 0, 0, 0
local Running = false
local StartTime = os.time()
local WhitelistFriends = false

getgenv().WhitelistedPlayers = getgenv().WhitelistedPlayers or {}

local Animations = {
    ["rbxassetid://3638729053"] = true,
    ["rbxassetid://3638749874"] = true,
    ["rbxassetid://3638767427"] = true,
    ["rbxassetid://102357151005774"] = true
}

local function UpdateWhitelist()
    if WhitelistFriends then
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if targetPlayer ~= LocalPlayer and targetPlayer:IsFriendsWith(LocalPlayer.UserId) then
                local playerName = targetPlayer.Name
                local alreadyWhitelisted = false
                for _, name in ipairs(getgenv().WhitelistedPlayers) do
                    if name:lower() == playerName:lower() then
                        alreadyWhitelisted = true
                        break
                    end
                end
                if not alreadyWhitelisted then
                    table.insert(getgenv().WhitelistedPlayers, playerName)
                end
            end
        end
    else
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if targetPlayer ~= LocalPlayer and targetPlayer:IsFriendsWith(LocalPlayer.UserId) then
                local playerName = targetPlayer.Name
                for i = #getgenv().WhitelistedPlayers, 1, -1 do
                    if getgenv().WhitelistedPlayers[i]:lower() == playerName:lower() then
                        table.remove(getgenv().WhitelistedPlayers, i)
                    end
                end
            end
        end
    end
end

local function IsWhitelisted(player)
    if not WhitelistFriends then return false end
    for _, name in ipairs(getgenv().WhitelistedPlayers) do
        if name:lower() == player.Name:lower() then
            return true
        end
    end
    return false
end

local function UpdateAll()
    Character = LocalPlayer.Character
    if Character then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
        Hand = Character:FindFirstChild("LeftHand") or Character:FindFirstChild("Left Arm")
        Animator = Humanoid and (Character:FindFirstChildOfClass("Animator") or Humanoid:FindFirstChildOfClass("Animator"))
        Punch = Character:FindFirstChild("Punch")
    else
        Character, Humanoid, Hand, Animator, Punch = nil, nil, nil, nil, nil
    end
end

LocalPlayer.CharacterAdded:Connect(UpdateAll)
Players.PlayerAdded:Connect(function()
    UpdateWhitelist()
end)
UpdateAll()

RunService.RenderStepped:Connect(function()
    if not Running then return end
    local TimeNow = os.clock()
    if TimeNow - LastAttack < 0.05 then return end
    LastAttack = TimeNow
    if not Character or not Humanoid or TimeNow - LastCheck > 1 then
        UpdateAll()
        LastCheck = TimeNow
        if not Character or not Humanoid then return end
    end
    if not Hand then
        Hand = Character:FindFirstChild("LeftHand") or Character:FindFirstChild("Left Arm")
        if not Hand then return end
    end
    if not Punch or not Punch.Parent then
        Punch = Character:FindFirstChild("Punch")
        if not Punch then
            local Tool = LocalPlayer.Backpack:FindFirstChild("Punch")
            if Tool then
                Humanoid:EquipTool(Tool)
                Punch = Character:FindFirstChild("Punch")
            else
                if TimeNow - LastRespawn > 3 and Humanoid and Humanoid.Health > 0 then
                    Humanoid.Health = 0
                    LastRespawn = TimeNow
                end
                return
            end
        end
    end
    if Punch and Punch.Parent then
        Punch.attackTime.Value = 0
        Punch:Activate()
        for _, Player in ipairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer and not IsWhitelisted(Player) then
                local Character2 = Player.Character
                if Character2 and Character2.Parent then
                    local Humanoid2 = Character2:FindFirstChildOfClass("Humanoid")
                    local Head = Character2:FindFirstChild("Head")
                    if Humanoid2 and Head and Humanoid2.Health > 0 then
                        firetouchinterest(Head, Hand, 0)
                        firetouchinterest(Head, Hand, 1)
                    end
                end
            end
        end
        if Animator then
            for _, Track in ipairs(Animator:GetPlayingAnimationTracks()) do
                local Animation = Track.Animation
                if Animation and Animations[Animation.AnimationId] then
                    Track:Stop()
                end
            end
        end
    end
end)

LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local Screen = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local TitleBar = Instance.new("Frame")
local TitleCorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local FpsLabel = Instance.new("TextLabel")
local TimeLabel = Instance.new("TextLabel")
local ExecLabel = Instance.new("TextLabel")
local WhitelistToggle = Instance.new("TextButton")
local StartButton = Instance.new("TextButton")
local StopButton = Instance.new("TextButton")

Screen.Parent = game:GetService("CoreGui")
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Screen.ResetOnSpawn = false

Main.Parent = Screen
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BackgroundTransparency = 0.1
Main.Position = UDim2.new(0.5, -90, 0.1, 0)
Main.Size = UDim2.new(0, 180, 0, 130)

TitleBar.Parent = Main
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BackgroundTransparency = 0.1
TitleBar.Size = UDim2.new(1, 0, 0, 22)

TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0, 4)

MainCorner.Parent = Main
MainCorner.CornerRadius = UDim.new(0, 4)

Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 8, 0, 0)
Title.Size = UDim2.new(1, -32, 1, 0)
Title.Font = Enum.Font.Code
Title.Text = "Auto Kill Control"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.Size = UDim2.new(0, 20, 1, 0)
CloseButton.Font = Enum.Font.Code
CloseButton.Text = "×"
CloseButton.TextSize = 14
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.AutoButtonColor = false

FpsLabel.Parent = Main
FpsLabel.BackgroundTransparency = 1
FpsLabel.Position = UDim2.new(0, 8, 0, 26)
FpsLabel.Size = UDim2.new(1, -10, 0, 18)
FpsLabel.Font = Enum.Font.Code
FpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FpsLabel.TextSize = 13
FpsLabel.TextXAlignment = Enum.TextXAlignment.Left

TimeLabel.Parent = Main
TimeLabel.BackgroundTransparency = 1
TimeLabel.Position = UDim2.new(0, 8, 0, 46)
TimeLabel.Size = UDim2.new(1, -10, 0, 18)
TimeLabel.Font = Enum.Font.Code
TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeLabel.TextSize = 13
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left

ExecLabel.Parent = Main
ExecLabel.BackgroundTransparency = 1
ExecLabel.Position = UDim2.new(0, 8, 0, 66)
ExecLabel.Size = UDim2.new(1, -10, 0, 18)
ExecLabel.Font = Enum.Font.Code
ExecLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecLabel.TextSize = 13
ExecLabel.TextXAlignment = Enum.TextXAlignment.Center

WhitelistToggle.Parent = Main
WhitelistToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
WhitelistToggle.Position = UDim2.new(0, 8, 0, 88)
WhitelistToggle.Size = UDim2.new(1, -16, 0, 18)
WhitelistToggle.Font = Enum.Font.Code
WhitelistToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
WhitelistToggle.TextSize = 13
WhitelistToggle.Text = "Whitelist Friends: OFF"

StartButton.Parent = Main
StartButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StartButton.Position = UDim2.new(0, 8, 0, 108)
StartButton.Size = UDim2.new(0, 78, 0, 18)
StartButton.Font = Enum.Font.Code
StartButton.TextColor3 = Color3.fromRGB(0, 255, 0)
StartButton.TextSize = 13
StartButton.Text = "Start"

StopButton.Parent = Main
StopButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StopButton.Position = UDim2.new(0, 94, 0, 108)
StopButton.Size = UDim2.new(0, 78, 0, 18)
StopButton.Font = Enum.Font.Code
StopButton.TextColor3 = Color3.fromRGB(255, 0, 0)
StopButton.TextSize = 13
StopButton.Text = "Stop"

local Dragging = false
local DragInput, MousePos, FramePos

TitleBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        MousePos = Input.Position
        FramePos = Main.Position
        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
        DragInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Input == DragInput and Dragging then
        local Delta = Input.Position - MousePos
        Main.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
    end
end)

WhitelistToggle.MouseButton1Click:Connect(function()
    WhitelistFriends = not WhitelistFriends
    WhitelistToggle.Text = "Whitelist Friends: " .. (WhitelistFriends and "ON" or "OFF")
    WhitelistToggle.TextColor3 = WhitelistFriends and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
    UpdateWhitelist()
end)

StartButton.MouseButton1Click:Connect(function()
    Running = true
    StartTime = os.time()
end)

StopButton.MouseButton1Click:Connect(function()
    Running = false
end)

CloseButton.MouseButton1Click:Connect(function()
    Screen:Destroy()
end)

RunService.RenderStepped:Connect(function()
    FpsLabel.Text = "fps: " .. math.floor(1/RunService.RenderStepped:Wait())
    TimeLabel.Text = "time: " .. os.date("%H:%M:%S")
    local Elapsed = os.time() - StartTime
    ExecLabel.Text = string.format("exec: %02d:%02d:%02d", Elapsed/3600%24, Elapsed/60%60, Elapsed%60)
end)

StarterGui:SetCore("SendNotification", {
    Title = "Auto Kill Control",
    Text = "running",
    Duration = 5
})
