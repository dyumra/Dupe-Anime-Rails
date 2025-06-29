local player = game:GetService("Players").LocalPlayer
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "DYHUB",
            Text = text,
            Duration = 5
        })
    end)
    print("Notify:", text)
end

notify("🛡️ DYHUB'S TEAM\nJoin our (.gg/DYHUBGG)")

local key1InputGui = Instance.new("ScreenGui")
key1InputGui.Name = "LoadingMenu"
key1InputGui.ResetOnSpawn = false
key1InputGui.Parent = player:WaitForChild("PlayerGui")

local key1Frame = Instance.new("Frame")
key1Frame.Parent = key1InputGui
key1Frame.Size = UDim2.new(0, 320, 0, 180)
key1Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
key1Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
key1Frame.BackgroundTransparency = 0.2
key1Frame.BorderSizePixel = 0
key1Frame.ClipsDescendants = true
key1Frame.Visible = true

Instance.new("UICorner", key1Frame).CornerRadius = UDim.new(0, 15)
Instance.new("UIStroke", key1Frame).Thickness = 2

local key1Title = Instance.new("TextLabel", key1Frame)
key1Title.Size = UDim2.new(1, 0, 0, 50)
key1Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
key1Title.TextColor3 = Color3.fromRGB(255, 255, 255)
key1Title.BackgroundTransparency = 0.5
key1Title.Font = Enum.Font.GothamBold
key1Title.TextSize = 22
key1Title.Text = "🛡 DYHUB'S\n Join our (.gg/DYHUBGG)"
Instance.new("UICorner", key1Title).CornerRadius = UDim.new(0, 15)

local spinner = Instance.new("ImageLabel", key1Frame)
spinner.Size = UDim2.new(0, 60, 0, 60)
spinner.Position = UDim2.new(0.5, 0, 0.5, 10)
spinner.AnchorPoint = Vector2.new(0.5, 0.5)
spinner.BackgroundTransparency = 1
spinner.Image = "rbxassetid://82285050019288"
spinner.ImageColor3 = Color3.fromRGB(255, 255, 255)

spawn(function()
    while spinner and spinner.Parent do
        spinner.Rotation = spinner.Rotation + 3
        RunService.RenderStepped:Wait()
    end
end)

local bypassSteps = {
    "Initializing bypass protocol...",
    "Verifying server connection...",
    "Establishing secure channel...",
    "Bypassing client restrictions...",
    "Bypassing anti-cheat system...",
    "Finalizing bypass process...",
    "Success!"
}
local stepCount = #bypassSteps
local delayPerStep = 10 / (stepCount - 1)

spawn(function()
    for i, step in ipairs(bypassSteps) do
        key1Title.Text = "🛡 DYHUB'S\n"..step
        if step == "Success!" then
            wait(1.5)
        else
            wait(delayPerStep)
        end
    end
    key1InputGui.Enabled = false
    gui.Enabled = true
end)

local gui = Instance.new("ScreenGui")
gui.Name = "DupeDYHUBGui"
gui.ResetOnSpawn = false
gui.Enabled = false
gui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 300)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
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
title.Text = "Dupe | DYHUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

RunService.RenderStepped:Connect(function()
    local color = getRainbowColor(tick())
    borderStroke.Color = color
    title.TextColor3 = color
end)

local inputBox = Instance.new("TextBox", mainFrame)
inputBox.Size = UDim2.new(0.8, 0, 0, 40)
inputBox.Position = UDim2.new(0.1, 0, 0, 60)
inputBox.PlaceholderText = "Enter amount (10,000 ~ 500,000)"
inputBox.Text = ""
inputBox.Font = Enum.Font.Gotham
inputBox.TextScaled = true
inputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 10)

local enterButton = Instance.new("TextButton", mainFrame)
enterButton.Size = UDim2.new(0.5, 0, 0, 40)
enterButton.Position = UDim2.new(0.25, 0, 0, 120)
enterButton.Text = "ENTER"
enterButton.Font = Enum.Font.GothamBold
enterButton.TextScaled = true
enterButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", enterButton).CornerRadius = UDim.new(0, 10)

local enterButton2 = Instance.new("TextButton", mainFrame)
enterButton2.Size = UDim2.new(0.5, 0, 0, 40)
enterButton2.Position = UDim2.new(0.25, 0, 0, 180)
enterButton2.Text = "INF MONEY"
enterButton2.Font = Enum.Font.GothamBold
enterButton2.TextScaled = true
enterButton2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
enterButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", enterButton2).CornerRadius = UDim.new(0, 10)

enterButton.MouseButton1Click:Connect(function()
    local input = tonumber(inputBox.Text)
    if input and input >= 10000 and input <= 500000 then
        local args = {
            [1] = "Wins",
            [2] = input,
            [3] = "ARISE"
        }
        ReplicatedStorage:WaitForChild("redeemedCode"):FireServer(unpack(args))
        notify("✅ Dupe Cash: "..input)
    else
        notify("❌ Invalid amount! Please enter 10,000 ~ 500,000.")
    end
end)

enterButton2.MouseButton1Click:Connect(function()
    local totalAmount = 999000000
    local perFire = 999999
    local times = math.floor(totalAmount / perFire)
    
    notify("⏳ Starting infinite money dupe loop...")
    
    for i = 1, times do
        local args = {
            [1] = "Wins",
            [2] = perFire,
            [3] = "ARISE"
        }
        ReplicatedStorage:WaitForChild("redeemedCode"):FireServer(unpack(args))
        wait(0.1)
    end
    
    notify("✅ Dupe Cash: Completed 999 million!")
end)
