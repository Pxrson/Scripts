local Services = {
    Players = game:GetService('Players'),
    VirtualUser = game:GetService('VirtualUser'),
    StarterGui = game:GetService("StarterGui"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService")
}

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local TitleBar = Instance.new("Frame")
local TitleCorner = Instance.new("UICorner")
local FpsLabel = Instance.new("TextLabel")
local TimeLabel = Instance.new("TextLabel")
local ExecLabel = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Position = UDim2.new(0.8, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 95)

TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BackgroundTransparency = 0.1
TitleBar.Size = UDim2.new(1, 0, 0, 22)

TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0, 4)

MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 4)

local function CreateLabel(Position)
    local Label = Instance.new("TextLabel")
    Label.Parent = MainFrame
    Label.BackgroundTransparency = 1
    Label.Position = Position
    Label.Size = UDim2.new(1, -10, 0, 18)
    Label.Font = Enum.Font.Code
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    return Label
end

FpsLabel = CreateLabel(UDim2.new(0, 8, 0, 24))
TimeLabel = CreateLabel(UDim2.new(0, 8, 0, 42))
ExecLabel = CreateLabel(UDim2.new(0, 8, 0, 60))

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

local StartTime = os.time()

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 8, 0, 0)
TitleText.Size = UDim2.new(1, -16, 1, 0)
TitleText.Font = Enum.Font.Code
TitleText.Text = "Anti AFK"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 13
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.Size = UDim2.new(0, 20, 1, 0)
CloseButton.Font = Enum.Font.Code
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
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

local function UpdateDisplay()
    FpsLabel.Text = "fps: " .. math.floor(1/Services.RunService.RenderStepped:Wait())
    TimeLabel.Text = "time: " .. os.date("%H:%M:%S")
    local ElapsedTime = os.time() - StartTime
    ExecLabel.Text = string.format("exec: %02d:%02d:%02d", ElapsedTime/3600%24, ElapsedTime/60%60, ElapsedTime%60)
end

Services.RunService.RenderStepped:Connect(UpdateDisplay)

Services.StarterGui:SetCore("SendNotification", {
    Title = "Anti AFK",
    Text = "running.. [github.com/Pxrson] <3",
    Icon = "rbxassetid://96250665598150",
    Duration = 5
})

Services.Players.LocalPlayer.Idled:Connect(function()
    Services.VirtualUser:CaptureController()
    Services.VirtualUser:ClickButton2(Vector2.new())
end)
