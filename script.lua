-- ================= KEY SYSTEM =================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService") -- 🔥 THÊM

local LocalPlayer = Players.LocalPlayer

-- 🔥 FILE LƯU KEY
local KEY_FILE = "zeus_key.json"
local KEY_VALID_TIME = 24 * 60 * 60

local function saveKey()
    local data = {
        time = os.time()
    }
    writefile(KEY_FILE, HttpService:JSONEncode(data))
end

local function isKeySaved()
    if not isfile(KEY_FILE) then return false end

    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile(KEY_FILE))
    end)

    if not success or not data.time then return false end

    return (os.time() - data.time) < KEY_VALID_TIME
end

local keyUI = Instance.new("ScreenGui", game.CoreGui)
keyUI.ResetOnSpawn = false

-- 🔥 NẾU ĐÃ NHẬP KEY TRONG 24H → ẨN UI
if isKeySaved() then
    keyUI.Enabled = false
end

local main = Instance.new("Frame", keyUI)
main.Size = UDim2.new(0,300,0,200)
main.Position = UDim2.new(0.5,-150,0.5,-100)
main.BackgroundColor3 = Color3.fromRGB(255,255,255)
main.BackgroundTransparency = 0.4
Instance.new("UICorner", main)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0,170,255)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "ZEUS KEY SYSTEM"
title.Font = Enum.Font.Arcade
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(0,170,255)

local box = Instance.new("TextBox", main)
box.Size = UDim2.new(0.8,0,0,35)
box.Position = UDim2.new(0.1,0,0.3,0)
box.PlaceholderText = "Vui lòng nhập key!"
box.BackgroundTransparency = 0.3
box.Font = Enum.Font.Arcade
box.TextSize = 18
Instance.new("UICorner", box)

-- GET KEY
local getKey = Instance.new("TextButton", main)
getKey.Size = UDim2.new(0.8,0,0,30)
getKey.Position = UDim2.new(0.1,0,0.55,0)
getKey.Text = "GET KEY"
getKey.BackgroundTransparency = 0.3
Instance.new("UICorner", getKey)

getKey.MouseButton1Click:Connect(function()
    setclipboard("https://link4m.com/o2lp2xx")
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title="GET KEY",
        Text="Đã copy link!",
        Duration=5
    })
end)

-- CHECK KEY
local check = Instance.new("TextButton", main)
check.Size = UDim2.new(0.8,0,0,30)
check.Position = UDim2.new(0.1,0,0.75,0)
check.Text = "XÁC NHẬN"
check.BackgroundTransparency = 0.3
Instance.new("UICorner", check)

local unlocked = false
local expireTime = nil

-- 🔥 NẾU ĐÃ LƯU KEY → AUTO UNLOCK
if isKeySaved() then
    unlocked = true
end

check.MouseButton1Click:Connect(function()
    local input = box.Text

    -- KEY VĨNH VIỄN
    if input == "Zeus-khangtra" then
        unlocked = true
        keyUI.Enabled = false

        saveKey() -- 🔥 LƯU 24H

        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title="ADMIN",
            Text="Key vĩnh viễn!",
            Duration=5
        })
        return
    end

    -- KEY CÓ THỜI GIAN
    local key, time, unit = string.match(input, "^(Zeus_%w+) %((%d+)([hd])%)$")

    if key and time and unit then
        local seconds = tonumber(time)

        if unit == "h" then
            seconds = seconds * 3600
        elseif unit == "d" then
            seconds = seconds * 86400
        end

        expireTime = os.time() + seconds
        unlocked = true
        keyUI.Enabled = false

        saveKey() -- 🔥 LƯU 24H

        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title="THÀNH CÔNG",
            Text="Key đúng! ("..time..unit..")",
            Duration=5
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title="LỖI",
            Text="Sai key!",
            Duration=5
        })
    end
end)

repeat task.wait() until unlocked

-- KEY VĨNH VIỄN
if input == "Zeus-admin" then
    unlocked = true
    keyUI.Enabled = false

    saveKey()

    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title="ADMIN",
        Text="Chào admin!",
        Duration=5
    })
    return

elseif input == "Zeus-khangtra" then
    unlocked = true
    keyUI.Enabled = false

    saveKey()

    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title="THÀNH CÔNG",
        Text="Key vĩnh viễn!",
        Duration=5
    })
    return
end

-- =================-- ================= SETTINGS =================

local HitboxEnabled = false
local ESPEnabled = false
local HitboxSize = 20000

-- ================= GUI =================

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
logo.TextColor3 = Color3.fromRGB(0,170,255)
logo.BackgroundColor3 = Color3.fromRGB(255,255,255)
logo.BackgroundTransparency = 0.4
Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

-- XOAY LOGO
task.spawn(function()
while true do
logo.Rotation += 2
task.wait(0.02)
end
end)

