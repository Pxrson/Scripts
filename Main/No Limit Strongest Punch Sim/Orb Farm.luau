local Services = {
    Players = game:GetService("Players"),
    StarterGui = game:GetService("StarterGui")
}

local Player = Services.Players.LocalPlayer
local Stage, Running = 1, false
local MaxStage = 30

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local TitleBar = Instance.new("Frame")
local TitleCorner = Instance.new("UICorner")
local CloseButton = Instance.new("TextButton")
local TitleLabel = Instance.new("TextLabel")
local StageLabel = Instance.new("TextLabel")
local StageBox = Instance.new("TextBox")
local LeftButton = Instance.new("TextButton")
local RightButton = Instance.new("TextButton")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Size = UDim2.new(0, 220, 0, 130)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -65)

MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 6)

TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BackgroundTransparency = 0.1
TitleBar.Size = UDim2.new(1, 0, 0, 28)

TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0, 4)

TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 8, 0, 0)
TitleLabel.Size = UDim2.new(1, -16, 1, 0)
TitleLabel.Font = Enum.Font.Code
TitleLabel.Text = "No Limit Orb Farm | Pxrson"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.Size = UDim2.new(0, 20, 1, 0)
CloseButton.Font = Enum.Font.Code
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextSize = 14
CloseButton.AutoButtonColor = false

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

CloseButton.TouchTap:Connect(function()
    ScreenGui:Destroy()
end)

local function MakeDraggable(Frame, Bar)
    local UserInput = game:GetService("UserInputService")
    local Dragging, StartPos, DragStart, DragConnection
    
    Bar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPos = Vector2.new(Frame.AbsolutePosition.X, Frame.AbsolutePosition.Y)
            
            DragConnection = UserInput.InputChanged:Connect(function(Changed)
                if Dragging and (Changed.UserInputType == Enum.UserInputType.MouseMovement or Changed.UserInputType == Enum.UserInputType.Touch) then
                    local Delta = Changed.Position - DragStart
                    local Viewport = workspace.CurrentCamera.ViewportSize
                    Frame.Position = UDim2.new(0, math.clamp(StartPos.X + Delta.X, 0, Viewport.X - Frame.AbsoluteSize.X), 0, math.clamp(StartPos.Y + Delta.Y, 0, Viewport.Y - Frame.AbsoluteSize.Y))
                end
            end)
            
            local EndConnection
            EndConnection = UserInput.InputEnded:Connect(function(Ended)
                if Ended.UserInputType == Enum.UserInputType.MouseButton1 or Ended.UserInputType == Enum.UserInputType.Touch then
                    Dragging = false
                    if DragConnection then
                        DragConnection:Disconnect()
                        DragConnection = nil
                    end
                    EndConnection:Disconnect()
                end
            end)
        end
    end)
end

MakeDraggable(MainFrame, TitleBar)

StageLabel.Parent = MainFrame
StageLabel.Size = UDim2.new(0, 70, 0, 18)
StageLabel.Position = UDim2.new(0, 10, 0, 40)
StageLabel.BackgroundTransparency = 1
StageLabel.Font = Enum.Font.Code
StageLabel.TextSize = 13
StageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StageLabel.Text = "Stage:"

LeftButton.Parent = MainFrame
LeftButton.Size = UDim2.new(0, 25, 0, 22)
LeftButton.Position = UDim2.new(0, 85, 0, 38)
LeftButton.Text = "<"
LeftButton.Font = Enum.Font.Code
LeftButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LeftButton.TextSize = 13
LeftButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

StageBox.Parent = MainFrame
StageBox.Size = UDim2.new(0, 50, 0, 22)
StageBox.Position = UDim2.new(0, 115, 0, 38)
StageBox.Text = "1"
StageBox.ClearTextOnFocus = false
StageBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
StageBox.TextColor3 = Color3.fromRGB(255, 255, 255)
StageBox.Font = Enum.Font.Code
StageBox.TextSize = 13

RightButton.Parent = MainFrame
RightButton.Size = UDim2.new(0, 25, 0, 22)
RightButton.Position = UDim2.new(0, 175, 0, 38)
RightButton.Text = ">"
RightButton.Font = Enum.Font.Code
RightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RightButton.TextSize = 13
RightButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

ToggleButton.Parent = MainFrame
ToggleButton.Size = UDim2.new(0, 200, 0, 25)
ToggleButton.Position = UDim2.new(0, 10, 0, 85)
ToggleButton.Text = "Start"
ToggleButton.Font = Enum.Font.Code
ToggleButton.TextSize = 13
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

StageBox.FocusLost:Connect(function()
    local Value = tonumber(StageBox.Text)
    if Value and Value >= 1 and Value <= MaxStage then
        Stage = Value
    else
        StageBox.Text = tostring(Stage)
    end
end)

LeftButton.MouseButton1Click:Connect(function()
    if Stage > 1 then
        Stage = Stage - 1
        StageBox.Text = tostring(Stage)
    end
end)

RightButton.MouseButton1Click:Connect(function()
    if Stage < MaxStage then
        Stage = Stage + 1
        StageBox.Text = tostring(Stage)
    end
end)

local function GetHumanoidRootPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    return Character:WaitForChild("HumanoidRootPart")
end

local function Teleport(CFrame)
    local Root = GetHumanoidRootPart()
    if Root then
        Root.CFrame = CFrame
    end
end

local function CollectOrbs()
    local Boosts = workspace:WaitForChild("Map"):WaitForChild("Stages"):WaitForChild("Boosts")
    local StageFolder = Boosts:FindFirstChild(tostring(Stage))
    if not StageFolder then return end
    
    for _, Model in ipairs(StageFolder:GetChildren()) do
        for _, Orb in ipairs(Model:GetDescendants()) do
            if not Running then return end
            if Orb:IsA("BasePart") then
                Teleport(Orb.CFrame)
                task.wait(0.25)
            end
        end
    end
end

ToggleButton.MouseButton1Click:Connect(function()
    Running = not Running
    if Running then
        ToggleButton.Text = "Stop"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        task.spawn(function()
            while Running do
                CollectOrbs()
                task.wait(0.25)
            end
        end)
    else
        ToggleButton.Text = "Start"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end
end)

Services.StarterGui:SetCore("SendNotification", {
    Title = "Tip",
    Text = "teleport to your world, then input your stage",
    Duration = 5
})
