local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local MAX_VALUE = 222222

-- Data stores for resources and inventory
local dataStore = {
    Hi = 1,
    Air = 1,
    Nothing = 1,
    Point = 1,
    StarDust = 0, -- New resource
    Gemstone = 0, -- New resource
}

local inventory = {
    Hi = 0,
    Air = 0,
    Nothing = 0,
    Point = 0,
    Premium = 0,
    ["X2 Item Drop"] = 0,
    ["Faster Roll"] = 0,
    ["Lucky X2"] = 0,
    ["Extra Lucky (x4)"] = 0,
    ["Flash Roll (0.01s)"] = 0,
    StarDust = 0,
    Gemstone = 0,
}

-- Utility functions
local function clamp(val)
    if val > MAX_VALUE then return MAX_VALUE end
    if val < 0 then return 0 end
    return val
}

local function setData(key, val)
    dataStore[key] = clamp(val)
    updateResources() -- Update resources whenever data changes
    if currentTab == "Shop" then
        showShop(contentFrame) -- Re-render shop to update button colors
    elseif currentTab == "Craft" then
        showCraft(contentFrame) -- Re-render craft to update button colors
    end
end

local function getData(key)
    return dataStore[key] or 0
end

local function setInventory(key, val)
    inventory[key] = clamp(val)
    updateInventory() -- Update inventory whenever it changes
end

local function getInventory(key)
    return inventory[key] or 0
end

-- --- GUI Setup ---
-- Destroy existing GUI if it exists
if playerGui:FindFirstChild("DYHUB_RNG_GUI") then
    playerGui.DYHUB_RNG_GUI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DYHUB_RNG_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 550) -- Increased size for better layout
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -275) -- Centered
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Add UI Corner for rounded edges
local uiCornerMain = Instance.new("UICorner")
uiCornerMain.CornerRadius = UDim.new(0, 12)
uiCornerMain.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50) -- Taller title bar
title.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
title.Text = "DYHUB RNG System ✨" -- Added emoji
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.BorderSizePixel = 0
title.Parent = mainFrame

local uiCornerTitle = Instance.new("UICorner")
uiCornerTitle.CornerRadius = UDim.new(0, 12)
uiCornerTitle.Parent = title

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 0, 45) -- Slightly taller tabs
tabContainer.Position = UDim2.new(0, 10, 0, 60)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -20, 1, -170) -- Adjusted size, leaving space for resource frame
contentFrame.Position = UDim2.new(0, 10, 0, 115) -- Lowered position to accommodate resource frame
contentFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 8
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.Parent = mainFrame

local uiCornerContent = Instance.new("UICorner")
uiCornerContent.CornerRadius = UDim.new(0, 8)
uiCornerContent.Parent = contentFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 8) -- Increased padding
uiListLayout.Parent = contentFrame
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.FillDirection = Enum.FillDirection.Vertical
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local resourceFrame = Instance.new("Frame")
resourceFrame.Size = UDim2.new(1, -20, 0, 80) -- Larger height to show more resources
resourceFrame.Position = UDim2.new(0, 10, 0, 460) -- Moved to bottom of mainFrame
resourceFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
resourceFrame.BorderSizePixel = 0
resourceFrame.Parent = mainFrame

local uiCornerResource = Instance.new("UICorner")
uiCornerResource.CornerRadius = UDim.new(0, 8)
uiCornerResource.Parent = resourceFrame

local resourceListLayout = Instance.new("UIListLayout")
resourceListLayout.Padding = UDim.new(0, 4)
resourceListLayout.Parent = resourceFrame
resourceListLayout.FillDirection = Enum.FillDirection.Horizontal
resourceListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
resourceListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local function updateResources()
    resourceFrame:ClearAllChildren()
    for name, count in pairs(dataStore) do
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.2, 0, 1, 0) -- Distribute horizontally
        label.Text = tostring(name .. ": " .. count)
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 15
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.Parent = resourceFrame
    end
end

updateResources()

