local Services = {
    Players = game:GetService('Players'),
    VirtualUser = game:GetService('VirtualUser'),
    StarterGui = game:GetService("StarterGui"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService")
}

local IsMobile = game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled

local SizeMultiplier = IsMobile and 0.8 or 1
local MainWidth = math.floor(260 * SizeMultiplier)
local MainHeight = math.floor(120 * SizeMultiplier)

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local TitleBar = Instance.new("Frame")
local TitleCorner = Instance.new("UICorner")
local FpsLabel = Instance.new("TextLabel")
local TimeLabel = Instance.new("TextLabel")
local CoordsLabel = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Position = UDim2.new(0.6, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, MainWidth, 0, MainHeight)

TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BackgroundTransparency = 0.1
TitleBar.Size = UDim2.new(1, 0, 0, math.floor(22 * SizeMultiplier))

TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0, 4)

MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 4)

local function CreateLabel(Position)
    local Label = Instance.new("TextLabel")
    Label.Parent = MainFrame
    Label.BackgroundTransparency = 1
    Label.Position = Position
    Label.Size = UDim2.new(1, -10, 0, math.floor(18 * SizeMultiplier))
    Label.Font = Enum.Font.Code
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = math.floor(13 * SizeMultiplier)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    return Label
end

FpsLabel = CreateLabel(UDim2.new(0, 8, 0, math.floor(24 * SizeMultiplier)))
TimeLabel = CreateLabel(UDim2.new(0, 8, 0, math.floor(42 * SizeMultiplier)))
CoordsLabel = CreateLabel(UDim2.new(0, 8, 0, math.floor(60 * SizeMultiplier)))

local UserInput = game:GetService("UserInputService")
local IsDragging = false
local DragStart
local StartPos
local DragConnection

local function UpdateDrag(CurrentPos)
    local Delta = CurrentPos - DragStart
    local Viewport = workspace.CurrentCamera.ViewportSize
    local NewX = math.max(0, math.min(Viewport.X - MainFrame.AbsoluteSize.X, StartPos.X + Delta.X))
    local NewY = math.max(0, math.min(Viewport.Y - MainFrame.AbsoluteSize.Y, StartPos.Y + Delta.Y))
    
    MainFrame.Position = UDim2.new(0, NewX, 0, NewY)
end

TitleBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        IsDragging = true
        DragStart = Input.Position
        StartPos = Vector2.new(MainFrame.AbsolutePosition.X, MainFrame.AbsolutePosition.Y)
        
        DragConnection = UserInput.InputChanged:Connect(function(InputChanged)
            if IsDragging and (InputChanged.UserInputType == Enum.UserInputType.MouseMovement or InputChanged.UserInputType == Enum.UserInputType.Touch) then
                UpdateDrag(InputChanged.Position)
            end
        end)
        
        local EndConnection
        EndConnection = UserInput.InputEnded:Connect(function(InputEnded)
            if InputEnded.UserInputType == Enum.UserInputType.MouseButton1 or InputEnded.UserInputType == Enum.UserInputType.Touch then
                IsDragging = false
                if DragConnection then
                    DragConnection:Disconnect()
                    DragConnection = nil
                end
                EndConnection:Disconnect()
            end
        end)
    end
end)

local SavedCoords = nil

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 8, 0, 0)
TitleText.Size = UDim2.new(1, -16, 1, 0)
TitleText.Font = Enum.Font.Code
TitleText.Text = "Coordinates Copy"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = math.floor(13 * SizeMultiplier)
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.Size = UDim2.new(0, 20, 1, 0)
CloseButton.Font = Enum.Font.Code
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = math.floor(14 * SizeMultiplier)
CloseButton.AutoButtonColor = false

