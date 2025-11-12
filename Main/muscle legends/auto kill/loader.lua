local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Cursor = nil
local Threshold = 5

if getgenv().ScriptLoaded then
    return
end
getgenv().ScriptLoaded = true

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
                queue_on_teleport([[
                    repeat task.wait() until game:IsLoaded()
                    getgenv().AutoStartEnabled = true
                    getgenv().ScriptLoaded = nil
                    loadstring(game:HttpGet('https://raw.githubusercontent.com/Pxrson/Scripts/refs/heads/main/Main/muscle%20legends/auto%20kill/code.lua'))()
                ]])
                TeleportService:TeleportToPlaceInstance(game.PlaceId, Server.id, LocalPlayer)
                return
            end
        end
        if not Cursor then
            Cursor = nil
            break
        end
        task.wait(1)
    end
end

getgenv().AutoStartEnabled = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pxrson/Scripts/refs/heads/main/Main/muscle%20legends/auto%20kill/code.lua", true))()

spawn(function()
    while true do
        task.wait(5)
        local Count = #Players:GetPlayers()
        if Count <= Threshold then
            Hop()
            break
        end
    end
end)
