local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Manny's Script [V1.0]", HidePremium = false, SaveConfig = true, IntroEnabled = false})

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local toggleActive = false

local function disableCollisions(model)
    for _, part in pairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- Function to bring all zombies to the player's character
local function bringZombies()
    local enemiesFolder = workspace:FindFirstChild("enemies") -- Lowercase "enemies"
    if not enemiesFolder then
        warn("enemies folder not found!")
        return
    end

    for _, zombie in pairs(enemiesFolder:GetChildren()) do
        if zombie:IsA("Model") and zombie:FindFirstChild("HumanoidRootPart") then
            -- Disable collisions for the zombie
            disableCollisions(zombie)

            -- Move zombie to the front of the player's character
            zombie.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        end
    end
end


OrionLib:MakeNotification({
	Name = "Notification",
	Content = "Manny's Script successfully loaded.",
	Image = "rbxassetid://4483345998",
	Time = 5
})

local Tab = Window:MakeTab({
	Name = "Welcome",
	Icon = "rbxassetid://17829948098",
	PremiumOnly = false
})

Tab:AddParagraph("Thank you for using Manny's Script!","I hope you have fun using my script.")
Tab:AddLabel("Version 1.0")

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://18719810838",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "Safe spot",
    Callback = function()
        -- Define player and character
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")

        -- Platform creation and teleport function
        local function createPlatformAndTeleport()
            -- Define platform properties
            local platformSize = Vector3.new(50, 1, 50)
            local platformPosition = Vector3.new(10000, 100, 10000) -- Far away from the map

            -- Create the platform
            local platform = Instance.new("Part")
            platform.Size = platformSize
            platform.Position = platformPosition
            platform.Anchored = true
            platform.Color = Color3.new(0.5, 0.5, 0.5) -- Gray color
            platform.Name = "TeleportPlatform"
            platform.Parent = workspace

            -- Teleport the player to the platform
            rootPart.CFrame = CFrame.new(platform.Position + Vector3.new(0, 3, 0)) -- Offset to place above the platform
        end

        -- Execute the function
        createPlatformAndTeleport()
    end    
})

Tab:AddToggle({
    Name = "Bring Zombies",
    Default = false,
    Callback = function(Value)
        toggleActive = Value -- Update toggle state
        if toggleActive then
            -- Run until toggle is turned off
            while toggleActive do
                bringZombies()
                wait(0.1) -- Adjust delay as needed to control performance
            end
        end
    end    
})


Tab:AddSlider({
	Name = "Walkspeed",
	Min = 16,
	Max = 100,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(s)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
	end    
})

Tab:AddSlider({
	Name = "Jump Power",
	Min = 50,
	Max = 150,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(x)
		 game.Players.LocalPlayer.Character.Humanoid.JumpPower = x
	end    
})

OrionLib:Init()
