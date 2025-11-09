print("Script injecting with bypasser")
wait(2.5)
print("Successfully Injected Nexar script")
wait(1.2)
print("Have Fun using the Best script Made By Love -unnezy x3")
wait(0.1)
print("This Script currently only works on a level 8 executor dont use executors like: Xeno,Solara ! instead use Velocity,Volcano,Bunni.lol")
-- // Orion Library
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/MrOhio67/Scripts/refs/heads/main/TTest.lua'))()

local Window = OrionLib:MakeWindow({
    Name = "Nexar Scripts v1.1",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "EmptyTabs"
})

-- Tabs
local AimbotTab = Window:MakeTab({ Name = "Aimbot", Icon = "rbxassetid://3926305904" })
local TrollTab = Window:MakeTab({ Name = "Troll", Icon = "rbxassetid://3926305904" })
local ServerInfoTab = Window:MakeTab({ Name = "Server Info", Icon = "rbxassetid://3926305904" })
local MiscTab = Window:MakeTab({ Name = "Misc", Icon = "rbxassetid://3926305904" }) -- FIXED: MicsTab → MiscTab
local TeleportsTab = Window:MakeTab({ Name = "Teleport", Icon = "rbxassetid://3926305904"})
local CarModsTab = Window:MakeTab({ Name = "Car mods", Icon = "rbxassetid://3926305904"})
OrionLib:Init()

OrionLib:MakeNotification({
    Name = "Executed!",
    Content = "Made by -unnezy | discord: @unnezy",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Services
local RS = game:GetService("ReplicatedStorage")
local P = game:GetService("Players")
local W = game:GetService("Workspace")
local R = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local SG = game:GetService("StarterGui")
local LP = P.LocalPlayer

-- Anti-Remote Block
local mt = getrawmetatable(game)
local nc = mt.__namecall
setreadonly(mt, false)

local block = {
    RS:WaitForChild("8WX"):WaitForChild("c5e56a9e-c828-4d2a-a755-7086cca2a88d"),
    RS:WaitForChild("8WX"):WaitForChild("c2499a7d-2993-4c90-aa4d-df3bc5e06930"),
    RS:WaitForChild("8WX"):WaitForChild("86437dfc-c1d3-4a4c-90cb-041fa4d6a802"),
    RS:WaitForChild("8WX"):WaitForChild("d43e2acd-d917-48e2-8265-2a5917e3800e")
}

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" or method == "InvokeServer" then
        for _, remote in ipairs(block) do
            if self == remote then return end
        end
    end
    return nc(self, ...)
end)
setreadonly(mt, true)

--------------------------------------------------------------------
-- // NOCLIP SYSTEM (FIXED)
--------------------------------------------------------------------
local noclipActive = false
local noclipConnection = nil

local function updateNoclip()
    local char = LP.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noclipActive
        end
    end
end

MiscTab:AddToggle({
    Name = "Toggle NoClip",
    Default = false,
    Callback = function(value)
        noclipActive = value
        if noclipActive then
            if noclipConnection then noclipConnection:Disconnect() end
            noclipConnection = R.Stepped:Connect(updateNoclip)
            updateNoclip()
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            updateNoclip()
        end
    end
})

-- Respawn support
LP.CharacterAdded:Connect(function()
    task.wait(0.1)
    if noclipActive then updateNoclip() end
end)

--------------------------------------------------------------------
-- // FLY SYSTEM (IMPROVED)
--------------------------------------------------------------------
local flyEnabled = false
local flySpeed = 0.5
local flyKey = Enum.KeyCode.V
local flyToggleInstance = nil

-- Fly Toggle
flyToggleInstance = MiscTab:AddToggle({
    Name = "Fly",
    Default = false,
    Callback = function(v)
        flyEnabled = v
        if not v and LP.Character then
            local hum = LP.Character:FindFirstChildOfClass("Humanoid")
            local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
            if hum then hum.PlatformStand = false end
            if hrp then hrp.Velocity = Vector3.zero end
        end
    end
})

-- Fly Speed Slider
MiscTab:AddSlider({
    Name = "Fly Speed",
    Min = 1,
    Max = 10,
    Default = 2,
    Increment = 1,
    ValueName = "x",
    Callback = function(val)
        flySpeed = val
    end
})

-- Fly Keybind
MiscTab:AddBind({
    Name = "Fly Toggle Key",
    Default = Enum.KeyCode.V,
    Hold = false,
    Callback = function(key)
        flyKey = key
    end
})

-- Notification
local function notify(title, text)
    pcall(function()
        SG:SetCore("SendNotification", { Title = title, Text = text, Duration = 2 })
    end)
end

-- Toggle with key
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == flyKey then
        flyEnabled = not flyEnabled
        if flyToggleInstance then flyToggleInstance:Set(flyEnabled) end
        notify("Fly", flyEnabled and "ON" or "OFF")
        if not flyEnabled and LP.Character then
            local hum = LP.Character:FindFirstChildOfClass("Humanoid")
            local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
            if hum then hum.PlatformStand = false end
            if hrp then hrp.Velocity = Vector3.zero end
        end
    end
end)

-- Fly Loop
R.RenderStepped:Connect(function()
    if not flyEnabled then return end

    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local hrp = char.HumanoidRootPart
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = true end

    local cam = workspace.CurrentCamera
    local moveDir = Vector3.new()

    if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0,1,0) end

    -- Face forward
    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.CFrame.LookVector)

    -- Move
    hrp.Velocity = Vector3.zero
    if moveDir.Magnitude > 0 then
        hrp.CFrame += moveDir.Unit * flySpeed
    end
end)

-- Respawn fly fix
LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if flyEnabled and LP.Character then
        local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = true end
    end
end)



-------ESP ANFANG   


local VisualTab = Window:MakeTab({
    Name = "Esp",
    Icon = "rbxassetid://3926305904",
    PremiumOnly = false
})

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local ESPEnabled = false
local ESPSettings = {
    ShowName = false,
    ShowUsername = false,
    ShowDistance = false,
    ShowTeam = false,
    ESPColor = Color3.fromRGB(150,150,150), -- Gris
    TextSize = 20,
    MaxDistance = 100
}