local invBtn = Instance.new("TextButton")
invBtn.Size = UDim2.new(0, 120, 0, 45)
invBtn.Position = UDim2.new(1, -130, 1, -55) -- Positioned relative to mainFrame bottom right
invBtn.Text = "Inventory 🎒" -- Added emoji
invBtn.Font = Enum.Font.GothamBold
invBtn.TextSize = 18
invBtn.BackgroundColor3 = Color3.fromRGB(60, 150, 255) -- Softer blue
invBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
invBtn.Parent = mainFrame

local uiCornerInvBtn = Instance.new("UICorner")
uiCornerInvBtn.CornerRadius = UDim.new(0, 8)
uiCornerInvBtn.Parent = invBtn

-- Inventory GUI
local invGui = Instance.new("Frame")
invGui.Size = UDim2.new(0, 350, 0, 400) -- Larger inventory GUI
invGui.Position = UDim2.new(0.5, -175, 0.5, -200) -- Centered
invGui.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
invGui.BorderSizePixel = 0
invGui.Visible = false
invGui.Name = "InventoryFrame"
invGui.Active = true
invGui.Draggable = true
invGui.Parent = screenGui

local uiCornerInvGui = Instance.new("UICorner")
uiCornerInvGui.CornerRadius = UDim.new(0, 12)
uiCornerInvGui.Parent = invGui

local invTitle = Instance.new("TextLabel")
invTitle.Size = UDim2.new(1, 0, 0, 50)
invTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
invTitle.Text = "Your Inventory 📦" -- Added emoji
invTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
invTitle.Font = Enum.Font.GothamBold
invTitle.TextSize = 22
invTitle.BorderSizePixel = 0
invTitle.Parent = invGui

local uiCornerInvTitle = Instance.new("UICorner")
uiCornerInvTitle.CornerRadius = UDim.new(0, 12)
uiCornerInvTitle.Parent = invTitle

local invContent = Instance.new("ScrollingFrame")
invContent.Size = UDim2.new(1, -20, 1, -70) -- Adjusted for title
invContent.Position = UDim2.new(0, 10, 0, 60)
invContent.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
invContent.BorderSizePixel = 0
invContent.ScrollBarThickness = 8
invContent.CanvasSize = UDim2.new(0, 0, 0, 0)
invContent.Parent = invGui

local uiCornerInvContent = Instance.new("UICorner")
uiCornerInvContent.CornerRadius = UDim.new(0, 8)
uiCornerInvContent.Parent = invContent

local invListLayout = Instance.new("UIListLayout")
invListLayout.Padding = UDim.new(0, 6)
invListLayout.Parent = invContent
invListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
invListLayout.FillDirection = Enum.FillDirection.Vertical
invListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Define items that should show "Unlocked" if present, instead of quantity
local UNLOCKABLE_ITEMS = {
    ["X2 Item Drop"] = true,
    ["Faster Roll"] = true,
    ["Lucky X2"] = true,
    ["Extra Lucky (x4)"] = true,
    ["Flash Roll (0.01s)"] = true,
    -- Add any other crafted/unlocked items here
}

local function updateInventory()
    invContent:ClearAllChildren()
    local yOffset = 0
    local itemHeight = 35 -- Height of each item label
    for name, count in pairs(inventory) do
        -- Only show items that the player actually has OR are unlockable and present
        if count > 0 then
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -20, 0, itemHeight)
            
            if UNLOCKABLE_ITEMS[name] and count >= 1 then
                label.Text = tostring(name .. " (Unlocked) ✅") -- Added emoji
                if count > 1 then -- If player has more than one, still show quantity
                    label.Text = tostring(name .. " (Unlocked x" .. count .. ") ✅") -- Added emoji
                end
            else
                label.Text = tostring(name .. " (x" .. count .. ")")
            end

            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.GothamBold
            label.TextSize = 18
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = invContent
            yOffset = yOffset + itemHeight + invListLayout.Padding.Offset
        end
    end
    -- Adjust CanvasSize to fit all items
    invContent.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

invBtn.MouseButton1Click:Connect(function()
    invGui.Visible = not invGui.Visible
    if invGui.Visible then
        updateInventory()
    end
end)

local rollBtn = Instance.new("TextButton")
rollBtn.Size = UDim2.new(0, 120, 0, 60) -- Larger roll button
rollBtn.Position = UDim2.new(0, 10, 1, -70) -- Positioned bottom left
rollBtn.Text = "Roll! 🎲" -- Added emoji
rollBtn.Font = Enum.Font.GothamBold
rollBtn.TextSize = 28
rollBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100) -- Softer green
rollBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rollBtn.Parent = mainFrame

