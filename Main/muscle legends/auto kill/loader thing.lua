-- discord: .pxrson
local plrs = game:GetService("Players")
local tpsvc = game:GetService("TeleportService")
local http = game:GetService("HttpService")

local function hop()
    local success, result = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
    end)
    
    if not success then
        tpsvc:Teleport(game.PlaceId, plrs.LocalPlayer)
        return
    end
    
    local data = http:JSONDecode(result)
    local servers = {}
    
    for _, v in ipairs(data.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(servers, v.id)
        end
    end
    
    if #servers > 0 then
        tpsvc:TeleportToPlaceInstance(game.PlaceId, servers[math.random(#servers)], plrs.LocalPlayer)
    else
        tpsvc:Teleport(game.PlaceId, plrs.LocalPlayer)
    end
end

while true do
    if #plrs:GetPlayers() < 5 then
        hop()
        break
    else
        local success = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Pxrson/Scripts/refs/heads/main/Main/muscle%20legends/auto%20kill/code.lua", true))()
        end)
    end
    task.wait(10)
end
