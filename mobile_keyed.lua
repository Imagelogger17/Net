local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "HoopzMobileUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Window
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 520, 0, 330)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -165)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

-- Title Bar
local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.Text = "Hoopz Script Hub"
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 16
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Parent = mainFrame

-- Tabs
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(1, 0, 0, 30)
tabsFrame.Position = UDim2.new(0, 0, 0, 30)
tabsFrame.BackgroundTransparency = 1
tabsFrame.Parent = mainFrame

local function createTab(text, xOffset)
	local tab = Instance.new("TextButton")
	tab.Text = text
	tab.Size = UDim2.new(0, 120, 0, 30)
	tab.Position = UDim2.new(0, xOffset, 0, 0)
	tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	tab.TextColor3 = Color3.fromRGB(255, 255, 255)
	tab.Font = Enum.Font.Gotham
	tab.TextSize = 14
	tab.Parent = tabsFrame
	return tab
end

local tabMain = createTab("Main", 10)
local tabSettings = createTab("UI Settings", 140)

-- Scrollable Main Content
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -70)
scroll.Position = UDim2.new(0, 10, 0, 70)
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.Parent = mainFrame

-- Category Box Creator
local function createCategory(title, yOffset)
	local box = Instance.new("Frame")
	box.Size = UDim2.new(1, -20, 0, 140)
	box.Position = UDim2.new(0, 10, 0, yOffset)
	box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	box.BorderSizePixel = 0
	box.Parent = scroll

	local label = Instance.new("TextLabel")
	label.Text = title
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.Parent = box

	return box
end

-- Toggle Button
local function createToggle(text, parent, yPos)
	local btn = Instance.new("TextButton")
	btn.Text = "[ ] " .. text
	btn.Size = UDim2.new(0, 200, 0, 25)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 13
	btn.Parent = parent

	local enabled = false
	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		btn.Text = enabled and "[✔] " .. text or "[ ] " .. text
	end)

	return btn
end

-- Label
local function createLabel(text, parent, yPos, color)
	local lbl = Instance.new("TextLabel")
	lbl.Text = text
	lbl.Position = UDim2.new(0, 10, 0, yPos)
	lbl.Size = UDim2.new(0, 300, 0, 20)
	lbl.BackgroundTransparency = 1
	lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 13
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = parent
	return lbl
end

-- Shooting
local shootingBox = createCategory("Shooting", 0)
createToggle("Aimbot Type", shootingBox, 30)
createLabel("Shot Delay: 0.325 / 0.5", shootingBox, 60, Color3.fromRGB(150, 200, 255))
createLabel("Custom Arc: 0 / 100", shootingBox, 90, Color3.fromRGB(0, 180, 255))

-- Misc
local miscBox = createCategory("Misc", 160)
createToggle("Device Spoofer", miscBox, 30)

-- Player
local playerBox = createCategory("Player", 310)
createToggle("Walkspeed", playerBox, 30)
createLabel("Value: 0 / 0.23", playerBox, 60, Color3.fromRGB(200, 255, 255))

-- Defense
local defenseBox = createCategory("Defense", 470)
createToggle("Auto Guard", defenseBox, 30)
createLabel("Keybind: G", defenseBox, 55)
createToggle("Ball Magnet", defenseBox, 80)
createLabel("Magnet Range: 5 / 50", defenseBox, 105, Color3.fromRGB(0, 200, 255))
createToggle("Anti Fall", defenseBox, 130)

-- UI Settings Placeholder
tabSettings.MouseButton1Click:Connect(function()
	scroll.CanvasPosition = Vector2.new(0, 9999)
end)

-- Dragging
local dragging, offset
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		offset = input.Position - mainFrame.Position
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		mainFrame.Position = UDim2.new(0, input.Position.X - offset.X, 0, input.Position.Y - offset.Y)
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