local function getESPText(plr)
    local text = ""
    local char = plr.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return "" end
    if ESPSettings.ShowName then text = text .. plr.DisplayName .. " " end
    if ESPSettings.ShowUsername then text = text .. "(" .. plr.Name .. ") " end
    if ESPSettings.ShowDistance then
        local dist = (LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
        text = text .. "["..math.floor(dist).."m] "
    end
    if ESPSettings.ShowTeam and plr.Team and plr.Team.Name then
        text = text .. "["..plr.Team.Name.."] "
    end
    return text
end


local function getBillboard(head)
    local bb = head:FindFirstChild("ESP_BB")
    if not bb then
        bb = Instance.new("BillboardGui")
        bb.Name = "ESP_BB"
        bb.Size = UDim2.new(0, 200, 0, ESPSettings.TextSize)
        bb.AlwaysOnTop = true
        bb.StudsOffset = Vector3.new(0, 2, 0)
        bb.Parent = head

        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "ESP_Text"
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextStrokeTransparency = 0.6
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextYAlignment = Enum.TextYAlignment.Top
        textLabel.Parent = bb
    end
    return bb
end


local function adjustOffset(plr, index)
    local char = plr.Character
    if char and char:FindFirstChild("Head") then
        local bb = getBillboard(char.Head)
        bb.StudsOffset = Vector3.new(0, 2 + index * 0.5, 0)
    end
end


RunService.RenderStepped:Connect(function()
    if not ESPEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Head") then
                local bb = plr.Character.Head:FindFirstChild("ESP_BB")
                if bb then bb:Destroy() end
            end
        end
        return
    end

    local indexCounter = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
            if dist <= ESPSettings.MaxDistance then
                local bb = getBillboard(head)
                local label = bb.ESP_Text
                label.Text = getESPText(plr)
                label.TextColor3 = ESPSettings.ESPColor
                label.TextSize = ESPSettings.TextSize

               
                local key = math.floor(head.Position.X*10).."_"..math.floor(head.Position.Z*10)
                indexCounter[key] = (indexCounter[key] or 0) + 1
                adjustOffset(plr, indexCounter[key])
            else
                local bb = head:FindFirstChild("ESP_BB")
                if bb then bb:Destroy() end
            end
        end
    end
end)


VisualTab:AddToggle({ Name = "Enable ESP", Default = false, Callback = function(v) ESPEnabled = v end })
VisualTab:AddToggle({ Name = "Show Nametag", Default = false, Callback = function(v) ESPSettings.ShowName = v end })
VisualTab:AddToggle({ Name = "Show Username", Default = false, Callback = function(v) ESPSettings.ShowUsername = v end })
VisualTab:AddToggle({ Name = "Show Distance", Default = false, Callback = function(v) ESPSettings.ShowDistance = v end })
VisualTab:AddToggle({ Name = "Show Team", Default = false, Callback = function(v) ESPSettings.ShowTeam = v end })


VisualTab:AddSlider({
    Name = "ESP Text Size",
    Min = 10,
    Max = 40,
    Default = ESPSettings.TextSize,
    Callback = function(v) ESPSettings.TextSize = v end
})


VisualTab:AddSlider({
    Name = "Max ESP Distance",
    Min = 10,
    Max = 1000,
    Default = ESPSettings.MaxDistance,
    Callback = function(v) ESPSettings.MaxDistance = v end
})






--server info anfang 


local totalLabel = ServerInfoTab:AddLabel("Total Players: 0")
local policeLabel = ServerInfoTab:AddLabel("Police: 0")
local fireLabel = ServerInfoTab:AddLabel("Firedepartements: 0")
local adacLabel = ServerInfoTab:AddLabel("ADAC: 0")
local busLabel = ServerInfoTab:AddLabel("Bus Company: 0")
local truckLabel = ServerInfoTab:AddLabel("Truck Company: 0")
local citizenLabel = ServerInfoTab:AddLabel("Citizen: 0")
local youLabel = ServerInfoTab:AddLabel("You: N/A")


local function updateInfo()
    local players = game.Players:GetPlayers()
    local total = #players
    local police, fire, adac, bus, truck, citizen = 0,0,0,0,0,0

    for _,plr in pairs(players) do
        if plr.Team then
            local lname = plr.Team.Name:lower()
            if lname:find("police") then
                police += 1
            elseif lname:find("fire") then
                fire += 1
            elseif lname:find("adac") then
                adac += 1
            elseif lname:find("bus") then
                bus += 1
            elseif lname:find("truck") then
                truck += 1
            else
                citizen += 1
            end
        else
            citizen += 1
        end
    end

    totalLabel:Set("Total Players: " .. total)
    policeLabel:Set("Police: " .. police)
    fireLabel:Set("Firedepartements: " .. fire)
    adacLabel:Set("ADAC: " .. adac)
    busLabel:Set("Bus Company: " .. bus)
    truckLabel:Set("Truck Company: " .. truck)
    citizenLabel:Set("Citizen: " .. citizen)

    local me = game.Players.LocalPlayer
    if me.Team then
        youLabel:Set("You: " .. me.Name .. " (" .. me.Team.Name .. ")")
    else
        youLabel:Set("You: " .. me.Name .. " (No Team)")
    end
end


task.spawn(function()
    while task.wait(2) do
        updateInfo()
    end
end)

updateInfo()





--teleport 


 local function moveCarToTarget(destination)
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local LocalPlayer = Players.LocalPlayer
        local VehiclesFolder = workspace:WaitForChild("Vehicles")

        local car = VehiclesFolder:FindFirstChild(LocalPlayer.Name)
        if not car then
            warn("No car found")
            return
        end

        local driveSeat = car:FindFirstChild("DriveSeat", true)
        if not driveSeat then
            warn("No DriveSeat found")
            return
        end

        car.PrimaryPart = driveSeat
        driveSeat:Sit(LocalPlayer.Character:WaitForChild("Humanoid"))

        local function moveTo(target)
            local dist = (car.PrimaryPart.Position - target).Magnitude
            local time = dist / 175
            local info = TweenInfo.new(time, Enum.EasingStyle.Linear)
            local cfVal = Instance.new("CFrameValue")
            cfVal.Value = car:GetPivot()

            cfVal.Changed:Connect(function(cf)
                car:PivotTo(cf)
                driveSeat.AssemblyLinearVelocity = Vector3.zero
                driveSeat.AssemblyAngularVelocity = Vector3.zero
            end)

            local tween = TweenService:Create(cfVal, info, { Value = CFrame.new(target) })
            tween:Play()
            tween.Completed:Wait()
            cfVal:Destroy()
        end

        local start = car.PrimaryPart.Position
        moveTo(start + Vector3.new(0, -5, 0))
        moveTo(destination + Vector3.new(0, -5, 0))
        moveTo(destination)
    end


    TeleportsTab:AddButton({
        Name = "Teleport to Nearest Dealer",
        Callback = function()
            local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            local dealers = workspace:FindFirstChild("Dealers")
            if not dealers then return end

            local closest, shortest = nil, math.huge
            for _, dealer in pairs(dealers:GetChildren()) do
                if dealer:FindFirstChild("Head") then
                    local dist = (character.HumanoidRootPart.Position - dealer.Head.Position).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = dealer.Head
                    end
                end
            end
            if closest then
                moveCarToTarget(closest.Position + Vector3.new(0, 5, 0))
            end
        end
    })

    
    TeleportsTab:AddButton({
        Name = "Teleport to Robbable Vending Machine",
        Callback = function()
            local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            local machines = workspace:FindFirstChild("Robberies") and workspace.Robberies:FindFirstChild("VendingMachines")
            if not machines then return end

            local closest, shortest = nil, math.huge
            for _, model in pairs(machines:GetChildren()) do
                for _, part in pairs(model:GetChildren()) do
                    if part:IsA("Part") and part.Color == Color3.fromRGB(73, 147, 0) then
                        local dist = (character.HumanoidRootPart.Position - part.Position).Magnitude
                        if dist < shortest then
                            shortest = dist
                            closest = part
                        end
                    end
                end
            end

            if closest then
                moveCarToTarget(closest.Position)
            else
                OrionLib:MakeNotification({
                    Name = "Not Found",
                    Content = "Robbable Vending Machine not found!",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
    })
    
   
    TeleportsTab:AddButton({ Name = "Teleport to Bank", Callback = function() moveCarToTarget(Vector3.new(-1166.91, 5.86, 3190.407)) end })
 
    TeleportsTab:AddButton({ Name = "Teleport to Jewel Store", Callback = function() moveCarToTarget(Vector3.new(-427.862, 49.628, 3500.895)) end })

    TeleportsTab:AddButton({ Name = "Teleport to Club", Callback = function() moveCarToTarget(Vector3.new(-1865.73, 5.63, 3015.14)) end })
  
    TeleportsTab:AddButton({ Name = "Teleport to Farm Shop", Callback = function() moveCarToTarget(Vector3.new(-904.34, 5.35, -1167.26)) end })
  
    TeleportsTab:AddButton({ Name = "Teleport to Gas-N-Go", Callback = function() moveCarToTarget(Vector3.new(-1543.59, 5.82, 3799.58)) end })

    TeleportsTab:AddButton({ Name = "Teleport to Ares Gas Station", Callback = function() moveCarToTarget(Vector3.new(-865.29, 5.61, 1509.46)) end })
    
    TeleportsTab:AddButton({ Name = "Teleport to Osso", Callback = function() moveCarToTarget(Vector3.new(-35.25, 5.71, -761.23)) end })
    
    TeleportsTab:AddButton({ Name = "Teleport to Green Container", Callback = function() moveCarToTarget(Vector3.new(1164.07, 29.16, 2152.81)) end })
 
    TeleportsTab:AddButton({ Name = "Teleport to Golden Container", Callback = function() moveCarToTarget(Vector3.new(1125.94, 29.16, 2331.82)) end })
   
    TeleportsTab:AddButton({ Name = "Teleport to ADAC", Callback = function() moveCarToTarget(Vector3.new(-152.12, 5.52, 452.47)) end })
    
    TeleportsTab:AddButton({ Name = "Teleport to Tuning", Callback = function() moveCarToTarget(Vector3.new(-1372.408, 5.656, 170.811)) end })
   
    TeleportsTab:AddButton({ Name = "Teleport to Hospital", Callback = function() moveCarToTarget(Vector3.new(-288.187, 5.787, 1121.457)) end })
 
    TeleportsTab:AddButton({ Name = "Teleport to Police Station", Callback = function() moveCarToTarget(Vector3.new(-1674.341, 5.807, 2746.140)) end })
    
    TeleportsTab:AddButton({ Name = "Teleport to Fire Department", Callback = function() moveCarToTarget(Vector3.new(-1674.341, 5.807, 2746.140)) end })
    
    TeleportsTab:AddButton({ Name = "Teleport to Car Dealer", Callback = function() moveCarToTarget(Vector3.new(-1390.604, 5.615, 941.208)) end })
   
    TeleportsTab:AddButton({ Name = "Teleport to Car Bus Company", Callback = function() moveCarToTarget(Vector3.new(-1680.241, 5.618, -1278.784)) end })
 
    TeleportsTab:AddButton({ Name = "Teleport to Clothing Store", Callback = function() moveCarToTarget(Vector3.new(-1680.241, 5.618, -1278.784)) end })
    
    TeleportsTab:AddButton({ Name = "Teleport to Prison", Callback = function() moveCarToTarget(Vector3.new(-566.475, 5.810, 2851.558)) end })
    
    TeleportsTab:AddButton({ Name = "Teleport inside Prison", Callback = function() moveCarToTarget(Vector3.new(-606.739, 5.490, 3049.082)) end })

    TeleportsTab:AddLabel("Notes:You can get kick ")






    --carmods Anfang


    
local PlayerSection = CarModsTab:AddSection({
    Name = "Carfly"
})

local flightEnabled = false
local flightSpeed = 1
local flightGui
local guiFlightDirection = Vector3.new(0, 0, 0)
local buttonDirections = {
    W = Vector3.new(0, 0, -1),
    A = Vector3.new(-1, 0, 0),
    S = Vector3.new(0, 0, 1),
    D = Vector3.new(1, 0, 0),
}

local function createFlightGui()
    local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
    screenGui.Name = "FlightControlGui"
    screenGui.Enabled = false

    local frame = Instance.new("Frame", screenGui)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.8, 0)
    frame.Size = UDim2.new(0, 200, 0, 200)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BackgroundTransparency = 0.2
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0.1, 0)
    Instance.new("UIDragDetector", frame)

    local buttonSize = UDim2.new(0, 60, 0, 60)
    local positions = {
        W = UDim2.new(0.5, -30, 0, 0),
        A = UDim2.new(0, 0, 0.5, -30),
        S = UDim2.new(0.5, -30, 1, -60),
        D = UDim2.new(1, -60, 0.5, -30),
    }
    local rotations = {W = 0, A = -90, S = 180, D = 90}

    for key, direction in pairs(buttonDirections) do
        local button = Instance.new("ImageButton", frame)
        button.Name = key.."Button"
        button.Position = positions[key]
        button.Size = buttonSize
        button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        button.BackgroundTransparency = 0.1
        button.Image = "rbxassetid://11432834725"
        button.Rotation = rotations[key]
        Instance.new("UICorner", button).CornerRadius = UDim.new(0.1, 0)

        button.MouseButton1Down:Connect(function()
            guiFlightDirection = guiFlightDirection + direction
        end)
        button.MouseButton1Up:Connect(function()
            guiFlightDirection = Vector3.zero
        end)
    end
    return screenGui
end

local function toggleFlightGui(Value)
    if not flightGui then
        flightGui = createFlightGui()
    end
    guiFlightDirection = Vector3.zero
    flightGui.Enabled = Value
end

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LP = game.Players.LocalPlayer

RunService.RenderStepped:Connect(function()
    if flightEnabled then
        local char = LP.Character
        if char and char:FindFirstChild("Humanoid") and char.Humanoid.Sit then
            local seat = char.Humanoid.SeatPart
            if seat and seat.Name == "DriveSeat" then
                local vehicle = seat.Parent
                if vehicle then
                    if not vehicle.PrimaryPart then
                        vehicle.PrimaryPart = seat
                    end
                    local camLook = workspace.CurrentCamera.CFrame.LookVector
                    vehicle:PivotTo(CFrame.new(vehicle.PrimaryPart.Position, vehicle.PrimaryPart.Position + camLook) *
                        CFrame.new(
                            ((UIS:IsKeyDown(Enum.KeyCode.D) and flightSpeed or 0) - (UIS:IsKeyDown(Enum.KeyCode.A) and flightSpeed or 0)) + guiFlightDirection.X * flightSpeed,
                            ((UIS:IsKeyDown(Enum.KeyCode.E) and flightSpeed/2 or 0) - (UIS:IsKeyDown(Enum.KeyCode.Q) and flightSpeed/2 or 0)) + guiFlightDirection.Y * flightSpeed,
                            ((UIS:IsKeyDown(Enum.KeyCode.S) and flightSpeed or 0) - (UIS:IsKeyDown(Enum.KeyCode.W) and flightSpeed or 0)) + guiFlightDirection.Z * flightSpeed
                        ))
                    seat.AssemblyLinearVelocity = Vector3.zero
                    seat.AssemblyAngularVelocity = Vector3.zero
                end
            end
        end
    end
end)

local flyToggle = CarModsTab:AddToggle({
    Name = "Car Fly",
    Default = false,
    Callback = function(Value)
        flightEnabled = Value
    end
})

CarModsTab:AddToggle({
    Name = "Mobile Fly Menu",
    Default = false,
    Callback = function(Value)
        toggleFlightGui(Value)
    end
})

CarModsTab:AddSlider({
    Name = "Car Fly Speed",
    Min = 10,
    Max = 190,
    Default = 60,
    Increment = 10,
    ValueName = "Speed",
    Callback = function(Value)
        flightSpeed = Value / 50
    end
})

CarModsTab:AddBind({
    Name = "Car Fly Keybind",
    Default = Enum.KeyCode.X,
    Hold = false,
    Callback = function()
        flightEnabled = not flightEnabled
        flyToggle:Set(flightEnabled)
    end
})



--SPINBOT

-- // SPINBOT (NUR DAS!)
local spinbotEnabled = false
local spinbotSpeed = 50
local spinConnection

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

OrionLib:Init()

-- Spinbot Toggle
MiscTab:AddToggle({
    Name = "Spinbot",
    Default = false,
    Callback = function(v)
        spinbotEnabled = v
        if v then
            spinConnection = RunService.Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    local spinRad = math.rad(spinbotSpeed / 30) -- RPM zu Radians
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, spinRad, 0)
                end
            end)
        else
            if spinConnection then
                spinConnection:Disconnect()
                spinConnection = nil
            end
        end
    end
})

