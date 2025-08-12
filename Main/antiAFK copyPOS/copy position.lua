-- dont steal this shit brutha so i added "pxrson_" to every local lol
-- discord: .pxrson
local pxrson_s = {
    p = game:GetService('Players'),
    v = game:GetService('VirtualUser'),
    sg = game:GetService("StarterGui"),
    rs = game:GetService("RunService"),
    ts = game:GetService("TweenService")
}

local pxrson_is_mobile = game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled

local pxrson_size_multiplier = pxrson_is_mobile and 0.8 or 1
local pxrson_main_width = math.floor(260 * pxrson_size_multiplier)
local pxrson_main_height = math.floor(120 * pxrson_size_multiplier)

local pxrson_g = Instance.new("ScreenGui")
local pxrson_m = Instance.new("Frame")
local pxrson_uc = Instance.new("UICorner")
local pxrson_tb = Instance.new("Frame")
local pxrson_tc = Instance.new("UICorner")
local pxrson_fl = Instance.new("TextLabel")
local pxrson_tl = Instance.new("TextLabel")
local pxrson_el = Instance.new("TextLabel")

pxrson_g.Parent = game:GetService("CoreGui")
pxrson_g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pxrson_g.ResetOnSpawn = false

pxrson_m.Parent = pxrson_g
pxrson_m.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
pxrson_m.BackgroundTransparency = 0.1
pxrson_m.Position = UDim2.new(0.6, 0, 0.1, 0)
pxrson_m.Size = UDim2.new(0, pxrson_main_width, 0, pxrson_main_height)

pxrson_tb.Parent = pxrson_m
pxrson_tb.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
pxrson_tb.BackgroundTransparency = 0.1
pxrson_tb.Size = UDim2.new(1, 0, 0, math.floor(22 * pxrson_size_multiplier))

pxrson_tc.Parent = pxrson_tb
pxrson_tc.CornerRadius = UDim.new(0, 4)

pxrson_uc.Parent = pxrson_m
pxrson_uc.CornerRadius = UDim.new(0, 4)

local function pxrson_l(pxrson_p)
    local pxrson_x = Instance.new("TextLabel")
    pxrson_x.Parent = pxrson_m
    pxrson_x.BackgroundTransparency = 1
    pxrson_x.Position = pxrson_p
    pxrson_x.Size = UDim2.new(1, -10, 0, math.floor(18 * pxrson_size_multiplier))
    pxrson_x.Font = Enum.Font.Code
    pxrson_x.TextColor3 = Color3.fromRGB(255, 255, 255)
    pxrson_x.TextSize = math.floor(13 * pxrson_size_multiplier)
    pxrson_x.TextXAlignment = Enum.TextXAlignment.Left
    return pxrson_x
end

pxrson_fl = pxrson_l(UDim2.new(0, 8, 0, math.floor(24 * pxrson_size_multiplier)))
pxrson_tl = pxrson_l(UDim2.new(0, 8, 0, math.floor(42 * pxrson_size_multiplier)))
pxrson_el = pxrson_l(UDim2.new(0, 8, 0, math.floor(60 * pxrson_size_multiplier)))

local pxrson_u = game:GetService("UserInputService")
local pxrson_d = false
local pxrson_ds
local pxrson_sp
local pxrson_conn

local function pxrson_upd(pxrson_current_pos)
    local pxrson_delta = pxrson_current_pos - pxrson_ds
    local pxrson_viewport = workspace.CurrentCamera.ViewportSize
    local pxrson_new_x = math.max(0, math.min(pxrson_viewport.X - pxrson_m.AbsoluteSize.X, pxrson_sp.X + pxrson_delta.X))
    local pxrson_new_y = math.max(0, math.min(pxrson_viewport.Y - pxrson_m.AbsoluteSize.Y, pxrson_sp.Y + pxrson_delta.Y))
    
    pxrson_m.Position = UDim2.new(0, pxrson_new_x, 0, pxrson_new_y)
end

