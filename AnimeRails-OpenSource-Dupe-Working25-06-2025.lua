-- [[ Powered by @dyumra. ]]
-- [[ Status: 🟢 ]]

-- [[ 🟢 = Working]]
-- [[ 🔴 = Not Work]]
-- [[ 🟠 = Fixing]]
-- [[ ⚫ = Broke]]

local player = game:GetService("Players").LocalPlayer
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Force GUI permission
pcall(function()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)

-- Safe Notify Function
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

notify("🛡️ DYHUB'S TEAM\nJoin us (.gg/DYHUBGG)")

local guiReady = player:WaitForChild("PlayerGui", 10)
if not guiReady then
	warn("❌ PlayerGui not found!")
	return
end

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "DupeDYHUBGui"
gui.ResetOnSpawn = false
gui.Parent = guiReady

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 420)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Dupe | DYHUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Color animation
task.spawn(function()
	local hue = 0
	while mainFrame do
		hue = (hue + 0.01) % 1
		local color = Color3.fromHSV(hue, 1, 1)
		title.TextColor3 = color
		stroke.Color = color
		wait(0.03)
	end
end)

-- InputBox
local inputBox = Instance.new("TextBox", mainFrame)
inputBox.Size = UDim2.new(0.7, 0, 0, 35)
inputBox.Position = UDim2.new(0.1, 0, 0.14, 0)
inputBox.PlaceholderText = "Enter name"
inputBox.Text = ""
inputBox.TextScaled = true
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Font = Enum.Font.Gotham
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 10)

-- Hint Button
local hintBtn = Instance.new("TextButton", mainFrame)
hintBtn.Size = UDim2.new(0, 30, 0, 30)
hintBtn.Position = UDim2.new(0.81, 0, 0.145, 0)
hintBtn.Text = "?"
hintBtn.TextScaled = true
hintBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hintBtn.TextColor3 = Color3.new(1, 1, 1)
hintBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", hintBtn).CornerRadius = UDim.new(0, 10)

-- List Frame
local listFrame = Instance.new("Frame", mainFrame)
listFrame.Size = UDim2.new(0.8, 0, 0.3, 0)
listFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
listFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
listFrame.Visible = false
Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 8)

local scrolling = Instance.new("ScrollingFrame", listFrame)
scrolling.Size = UDim2.new(1, 0, 1, 0)
scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
scrolling.BackgroundTransparency = 1
scrolling.BorderSizePixel = 0
scrolling.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout", scrolling)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local dupeNames = {
	"Infinity", "Solar", "Crimson", "DarkArcher", "PurpleAssasin", "WolfBoss", "Merchant", "SickCurse", "Tank",
	"CrimsonMaster", "Lightning", "SunBreather", "KnightBoss", "Materials", "Baryon", "HeinEra", "Sukuna",
	"Naruto", "SSGoku", "Tanjiro", "Goku", "Shadows", "Kaiser", "Puzzle", "Knight", "Shake", "Hapticss",
	"MuzanAura", "MoonAura", "YellowAura", "MuzanClass", "KokoshiboClass", "CompassClass", "MuzanMorph",
	"MoonMorph", "HakiPower", "InfinityVoid", "Dismantle", "Restriction", "BlackFlashAura", "ShadowAura",
	"CriticalHit", "Gear4", "BlackFlash", "Toji", "InfinityEyes", "MasteredReflex", "LavaMasterClass",
	"RedeemedWolfBoss", "RedeemedKnight", "LuffyMorph", "DoughMorph", "GravityAura", "DoughAura",
	"LavaAura", "Gear5Class", "MochiClass", "Rinnegan", "Kurama", "Sasuke", "Pain", "EightGates", "Sed",
	"Cid", "Gojo", "Assasin", "AntKing", "BlueFames", "BloodKnight", "BloodMorph", "BloodMorphS",
	"AntMorph", "AntMorphS", "AssasinMorph"
}

hintBtn.MouseEnter:Connect(function()
	listFrame.Visible = true
	notify("📜 Showing dupe list")
end)

hintBtn.MouseLeave:Connect(function()
	listFrame.Visible = false
end)

for _, name in ipairs(dupeNames) do
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -10, 0, 20)
	label.Text = name
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.Gotham
	label.TextScaled = true
	label.Parent = scrolling
end
scrolling.CanvasSize = UDim2.new(0, 0, 0, #dupeNames * 20)

-- Dupe All Button
local dupeAllBtn = Instance.new("TextButton", mainFrame)
dupeAllBtn.Size = UDim2.new(0.8, 0, 0, 35)
dupeAllBtn.Position = UDim2.new(0.1, 0, 0.63, 0)
dupeAllBtn.Text = "Dupe All"
dupeAllBtn.TextScaled = true
dupeAllBtn.Font = Enum.Font.GothamBold
dupeAllBtn.TextColor3 = Color3.new(1, 1, 1)
dupeAllBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
Instance.new("UICorner", dupeAllBtn).CornerRadius = UDim.new(0, 10)

dupeAllBtn.MouseButton1Click:Connect(function()
	for _, name in ipairs(dupeNames) do
		local args = {"SetMorphBuy", name, 0}
		local event = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("ChangeValue")
		if event then
			event:FireServer(unpack(args))
			wait(0.05)
		else
			warn("❌ Event ChangeValue not found")
		end
	end
	notify("✅ Dupe All executed!")
end)

-- HideMorph Button
local hideMorphBtn = Instance.new("TextButton", mainFrame)
hideMorphBtn.Size = UDim2.new(0.8, 0, 0, 30)
hideMorphBtn.Position = UDim2.new(0.1, 0, 0.77, 0)
hideMorphBtn.Text = "HideMorph: Off"
hideMorphBtn.TextScaled = true
hideMorphBtn.Font = Enum.Font.Gotham
hideMorphBtn.TextColor3 = Color3.new(1, 1, 1)
hideMorphBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", hideMorphBtn).CornerRadius = UDim.new(0, 10)

hideMorphBtn.MouseButton1Click:Connect(function()
	local data = player:FindFirstChild("Data")
	if data and data:FindFirstChild("HideMorph") then
		data.HideMorph.Value = not data.HideMorph.Value
		hideMorphBtn.Text = "HideMorph: " .. (data.HideMorph.Value and "On" or "Off")
		notify("🔁 HideMorph: " .. tostring(data.HideMorph.Value))
	else
		notify("❌ HideMorph BoolValue not found")
	end
end)

-- Gamepass Unlock Button
local gamepassBtn = Instance.new("TextButton", mainFrame)
gamepassBtn.Size = UDim2.new(0.8, 0, 0, 30)
gamepassBtn.Position = UDim2.new(0.1, 0, 0.88, 0)
gamepassBtn.Text = "Unlock Gamepass (BETA)"
gamepassBtn.TextScaled = true
gamepassBtn.Font = Enum.Font.Gotham
gamepassBtn.TextColor3 = Color3.new(1, 1, 1)
gamepassBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", gamepassBtn).CornerRadius = UDim.new(0, 10)

gamepassBtn.MouseButton1Click:Connect(function()
	local data = player:FindFirstChild("Data")
	if data then
		local gp1 = data:FindFirstChild("DoubleCash")
		local gp2 = data:FindFirstChild("AlrBoughtSkipSpin")
		if gp1 then gp1.Value = true end
		if gp2 then gp2.Value = true end
		notify("✅ Gamepasses unlocked!")
	else
		notify("❌ Data folder not found")
	end
end)
