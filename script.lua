local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- SETTINGS
local HitboxEnabled = false
local ESPEnabled = false
local HitboxSize = 3000

-- THÔNG BÁO
pcall(function()
game.StarterGui:SetCore("SendNotification",{
Title="ZEUS HUB",
Text="Chào "..LocalPlayer.Name.." cảm ơn bạn đã sài script tiktok @zeus_brainrot",
Duration=6
})
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

-- LOGO
local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,70,0,70)
logo.Position = UDim2.new(0.05,0,0.6,0)
logo.Text = "Z"
logo.Font = Enum.Font.Arcade
logo.TextSize = 35
logo.BackgroundColor3 = Color3.fromRGB(0,0,0)
Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

-- LOGO XOAY + RAINBOW
task.spawn(function()

local hue = 0

while true do

logo.Rotation = logo.Rotation + 2

hue = hue + 0.01
if hue > 1 then
hue = 0
end

logo.TextColor3 = Color3.fromHSV(hue,1,1)

task.wait(0.02)

end

end)

-- MENU
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,240,0,180)
frame.Position = UDim2.new(0.5,-120,0.5,-90)
frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
frame.BackgroundTransparency = 0.25
frame.Visible = false

Instance.new("UICorner",frame)

-- GLASS EFFECT
local stroke = Instance.new("UIStroke")
stroke.Parent = frame
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255,255,255)
stroke.Transparency = 0.4

local gradient = Instance.new("UIGradient")
gradient.Parent = frame
gradient.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(200,200,255))
}
gradient.Rotation = 90

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Zeus Hub v2"
title.Font = Enum.Font.Arcade
title.TextSize = 24

-- TITLE RAINBOW
task.spawn(function()

local hue = 0

while true do

hue = hue + 0.01
if hue > 1 then
hue = 0
end

title.TextColor3 = Color3.fromHSV(hue,1,1)

task.wait(0.03)

end

end)

-- ESP BUTTON
local espButton = Instance.new("TextButton",frame)
espButton.Size = UDim2.new(0.8,0,0,35)
espButton.Position = UDim2.new(0.1,0,0.4,0)
espButton.Text = "ESP : OFF"
espButton.Font = Enum.Font.Arcade
espButton.TextSize = 18
espButton.BackgroundColor3 = Color3.fromRGB(90,90,90)
Instance.new("UICorner",espButton)

-- HITBOX BUTTON
local hitboxButton = Instance.new("TextButton",frame)
hitboxButton.Size = UDim2.new(0.8,0,0,35)
hitboxButton.Position = UDim2.new(0.1,0,0.7,0)
hitboxButton.Text = "HITBOX : OFF"
hitboxButton.Font = Enum.Font.Arcade
hitboxButton.TextSize = 18
hitboxButton.BackgroundColor3 = Color3.fromRGB(90,90,90)
Instance.new("UICorner",hitboxButton)

-- DRAG FUNCTION
local function dragify(obj)

local dragging=false
local dragStart
local startPos

obj.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.Touch
or input.UserInputType == Enum.UserInputType.MouseButton1 then

dragging=true
dragStart=input.Position
startPos=obj.Position

input.Changed:Connect(function()

if input.UserInputState == Enum.UserInputState.End then
dragging=false
end

end)

end
end)

obj.InputChanged:Connect(function(input)

if dragging then

local delta=input.Position-dragStart

obj.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)

end

end)

end

dragify(logo)
dragify(frame)

logo.MouseButton1Click:Connect(function()
frame.Visible = not frame.Visible
end)

-- TUYẾT RƠI MƯỢT
task.spawn(function()

while true do

if frame.Visible then

local snow = Instance.new("Frame")
snow.Parent = frame
snow.Size = UDim2.new(0,3,0,3)
snow.Position = UDim2.new(math.random(),0,-0.1,0)
snow.BackgroundColor3 = Color3.new(1,1,1)
snow.BorderSizePixel = 0

Instance.new("UICorner",snow).CornerRadius = UDim.new(1,0)

TweenService:Create(
snow,
TweenInfo.new(3,Enum.EasingStyle.Linear),
{Position = UDim2.new(math.random(),0,1.1,0)}
):Play()

game:GetService("Debris"):AddItem(snow,3)

task.wait(0.05)

else
task.wait(0.3)
end

end

end)

-- BUTTONS
espButton.MouseButton1Click:Connect(function()

ESPEnabled = not ESPEnabled
espButton.Text = ESPEnabled and "ESP : ON" or "ESP : OFF"

end)

hitboxButton.MouseButton1Click:Connect(function()

HitboxEnabled = not HitboxEnabled
hitboxButton.Text = HitboxEnabled and "HITBOX : ON" or "HITBOX : OFF"

end)

-- PLAYER FEATURES
local function applyFeatures(player)

if player == LocalPlayer then return end

local function setup(char)

local hrp = char:WaitForChild("HumanoidRootPart")

-- ESP
local highlight = Instance.new("Highlight")
highlight.FillColor = Color3.fromRGB(170,0,255)
highlight.OutlineColor = Color3.fromRGB(170,0,255)
highlight.FillTransparency = 0.2
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.Parent = char

local box = Instance.new("BoxHandleAdornment")
box.Size = Vector3.new(4,6,2)
box.Color3 = Color3.fromRGB(170,0,255)
box.Transparency = 0.5
box.AlwaysOnTop = true
box.Adornee = hrp
box.Parent = char

RunService.RenderStepped:Connect(function()

highlight.Enabled = ESPEnabled
box.Visible = ESPEnabled

if HitboxEnabled then

hrp.Size = Vector3.new(HitboxSize,HitboxSize,HitboxSize)
hrp.Transparency = 0.4
hrp.Material = Enum.Material.Neon
hrp.Color = Color3.fromRGB(255,255,255)
hrp.CanCollide = false

else

hrp.Size = Vector3.new(2,2,1)
hrp.Transparency = 1

end

end)

end

if player.Character then
setup(player.Character)
end

player.CharacterAdded:Connect(setup)

end

for _,p in pairs(Players:GetPlayers()) do
applyFeatures(p)
end

Players.PlayerAdded:Connect(applyFeatures)