pxrson_tb.InputBegan:Connect(function(pxrson_i)
    if pxrson_i.UserInputType == Enum.UserInputType.MouseButton1 or pxrson_i.UserInputType == Enum.UserInputType.Touch then
        pxrson_d = true
        pxrson_ds = pxrson_i.Position
        pxrson_sp = Vector2.new(pxrson_m.AbsolutePosition.X, pxrson_m.AbsolutePosition.Y)
        
        pxrson_conn = pxrson_u.InputChanged:Connect(function(pxrson_input)
            if pxrson_d and (pxrson_input.UserInputType == Enum.UserInputType.MouseMovement or pxrson_input.UserInputType == Enum.UserInputType.Touch) then
                pxrson_upd(pxrson_input.Position)
            end
        end)
        
        local pxrson_end_conn
        pxrson_end_conn = pxrson_u.InputEnded:Connect(function(pxrson_input)
            if pxrson_input.UserInputType == Enum.UserInputType.MouseButton1 or pxrson_input.UserInputType == Enum.UserInputType.Touch then
                pxrson_d = false
                if pxrson_conn then
                    pxrson_conn:Disconnect()
                    pxrson_conn = nil
                end
                pxrson_end_conn:Disconnect()
            end
        end)
    end
end)

local pxrson_st = nil

local pxrson_t = Instance.new("TextLabel")
pxrson_t.Parent = pxrson_tb
pxrson_t.BackgroundTransparency = 1
pxrson_t.Position = UDim2.new(0, 8, 0, 0)
pxrson_t.Size = UDim2.new(1, -16, 1, 0)
pxrson_t.Font = Enum.Font.Code
pxrson_t.Text = "Coordinates Copy"
pxrson_t.TextColor3 = Color3.fromRGB(255, 255, 255)
pxrson_t.TextSize = math.floor(13 * pxrson_size_multiplier)
pxrson_t.TextXAlignment = Enum.TextXAlignment.Left

local pxrson_cb = Instance.new("TextButton")
pxrson_cb.Parent = pxrson_tb
pxrson_cb.BackgroundTransparency = 1
pxrson_cb.Position = UDim2.new(1, -20, 0, 0)
pxrson_cb.Size = UDim2.new(0, 20, 1, 0)
pxrson_cb.Font = Enum.Font.Code
pxrson_cb.Text = "×"
pxrson_cb.TextColor3 = Color3.fromRGB(255, 255, 255)
pxrson_cb.TextSize = math.floor(14 * pxrson_size_multiplier)
pxrson_cb.AutoButtonColor = false

pxrson_cb.MouseEnter:Connect(function()
    pxrson_cb.TextColor3 = Color3.fromRGB(255, 50, 50)
end)

