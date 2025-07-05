local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

local g = game.workspace:FindFirstChild("glorytoJESUSmap")
if g and g:FindFirstChild("Group") then
    g.Group:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DYHUB | Auto Farm | Anime Tower Piece"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 400)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
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
teleportButton.Position = UDim2.new(0.25, 0, 0, 50)
teleportButton.Text = "Auto Win: Off"
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextScaled = true
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", teleportButton).CornerRadius = UDim.new(0, 10)

local function getBlackRedColor(t)
    local freq = 2
    local red = math.floor((math.sin(freq * t) * 0.5 + 0.5) * 255)
    return Color3.fromRGB(red, 0, 0)
end

RunService.RenderStepped:Connect(function()
    teleportButton.BackgroundColor3 = getBlackRedColor(tick())
end)

local textla = Instance.new("TextLabel", mainFrame)
textla.Size = UDim2.new(1, -20, 0, 30)
textla.Position = UDim2.new(0, 10, 0, 95)
textla.Text = "⚠️ Auto-Win will teleport every 10 sec."
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
    teleportButton.Text = looping and "Auto Win: On" or "Auto Win: Off"
    notify("Auto Win: " .. (looping and "Enabled" or "Disabled"))

    if looping then
        task.spawn(function()
            while looping do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = targetCFrame
                end
                task.wait(10)
            end
        end)
    end
end)

local wearLabel = Instance.new("TextLabel", mainFrame)
wearLabel.Size = UDim2.new(1, -20, 0, 25)
wearLabel.Position = UDim2.new(0, 10, 0, 135)
wearLabel.Text = "🎭 Choose character to wear:"
wearLabel.Font = Enum.Font.GothamBold
wearLabel.TextScaled = true
wearLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
wearLabel.BackgroundTransparency = 1
wearLabel.TextWrapped = true

local selectedChar = nil

local charList = {
    "Shanks", "Shiryu", "Roger", "LuffyGear5", "Kaido", "BigMom",
    "Zoro", "Usopp", "Nami", "Sanji", "Kidd", "Law",
    "Luffy", "Blackbeard", "Chopper", "Yamato", "Fujitora", "Kuma", "Bartolomeo"
}

local scrollFrame = Instance.new("ScrollingFrame", mainFrame)
scrollFrame.Size = UDim2.new(0.8, 0, 0, 140)
scrollFrame.Position = UDim2.new(0.1, 0, 0, 165)
scrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
scrollFrame.ScrollBarThickness = 6
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #charList * 30)
Instance.new("UICorner", scrollFrame).CornerRadius = UDim.new(0, 8)

local uiList = Instance.new("UIListLayout", scrollFrame)
uiList.Padding = UDim.new(0, 4)

for _, name in ipairs(charList) do
    local btn = Instance.new("TextButton", scrollFrame)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        selectedChar = name
        notify("Selected: "..name)
    end)
end

local enterButton = Instance.new("TextButton", mainFrame)
enterButton.Size = UDim2.new(0.4, 0, 0, 35)
enterButton.Position = UDim2.new(0.3, 0, 0, 320)
enterButton.Text = "Equip"
enterButton.Font = Enum.Font.GothamBold
enterButton.TextScaled = true
enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
enterButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
Instance.new("UICorner", enterButton).CornerRadius = UDim.new(0, 8)

enterButton.MouseButton1Click:Connect(function()
    if selectedChar then
        local args = { [1] = selectedChar }
        ReplicatedStorage:WaitForChild("WearEvent"):FireServer(unpack(args))
        notify("🎉 Equipped character: " .. selectedChar)
    else
        notify("⚠️ Please select a character first!")
    end
end)
