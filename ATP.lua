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

notify("DYHUB Loaded! for Anime Tower Piece")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DYHUB | Auto Farm | Anime Tower Piece"
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
title.Text = "Anime Tower Piece | DYHUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

RunService.RenderStepped:Connect(function()
    local color = getRainbowColor(tick())
    borderStroke.Color = color
    title.TextColor3 = color
end)

local teleportButton = Instance.new("TextButton", mainFrame)
teleportButton.Size = UDim2.new(0.5, 0, 0, 40)
teleportButton.Position = UDim2.new(0.25, 0, 0, 60)
teleportButton.Text = "Auto Farm: Off"
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextScaled = true
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", teleportButton).CornerRadius = UDim.new(0, 10)

local function getBlackRedColor(t)
    local freq = 2
    local red = math.floor((math.sin(freq * t) * 0.5 + 0.5) * 255)
    local green = 0
    local blue = 0
    return Color3.fromRGB(red, green, blue)
end

RunService.RenderStepped:Connect(function()
    teleportButton.BackgroundColor3 = getBlackRedColor(tick())
end)

local textla = Instance.new("TextLabel", mainFrame)
textla.Size = UDim2.new(1, -20, 0, 40)
textla.Position = UDim2.new(0, 10, 0, 110)
textla.Text = "⚠️ Cooldown Auto-Farm 3 sec."
textla.Font = Enum.Font.GothamBold
textla.TextScaled = true
textla.TextColor3 = Color3.fromRGB(255, 255, 255)
textla.BackgroundTransparency = 1
textla.TextWrapped = true

local targetCFrame = CFrame.new(
    -353.43457, 409.376617, 24.4039631,
    -1.1920929e-07, 0, -1.00000012,
    0, 1, 0,
    1.00000012, 0, -1.1920929e-07
)

local looping = false

teleportButton.MouseButton1Click:Connect(function()
    looping = not looping
    teleportButton.Text = looping and "Auto Farm: On" or "Auto Farm: Off"
    notify("Auto Farm: " .. (looping and "Enabled" or "Disabled"))

    if looping then
        task.spawn(function()
            while looping do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = targetCFrame
                end
                task.wait(3.5)
            end
        end)
    end
end)