pxrson_cb.MouseLeave:Connect(function()
    pxrson_cb.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

pxrson_cb.InputBegan:Connect(function(pxrson_i)
    if pxrson_i.UserInputType == Enum.UserInputType.Touch then
        pxrson_cb.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

pxrson_cb.InputEnded:Connect(function(pxrson_i)
    if pxrson_i.UserInputType == Enum.UserInputType.Touch then
        pxrson_cb.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

pxrson_cb.MouseButton1Click:Connect(function()
    pxrson_g:Destroy()
end)

pxrson_cb.TouchTap:Connect(function()
    pxrson_g:Destroy()
end)

local pxrson_bp = Instance.new("TextButton")
pxrson_bp.Parent = pxrson_m
pxrson_bp.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
pxrson_bp.BackgroundTransparency = 0.1
pxrson_bp.Position = UDim2.new(0, 8, 0, math.floor(80 * pxrson_size_multiplier))
pxrson_bp.Size = UDim2.new(0, math.floor(70 * pxrson_size_multiplier), 0, math.floor(20 * pxrson_size_multiplier))
pxrson_bp.Font = Enum.Font.Code
pxrson_bp.Text = "copy"
pxrson_bp.TextColor3 = Color3.fromRGB(255, 255, 255)
pxrson_bp.TextSize = math.floor(12 * pxrson_size_multiplier)
pxrson_bp.AutoButtonColor = false

local pxrson_bpc = Instance.new("UICorner")
pxrson_bpc.Parent = pxrson_bp
pxrson_bpc.CornerRadius = UDim.new(0, 3)

local pxrson_bt = Instance.new("TextButton")
pxrson_bt.Parent = pxrson_m
pxrson_bt.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
pxrson_bt.BackgroundTransparency = 0.1
pxrson_bt.Position = UDim2.new(0, math.floor(82 * pxrson_size_multiplier), 0, math.floor(80 * pxrson_size_multiplier))
pxrson_bt.Size = UDim2.new(0, math.floor(70 * pxrson_size_multiplier), 0, math.floor(20 * pxrson_size_multiplier))
pxrson_bt.Font = Enum.Font.Code
pxrson_bt.Text = "paste"
pxrson_bt.TextColor3 = Color3.fromRGB(255, 255, 255)
pxrson_bt.TextSize = math.floor(12 * pxrson_size_multiplier)
pxrson_bt.AutoButtonColor = false

local pxrson_btc = Instance.new("UICorner")
pxrson_btc.Parent = pxrson_bt
pxrson_btc.CornerRadius = UDim.new(0, 3)

pxrson_bp.MouseEnter:Connect(function()
    pxrson_bp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

pxrson_bp.MouseLeave:Connect(function()
    pxrson_bp.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

pxrson_bt.MouseEnter:Connect(function()
    pxrson_bt.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

pxrson_bt.MouseLeave:Connect(function()
    pxrson_bt.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

pxrson_bp.MouseButton1Click:Connect(function()
    if pxrson_s.p.LocalPlayer.Character and pxrson_s.p.LocalPlayer.Character.HumanoidRootPart then
        local pxrson_coords = pxrson_s.p.LocalPlayer.Character.HumanoidRootPart.Position
        pxrson_st = pxrson_coords
        local pxrson_formatted_coords = string.format("%.1f, %.1f, %.1f", pxrson_coords.X, pxrson_coords.Y, pxrson_coords.Z)
        
        setclipboard(pxrson_formatted_coords)
        
        pxrson_s.sg:SetCore("SendNotification", {
            Title = "Coordinates Copy",
            Text = "coordinates saved: " .. pxrson_formatted_coords,
            Duration = 3
        })
    else
        pxrson_s.sg:SetCore("SendNotification", {
            Title = "Fuckass Error",
            Text = "no character found :(",
            Duration = 3
        })
    end
end)

pxrson_bt.MouseButton1Click:Connect(function()
    if pxrson_st then
        if pxrson_s.p.LocalPlayer.Character and pxrson_s.p.LocalPlayer.Character.HumanoidRootPart then
            pxrson_s.p.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pxrson_st)
            local pxrson_formatted_coords = string.format("%.1f, %.1f, %.1f", pxrson_st.X, pxrson_st.Y, pxrson_st.Z)
            pxrson_s.sg:SetCore("SendNotification", {
                Title = "Coordinates Copy",
                Text = "teleported to: " .. pxrson_formatted_coords,
                Duration = 3
            })
        else
            pxrson_s.sg:SetCore("SendNotification", {
                Title = "Fuckass Error",
                Text = "no character found :(",
                Duration = 3
            })
        end
    else
        pxrson_s.sg:SetCore("SendNotification", {
            Title = "Coordinates Copy",
            Text = "no coordinates saved :(",
            Duration = 3
        })
    end
end)

local function pxrson_upg()
    pxrson_fl.Text = "fps: " .. math.floor(1/pxrson_s.rs.RenderStepped:Wait())
    pxrson_tl.Text = "time: " .. os.date("%H:%M:%S")
    if pxrson_s.p.LocalPlayer.Character and pxrson_s.p.LocalPlayer.Character.HumanoidRootPart then
        local pxrson_coords = pxrson_s.p.LocalPlayer.Character.HumanoidRootPart.Position
        pxrson_el.Text = string.format("coords: %.1f, %.1f, %.1f", pxrson_coords.X, pxrson_coords.Y, pxrson_coords.Z)
    else
        pxrson_el.Text = "coords: no character"
    end
end

pxrson_s.rs.RenderStepped:Connect(pxrson_upg)

pxrson_s.sg:SetCore("SendNotification", {
    Title = "Coordinates Copy",
    Text = "running.. [github.com/Pxrson] <3",
    Duration = 5
})