-- Speed Slider (1-500 RPM)
MiscTab:AddSlider({
    Name = "Spin Speed",
    Min = 1,
    Max = 500,
    Default = 50,
    Increment = 1,
    ValueName = "RPM",
    Callback = function(val)
        spinbotSpeed = val
    end
})

-- Notification
StarterGui:SetCore("SendNotification", {
    Title = "SPINBOT LOADED!",
    Text = "Troll Tab → 1-500 RPM",
    Duration = 4
})



--Car speed multiplaier


local player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local vehicleGodMode = false
local lastVehicle = nil

local function updateVehicle()
    if not vehicleGodMode then return end
    if not lastVehicle or not lastVehicle.Parent then
        local vehiclesFolder = workspace:FindFirstChild("Vehicles")
        lastVehicle = vehiclesFolder and vehiclesFolder:FindFirstChild(player.Name) or nil
    end
    if lastVehicle then
        lastvehicle:SetAttribute("IsOn", true)
        lastVehicle:SetAttribute("currentHealth", 999999999999)
        lastVehicle:SetAttribute("currentFuel", math.huge)
    end
end

CarModsTab:AddButton({
    Name = "Car Godmode",
    Default = false,
    Callback = function(value)
        vehicleGodMode = value
        if not vehicleGodMode then
            lastVehicle = nil
        end
    end
})