-- MENU GLASS
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,240,0,180)
frame.Position = UDim2.new(0.5,-120,0.5,-90)
frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
frame.BackgroundTransparency = 0.4
frame.Visible = false
Instance.new("UICorner",frame)

local stroke2 = Instance.new("UIStroke", frame)
stroke2.Color = Color3.fromRGB(0,170,255)

-- TITLE
local title2 = Instance.new("TextLabel",frame)
title2.Size = UDim2.new(1,0,0,40)
title2.BackgroundTransparency = 1
title2.Text = "Zeus Hub v2"
title2.Font = Enum.Font.Arcade
title2.TextSize = 24
title2.TextColor3 = Color3.fromRGB(0,170,255)

-- BUTTONS
local espButton = Instance.new("TextButton",frame)
espButton.Size = UDim2.new(0.8,0,0,35)
espButton.Position = UDim2.new(0.1,0,0.4,0)
espButton.Text = "ESP : OFF"
espButton.BackgroundTransparency = 0.3
Instance.new("UICorner",espButton)

local hitboxButton = Instance.new("TextButton",frame)
hitboxButton.Size = UDim2.new(0.8,0,0,35)
hitboxButton.Position = UDim2.new(0.1,0,0.7,0)
hitboxButton.Text = "HITBOX : OFF"
hitboxButton.BackgroundTransparency = 0.3
Instance.new("UICorner",hitboxButton)

-- DRAG FIX
local function dragify(Frame)
    local dragToggle = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = Frame.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)

    Frame.InputEnded:Connect(function()
        dragToggle = false
    end)
end

dragify(logo)
dragify(frame)

logo.MouseButton1Click:Connect(function()
frame.Visible = not frame.Visible
end)

-- TUYẾT
task.spawn(function()
while true do
if frame.Visible then
local snow = Instance.new("Frame")
snow.Parent = frame
snow.Size = UDim2.new(0,4,0,4)
snow.Position = UDim2.new(math.random(),0,-0.1,0)
snow.BackgroundColor3 = Color3.new(1,1,1)
snow.BorderSizePixel = 0
Instance.new("UICorner",snow).CornerRadius = UDim.new(1,0)

TweenService:Create(snow,TweenInfo.new(4),{
Position = UDim2.new(math.random(),0,1,0)
}):Play()

game:GetService("Debris"):AddItem(snow,4)
task.wait(0.1)
else
task.wait(0.3)
end
end
end)

-- BUTTON LOGIC
espButton.MouseButton1Click:Connect(function()
ESPEnabled = not ESPEnabled
espButton.Text = ESPEnabled and "ESP : ON" or "ESP : OFF"
end)

hitboxButton.MouseButton1Click:Connect(function()
HitboxEnabled = not HitboxEnabled
hitboxButton.Text = HitboxEnabled and "HITBOX : ON" or "HITBOX : OFF"
end)

-- APPLY ESP + HITBOX
local function apply(player)
if player == LocalPlayer then return end

local function setup(char)
local hrp = char:WaitForChild("HumanoidRootPart")

local highlight = Instance.new("Highlight")
highlight.Parent = char
highlight.FillTransparency = 1
highlight.OutlineColor = Color3.fromRGB(0,170,255)

local box = Instance.new("BoxHandleAdornment")
box.Parent = char
box.Adornee = hrp
box.Size = Vector3.new(4,6,2)
box.Color3 = Color3.fromRGB(0,170,255)
box.Transparency = 0.5
box.AlwaysOnTop = true

-- NAME 7 MÀU NHỎ
local billboard = Instance.new("BillboardGui")
billboard.Parent = char
billboard.Size = UDim2.new(0,100,0,30)
billboard.StudsOffset = Vector3.new(0,3,0)
billboard.AlwaysOnTop = true

local text = Instance.new("TextLabel")
text.Parent = billboard
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.Text = player.Name
text.TextSize = 14
text.Font = Enum.Font.Arcade

task.spawn(function()
local colors = {
Color3.fromRGB(255,0,0),
Color3.fromRGB(255,127,0),
Color3.fromRGB(255,255,0),
Color3.fromRGB(0,255,0),
Color3.fromRGB(0,0,255),
Color3.fromRGB(75,0,130),
Color3.fromRGB(148,0,211)
}

while text.Parent do
for _,c in pairs(colors) do
text.TextColor3 = c
task.wait(0.3)
end
end
end)

RunService.RenderStepped:Connect(function()
highlight.Enabled = ESPEnabled
box.Visible = ESPEnabled
billboard.Enabled = ESPEnabled

if HitboxEnabled then
hrp.Size = Vector3.new(20000,20000,20000)
hrp.Transparency = 0.5
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
apply(p)
end

Players.PlayerAdded:Connect(apply)
