-- Hoopz Auto Camlock Shooter for Delta (Mobile + PC)
-- Made for Imagelogger17's Net repo

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Change if your shooting event is named differently
local shootEvent = ReplicatedStorage:WaitForChild("ShootingEvent")

local autoEnabled = false
local shootingRange = 18 -- studs from hoop

-- Find closest hoop
local function getClosestHoop()
    local closest, closestDist = nil, math.huge
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("hoop") or obj.Name:lower():find("rim")) then
            local dist = (obj.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = obj
            end
        end
    end
    return closest, closestDist
end

-- Smoothly turn camera
local function smoothLookAt(targetPos, duration)
    local startTime = tick()
    local startCFrame = Camera.CFrame
    local goalCFrame = CFrame.new(Camera.CFrame.Position, targetPos)

    local conn
    conn = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local alpha = math.clamp(elapsed / duration, 0, 1)
        Camera.CFrame = startCFrame:Lerp(goalCFrame, alpha)
        if alpha >= 1 then
            conn:Disconnect()
        end
    end)
end

-- Auto shoot loop
RunService.RenderStepped:Connect(function()
    if autoEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hoop, dist = getClosestHoop()
        if hoop and dist <= shootingRange then
            local originalCFrame = Camera.CFrame

            Camera.CameraType = Enum.CameraType.Scriptable
            smoothLookAt(hoop.Position, 0.15)
            task.wait(0.18)

            shootEvent:FireServer()

            task.wait(0.2)
            Camera.CFrame = originalCFrame
            Camera.CameraType = Enum.CameraType.Custom
        end
    end
end)

-- Toggle button UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = PlayerGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 140, 0, 50)
button.Position = UDim2.new(0.75, 0, 0.85, 0)
button.Text = "AutoCamlock: OFF"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
button.TextColor3 = Color3.new(1, 1, 1)
button.Parent = screenGui

button.MouseButton1Click:Connect(function()
    autoEnabled = not autoEnabled
    if autoEnabled then
        button.Text = "AutoCamlock: ON"
        button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        button.Text = "AutoCamlock: OFF"
        button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)
