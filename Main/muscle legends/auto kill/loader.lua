local plrs = game:GetService("Players")
local tpsvc = game:GetService("TeleportService")
local http = game:GetService("HttpService")

queue_on_teleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Pxrson/Scripts/refs/heads/main/Main/muscle%20legends/auto%20kill/code.lua", true))()
]])

local function hop()
    local res = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
    local data = http:JSONDecode(res)

    for _, v in ipairs(data.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            return tpsvc:TeleportToPlaceInstance(game.PlaceId, v.id, plrs.LocalPlayer)
        end
    end

    tpsvc:Teleport(game.PlaceId, plrs.LocalPlayer)
end

while true do
    if #plrs:GetPlayers() < 5 then
        hop()
        break
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Pxrson/Scripts/refs/heads/main/Main/muscle%20legends/auto%20kill/code.lua", true))()
    end
    task.wait(10)
end