RunService.Heartbeat:Connect(updateVehicle)


CarModsTab:AddSlider({
    Name = "Engine Armor Brakes",
    Min = 0,
    Max = 6,
    Default = 0,
    Color = Color3.fromRGB(255, 215, 0),
    Increment = 1,
    ValueName = "Level",
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        local vehicleFolder = workspace:WaitForChild("Vehicles")
        local playerVehicle = vehicleFolder:FindFirstChild(player.Name)
        if playerVehicle then
            playerVehicle:SetAttribute("armorLevel", value)
            playerVehicle:SetAttribute("brakesLevel", value)
            playerVehicle:SetAttribute("engineLevel", value)
        end
    end
})



local VehiclesFolder = workspace:WaitForChild("Vehicles")
local LocalPlayer = game.Players.LocalPlayer


local SuspensionBase = {}


local function setSuspensionHeight(offset)
    local vehicle = VehiclesFolder:FindFirstChild(LocalPlayer.Name)
    if not vehicle then return end

    -- Applique la vraie suspension (SpringConstraint)
    for _, part in ipairs(vehicle:GetDescendants()) do
        if part:IsA("SpringConstraint") then
            if not SuspensionBase[part] then
                SuspensionBase[part] = {
                    FreeLength = part.FreeLength,
                    Stiffness = part.Stiffness,
                    Damping = part.Damping
                }
            end

            local base = SuspensionBase[part]
            part.FreeLength = math.max(base.FreeLength + offset, 0.5)
            part.Stiffness = base.Stiffness * (1 + offset/10) -- évite que ça s’écrase
            part.Damping = base.Damping * (1 + offset/15) -- garde stabilité
        end
    end


    if vehicle.PrimaryPart then
        vehicle:SetPrimaryPartCFrame(vehicle.PrimaryPart.CFrame * CFrame.new(0, offset * 0.05, 0))
    end
end


CarModsTab:AddSlider({
    Name = "Suspension Height (Bug)",
    Min = 1,
    Max = 4,
    Default = 0,
    Color = Color3.fromRGB(255, 215, 0),
    Increment = 0.5,
    ValueName = "Offset",
    Callback = function(value)
        setSuspensionHeight(value)
    end
})



local carBoostPower = 250
CarModsTab:AddSlider({
    Name = "Car Boost Power",
    Min = 100,
    Max = 500,
    Default = carBoostPower,
    Color = Color3.fromRGB(255, 215, 0),
    Increment = 10,
    ValueName = "Studs/sec",
    Callback = function(value)
        carBoostPower = value
    end
})

CarModsTab:AddButton({
    Name = "Car Boost",
    Callback = function()
        local player = game.Players.LocalPlayer
        local vehiclesFolder = workspace:FindFirstChild("Vehicles")
        if not vehiclesFolder then return end
        local vehicle = vehiclesFolder:FindFirstChild(player.Name)
        if not vehicle then return end
        local seat = vehicle:FindFirstChild("DriveSeat") or vehicle:FindFirstChildWhichIsA("VehicleSeat")
        if not seat then return end
        local primaryPart = vehicle.PrimaryPart or seat
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        if humanoid.SeatPart ~= seat then return end
        primaryPart.AssemblyLinearVelocity = seat.CFrame.LookVector * carBoostPower
    end
})


