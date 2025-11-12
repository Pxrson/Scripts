local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Cursor = nil
local Threshold = 5

local function GetServers()
    local Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (Cursor and ("&cursor=" .. Cursor) or "")
    local Response = game:HttpGet(Url)
    local Data = HttpService:JSONDecode(Response)
    Cursor = Data.nextPageCursor
    return Data.data
end

local function Hop()
    while true do
        local List = GetServers()
        for _, Server in ipairs(List) do
            if Server.playing >= Threshold and Server.playing < Server.maxPlayers and Server.id ~= game.JobId then
                queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Pxrson/Scripts/refs/heads/main/Main/muscle%20legends/auto%20kill/code.lua'))()")
                TeleportService:TeleportToPlaceInstance(game.PlaceId, Server.id, LocalPlayer)
                return
            end
        end
        if not Cursor then
            Cursor = nil
        end
        task.wait(1)
    end
end

while true do
    local Count = #Players:GetPlayers()
    if Count >= Threshold then
        Hop()
        break
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Pxrson/Scripts/refs/heads/main/Main/muscle%20legends/auto%20kill/code.lua", true))()
        task.wait(10)
    end
end
