-- Roblox Hoopz GUI Script (Tabs, Toggles, Sliders)

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NetGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(1, 0, 0, 40)
tabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
tabsFrame.BorderSizePixel = 0
tabsFrame.Parent = mainFrame

local tabNames = {"Main", "UI Settings"}
local tabButtons = {}
local contentFrames = {}

for i, tabName in ipairs(tabNames) do
	local tabBtn = Instance.new("TextButton")
	tabBtn.Size = UDim2.new(0, 100, 1, 0)
	tabBtn.Position = UDim2.new(0, (i - 1) * 100, 0, 0)
	tabBtn.Text = tabName
	tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	tabBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
	tabBtn.Font = Enum.Font.GothamBold
	tabBtn.TextScaled = true
	tabBtn.Name = tabName .. "Tab"
	tabBtn.Parent = tabsFrame
	tabButtons[i] = tabBtn

	local content = Instance.new("Frame")
	content.Size = UDim2.new(1, 0, 1, -40)
	content.Position = UDim2.new(0, 0, 0, 40)
	content.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	content.BorderSizePixel = 0
	content.Visible = (i == 1)
	content.Parent = mainFrame
	contentFrames[i] = content
end

for i, btn in ipairs(tabButtons) do
	btn.MouseButton1Click:Connect(function()
		for j, frame in ipairs(contentFrames) do
			frame.Visible = (i == j)
			tabButtons[j].BackgroundColor3 = (i == j) and Color3.fromRGB(60, 60, 80) or Color3.fromRGB(40, 40, 50)
		end
	end)
end

local function createSection(parent, title, posY)
	local section = Instance.new("Frame")
	section.Size = UDim2.new(0, 280, 0, 150)
	section.Position = UDim2.new(0, 10, 0, posY)
	section.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
	section.BorderSizePixel = 0
	section.Parent = parent

	local header = Instance.new("TextLabel")
	header.Size = UDim2.new(1, 0, 0, 25)
	header.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	header.Text = title
	header.Font = Enum.Font.GothamBold
	header.TextSize = 18
	header.TextColor3 = Color3.fromRGB(220, 220, 255)
	header.BorderSizePixel = 0
	header.Parent = section

	return section
end

local function createToggle(parent, labelText, posY)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -10, 0, 30)
	container.Position = UDim2.new(0, 5, 0, posY)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.7, 0, 1, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.Text = labelText
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.TextColor3 = Color3.fromRGB(210, 210, 230)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local checkbox = Instance.new("TextButton")
	checkbox.Size = UDim2.new(0, 25, 0, 25)
	checkbox.Position = UDim2.new(0.8, 0, 0.1, 0)
	checkbox.Text = ""
	checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	checkbox.BorderSizePixel = 0
	checkbox.Parent = container

	local checkmark = Instance.new("TextLabel")
	checkmark.Text = "✓"
	checkmark.Size = UDim2.new(1, 0, 1, 0)
	checkmark.TextColor3 = Color3.fromRGB(120, 220, 120)
	checkmark.Visible = false
	checkmark.BackgroundTransparency = 1
	checkmark.Font = Enum.Font.GothamBold
	checkmark.TextScaled = true
	checkmark.Parent = checkbox

	local checked = false

	checkbox.MouseButton1Click:Connect(function()
		checked = not checked
		checkmark.Visible = checked
	end)
end

local function createSlider(parent, labelText, posY, maxValue)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -10, 0, 50)
	container.Position = UDim2.new(0, 5, 0, posY)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -50, 0, 20)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.Text = labelText
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.TextColor3 = Color3.fromRGB(210, 210, 230)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local sliderBar = Instance.new("Frame")
	sliderBar.Size = UDim2.new(1, -50, 0, 10)
	sliderBar.Position = UDim2.new(0, 0, 0, 30)
	sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	sliderBar.BorderSizePixel = 0
	sliderBar.Parent = container

	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(120, 220, 120)
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBar

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0, 40, 0, 20)
	valueLabel.Position = UDim2.new(1, -40, 0, 0)
	valueLabel.Text = tostring(0.5 * maxValue)
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 16
	valueLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Parent = container

	local dragging = false

	sliderBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			local relPos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
			sliderFill.Size = UDim2.new(relPos, 0, 1, 0)
			valueLabel.Text = tostring(math.floor(relPos * maxValue))
		end
	end)

	sliderBar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	sliderBar.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local relPos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
			sliderFill.Size = UDim2.new(relPos, 0, 1, 0)
			valueLabel.Text = tostring(math.floor(relPos * maxValue))
		end
	end)
end

-- Add Sections, Toggles, Sliders
local mainTab = contentFrames[1]
local shootingSection = createSection(mainTab, "Shooting", 10)
createToggle(shootingSection, "Aim Assist", 40)
createSlider(shootingSection, "Power", 80, 100)

local playerSection = createSection(mainTab, "Player", 170)
createToggle(playerSection, "Speed Boost", 40)
createSlider(playerSection, "Speed", 80, 10)

local settingsTab = contentFrames[2]
local uiSection = createSection(settingsTab, "UI Settings", 10)
createToggle(uiSection, "Dark Mode", 40)