local carJumpPower = 90
CarModsTab:AddSlider({
    Name = "Car Jump Height",
    Min = 80,
    Max = 500,
    Default = carJumpPower,
    Color = Color3.fromRGB(255, 215, 0),
    Increment = 1,
    ValueName = "Studs",
    Callback = function(value)
        carJumpPower = value
    end
})

CarModsTab:AddButton({
    Name = "Car Jump",
    Callback = function()
        local player = game.Players.LocalPlayer
        local vehiclesFolder = workspace:FindFirstChild("Vehicles")
        if not vehiclesFolder then return end
        local vehicle = vehiclesFolder:FindFirstChild(player.Name)
        if not vehicle then return end
        local seat = vehicle:FindFirstChild("DriveSeat") or vehicle:FindFirstChildWhichIsA("VehicleSeat")
        if not seat then return end
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        if humanoid.SeatPart ~= seat then return end
        seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity + Vector3.new(0, carJumpPower, 0)
    end
})


local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VehiclesFolder = workspace:FindFirstChild("Vehicles")


local accelMultiplier = 1      
local accelEnabled = false     
local originalAttrs = {}       
local lastVehicleRef = nil     


CarModsTab:AddSlider({
    Name = "Acceleration Multiplier",
    Min = 1,
    Max = 3, 
    Default = 1,
    Color = Color3.fromRGB(255, 215, 0),
    Increment = 0.1,
    ValueName = "x",
    Callback = function(value)
        accelMultiplier = value
    end
})


CarModsTab:AddToggle({
    Name = "Enable Accel Multiplier",
    Default = false,
    Callback = function(v)
        accelEnabled = v
        -- si on désactive, restore du véhicule précédemment modifié
        if not accelEnabled and lastVehicleRef then
            pcall(function()
                if originalAttrs[lastVehicleRef] then
                    for attrName, orig in pairs(originalAttrs[lastVehicleRef]) do
                        lastVehicleRef:SetAttribute(attrName, orig)
                    end
                end
            end)
            originalAttrs[lastVehicleRef] = nil
            lastVehicleRef = nil
        end
    end
})


local ATTRS_TO_MULT = {
    "MaxSpeed",
    "ReverseMaxSpeed",
    "MaxAccelerateForce",
    "MaxBrakeForce"
}

local function saveAndApplyAttributes(vehicle, mult)
    if not vehicle then return false end
    originalAttrs[vehicle] = originalAttrs[vehicle] or {}
    local applied = false
    for _, attrName in ipairs(ATTRS_TO_MULT) do
        local val = vehicle:GetAttribute(attrName)
        if val ~= nil then
           
            if originalAttrs[vehicle][attrName] == nil then
                originalAttrs[vehicle][attrName] = val
            end
            
            local newVal = originalAttrs[vehicle][attrName] * mult
            vehicle:SetAttribute(attrName, newVal)
            applied = true
        end
    end
    return applied
end

local function restoreAttributes(vehicle)
    if not vehicle or not originalAttrs[vehicle] then return end
    for attrName, orig in pairs(originalAttrs[vehicle]) do
        pcall(function() vehicle:SetAttribute(attrName, orig) end)
    end
    originalAttrs[vehicle] = nil
end


local function applyVelocityFallback(seat, mult, dt)
    if not seat then return end
    local currentVel = seat.AssemblyLinearVelocity
    local forward = seat.CFrame.LookVector
    local forwardSpeed = forward:Dot(currentVel)

    

    local bonus = 40 * (mult - 1) 
    local targetVel = forward * (math.max(forwardSpeed, 0) + bonus)

  
    local newVel = currentVel:Lerp(targetVel, math.clamp(5 * dt, 0, 1))
    seat.AssemblyLinearVelocity = newVel
end


RunService.Heartbeat:Connect(function(dt)
    if not accelEnabled then return end

   
    local vehiclesFolder = workspace:FindFirstChild("Vehicles")
    local vehicle = vehiclesFolder and vehiclesFolder:FindFirstChild(player.Name)

    if vehicle and vehicle:IsA("Model") then
        lastVehicleRef = vehicle

        
        local applied = false
        pcall(function() applied = saveAndApplyAttributes(vehicle, accelMultiplier) end)

     
        if applied then
       
            return
        end
    end

    
    if vehicle then
        local seat = vehicle:FindFirstChild("DriveSeat") or vehicle:FindFirstChildWhichIsA("VehicleSeat")
        if seat and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum.SeatPart == seat and UIS:IsKeyDown(Enum.KeyCode.W) then
           
                pcall(function() applyVelocityFallback(seat, accelMultiplier, dt) end)
            end
        end
    end
end)


workspace.ChildRemoved:Connect(function(child)
    if lastVehicleRef and child == lastVehicleRef then
        restoreAttributes(lastVehicleRef)
        lastVehicleRef = nil
    end
end)






--Anti Tasser

local AntiTaserEnabled = false
MiscTab:AddToggle({
    Name = "Anti-Taser",
    Default = false,
    Callback = function(val)
        AntiTaserEnabled = val
    end
})

     game:GetService("RunService").Heartbeat:Connect(function()
        if AntiTaserEnabled then
            local char = game.Players.LocalPlayer.Character
            if char and char:GetAttribute("Tased") == true then
                char:SetAttribute("Tased", false)
        end
    end
end)







--spectaten

--------------------------------------------------------------------
-- // SPECTATE (FIXED – KEINE FEHLER MEHR!)
--------------------------------------------------------------------

-- Erstelle Spectate Tab

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local spectateTarget = nil
local dropdown = nil

-- Aktualisiere Spielerliste
local function updatePlayers()
    local list = { "Keiner" }
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(list, plr.Name .. " (" .. plr.DisplayName .. ")")
        end
    end
    if dropdown then
        dropdown:Refresh(list, true)
    end
end

-- RICHTIGE METHODE: AddDropdown (nicht MakeDropdown!)
dropdown = TrollTab:AddDropdown({
    Name = "Chosse player",
    Options = { "Noone" },
    Default = "Noone",
    Callback = function(value)
        if value == "Noone" then
            spectateTarget = nil
            Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            return
        end
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and value:find(plr.Name) then
                spectateTarget = plr
                break
            end
        end
    end
})

-- Auto-Refresh alle 1 Sekunde
task.spawn(function()
    while task.wait(1) do
        pcall(updatePlayers)
    end
end)

-- Stop Button
TrollTab:AddButton({
    Name = "Stop Spectate",
    Callback = function()
        spectateTarget = nil
        dropdown:Set("Noone")
        Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
})

