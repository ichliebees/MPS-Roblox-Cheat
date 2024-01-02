local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait

local WAMPSTab = library:CreateWindow({
    Name = "WA MPS",
    Themeable = {
        Info = "By WA"
    }
})

local BallTab = WAMPSTab:CreateTab({
    Name = "Ball"
})

local BallSection = BallTab:CreateSection({
    Name = "Ball Actions"
})

local BallESPEnabled = false
local BallESPText = "Ball"
local BallESPColor = Color3.fromRGB(255, 0, 0)
local BallESPSize = 15

local BallESPBillboard

local function findBall()
    return workspace:FindFirstChild("CSF")
end

local function createBallESP()
    if BallESPBillboard then
        BallESPBillboard:Destroy()
    end

    local ball = findBall()

    if ball then
        BallESPBillboard = Instance.new("BillboardGui")
        BallESPBillboard.Adornee = ball
        BallESPBillboard.Size = UDim2.new(0, BallESPSize, 0, BallESPSize)
        BallESPBillboard.StudsOffset = Vector3.new(0, 5, 0)
        BallESPBillboard.AlwaysOnTop = true
        BallESPBillboard.LightInfluence = 1
        BallESPBillboard.Name = "BallESPBillboard"

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Text = BallESPText
        textLabel.TextColor3 = BallESPColor
        textLabel.Font = Enum.Font.LuckiestGuy
        textLabel.TextSize = BallESPSize
        textLabel.BackgroundTransparency = 1

        textLabel.Parent = BallESPBillboard
        BallESPBillboard.Parent = game.CoreGui
    end
end

local function teleportToBall()
    local ball = findBall()

    if ball then
        local offset = Vector3.new(0, 10, 0)
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(ball.Position + offset))
    else
        findBall()
    end
end

BallSection:AddButton({
    Name = "Teleport to Ball",
    Callback = teleportToBall
})

BallSection:AddToggle({
    Name = "Ball ESP",
    Flag = "BallESPEnabled",
    Callback = function(value)
        BallESPEnabled = value
        if BallESPEnabled then
            createBallESP()
        else
            if BallESPBillboard then
                BallESPBillboard:Destroy()
            end
        end
    end
})

BallSection:AddColorPicker({
    Name = "ESP Color",
    Flag = "BallESPColor",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(value)
        BallESPColor = value
        if BallESPBillboard then
            BallESPBillboard.TextLabel.TextColor3 = BallESPColor
        end
    end
})

BallSection:AddSlider({
    Name = "ESP Size",
    Flag = "BallESPSize",
    Value = 15,
    Min = 5,
    Max = 50,
    Precise = 0,
    Callback = function(value)
        BallESPSize = value
        if BallESPBillboard then
            BallESPBillboard.Size = UDim2.new(0, BallESPSize, 0, BallESPSize)
            BallESPBillboard.TextLabel.TextSize = BallESPSize
        end
    end
})

findBall()

Wait()
if BallESPEnabled then
    createBallESP()
end
