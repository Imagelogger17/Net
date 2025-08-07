-- KEY SYSTEM
local correctKey = "Net2025"
local player = game:GetService("Players").LocalPlayer

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NetKeySystem"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 160)
frame.Position = UDim2.new(0.5, -150, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Enter Key for Net"
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold

local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(0.8, 0, 0.3, 0)
textbox.Position = UDim2.new(0.1, 0, 0.4, 0)
textbox.PlaceholderText = "Enter Key"
textbox.Text = ""
textbox.TextScaled = true
textbox.BackgroundColor3 = Color3.fromRGB(50,50,50)
textbox.TextColor3 = Color3.new(1,1,1)
textbox.Font = Enum.Font.Gotham

local submit = Instance.new("TextButton", frame)
submit.Size = UDim2.new(0.6, 0, 0.2, 0)
submit.Position = UDim2.new(0.2, 0, 0.75, 0)
submit.Text = "Submit"
submit.TextScaled = true
submit.BackgroundColor3 = Color3.fromRGB(35, 150, 35)
submit.TextColor3 = Color3.new(1,1,1)
submit.Font = Enum.Font.GothamBold

submit.MouseButton1Click:Connect(function()
	if textbox.Text == correctKey then
		gui:Destroy()
	else
		player:Kick("Wrong key!")
	end
end)

-- Wait until key is entered
repeat wait() until not gui or gui.Parent == nil

-- === HOOPZ FEATURES (Net Script with Aimbot) ===

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local mainGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
mainGui.Name = "NetGui"
mainGui.ResetOnSpawn = false

local function createButton(text, posY)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 160, 0, 50)
	btn.Position = UDim2.new(0.5, -80, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Text = text
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.Parent = mainGui
	return btn
end

-- Remove shoot boost button (not needed)

-- Aimbot Implementation
local basket = workspace:WaitForChild("Basket") -- Change if basket name differs
local hoop = basket:WaitForChild("Hoop") -- Hoop part to target

local function getShotVelocity(startPos, targetPos, height, gravity)
	-- Calculate velocity needed to hit target at targetPos with given arc height
	local displacement = targetPos - startPos
	local displacementXZ = Vector3.new(displacement.X, 0, displacement.Z)
	local time = math.sqrt((2 * height) / gravity) + math.sqrt((2 * (displacement.Y - height)) / gravity)
	local velocityY = math.sqrt(2 * gravity * height)
	local velocityXZ = displacementXZ / time
	return Vector3.new(velocityXZ.X, velocityY, velocityXZ.Z)
end

-- Auto shoot on jump or button press
uis.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.Touch or input.KeyCode == Enum.KeyCode.V then
		if hrp and char.HoopzBall then
			local startPos = hrp.Position
			local targetPos = hoop.Position + Vector3.new(0, 5, 0) -- aim a bit above hoop center
			local gravity = workspace.Gravity
			local arcHeight = 15
			local velocity = getShotVelocity(startPos, targetPos, arcHeight, gravity)
			hrp.Velocity = velocity
		end
	end
end)

-- Silent Aim (basic)
local silentAim = true
local mt = getrawmetatable(game)
local backup = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
	local args = {...}
	if self.Name == "ShootEvent" and silentAim then
		args[2] = hoop.Position + Vector3.new(0, 5, 0) -- target above hoop center
		return backup(self, unpack(args))
	end
	return backup(self, ...)
end)

-- Auto Green
local autoGreen = true
RunService.RenderStepped:Connect(function()
	if autoGreen and char:FindFirstChild("HoopzBall") then
		char.HoopzBall:SetAttribute("Green", true)
	end
end)

-- Anti Lock Button
local antiLock = createButton("🌀 Anti Lock", 460)
local lockOn = false
antiLock.MouseButton1Click:Connect(function()
	lockOn = not lockOn
	antiLock.Text = lockOn and "🌀 Anti Lock: ON" or "🌀 Anti Lock"
end)
RunService.Heartbeat:Connect(function()
	if lockOn and hrp then
		hrp.RotVelocity = Vector3.new(0, 40, 0)
	end
end)

-- Speed Boost Button
local speedBoost = createButton("⚡ Speed", 520)
local speedOn = false
speedBoost.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = speedOn and 32 or 16
	end
	speedBoost.Text = speedOn and "⚡ Speed: ON" or "⚡ Speed"
end)

-- Jump Boost Button
local jumpBoost = createButton("⬆️ Jump", 580)
local jumpOn = false
jumpBoost.MouseButton1Click:Connect(function()
	jumpOn = not jumpOn
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.JumpPower = jumpOn and 90 or 50
	end
	jumpBoost.Text = jumpOn and "⬆️ Jump: ON" or "⬆️ Jump"
end)

-- Drag buttons (mobile friendly)
for _, btn in pairs(mainGui:GetChildren()) do
	if btn:IsA("TextButton") then
		local dragging, offset
		btn.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				offset = input.Position - btn.Position
			end
		end)
		btn.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.Touch then
				btn.Position = UDim2.new(0, input.Position.X - offset.X.Offset, 0, input.Position.Y - offset.Y.Offset)
			end
		end)
		btn.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)
	end
end
