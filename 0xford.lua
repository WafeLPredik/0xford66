--==============================
-- 0XFORD Mobile Hub (Delta Ready) + Key System Online
--==============================
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()
local player = game.Players.LocalPlayer
if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
    player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")
end

-- ======================
-- Mengambil Data Key dari URL JSON
-- ======================
local HttpService = game:GetService("HttpService")
local keyDataUrl = "https://raw.githubusercontent.com/WafeLPredik/0xford66/main/key.json"
local keyData = HttpService:GetAsync(keyDataUrl)
local keyConfig = HttpService:JSONDecode(keyData)

-- Buat Window
local Window = Luna:CreateWindow({
    Name = "0XFORD",
    Subtitle = "",
    LoadingEnabled = true,
    LoadingTitle = "0XFORD",
    LoadingSubtitle = "@0xford66",
    ConfigSettings = { ConfigFolder = "AutoSummitHub" },
    KeySystem = true -- Nyalakan KeySystem
})

-- ======================
-- Key System Online
-- ======================
Window:EnableKeySystem({
    Title = "0XFORD Key",
    Subtitle = "Masukkan Key Anda",
    SaveKey = true,
    KeySettings = keyConfig,
    Callback = function(key)
        local keyInfo = keyConfig[key]
        if not keyInfo then
            return false, "Key tidak valid!"
        end
        if keyInfo.Duration == 0 then
            getgenv().KeyExpire = math.huge
        else
            getgenv().KeyExpire = os.time() + keyInfo.Duration * 24 * 60 * 60
        end
        return true
    end
})

-- ======================
-- Tab Home: Sisa Key
-- ======================
local HomeTab = Window:CreateTab({ Name = "🏠 Home", Icon = "home" })
local KeyLabel = HomeTab:CreateLabel({ Text = "Sisa Key Anda: ❌" })

task.spawn(function()
    while true do
        if getgenv().KeyExpire then
            local remaining = getgenv().KeyExpire - os.time()
            if remaining <= 0 then
                KeyLabel:Set("Key Anda sudah expired!")
            else
                local days = math.floor(remaining / 86400)
                local hours = math.floor((remaining % 86400) / 3600)
                local minutes = math.floor((remaining % 3600) / 60)
                KeyLabel:Set(string.format("Sisa Key Anda: %d Hari %d Jam %d Menit", days, hours, minutes))
            end
        else
            KeyLabel:Set("Sisa Key Anda: ❌")
        end
        task.wait(60)
    end
end)

-- ======================
-- Tab 1: Auto Summit
-- ======================
local SummitTab = Window:CreateTab({ Name = "⛰️ Auto Summit", Icon = "terrain" })

