local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NetGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main container
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 650, 0, 400)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderColor3 = Color3.fromRGB(15, 15, 30)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "Hello Kitty Klub"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 22
titleLabel.Parent = mainFrame

-- Tabs container
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(1, 0, 0, 30)
tabsFrame.Position = UDim2.new(0, 0, 0, 35)
tabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
tabsFrame.BorderSizePixel = 0
tabsFrame.Parent = mainFrame

-- Tabs buttons
local tabNames = {"Main", "UI Settings"}
local tabButtons = {}
local contentFrames = {}

for i, tabName in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 90, 1, 0)
    tabBtn.Position = UDim2.new(0, (i -1) * 90, 0, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    tabBtn.BorderSizePixel = 0
    tabBtn.Text = tabName
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 16
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    tabBtn.Parent = tabsFrame
    tabButtons[i] = tabBtn

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -65)
    contentFrame.Position = UDim2.new(0, 0, 0, 65)
    contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    contentFrame.BorderSizePixel = 0
    contentFrame.Visible = (i == 1)
    contentFrame.Parent = mainFrame
    contentFrames[i] = contentFrame
end

-- Tab switching
for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        for j, frame in ipairs(contentFrames) do
            frame.Visible = (i == j)
            tabButtons[j].TextColor3 = (i == j) and Color3.fromRGB(220, 220, 255) or Color3.fromRGB(180, 180, 200)
            tabButtons[j].BackgroundColor3 = (i == j) and Color3.fromRGB(45, 45, 60) or Color3.fromRGB(30, 30, 40)
        end
    end)
end

-- Helper function to create a section with blue header
local function createSection(parent, title, posY, width)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(0, width or 300, 0, 140)
    section.Position = UDim2.new(0, 10, 0, posY)
    section.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    section.BorderSizePixel = 0
    section.Parent = parent

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 25)
    header.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    header.BorderSizePixel = 0
    header.Parent = section

    local headerLabel = Instance.new("TextLabel")
    headerLabel.Size = UDim2.new(1, -10, 1, 0)
    headerLabel.Position = UDim2.new(0, 5, 0, 0)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Text = title
    headerLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    headerLabel.Font = Enum.Font.GothamBold
    headerLabel.TextSize = 18
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.Parent = header

    return section
end

-- Toggle checkbox creator
local function createToggle(parent, labelText, posY)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 30)
    container.Position = UDim2.new(0, 10, 0, posY)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.75, 0, 1, 0)
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
    checkbox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    checkbox.BorderSizePixel = 0
    checkbox.Parent = container

    local checkmark = Instance.new("TextLabel")
    checkmark.Text = "✓"
    checkmark.Size = UDim2.new(1, 0, 1, 0)
    checkmark.TextColor3 = Color3.fromRGB(0, 255, 255)
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

    return container, function() return checked end
end