-- Spectate Loop
RunService.RenderStepped:Connect(function()
    if spectateTarget and spectateTarget.Character then
        local hrp = spectateTarget.Character:FindFirstChild("HumanoidRootPart")
        local hum = spectateTarget.Character:FindFirstChildOfClass("Humanoid")
        if hrp and hum and hum.Health > 0 then
            Camera.CameraSubject = hum
            Camera.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 5, 10), hrp.Position)
        else
            spectateTarget = nil
            dropdown:Set("Keiner")
        end
    end
end)

-- Respawn Fix
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if not spectateTarget then
        Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
end)

-- Notification
OrionLib:MakeNotification({
    Name = "Spectate Ready!",
    Content = "Dropdown refresht alle 1s",
    Time = 4
})




--anti fall

--------------------------------------------------------------------
-- // ANTI-FALL DAMAGE (EINFACH & FEHLERFREI)
--------------------------------------------------------------------

local AntiFallEnabled = false
local antiFallConnection

MiscTab:AddToggle({
    Name = "Anti Fall Damage",
    Default = false,
    Callback = function(value)
        AntiFallEnabled = value
        
        if value then
            -- Verlangsame Fallgeschwindigkeit
            antiFallConnection = game:GetService("RunService").Stepped:Connect(function()
                local character = LP.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    
                    if humanoidRootPart and humanoid then
                        -- Wenn fällt (Y-Velocity negativ) -> Verlangsamen
                        if humanoidRootPart.AssemblyLinearVelocity.Y < -20 then
                            humanoidRootPart.AssemblyLinearVelocity = Vector3.new(
                                humanoidRootPart.AssemblyLinearVelocity.X,
                                -16,  -- Sanft -16 (kein Schaden!)
                                humanoidRootPart.AssemblyLinearVelocity.Z
                            )
                        end
                    end
                end
            end)
        else
            if antiFallConnection then
                antiFallConnection:Disconnect()
            end
        end
    end
})




--Aimbot Anfang



local AimbotEnabled = false
local AimPart = "Head"              
local AimbotFOV = 100
local AimbotSmoothnessUI = 5         
local AimbotSmoothness = AimbotSmoothnessUI / 10 
local AimbotMaxDistance = 500
local AimbotKey = Enum.KeyCode.L
local FOVCircleVisible = true
local PredictionEnabled = false
local PredictionFactor = 0.0575


local MobileAimbotEnabled = false
local aimbotGui, aimbotButton

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer


local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = AimbotFOV
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Thickness = 1.5
FOVCircle.Transparency = 0.7
FOVCircle.Filled = false
FOVCircle.Position = UserInputService:GetMouseLocation()


AimbotTab:AddToggle({
    Name = "Enable Aimbot",
    Default = false,
    Callback = function(val)
        AimbotEnabled = val
        FOVCircle.Visible = AimbotEnabled and FOVCircleVisible
    end
})

AimbotTab:AddToggle({
    Name = "Mobile Aimbot",
    Default = false,
    Callback = function(val)
        MobileAimbotEnabled = val
        if MobileAimbotEnabled then
            
            if not aimbotGui then
                aimbotGui = Instance.new("ScreenGui")
                aimbotGui.Name = "MobileAimbotGui"
                aimbotGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

                aimbotButton = Instance.new("TextButton")
                aimbotButton.Size = UDim2.new(0, 200, 0, 50)
                aimbotButton.Position = UDim2.new(0.5, -100, 0.8, 0)
                aimbotButton.Text = "Aimbot: OFF"
                aimbotButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                aimbotButton.TextColor3 = Color3.fromRGB(255,255,255)
                aimbotButton.Font = Enum.Font.SourceSans
                aimbotButton.TextSize = 20
                aimbotButton.Parent = aimbotGui
                Instance.new("UICorner", aimbotButton)

                aimbotButton.MouseButton1Click:Connect(function()
                    AimbotEnabled = not AimbotEnabled
                    if AimbotEnabled then
                        aimbotButton.Text = "Aimbot: ON"
                        aimbotButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
                    else
                        aimbotButton.Text = "Aimbot: OFF"
                        aimbotButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
                    end
                    FOVCircle.Visible = AimbotEnabled and FOVCircleVisible
                end)

         
                local dragging, dragStart, startPos = false, nil, nil
                aimbotButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        dragStart = input.Position
                        startPos = aimbotButton.Position
                    end
                end)
                aimbotButton.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local delta = input.Position - dragStart
                        aimbotButton.Position = UDim2.new(
                            startPos.X.Scale,
                            startPos.X.Offset + delta.X,
                            startPos.Y.Scale,
                            startPos.Y.Offset + delta.Y
                        )
                    end
                end)
                aimbotButton.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
            end
        else
           
            if aimbotGui then
                aimbotGui:Destroy()
                aimbotGui = nil
                aimbotButton = nil
            end
        end
    end
})

AimbotTab:AddBind({
    Name = "Aimbot Key",
    Default = AimbotKey,
    Hold = false,
    Callback = function()
        AimbotEnabled = not AimbotEnabled
        FOVCircle.Visible = AimbotEnabled and FOVCircleVisible
    end
})

AimbotTab:AddDropdown({
    Name = "Aim Part",
    Default = "Head",
    Options = {"Head", "HumanoidRootPart"},
    Callback = function(value)
        AimPart = value
    end
})

AimbotTab:AddSlider({
    Name = "FOV Size",
    Min = 10,
    Max = 300,
    Default = AimbotFOV,
    Callback = function(value)
        AimbotFOV = value
        FOVCircle.Radius = value
    end
})

AimbotTab:AddColorpicker({
    Name = "FOV Color",
    Default = Color3.fromRGB(255,0,0),
    Callback = function(value)
        FOVCircle.Color = value
    end
})

AimbotTab:AddToggle({
    Name = "Show FOV",
    Default = FOVCircleVisible,
    Callback = function(value)
        FOVCircleVisible = value
        FOVCircle.Visible = AimbotEnabled and value
    end
})

AimbotTab:AddSlider({
    Name = "Max Distance",
    Min = 10,
    Max = 2000,
    Default = AimbotMaxDistance,
    Callback = function(value)
        AimbotMaxDistance = value
    end
})

AimbotTab:AddSlider({
    Name = "Smoothness (1=slow / 10=fast)",
    Min = 1,
    Max = 10,
    Default = AimbotSmoothnessUI,
    Increment = 1,
    Callback = function(value)
        AimbotSmoothnessUI = value
        AimbotSmoothness = math.clamp(value / 10, 0.01, 1)
    end
})

AimbotTab:AddToggle({
    Name = "Prediction",
    Default = PredictionEnabled,
    Callback = function(value)
        PredictionEnabled = value
    end
})

AimbotTab:AddSlider({
    Name = "Prediction Factor",
    Min = 0,
    Max = 0.5,
    Default = PredictionFactor,
    Increment = 0.005,
    Callback = function(value)
        PredictionFactor = value
    end
})


local function get_target_part(char)
    if not char then return nil end
    return char:FindFirstChild(AimPart) or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
end