local uiCornerRollBtn = Instance.new("UICorner")
uiCornerRollBtn.CornerRadius = UDim.new(0, 10)
uiCornerRollBtn.Parent = rollBtn

-- --- Rolling Logic and Effects ---
local rolling = false -- Prevent spamming roll button
local lastRollTime = 0
local ROLL_COOLDOWN = 2.5 -- 2.5 seconds cooldown

local function rollItem()
    local rand = math.random(1, 1000) -- Increased range for finer control
    if rand <= 250 then -- 25%
        return "Hi"
    elseif rand <= 550 then -- 30%
        return "Air"
    elseif rand <= 850 then -- 30%
        return "Nothing"
    elseif rand <= 950 then -- 10%
        return "Point"
    elseif rand <= 990 then -- 4%
        return "StarDust" -- New item
    elseif rand <= 998 then -- 0.8%
        return "Gemstone" -- New item
    else -- 0.2%
        return "Premium"
    end
end

local function playRollEffect(resultText)
    rolling = true
    local originalColor = rollBtn.BackgroundColor3
    local originalText = rollBtn.Text

    -- Rolling animation (color pulse)
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0)
    local colorTween = TweenService:Create(rollBtn, tweenInfo, {BackgroundColor3 = Color3.fromRGB(150, 255, 150)})
    colorTween:Play()

    -- Sound effect (create a simple sound if not available)
    local rollSound = Instance.new("Sound")
    rollSound.SoundId = "rbxassetid://1067252066" -- Example sound ID (button click)
    rollSound.Volume = 0.5
    rollSound.Parent = rollBtn
    rollSound:Play()

    -- Temporarily change button text
    local dots = {"", ".", "..", "..."}
    local dotIndex = 1
    local textUpdateConnection = game:GetService("RunService").RenderStepped:Connect(function()
        rollBtn.Text = "Rolling" .. dots[dotIndex]
        dotIndex = dotIndex % #dots + 1
    end)

    task.wait(1.5) -- Rolling duration

    textUpdateConnection:Disconnect()
    colorTween:Cancel()
    rollBtn.BackgroundColor3 = originalColor
    rollBtn.Text = originalText

    local resultItem = Instance.new("TextLabel")
    resultItem.Size = UDim2.new(0, 200, 0, 50)
    resultItem.Position = UDim2.new(0.5, -100, 0.5, -25)
    resultItem.AnchorPoint = Vector2.new(0.5, 0.5)
    resultItem.BackgroundTransparency = 0.8
    resultItem.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    resultItem.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow for notification
    resultItem.Font = Enum.Font.GothamBold
    resultItem.TextSize = 24
    resultItem.Text = resultText
    resultItem.Parent = mainFrame
    resultItem.ZIndex = 10 -- Ensure it's on top

    local resultTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local resultTweenPosition = TweenService:Create(resultItem, resultTweenInfo, {Position = UDim2.new(0.5, -100, 0.2, -25)})
    resultTweenPosition:Play()

    resultTweenPosition.Completed:Wait()

    local fadeTweenInfo = TweenInfo.new(1.0, Enum.EasingStyle.Linear)
    local fadeTween = TweenService:Create(resultItem, fadeTweenInfo, {TextTransparency = 1, BackgroundTransparency = 1})
    fadeTween:Play()

    fadeTween.Completed:Wait()
    resultItem:Destroy()

    -- Play a final chime sound for success
    local successSound = Instance.new("Sound")
    successSound.SoundId = "rbxassetid://1067252195" -- Example sound ID (success chime)
    successSound.Volume = 0.7
    successSound.Parent = rollBtn
    successSound:Play()

    rolling = false
end