local function createMountToggle(name, checkpoints)
    local label = SummitTab:CreateLabel({ Text = name.." Checkpoint: ❌" })
    getgenv()[name.."Running"] = false

    SummitTab:CreateToggle({
        Name = name,
        CurrentValue = false,
        Callback = function(val)
            getgenv()[name.."Running"] = val
            if val then
                task.spawn(function()
                    local hrp = player.Character:WaitForChild("HumanoidRootPart")
                    while getgenv()[name.."Running"] do
                        for i, cp in ipairs(checkpoints) do
                            hrp.CFrame = CFrame.new(cp)
                            label:Set(name.." Checkpoint: "..i.."/"..#checkpoints)
                            task.wait(0.5)
                        end
                    end
                    label:Set(name.." Checkpoint: ❌")
                end)
            end
        end
    })
    return label
end

-- Mount biasa
createMountToggle("Letaunima", {
    Vector3.new(25.5, 67.292, -721.421),
    Vector3.new(-385.826, 706.942, 985.642)
})
createMountToggle("Atin", {
    Vector3.new(780.575, 2176.612, 3922.718)
})
createMountToggle("Akhirat", {
    Vector3.new(-135.181, 425.768, -220.57),
    Vector3.new(-3, 952.688, -1054),
    Vector3.new(109, 1204.764, -1359),
    Vector3.new(103, 1468.373, -1808),
    Vector3.new(303.773, 1872.025, -2327.932),
    Vector3.new(560.051, 2088.92, -2560.066),
    Vector3.new(754, 2189, -2500),
    Vector3.new(793, 2333, -2641),
    Vector3.new(969, 2521, -2632),
    Vector3.new(1239, 2696, -2798),
    Vector3.new(1622, 3060, -2762),
    Vector3.new(2050, 4304.3, -4117),
    Vector3.new(3470, 4859.8, -4178),
    Vector3.new(3478, 5109, -4279),
    Vector3.new(3975, 5670.5, -3973),
    Vector3.new(4498, 5901.586, -3792),
    Vector3.new(5064, 6375.865, -2979),
    Vector3.new(5539, 6594.5, -2490),
    Vector3.new(5549, 6876.147, -1050),
    Vector3.new(3456.166, 7714.4, 938.19),
    Vector3.new(3041.74, 7893.972, 1037.593)
})
createMountToggle("Konoha", {
    Vector3.new(824.228, 288.087, -579.934),
    Vector3.new(771.723, 518.361, -378.854),
    Vector3.new(-78.058, 475.283, 387.013),
    Vector3.new(179.471, 582.325, 700.312),
    Vector3.new(349.872, 587.384, 819.991),
    Vector3.new(793.55, 812.015, 624.768),
    Vector3.new(926.316, 1019.111, 604.968)
})

-- Semesta ultra-fast
local SemestaLabel = SummitTab:CreateLabel({ Text = "Semesta Checkpoint: ❌" })
getgenv().SemestaRunning = false
SummitTab:CreateToggle({
    Name = "Semesta Fast",
    CurrentValue = false,
    Callback = function(val)
        getgenv().SemestaRunning = val
        if val then
            task.spawn(function()
                local hrp = player.Character:WaitForChild("HumanoidRootPart")
                local basecamp = Vector3.new(2714, 1769, 1513)
                local summitPos = Vector3.new(4547.54883, 3414.06201, 662.14679)
                while getgenv().SemestaRunning do
                    hrp.CFrame = CFrame.new(summitPos + Vector3.new(0,3,0))
                    SemestaLabel:Set("Semesta Checkpoint: Summit")
                    task.wait(0.1)
                    hrp.CFrame = CFrame.new(basecamp + Vector3.new(0,3,0))
                    SemestaLabel:Set("Semesta Checkpoint: Basecamp")
                    task.wait(0.1)
                end
                SemestaLabel:Set("Semesta Checkpoint: ❌")
            end)
        end
    end
})

-- ======================
-- Tab 2: Ability
-- ======================
local AbilityTab = Window:CreateTab({ Name = "⚡ Ability", Icon = "flash_on" })
getgenv().HighJumpPower = 100
getgenv().SpeedBoostPower = 16
getgenv().InfiniteJump = false
getgenv().WallClimb = false
getgenv().Noclip = false
getgenv().DayMode = true

AbilityTab:CreateSlider({ Name = "High Jump", Range = {50,500}, Increment = 10, CurrentValue = 100, Callback = function(val) getgenv().HighJumpPower = val end })
AbilityTab:CreateSlider({ Name = "Speed Boost", Range = {16,100}, Increment = 1, CurrentValue = 16, Callback = function(val) getgenv().SpeedBoostPower = val end })
AbilityTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false, Callback = function(val) getgenv().InfiniteJump = val end })
AbilityTab:CreateToggle({ Name = "Wall Climb", CurrentValue = false, Callback = function(val) getgenv().WallClimb = val end })
AbilityTab:CreateToggle({ Name = "Noclip", CurrentValue = false, Callback = function(val) getgenv().Noclip = val end })
AbilityTab:CreateToggle({ Name = "Day Mode", CurrentValue = true, Callback = function(val)
    getgenv().DayMode = val
    game.Lighting.TimeOfDay = val and "12:00:00" or "00:00:00"
end })

-- Ability functions
game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().InfiniteJump then
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
game:GetService("RunService").Stepped:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = getgenv().HighJumpPower
        char.Humanoid.WalkSpeed = getgenv().SpeedBoostPower
        if getgenv().WallClimb then
            if char.Humanoid.FloorMaterial == Enum.Material.Air then
                char.HumanoidRootPart.Velocity = Vector3.new(0,50,0)
            end
        end
    end
end)
game:GetService("RunService").Stepped:Connect(function()
    if getgenv().Noclip then
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- ======================
-- Tab 3: Misc
-- ======================
local MiscTab = Window:CreateTab({ Name = "🛠️ Misc", Icon = "build" })
MiscTab:CreateToggle({ Name = "No Fog", CurrentValue = false, Callback = function(val) game.Lighting.FogEnd = val and 100000 or 1000 end })
MiscTab:CreateToggle({ Name = "Full Bright", CurrentValue = false, Callback = function(val) game.Lighting.Ambient = val and Color3.fromRGB(255,255,255) or Color3.fromRGB(128,128,128) end })
MiscTab:CreateToggle({ Name = "No Shadows", CurrentValue = false, Callback = function(val) game.Lighting.GlobalShadows = not val end })
MiscTab:CreateToggle({ Name = "Clear Water", CurrentValue = false, Callback = function(val) for _, part in pairs(workspace:GetDescendants()) do if part:IsA("Terrain") then part.WaterTransparency = val and 1 or 0 end end end })
MiscTab:CreateToggle({ Name = "Fast Particles", CurrentValue = false, Callback = function(val) for _, effect in pairs(workspace:GetDescendants()) do if effect:IsA("ParticleEmitter") or effect:IsA("Trail") then effect.Enabled = not val end end end })
MiscTab:CreateToggle({ Name = "No Skybox", CurrentValue = false, Callback = function(val) for _, bg in pairs(game.Lighting:GetDescendants()) do if bg:IsA("Sky") then bg:Destroy() end end end })

-- ======================
-- Theme & Config Tabs
-- ======================
local ThemeTab = Window:CreateTab({ Name = "🎨 Theme", Icon = "palette" })
ThemeTab:BuildThemeSection()
local ConfigTab = Window:CreateTab({ Name = "⚙️ Config", Icon = "settings" })
ConfigTab:BuildConfigSection()

-- ======================
-- Notification
-- ======================
Luna:Notification({
    Title = "0XFORD Mobile Loaded",
    Icon = "notifications_active",
    ImageSource = "Material",
    Content = "Auto Summit + Ability + Misc ready to use!"
})