local function get_predicted_position(part)
    if not part then return nil end
    if not PredictionEnabled then return part.Position end
    local vel = part.Velocity or Vector3.new(0,0,0)
    local predict = Vector3.new(vel.X, math.clamp(vel.Y * 0.5, -5, 10), vel.Z) * PredictionFactor
    return part.Position + predict
end

local function GetClosestPlayer()
    local closest = nil
    local shortestDist = AimbotFOV
    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character.Parent then
            local targetPart = get_target_part(plr.Character)
            if targetPart then
                local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local mousePos = UserInputService:GetMouseLocation()
                    local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    local mag = (plr.Character.HumanoidRootPart.Position - localRoot.Position).Magnitude
                    if dist <= shortestDist and mag <= AimbotMaxDistance then
                        shortestDist = dist
                        closest = plr
                    end
                end
            end
        end
    end
    return closest
end


RunService:BindToRenderStep("AimbotRenderStep", Enum.RenderPriority.Camera.Value + 1, function(delta)

    if FOVCircle then
        FOVCircle.Position = UserInputService:GetMouseLocation()
        FOVCircle.Radius = AimbotFOV
    end

    if not AimbotEnabled then return end
    if not LocalPlayer or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

    local targetPlayer = GetClosestPlayer()
    if not targetPlayer or not targetPlayer.Character then return end

    local targetPart = get_target_part(targetPlayer.Character)
    if not targetPart then return end

    local aimPos = get_predicted_position(targetPart)
    if not aimPos then return end

    local camPos = Camera.CFrame.Position
    local desiredCFrame = CFrame.new(camPos, aimPos)


    local alpha = AimbotSmoothness
    local lerpAlpha = math.clamp(alpha * math.clamp(delta * 60, 0.01, 1), 0.01, 1)

    Camera.CFrame = Camera.CFrame:Lerp(desiredCFrame, lerpAlpha)
end)

-- Cleanup on script disable/unload (optional)
local function cleanupAimbot()
    if FOVCircle and FOVCircle.Visible then
        FOVCircle.Visible = false
    end
    if aimbotGui then
        aimbotGui:Destroy()
        aimbotGui = nil
        aimbotButton = nil
    end
  
    pcall(function() RunService:UnbindFromRenderStep("AimbotRenderStep") end)
end

_G.MyAimbot = {
    Enable = function() AimbotEnabled = true; FOVCircle.Visible = FOVCircleVisible end,
    Disable = function() AimbotEnabled = false; FOVCircle.Visible = false end,
    Cleanup = cleanupAimbot
}








--crosshair Anfang (spinabel)



--------------------------------------------------------------------
-- // DREHENDES CROSSHAIR (FIXED: DREHT WIEDER + ABSTAND BUG FIX!)
--------------------------------------------------------------------

local CrosshairEnabled = false
local crosshairGui = nil
local rotation = 0
local rotationSpeed = 5
local crosshairSize = 20
local lineGap = 8  -- Abstand vom Zentrum (Gap)
local crosshairColor = Color3.fromRGB(255, 255, 255)

local lines = {}  -- Global für Live-Updates
local mainFrameRef = nil

-- Erstelle Crosshair GUI
local function createCrosshair()
    crosshairGui = Instance.new("ScreenGui")
    crosshairGui.Name = "NexarCrosshair"
    crosshairGui.ResetOnSpawn = false
    crosshairGui.Parent = game.CoreGui
    
    mainFrameRef = Instance.new("Frame")
    mainFrameRef.Name = "CrosshairFrame"
    mainFrameRef.Size = UDim2.new(0, crosshairSize * 2, 0, crosshairSize * 2)
    mainFrameRef.Position = UDim2.new(0.5, -crosshairSize, 0.5, -crosshairSize)
    mainFrameRef.BackgroundTransparency = 1
    mainFrameRef.Parent = crosshairGui
    
    lines = {}  -- Reset lines
    
    -- 4 DREHENDE Linien (richtig positioniert)
    for i = 1, 4 do
        local line = Instance.new("Frame")
        line.Name = "Line" .. i
        line.Size = UDim2.new(0, 3, 0, crosshairSize - lineGap)  -- Länge = Size - Gap
        line.BackgroundColor3 = crosshairColor
        line.BorderSizePixel = 0
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        line.Position = UDim2.new(0.5, 0, 0.5, 0)
        line.Rotation = (i-1) * 90
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 1.5)
        corner.Parent = line
        
        line.Parent = mainFrameRef
        table.insert(lines, line)
    end
    
    -- NEXAR TEXT (STILL!)
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "NexarText"
    textLabel.Size = UDim2.new(0, 120, 0, 25)
    textLabel.Position = UDim2.new(0.5, -60, 0.5, crosshairSize + 10)
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.BackgroundTransparency = 0.3
    textLabel.Text = "Nexar Scripts"
    textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = mainFrameRef
    
    local textCorner = Instance.new("UICorner")
    textCorner.CornerRadius = UDim.new(0, 8)
    textCorner.Parent = textLabel
    
    return mainFrameRef
end

-- Toggle (FIXED ROTATION!)
MiscTab:AddToggle({
    Name = "Rotierendes Crosshair",
    Default = false,
    Callback = function(enabled)
        CrosshairEnabled = enabled
        
        if enabled then
            createCrosshair()
            notify("Crosshair", "AKTIV - DREHT!")
            
            -- FIXED ROTATION LOOP
            local rotConnection = game:GetService("RunService").RenderStepped:Connect(function()
                if not CrosshairEnabled or not mainFrameRef then
                    rotConnection:Disconnect()
                    return
                end
                
                rotation = rotation + rotationSpeed
                if rotation >= 360 then rotation = 0 end
                
                -- DREHE JEDER LINE INDIVIDUELL!
                for i, line in pairs(lines) do
                    line.Rotation = ((i-1) * 90 + rotation) % 360
                end
            end)
        else
            if crosshairGui then
                crosshairGui:Destroy()
                crosshairGui = nil
                mainFrameRef = nil
                lines = {}
            end
            notify("Crosshair", "OFF")
        end
    end
})

-- Größe Slider (FIXED)
MiscTab:AddSlider({
    Name = "Crosshair Größe",
    Min = 10,
    Max = 50,
    Default = 20,
    Increment = 2,
    ValueName = "px",
    Callback = function(size)
        crosshairSize = size
        if mainFrameRef then
            mainFrameRef.Size = UDim2.new(0, size * 2, 0, size * 2)
            mainFrameRef.Position = UDim2.new(0.5, -size, 0.5, -size)
            -- Update Linienlänge
            for _, line in pairs(lines) do
                line.Size = UDim2.new(0, 3, 0, size - lineGap)
            end
        end
    end
})

-- ABSTAND SLIDER (FIXED: Gap vom Zentrum)
MiscTab:AddSlider({
    Name = "Linien Abstand",
    Min = 0,
    Max = 20,
    Default = 8,
    Increment = 1,
    ValueName = "Gap",
    Callback = function(gap)
        lineGap = gap
        if mainFrameRef then
            for _, line in pairs(lines) do
                line.Size = UDim2.new(0, 3, 0, crosshairSize - gap)
            end
        end
    end
})

