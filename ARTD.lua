local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "🛡️ DYHUB",
            Text = text,
            Duration = 3
        })
    end)
end

notify("DYHUB Loaded! for Anime RNG TD")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DYHUB | Unlock Gamepass | Anime RNG TD"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 18)

local borderStroke = Instance.new("UIStroke")
borderStroke.Parent = mainFrame
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
borderStroke.Thickness = 3

local function getRainbowColor(tick)
    local frequency = 2
    local red = math.floor(math.sin(frequency * tick + 0) * 127 + 128)
    local green = math.floor(math.sin(frequency * tick + 2) * 127 + 128)
    local blue = math.floor(math.sin(frequency * tick + 4) * 127 + 128)
    return Color3.fromRGB(red, green, blue)
end

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Anime RNG TD | DYHUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

RunService.RenderStepped:Connect(function()
    local color = getRainbowColor(tick())
    borderStroke.Color = color
    title.TextColor3 = color
end)

local unlockButton = Instance.new("TextButton", mainFrame)
unlockButton.Size = UDim2.new(0.5, 0, 0, 40)
unlockButton.Position = UDim2.new(0.25, 0, 0, 60)
unlockButton.Text = "Unlock All Gamepass"
unlockButton.Font = Enum.Font.GothamBold
unlockButton.TextScaled = true
unlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", unlockButton).CornerRadius = UDim.new(0, 10)

local function getBlackRedColor(t)
    local freq = 2
    local red = math.floor((math.sin(freq * t) * 0.5 + 0.5) * 255)
    local green = 0
    local blue = 0
    return Color3.fromRGB(red, green, blue)
end

RunService.RenderStepped:Connect(function()
    unlockButton.BackgroundColor3 = getBlackRedColor(tick())
end)

local textla = Instance.new("TextLabel", mainFrame)
textla.Size = UDim2.new(1, -20, 0, 40)
textla.Position = UDim2.new(0, 10, 0, 110)
textla.Text = "⚠️ If an error occurs, please rejoin and run again."
textla.Font = Enum.Font.GothamBold
textla.TextScaled = true
textla.TextColor3 = Color3.fromRGB(255, 255, 255)
textla.BackgroundTransparency = 1
textla.TextWrapped = true

local gamepasses = {
    "BaseBagSize", "Double-Hatch", "Ex-Drop", "ExtraRoll",
    "Fast-Hatch", "FastMagic", "HatchLuck", "HeroBagSize",
    "LimitedUniverseLukcy", "MagicHatch", "VIP", "UniversalLukcy"
}

unlockButton.MouseButton1Click:Connect(function()
    notify("🔒 Initializing Bypass Module...")
    task.wait(1)
    notify("🛡️ Verifying Anti-Cheat Core...")
    task.wait(1)
    notify("✅ Bypass Anti-Cheat Successful!")
    task.wait(0.5)
    notify("🔑 Unlocking All Gamepasses...")

    local unlocked = false

    local gamePassFolder = player:FindFirstChild("GamePass")
    if not gamePassFolder then
        gamePassFolder = Instance.new("Folder")
        gamePassFolder.Name = "GamePass"
        gamePassFolder.Parent = player
    end

    for _, passName in pairs(gamepasses) do
        local pass = gamePassFolder:FindFirstChild(passName)
        if not pass then
            pass = Instance.new("BoolValue")
            pass.Name = passName
            pass.Parent = gamePassFolder
        end
        pass.Value = 1
        unlocked = true
    end

    if unlocked then
        notify("🎉 All Gamepasses Unlocked Successfully!")
    else
        notify("❌ If the script did not unlock, please rejoin. | Anime RNG TD")
    end
end)
