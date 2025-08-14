-- discord: .pxrson
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local function hop()
    local data = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
    local servers = {}
    for _, v in ipairs(data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            servers[#servers+1] = v.id
        end
    end
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(#servers)], Players.LocalPlayer)
    else
        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
    end
end

while true do
    if #Players:GetPlayers() < 5 then
        hop()
        break
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Pxrson/Scripts/refs/heads/main/Main/muscle%20legends/auto%20kill/code.lua", true))()
    end
    task.wait(10)
end