rollBtn.MouseButton1Click:Connect(function()
    if rolling then return end
    if os.time() - lastRollTime < ROLL_COOLDOWN then
        StarterGui:SetCore("SendNotification", {
            Title = "Slow Down! ⏳", -- Added emoji
            Text = "Please wait a moment before rolling again.",
            Duration = 2
        })
        return
    end

    lastRollTime = os.time() -- Update last roll time

    local result = rollItem()
    setInventory(result, getInventory(result) + 1)
    if result ~= "Premium" then
        setData(result, getData(result) + 1)
    end

    playRollEffect(result) -- Play visual and sound effects

    StarterGui:SetCore("SendNotification", {
        Title = "You got: 🎉", -- Added emoji
        Text = tostring(result),
        Duration = 3
    })

    -- updateInventory() and updateResources() are now called by setData/setInventory

    if result == "Premium" then
        local code = "DY-" .. math.random(100,9999) .. "-" .. math.random(1000,9999) .. "-HUB"
        StarterGui:SetCore("SendNotification", {
            Title = "Premium Acquired! 💎", -- Added emoji
            Text = "Code: " .. code .. "\nReport on Discord",
            Duration = 6
        })
        print("[Premium Code] " .. code)
    end
end)

-- --- Tab System ---
local tabs = {"Shop 🛍️", "Craft 🛠️"} -- Added emojis
local currentTab = nil

local function clearContent()
    for _, child in ipairs(contentFrame:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Reset canvas size
end

local buttons = {}
for i, tabNameDisplay in ipairs(tabs) do -- Changed variable name to tabNameDisplay for clarity
    local tabName = string.gsub(tabNameDisplay, " %S+", "") -- Extract actual tab name without emoji
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 100, 1, 0)
    button.Position = UDim2.new(0, (i-1)*110, 0, 0)
    button.Text = tabNameDisplay
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Name = tabName .. "TabButton" -- Use actual tabName for button name
    button.Parent = tabContainer

    local uiCornerTabBtn = Instance.new("UICorner")
    uiCornerTabBtn.CornerRadius = UDim.new(0, 8)
    uiCornerTabBtn.Parent = button

    table.insert(buttons, button)

    button.MouseButton1Click:Connect(function()
        if currentTab == tabName then return end
        currentTab = tabName -- Use actual tab name for currentTab
        clearContent()

        -- Reset all button colors
        for _, btn in ipairs(buttons) do
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        end
        -- Highlight current tab
        button.BackgroundColor3 = Color3.fromRGB(85, 170, 255)

        if tabName == "Shop" then
            showShop(contentFrame)
        elseif tabName == "Craft" then
            showCraft(contentFrame)
        end
        -- Ensure canvas size updates after content is added
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + uiListLayout.Padding.Offset * 2)
    end)
end

-- Select the first tab on load
buttons[1].MouseButton1Click:Wait() -- Simulate a click to show default tab

-- --- Shop Functions ---
function showShop(parent)
    clearContent() -- Clear content to re-render with updated colors

    local shopItems = {
        {"Buy Premium 1 Day", 333, "Point", "Premium", "DY-", "333 Points 🌟"}, -- Added emoji
        {"Small StarDust Pack", 100, "Hi", "StarDust", nil, "100 Hi ✨"}, -- Added emoji
        {"Small Gemstone Pack", 50, "Air", "Gemstone", nil, "50 Air 💎"}, -- Added emoji
    }

    for i, item in ipairs(shopItems) do
        local itemName, costAmount, costCurrency, resultItem, premiumPrefix, costTextDisplay = unpack(item)

        local buyBtn = Instance.new("TextButton")
        buyBtn.Size = UDim2.new(1, -20, 0, 60)
        buyBtn.Text = itemName .. " (" .. costTextDisplay .. ")"
        buyBtn.Font = Enum.Font.GothamBold
        buyBtn.TextSize = 18
        buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        buyBtn.Parent = parent

        local uiCornerBuyBtn = Instance.new("UICorner")
        uiCornerBuyBtn.CornerRadius = UDim.new(0, 8)
        uiCornerBuyBtn.Parent = buyBtn

        -- Set initial button color based on affordability
        if getData(costCurrency) >= costAmount then
            buyBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 80) -- Green (can afford)
        else
            buyBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 80) -- Red (cannot afford)
        end

        buyBtn.MouseButton1Click:Connect(function()
            if getData(costCurrency) >= costAmount then
                setData(costCurrency, getData(costCurrency) - costAmount)
                setInventory(resultItem, getInventory(resultItem) + 1)

                local notificationText = "You bought " .. itemName .. "."
                if premiumPrefix then
                    local code = premiumPrefix .. math.random(100,9999) .. "-" .. math.random(1000,9999) .. "-HUB"
                    notificationText = notificationText .. "\nCode: " .. code
                    print("[Purchase] " .. itemName .. ", Code:", code)
                end

                StarterGui:SetCore("SendNotification", {
                    Title = "Purchase Successful! ✅", -- Added emoji
                    Text = notificationText,
                    Duration = 4
                })
                -- setData already calls updateResources and re-renders shop to update button colors
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "Insufficient Funds! 💸", -- Added emoji
                    Text = "You need " .. costAmount .. " " .. costCurrency .. " to buy " .. itemName .. ".",
                    Duration = 4
                })
            end
        end)
    end
    -- Update canvas size after adding shop items
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + uiListLayout.Padding.Offset * 2)
end

