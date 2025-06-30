local allowedGames = {
    ["286090429"] = "Arsenal",
    ["14940775218"] = "No-Scope Arcade (2021)",
    ["6407649031"] = "No-Scope Arcade",
    ["86628581581863"] = "Anime Rails",
    ["73934517857372"] = "+1 Speed Prison Escape",
    ["139143597034555"] = "+1 Speed Prison Escape (Squid Island)"
}

local player = game:GetService("Players").LocalPlayer
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local VALID_KEY = "DYHUBTHEBEST"

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "DYHUB",
            Text = text,
            Duration = 4
        })
    end)
end

notify("🛡️ DYHUB'S TEAM | Join our (.gg/vCpzGfscnY)")

local placeId = tostring(game.PlaceId)
local gameName = allowedGames[placeId]

if not gameName then
    StarterGui:SetCore("SendNotification", {
        Title = "DYHUB",
        Text = "This script only works in allowed games!",
        Duration = 5
    })
    task.wait(2)
    player:Kick("⚠️ This script is not supported in this game.\nPlease run it in a supported game.\n🔗 (.gg/vCpzGfscnY)")
    return
end

local blur = Instance.new("BlurEffect")
blur.Size = 15
blur.Parent = game:GetService("Lighting")

local function clickTween(button)
    local originalColor = button.BackgroundColor3
    local goal = {BackgroundColor3 = originalColor:lerp(Color3.fromRGB(40,40,40), 0.5)}
    local tween = TweenService:Create(button, TweenInfo.new(0.15), goal)
    tween:Play()
    tween.Completed:Wait()
    TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = originalColor}):Play()
end

local function createKeyGui()
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "DYHUB_KeyGui"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Destroying:Connect(function() blur:Destroy() end)

    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(20,20,20)
    bg.BackgroundTransparency = 0.7
    bg.ZIndex = 10

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,350,0,210)
    frame.Position = UDim2.new(0.5,-175,0.5,-105)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.ZIndex = 11
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,20)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,25)
    title.Position = UDim2.new(0,0,0,25)
    title.BackgroundTransparency = 1
    title.Text = "Access Key Required"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.ZIndex = 12

    local sub = Instance.new("TextLabel", frame)
    sub.Size = UDim2.new(1,-40,0,30)
    sub.Position = UDim2.new(0,20,0,50)
    sub.BackgroundTransparency = 1
    sub.Text = "Enter your access key below to continue"
    sub.TextColor3 = Color3.fromRGB(180,180,180)
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 16
    sub.ZIndex = 12

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(1,-40,0,40)
    box.Position = UDim2.new(0,20,0,80)
    box.PlaceholderText = "Enter key here..."
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.BackgroundColor3 = Color3.fromRGB(70,70,70)
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 20
    box.ClearTextOnFocus = false
    box.ZIndex = 12
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,15)

    local submit = Instance.new("TextButton", frame)
    submit.Size = UDim2.new(1,-40,0,40)
    submit.Position = UDim2.new(0,20,0,122)
    submit.Text = "Submit"
    submit.BackgroundColor3 = Color3.fromRGB(255,85,85)
    submit.TextColor3 = Color3.fromRGB(255,255,255)
    submit.Font = Enum.Font.GothamBold
    submit.TextSize = 22
    submit.ZIndex = 12
    Instance.new("UICorner", submit).CornerRadius = UDim.new(0,15)

    local getKey = Instance.new("TextButton", frame)
    getKey.Size = UDim2.new(1,-40,0,40)
    getKey.Position = UDim2.new(0,20,0,165)
    getKey.Text = "Get Key"
    getKey.BackgroundColor3 = Color3.fromRGB(70,130,255)
    getKey.TextColor3 = Color3.fromRGB(255,255,255)
    getKey.Font = Enum.Font.GothamBold
    getKey.TextSize = 18
    getKey.ZIndex = 12
    Instance.new("UICorner", getKey).CornerRadius = UDim.new(0,15)

    submit.MouseButton1Click:Connect(function()
        clickTween(submit)
        local entered = box.Text:lower():gsub("%s+","")
        if entered == VALID_KEY:lower() or entered == "dev" then
            notify("✅ Key Correct! | Loading Script...")
            gui:Destroy()
            loadScript()
        else
            notify("❌ Key Incorrect! Please try again.")
        end
    end)

    getKey.MouseButton1Click:Connect(function()
        clickTween(getKey)
        pcall(function() setclipboard("https://github.com/dyumra/DYHUB-Universal") end)
        notify("🔗 Link copied to clipboard!")
    end)
end