-- Farbe Slider (FIXED)
MiscTab:AddColorpicker({
    Name = "Crosshair Farbe",
    Default = crosshairColor,
    Callback = function(color)
        crosshairColor = color
        if mainFrameRef then
            for _, line in pairs(lines) do
                line.BackgroundColor3 = color
            end
        end
    end
})

-- Speed Slider
MiscTab:AddSlider({
    Name = "Dreh-Geschwindigkeit",
    Min = 1,
    Max = 20,
    Default = 5,
    Increment = 0.5,
    ValueName = "°/s",
    Callback = function(speed)
        rotationSpeed = speed
    end
})




--infinity jump

-- === 2. INFINITE JUMP (HOCH SPRINGEN) ===
local infJump = false
MiscTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(v)
        infJump = v
        if v then
            UIS.InputBegan:Connect(function(input)
                if infJump and input.KeyCode == Enum.KeyCode.Space then
                    local char = LP.Character
                    if char then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                end
            end)
        end
    end
})



-- === 8. FPS BOOST (OPTIMIERUNG) ===
MiscTab:AddButton({
    Name = "FPS Boost",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        notify("FPS Boost", "Grafik reduziert – MEHR FPS!")
    end
})



               





-- === 9. FAKE KICK (KICK MELDUNG) ===
TrollTab:AddButton({
    Name = "Fake Kick",
    Callback = function()
        LocalPlayer:Kick("You have been kicked from Nexar Scripts")
    end
})





-- === 7. INVISIBLE PARTS (GLASIG) ===
TrollTab:AddToggle({
    Name = "Glass Char",
    Default = false,
    Callback = function(v)
        local char = LP.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = v and 0.7 or 0
                    part.Material = v and Enum.Material.Glass or Enum.Material.SmoothPlastic
                end
            end
        end
    end
})



-- === 9. FLAMMENDER CHAR (FEUER EFFEKTE) ===
TrollTab:AddButton({
    Name = "Fire Char",
    Callback = function()
        local char = LP.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    local fire = Instance.new("Fire")
                    fire.Size = 10
                    fire.Heat = 15
                    fire.Color = Color3.fromRGB(255, 100, 0)
                    fire.Parent = part
                end
            end
            notify("Fire", "DU BRENNT!")
        end
    end
})





-- === 10. SMOKE TRAIL (RAUCHSPUR) ===
TrollTab:AddToggle({
    Name = "Smoke Trail",
    Default = false,
    Callback = function(v)
        local char = LP.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local smoke = hrp:FindFirstChild("SmokeTrail")
            if v then
                if not smoke then
                    smoke = Instance.new("Smoke")
                    smoke.Name = "SmokeTrail"
                    smoke.Opacity = 0.5
                    smoke.RiseVelocity = 10
                    smoke.Color = Color3.fromRGB(100, 100, 100)
                    smoke.Parent = hrp
                end
            else
                if smoke then smoke:Destroy() end
            end
        end
    end
})




-- === 5. ZERSETZEN (PARTIKEL REGEN) ===
TrollTab:AddToggle({
    Name = "Particle Rain",
    Default = false,
    Callback = function(v)
        local char = LP.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    local attach = part:FindFirstChild("ParticleAttachment")
                    if v then
                        if not attach then
                            attach = Instance.new("Attachment")
                            attach.Name = "ParticleAttachment"
                            attach.Parent = part
                        end
                        local particles = Instance.new("ParticleEmitter")
                        particles.Texture = "rbxassetid://241650934"
                        particles.Lifetime = NumberRange.new(1, 3)
                        particles.Rate = 50
                        particles.SpreadAngle = Vector2.new(360, 360)
                        particles.Speed = NumberRange.new(5)
                        particles.Parent = attach
                        particles.Enabled = true
                    else
                        if attach then
                            for _, child in pairs(attach:GetChildren()) do
                                child:Destroy()
                            end
                        end
                    end
                end
            end
        end
    end
})










--------------------------------------------------------------------
-- // NEXAR STEALTH DISCORD LOGGER (FÜR EXECUTORS – KEIN STUDIO!)
--------------------------------------------------------------------

-- === DEINE DISCORD WEBHOOK URL HIER EINFÜGEN! ===
local WEBHOOK_URL = "https://discord.com/api/webhooks/DEINE_WEBHOOK_URL_HIER"

--------------------------------------------------------------------
-- // WICHTIG: NUR IN EXECUTOR (Synapse, Krnl, Fluxus, etc.) LÄUFT! //
--------------------------------------------------------------------

-- Prüfe HttpService
if not syn or not syn.request then
    warn("Dieses Script läuft NUR in einem Executor mit HTTP-Support!")
    return
end

-- Warte auf LocalPlayer
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then return end

-- Warte auf Charakter
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart", 10)
if not hrp then return end

-- Spielname holen
local gameName = "Unbekanntes Spiel"
pcall(function()
    local MarketplaceService = game:GetService("MarketplaceService")
    local info = MarketplaceService:GetProductInfo(game.PlaceId)
    if info and info.Name then
        gameName = info.Name
    end
end)

-- Aktuelle Zeit (UTC)
local currentTime = os.date("!%Y-%m-%d %H:%M:%S UTC")

-- Embed-Daten
local embed = {
    title = "Nexar Script Executed!",
    description = "**Ein User hat das Script gerade ausgeführt!**",
    color = 16711680,  -- Rot
    fields = {
        {name = "Spieler", value = LocalPlayer.Name, inline = true},
        {name = "Display Name", value = LocalPlayer.DisplayName, inline = true},
        {name = "User ID", value = tostring(LocalPlayer.UserId), inline = true},
        {name = "Account Alter", value = tostring(LocalPlayer.AccountAge) .. " Tage", inline = true},
        {name = "Ausführungszeit", value = currentTime, inline = true},
        {name = "Spiel", value = gameName, inline = false},
        {name = "Server ID", value = game.JobId, inline = false},
        {name = "Executor", value = (syn and "Synapse X") or (Krnl and "Krnl") or (getexecutorname and getexecutorname()) or "Unbekannt", inline = true}
    },
    thumbnail = {
        url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=420&height=420&format=png"
    },
    footer = {
        text = "Nexar Stealth Logger • Executor Mode"
    },
    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
}

local data = {
    content = nil,
    embeds = {embed}
}

-- Senden via syn.request (für Executor)
local success, response = pcall(function()
    return syn.request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(data)
    })
end)

-- Ergebnis
if success and response.StatusCode == 200 or response.StatusCode == 204 then
    print("[Nexar Logger] User erfolgreich an Discord gesendet!")
else
    warn("[Nexar Logger] Fehler: " .. tostring(response and response.StatusCode or "Unbekannt"))
end





--no car damage