-- --- Crafting Functions ---
function showCraft(parent)
    clearContent() -- Clear content to re-render with updated colors

    local recipes = {
        ["X2 Item Drop"] = {Air=20, Nothing=150, Hi=50, Point=1},
        ["Faster Roll"] = {Air=70, Nothing=90, Hi=85, Point=1},
        ["Lucky X2"] = {Nothing=500, Point=5},
        ["Extra Lucky (x4)"] = {Nothing=3333, Point=3},
        ["Flash Roll (0.01s)"] = {Hi=250, Point=2},
        ["Stardust Boost"] = {StarDust=10, Point=2}, -- New craftable item
        ["Gemstone Upgrade"] = {Gemstone=5, StarDust=50, Point=10} -- New craftable item
    }

    for name, cost in pairs(recipes) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -20, 0, 80) -- Taller buttons for better text display
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.Text = "" -- Text will be set by labels
        btn.Parent = parent

        local uiCornerCraftBtn = Instance.new("UICorner")
        uiCornerCraftBtn.CornerRadius = UDim.new(0, 8)
        uiCornerCraftBtn.Parent = btn

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0, 30)
        nameLabel.Position = UDim2.new(0, 0, 0, 5)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 18
        nameLabel.Text = tostring(name)
        nameLabel.Parent = btn

        local costLabel = Instance.new("TextLabel")
        costLabel.Size = UDim2.new(1, 0, 0, 35)
        costLabel.Position = UDim2.new(0, 0, 0, 35)
        costLabel.BackgroundTransparency = 1
        costLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        costLabel.Font = Enum.Font.Gotham
        costLabel.TextSize = 14

        local costText = ""
        local costs = {}
        local canCraft = true
        for res, val in pairs(cost) do
            table.insert(costs, tostring(res .. ": " .. val))
            if getData(res) < val then
                canCraft = false
            end
        end
        costLabel.Text = tostring("Costs: " .. table.concat(costs, ", "))
        costLabel.TextWrapped = true
        costLabel.Parent = btn

        -- Set initial button color based on affordability
        if canCraft then
            btn.BackgroundColor3 = Color3.fromRGB(80, 180, 80) -- Green (can afford)
        else
            btn.BackgroundColor3 = Color3.fromRGB(180, 80, 80) -- Red (cannot afford)
        end

        btn.MouseButton1Click:Connect(function()
            local currentCanCraft = true -- Re-check when clicked
            for res, val in pairs(cost) do
                if getData(res) < val then
                    currentCanCraft = false
                    break
                end
            end

            if currentCanCraft then
                for res, val in pairs(cost) do
                    setData(res, getData(res) - val)
                end
                setInventory(name, getInventory(name) + 1) -- Add crafted item to inventory
                StarterGui:SetCore("SendNotification", {
                    Title = "Craft Successful! ✨", -- Added emoji
                    Text = "You crafted ".. tostring(name) .. "!",
                    Duration = 4
                })
                -- setData already calls updateResources and re-renders craft to update button colors
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "Craft Failed! ❌", -- Added emoji
                    Text = "Not enough resources to craft ".. tostring(name) .. ".",
                    Duration = 4
                })
            end
        end)
    end
    -- Update canvas size after adding craft items
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + uiListLayout.Padding.Offset * 2)
end
