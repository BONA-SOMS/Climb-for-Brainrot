--==================================================
-- BONA CLIMB FOR BRAINROT
-- RAYFIELD + SMALL OUTSIDE TELEPORT BUTTONS
--==================================================

local RayfieldSuccess, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not RayfieldSuccess or not Rayfield then
    warn("[BONA] Failed to load Rayfield")
    return
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local SafeZone = Vector3.new(-412.140, 1330.180, -329.418)
local LastStage = Vector3.new(-70.009, 61330.176, -333.292)

local function TeleportTo(Position)
    local Character = Player.Character
    if not Character then return end
    local Root = Character:FindFirstChild("HumanoidRootPart")
    if Root then Root.CFrame = CFrame.new(Position) end
end

local Window = Rayfield:CreateWindow({
    Name = "BONA Climb for Brainrot",
    LoadingTitle = "BONA Climb for Brainrot",
    LoadingSubtitle = "Safe Zone + Last Stage",
    ShowText = "Rayfield",
    ToggleUIKeybind = "K",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local TeleportTab = Window:CreateTab("Teleport", 4483362458)

TeleportTab:CreateButton({Name = "🟢 Safe Zone", Callback = function() TeleportTo(SafeZone) end})
TeleportTab:CreateButton({Name = "🟣 Last Stage", Callback = function() TeleportTo(LastStage) end})
TeleportTab:CreateParagraph({
    Title = "Locations",
    Content = "🟢 Safe Zone\nVector3.new(-412.140, 1330.180, -329.418)\n\n🟣 Last Stage\nVector3.new(-70.009, 61330.176, -333.292)"
})

local UIParent
pcall(function()
    if gethui then UIParent = gethui() end
end)
if not UIParent then UIParent = PlayerGui end

local OldUI = UIParent:FindFirstChild("BONA_OutsideTeleport")
if OldUI then OldUI:Destroy() end

local OutsideUI = Instance.new("ScreenGui")
OutsideUI.Name = "BONA_OutsideTeleport"
OutsideUI.ResetOnSpawn = false
OutsideUI.IgnoreGuiInset = true
OutsideUI.DisplayOrder = 2147483647
OutsideUI.ZIndexBehavior = Enum.ZIndexBehavior.Global
OutsideUI.Parent = UIParent

local Holder = Instance.new("Frame")
Holder.Name = "TeleportButtons"
Holder.AnchorPoint = Vector2.new(1, 0)
Holder.Position = UDim2.new(1, -265, 0, 78)
Holder.Size = UDim2.new(0, 260, 0, 60)
Holder.BackgroundTransparency = 1
Holder.BorderSizePixel = 0
Holder.ZIndex = 1000
Holder.Parent = OutsideUI

local SafeButton = Instance.new("TextButton")
SafeButton.Name = "SafeZone"
SafeButton.Size = UDim2.new(0, 125, 0, 60)
SafeButton.Position = UDim2.new(0, 0, 0, 0)
SafeButton.BackgroundColor3 = Color3.fromRGB(125, 190, 65)
SafeButton.BackgroundTransparency = 0.05
SafeButton.Text = "safe"
SafeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SafeButton.TextSize = 25
SafeButton.Font = Enum.Font.GothamBold
SafeButton.BorderSizePixel = 0
SafeButton.AutoButtonColor = true
SafeButton.ZIndex = 1001
SafeButton.Parent = Holder

local SafeCorner = Instance.new("UICorner")
SafeCorner.CornerRadius = UDim.new(0, 7)
SafeCorner.Parent = SafeButton

local LastButton = Instance.new("TextButton")
LastButton.Name = "LastStage"
LastButton.Size = UDim2.new(0, 125, 0, 60)
LastButton.Position = UDim2.new(0, 135, 0, 0)
LastButton.BackgroundColor3 = Color3.fromRGB(175, 65, 195)
LastButton.BackgroundTransparency = 0.05
LastButton.Text = "last stage"
LastButton.TextColor3 = Color3.fromRGB(0, 0, 0)
LastButton.TextSize = 23
LastButton.Font = Enum.Font.GothamBold
LastButton.BorderSizePixel = 0
LastButton.AutoButtonColor = true
LastButton.ZIndex = 1001
LastButton.Parent = Holder

local LastCorner = Instance.new("UICorner")
LastCorner.CornerRadius = UDim.new(0, 7)
LastCorner.Parent = LastButton

SafeButton.Activated:Connect(function() TeleportTo(SafeZone) end)
LastButton.Activated:Connect(function() TeleportTo(LastStage) end)

local Dragging = false
local DragStart
local StartPosition

Holder.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = Input.Position
        StartPosition = Holder.Position
        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if not Dragging then return end
    if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = Input.Position - DragStart
        Holder.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

Rayfield:Notify({
    Title = "BONA Climb for Brainrot",
    Content = "🟩 Safe + 🟪 Last Stage ready!",
    Duration = 4
})