CloseButton.MouseEnter:Connect(function()
    CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

CloseButton.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch then
        CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

CloseButton.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch then
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

CloseButton.TouchTap:Connect(function()
    ScreenGui:Destroy()
end)

local CopyButton = Instance.new("TextButton")
CopyButton.Parent = MainFrame
CopyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CopyButton.BackgroundTransparency = 0.1
CopyButton.Position = UDim2.new(0, 8, 0, math.floor(80 * SizeMultiplier))
CopyButton.Size = UDim2.new(0, math.floor(70 * SizeMultiplier), 0, math.floor(20 * SizeMultiplier))
CopyButton.Font = Enum.Font.Code
CopyButton.Text = "copy"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextSize = math.floor(12 * SizeMultiplier)
CopyButton.AutoButtonColor = false

local CopyButtonCorner = Instance.new("UICorner")
CopyButtonCorner.Parent = CopyButton
CopyButtonCorner.CornerRadius = UDim.new(0, 3)

local PasteButton = Instance.new("TextButton")
PasteButton.Parent = MainFrame
PasteButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PasteButton.BackgroundTransparency = 0.1
PasteButton.Position = UDim2.new(0, math.floor(82 * SizeMultiplier), 0, math.floor(80 * SizeMultiplier))
PasteButton.Size = UDim2.new(0, math.floor(70 * SizeMultiplier), 0, math.floor(20 * SizeMultiplier))
PasteButton.Font = Enum.Font.Code
PasteButton.Text = "paste"
PasteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PasteButton.TextSize = math.floor(12 * SizeMultiplier)
PasteButton.AutoButtonColor = false

local PasteButtonCorner = Instance.new("UICorner")
PasteButtonCorner.Parent = PasteButton
PasteButtonCorner.CornerRadius = UDim.new(0, 3)

CopyButton.MouseEnter:Connect(function()
    CopyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

CopyButton.MouseLeave:Connect(function()
    CopyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

PasteButton.MouseEnter:Connect(function()
    PasteButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

PasteButton.MouseLeave:Connect(function()
    PasteButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

CopyButton.MouseButton1Click:Connect(function()
    if Services.Players.LocalPlayer.Character and Services.Players.LocalPlayer.Character.HumanoidRootPart then
        local Coords = Services.Players.LocalPlayer.Character.HumanoidRootPart.Position
        SavedCoords = Coords
        local FormattedCoords = string.format("%.1f, %.1f, %.1f", Coords.X, Coords.Y, Coords.Z)
        
        setclipboard(FormattedCoords)
        
        Services.StarterGui:SetCore("SendNotification", {
            Title = "Coordinates Copy",
            Text = "coordinates saved: " .. FormattedCoords,
            Duration = 3
        })
    else
        Services.StarterGui:SetCore("SendNotification", {
            Title = "Fuckass Error",
            Text = "no character found :(",
            Duration = 3
        })
    end
end)

PasteButton.MouseButton1Click:Connect(function()
    if SavedCoords then
        if Services.Players.LocalPlayer.Character and Services.Players.LocalPlayer.Character.HumanoidRootPart then
            Services.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(SavedCoords)
            local FormattedCoords = string.format("%.1f, %.1f, %.1f", SavedCoords.X, SavedCoords.Y, SavedCoords.Z)
            Services.StarterGui:SetCore("SendNotification", {
                Title = "Coordinates Copy",
                Text = "teleported to: " .. FormattedCoords,
                Duration = 3
            })
        else
            Services.StarterGui:SetCore("SendNotification", {
                Title = "Fuckass Error",
                Text = "no character found :(",
                Duration = 3
            })
        end
    else
        Services.StarterGui:SetCore("SendNotification", {
            Title = "Coordinates Copy",
            Text = "no coordinates saved :(",
            Duration = 3
        })
    end
end)

local function UpdateDisplay()
    FpsLabel.Text = "fps: " .. math.floor(1/Services.RunService.RenderStepped:Wait())
    TimeLabel.Text = "time: " .. os.date("%H:%M:%S")
    if Services.Players.LocalPlayer.Character and Services.Players.LocalPlayer.Character.HumanoidRootPart then
        local Coords = Services.Players.LocalPlayer.Character.HumanoidRootPart.Position
        CoordsLabel.Text = string.format("coords: %.1f, %.1f, %.1f", Coords.X, Coords.Y, Coords.Z)
    else
        CoordsLabel.Text = "coords: no character"
    end
end

Services.RunService.RenderStepped:Connect(UpdateDisplay)

Services.StarterGui:SetCore("SendNotification", {
    Title = "Coordinates Copy",
    Text = "running.. [github.com/Pxrson] <3",
    Duration = 5
})
