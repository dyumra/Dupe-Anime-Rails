-- [[ Powered by @dyumra ]]
-- [[ 🟢 Working: 25-06-2025 ]]

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Name = "DupeDYHUBGui"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 230)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -115)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Dupe | DYHUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local inputBox = Instance.new("TextBox", mainFrame)
inputBox.Size = UDim2.new(0.8, 0, 0, 35)
inputBox.Position = UDim2.new(0.1, 0, 0.25, 0)
inputBox.PlaceholderText = "Enter name (e.g. DoughMorph)"
inputBox.Text = ""
inputBox.TextScaled = true
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Font = Enum.Font.Gotham

Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 10)

local modeBtn = Instance.new("TextButton", mainFrame)
modeBtn.Size = UDim2.new(0.8, 0, 0, 35)
modeBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
modeBtn.TextScaled = true
modeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
modeBtn.TextColor3 = Color3.new(1, 1, 1)
modeBtn.Font = Enum.Font.GothamBold

Instance.new("UICorner", modeBtn).CornerRadius = UDim.new(0, 10)

local buyBtn = Instance.new("TextButton", mainFrame)
buyBtn.Size = UDim2.new(0.8, 0, 0, 35)
buyBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
buyBtn.Text = "Buy"
buyBtn.TextScaled = true
buyBtn.BackgroundColor3 = Color3.fromRGB(60, 90, 60)
buyBtn.TextColor3 = Color3.new(1, 1, 1)
buyBtn.Font = Enum.Font.GothamBold

Instance.new("UICorner", buyBtn).CornerRadius = UDim.new(0, 10)

local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local function rainbow()
	local hue = 0
	while true do
		hue = (hue + 0.01) % 1
		local color = Color3.fromHSV(hue, 1, 1)
		title.TextColor3 = color
		stroke.Color = color
		wait(0.03)
	end
end

local modes = {"Morph", "Aura", "Class"}
local modeToEvent = {
	Morph = "SetMorphBuy",
	Aura = "SetAuraBuy",
	Class = "ClassInfo"
}
local currentIndex = 1
modeBtn.Text = "Dupe: " .. modes[currentIndex]

modeBtn.MouseButton1Click:Connect(function()
	currentIndex += 1
	if currentIndex > #modes then currentIndex = 1 end
	modeBtn.Text = "Dupe: " .. modes[currentIndex]
end)

buyBtn.MouseButton1Click:Connect(function()
	local input = inputBox.Text
	if input == "" then
		warn("Please enter a name.")
		return
	end
	local mode = modes[currentIndex]
	local eventName = modeToEvent[mode]
	local args = {
		[1] = eventName,
		[2] = input,
		[3] = 0
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ChangeValue"):FireServer(unpack(args))
end)

task.spawn(rainbow)