-- Dropdown creator
local function createDropdown(parent, labelText, options, posY, width)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, width or 250, 0, 35)
    container.Position = UDim2.new(0, 10, 0, posY)
    container.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    container.BorderSizePixel = 0
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(210, 210, 230)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(0, 120, 1, 0)
    dropdownBtn.Position = UDim2.new(0.5, 0, 0, 0)
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    dropdownBtn.BorderSizePixel = 0
    dropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
    dropdownBtn.Font = Enum.Font.GothamBold
    dropdownBtn.TextSize = 16
    dropdownBtn.Text = options[1]
    dropdownBtn.Parent = container

    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(0, 120, 0, #options * 25)
    optionsFrame.Position = UDim2.new(0.5, 0, 1, 0)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    optionsFrame.Parent = container

    for i, option in ipairs(options) do
        local optionBtn = Instance.new("TextButton")
        optionBtn.Size = UDim2.new(1, 0, 0, 25)
        optionBtn.Position = UDim2.new(0, 0, 0, (i - 1) * 25)
        optionBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        optionBtn.BorderSizePixel = 0
        optionBtn.Text = option
        optionBtn.TextColor3 = Color3.fromRGB(210, 210, 230)
        optionBtn.Font = Enum.Font.Gotham
        optionBtn.TextSize = 14
        optionBtn.Parent = optionsFrame

        optionBtn.MouseButton1Click:Connect(function()
            dropdownBtn.Text = option
            optionsFrame.Visible = false
        end)
    end

    dropdownBtn.MouseButton1Click:Connect(function()
        optionsFrame.Visible = not optionsFrame.Visible
    end)

    return container, function() return dropdownBtn.Text end
end

-- Slider creator
local function createSlider(parent, labelText, posY, maxValue, width)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, width or 250, 0, 50)
    container.Position = UDim2.new(0, 10, 0, posY)
    container.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    container.BorderSizePixel = 0
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 0, 20)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(210, 210, 230)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -60, 0, 10)
    sliderBar.Position = UDim2.new(0, 5, 0, 30)
    sliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = container

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0, 0, 1, 0) -- starts empty
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBar

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -50, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = "0"
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 16
    valueLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
    valueLabel.Parent = container

    local dragging = false

    local function updateSlider(inputPosX)
        local relativePos = math.clamp((inputPosX - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(relativePos, 0, 1, 0)
        valueLabel.Text = string.format("%.3f", relativePos * maxValue)
        return relativePos * maxValue
    end

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input.Position.X)
        end
    end)

    sliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    sliderBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position.X)
        end
    end)

    return container, function() return tonumber(valueLabel.Text) end
end

-- Keybind creator
local function createKeybind(parent, labelText, posY)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 130, 0, 30)
    container.Position = UDim2.new(0, 10, 0, posY)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 90, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = labelText
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(210, 210, 230)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.new(0, 35, 1, 0)
    keyBtn.Position = UDim2.new(0, 95, 0, 0)
    keyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    keyBtn.BorderSizePixel = 0
    keyBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.TextSize = 16
    keyBtn.Text = "None"
    keyBtn.Parent = container

    local listening = false
    keyBtn.MouseButton1Click:Connect(function()
        if not listening then
            keyBtn.Text = "Press..."
            listening = true
        end
    end)

    local userInputService = game:GetService("UserInputService")
    local conn
    conn = userInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening and not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
            keyBtn.Text = input.KeyCode.Name
            listening = false
            conn:Disconnect()
        end
    end)

    return container, function() return keyBtn.Text end
end

-- === Build GUI ===

-- Main tab content
local mainTab = contentFrames[1]

-- Shooting Section
local shootingSection = createSection(mainTab, "Shooting", 10, 300)
local aimbotDropdown, getAimbotType = createDropdown(shootingSection, "Aimbot Type", {"None", "Easy", "Hard"}, 35, 280)
local shotDelaySlider, getShotDelay = createSlider(shootingSection, "Shot Delay", 75, 0.5, 280)
local customArcSlider, getCustomArc = createSlider(shootingSection, "Custom Arc", 120, 100, 280)

-- Misc Section
local miscSection = createSection(mainTab, "Misc", 160, 300)
local deviceDropdown, getDeviceSpoofer = createDropdown(miscSection, "Device Spoofer", {"Default", "Spoofed", "Random"}, 35, 280)

-- Player Section
local playerSection = createSection(mainTab, "Player", 10, 300)
local walkToggle, getWalkToggle = createToggle(playerSection, "Walkspeed", 35)
local walkSpeedSlider, getWalkSpeed = createSlider(playerSection, "Value", 75, 0.23, 280)

-- Defense Section
local defenseSection = createSection(mainTab, "Defense", 160, 300)
local autoGuardToggle, getAutoGuardToggle = createToggle(defenseSection, "Auto Guard", 35)
local autoGuardKeybind, getAutoGuardKeybind = createKeybind(defenseSection, "Auto Guard Keybind", 75)
local ballMagnetToggle, getBallMagnetToggle = createToggle(defenseSection, "Ball Magnet", 115)
local magnetRangeSlider, getMagnetRange = createSlider(defenseSection, "Magnet Range", 155, 50, 280)
local antiFallToggle, getAntiFallToggle = createToggle(defenseSection, "Anti Fall