function loadScript()
    if gameName == "Anime Rails" then
        local g = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        g.Name = "AnimeRails_SelectGui"
        local f = Instance.new("Frame", g)
        f.Size = UDim2.new(0,350,0,210)
        f.Position = UDim2.new(0.5,-175,0.5,-105)
        f.BackgroundColor3 = Color3.fromRGB(40,40,40)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0,20)
        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1,0,0,25)
        t.Position = UDim2.new(0,0,0,25)
        t.BackgroundTransparency = 1
        t.Text = "Select Script"
        t.TextColor3 = Color3.fromRGB(255,255,255)
        t.Font = Enum.Font.GothamBold
        t.TextScaled = true
        local mca = Instance.new("TextButton", f)
        mca.Size = UDim2.new(1,-40,0,50)
        mca.Position = UDim2.new(0,20,0,70)
        mca.BackgroundColor3 = Color3.fromRGB(85,255,127)
        mca.Text = "Dupe MCA"
        mca.Font = Enum.Font.GothamBold
        mca.TextSize = 22
        Instance.new("UICorner", mca).CornerRadius = UDim.new(0,15)
        local cash = Instance.new("TextButton", f)
        cash.Size = UDim2.new(1,-40,0,50)
        cash.Position = UDim2.new(0,20,0,130)
        cash.BackgroundColor3 = Color3.fromRGB(85,255,127)
        cash.Text = "Dupe Cash"
        cash.Font = Enum.Font.GothamBold
        cash.TextSize = 22
        Instance.new("UICorner", cash).CornerRadius = UDim.new(0,15)
        mca.MouseButton1Click:Connect(function()
            notify("⚙️ Loading Dupe MCA...")
            g:Destroy()
            loadstring(game:HttpGet("https://pastebin.com/raw/tWLaQUPc"))()
        end)
        cash.MouseButton1Click:Connect(function()
            notify("⚙️ Loading Dupe Cash...")
            g:Destroy()
            loadstring(game:HttpGet("https://pastebin.com/raw/Cm328YQH"))()
        end)

    elseif gameName:find("+1 Speed Prison Escape") then
        local g = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        g.Name = "SpeedPrison_SelectGui"
        local f = Instance.new("Frame", g)
        f.Size = UDim2.new(0,350,0,210)
        f.Position = UDim2.new(0.5,-175,0.5,-105)
        f.BackgroundColor3 = Color3.fromRGB(40,40,40)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0,20)
        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1,0,0,25)
        t.Position = UDim2.new(0,0,0,25)
        t.BackgroundTransparency = 1
        t.Text = "Select Mode"
        t.TextColor3 = Color3.fromRGB(255,255,255)
        t.Font = Enum.Font.GothamBold
        t.TextScaled = true
        local n = Instance.new("TextButton", f)
        n.Size = UDim2.new(1,-40,0,50)
        n.Position = UDim2.new(0,20,0,70)
        n.BackgroundColor3 = Color3.fromRGB(85,255,127)
        n.Text = "Normal Mode"
        n.Font = Enum.Font.GothamBold
        n.TextSize = 22
        Instance.new("UICorner", n).CornerRadius = UDim.new(0,15)
        local s = Instance.new("TextButton", f)
        s.Size = UDim2.new(1,-40,0,50)
        s.Position = UDim2.new(0,20,0,130)
        s.BackgroundColor3 = Color3.fromRGB(85,255,127)
        s.Text = "Squid Island Mode"
        s.Font = Enum.Font.GothamBold
        s.TextSize = 22
        Instance.new("UICorner", s).CornerRadius = UDim.new(0,15)
        n.MouseButton1Click:Connect(function()
            notify("Loading Normal Mode...")
            g:Destroy()
            loadstring(game:HttpGet("https://pastebin.com/raw/KTCsyQSk"))()
        end)
        s.MouseButton1Click:Connect(function()
            notify("Loading Squid Island...")
            g:Destroy()
            loadstring(game:HttpGet("https://pastebin.com/raw/RKPm9zJB"))()
        end)
    else
        local url
        if gameName:find("No%-Scope Arcade") then
            url = "https://pastebin.com/raw/0xcSxSW4"
        elseif gameName == "Arsenal" then
            url = "https://pastebin.com/raw/NeCbQB58"
        end
        if url then
            loadstring(game:HttpGet(url))()
            notify("🎮 "..gameName.." loaded")
        end
    end
end

if player.Name == "Yolmar_43" then
    notify("🛡️ Owner! No key needed. | @DYHUB")
    blur:Destroy()
    loadScript()
else
    createKeyGui()
end
