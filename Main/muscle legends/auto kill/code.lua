-- discord: .pxrson
-- beware of ping getting to high, might ruin your grind !!
local lp = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local players = game:GetService("Players")

local animIds = {
    ["rbxassetid://3638729053"] = true,
    ["rbxassetid://3638749874"] = true,
    ["rbxassetid://3638767427"] = true,
    ["rbxassetid://102357151005774"] = true
}

local chr, hum, hnd, pnc, anm
local lastAtk, lastResp, lastChk, lastPlr = 0, 0, 0, 0
local cachedPlrs = {}

local function updateAll()
    chr = lp.Character
    if chr then
        hum = chr:FindFirstChildOfClass("Humanoid")
        hnd = chr:FindFirstChild("LeftHand") or chr:FindFirstChild("Left Arm")
        anm = hum and (chr:FindFirstChildOfClass("Animator") or hum:FindFirstChildOfClass("Animator"))
        pnc = chr:FindFirstChild("Punch")
    else
        chr, hum, hnd, anm, pnc = nil, nil, nil, nil, nil
    end
    
    cachedPlrs = {}
    for _, plr in ipairs(players:GetPlayers()) do
        if plr ~= lp then
            table.insert(cachedPlrs, plr)
        end
    end
end

lp.CharacterAdded:Connect(updateAll)
updateAll()
players.PlayerAdded:Connect(updateAll)
players.PlayerRemoving:Connect(updateAll)

rs.RenderStepped:Connect(function()
    local tm = os.clock()
    
    if tm - lastAtk < 0.05 then return end
    lastAtk = tm
    
    if not chr or not hum or tm - lastChk > 1 then
        updateAll()
        lastChk = tm
        if not chr or not hum then return end
    end
    
    if not hnd then
        hnd = chr:FindFirstChild("LeftHand") or chr:FindFirstChild("Left Arm")
        if not hnd then return end
    end
    
    if not pnc or not pnc.Parent then
        pnc = chr:FindFirstChild("Punch")
        if not pnc then
            local tool = lp.Backpack:FindFirstChild("Punch")
            if tool then
                hum:EquipTool(tool)
                pnc = chr:FindFirstChild("Punch")
            else
                if tm - lastResp > 3 and hum and hum.Health > 0 then
                    hum.Health = 0
                    lastResp = tm
                end
                return
            end
        end
    end
    
    if pnc and pnc.Parent then
        pnc.attackTime.Value = 0
        pnc:Activate()
        
        for _, plr in ipairs(cachedPlrs) do
            local chr2 = plr.Character
            if chr2 and chr2.Parent then
                local hum2 = chr2:FindFirstChildOfClass("Humanoid")
                local head = chr2:FindFirstChild("Head")
                if hum2 and head and hum2.Health > 0 then
                    firetouchinterest(head, hnd, 0)
                    firetouchinterest(head, hnd, 1)
                end
            end
        end
        
        if anm then
            for _, trk in ipairs(anm:GetPlayingAnimationTracks()) do
                local anim = trk.Animation
                if anim and animIds[anim.AnimationId] then
                    trk:Stop()
                end
            end
        end
    end
end)
