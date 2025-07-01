local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

local networkFolder = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Network")
local RemotePromiseMod = require(networkFolder:WaitForChild("RemotePromise"))
local ActivatePromise = RemotePromiseMod.new("ActivateObject")

local remotesRoot = ReplicatedStorage:WaitForChild("Remotes")
local EndDecisionRemote = remotesRoot:WaitForChild("EndDecision")

local queue_on_tp = (syn and syn.queue_on_teleport)
	or queue_on_teleport
	or (fluxus and fluxus.queue_on_teleport)

local bondData = {}
local seenKeys = {}

local function notify(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Bond Collector",
			Text = text,
			Duration = 3
		})
	end)
end

local function recordBonds()
	local runtime = Workspace:WaitForChild("RuntimeItems")
	for _, item in ipairs(runtime:GetChildren()) do
		if item.Name:match("Bond") then
			local part = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
			if part then
				local key = ("%.1f_%.1f_%.1f"):format(part.Position.X, part.Position.Y, part.Position.Z)
				if not seenKeys[key] then
					seenKeys[key] = true
					table.insert(bondData, { item = item, pos = part.Position, key = key })
				end
			end
		end
	end
end

notify("Scanning map for Bonds...")

local scanTarget = CFrame.new(-424.448975, 26.055481, -49040.6562)
local scanSteps = 50

for i = 1, scanSteps do
	hrp.CFrame = hrp.CFrame:Lerp(scanTarget, i / scanSteps)
	task.wait(0.3)
	recordBonds()
	task.wait(0.1)
end

hrp.CFrame = scanTarget
task.wait(0.3)
recordBonds()

notify(("Found %d Bonds"):format(#bondData))

if #bondData == 0 then
	warn("No Bonds found – check Runtime Items")
	return
end

local chair = Workspace:WaitForChild("RuntimeItems"):FindFirstChild("Chair")
assert(chair and chair:FindFirstChild("Seat"), "Chair.Seat not found")
local seat = chair.Seat

seat:Sit(humanoid)
task.wait(0.2)
assert(humanoid.SeatPart == seat, "Seat error")

for idx, entry in ipairs(bondData) do
	if idx == #bondData then
		notify("The last Bond must be collected manually!")
		break
	end

	notify(("Collecting Bond %d/%d"):format(idx, #bondData - 1))

	if humanoid.SeatPart == seat then
		local targetCFrame = CFrame.new(entry.pos) * CFrame.new(0, 2, 0)

		seat:PivotTo(targetCFrame)
		hrp.CFrame = targetCFrame

		task.wait(0.05)
		ActivatePromise:InvokeServer(entry.item)
		task.wait(0.2)

		if not entry.item.Parent then
			notify("Collected successfully.")
		else
			notify("Collection failed. Try increasing wait time.")
		end
	else
		notify("You are not on the chair.")
	end
end

--umanoid:TakeDamage(999999)
EndDecisionRemote:FireServer(false)

if queue_on_tp then
	queue_on_tp('PUT YOUR SCRIPT HERE')
end

notify("Script finished")
