local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end)

if not success then
    warn("Failed to load Kavo UI. Check your executor or internet.")
    return
end

local Window = Library.CreateLib("Bubble Gum Simulator INFINITY By Green Land", "Ocean")

-- Variables
local player = game:GetService("Players").LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local remoteEvent
local remoteFunction
local autoBlowEnabled = false
local autoSellEnabled = false
local autoSellV2Enabled = false
local autoHatchEnabled = false
local autoClaimEnabled = false
local autoGumPurchaseEnabled = false
local autoStoragePurchaseEnabled = false
local autoUpgradePetsEnabled = false
local autoUpgradeBuffsEnabled = false
local autoClaimPlaytimeEnabled = false
local autoClaimSeasonEnabled = false
local autoArcadeRewardsEnabled = false
local autoClaimChestEnabled = false
local autoClaimVoidChestEnabled = false
local autoFreeSpinEnabled = false
local autoWheelSpinEnabled = false
local autoClaimRayGiftEnabled = false -- New variable for Ray Gift
local autoUnlockGoldenChestEnabled = false -- New variable for Golden Chest
local infiniteJumpEnabled = false
local sellDelay = 1
local hatchDelay = 0.3
local claimDelay = 0.5
local gumPurchaseDelay = 0.5
local storagePurchaseDelay = 0.5
local upgradeDelay = 0.5
local buffsUpgradeDelay = 0.5
local playtimeClaimDelay = 0.5
local seasonClaimDelay = 0.5
local arcadeClaimDelay = 0.5
local chestClaimDelay = 0.3
local voidChestClaimDelay = 0.3
local freeSpinDelay = 0.3
local wheelSpinDelay = 0.3
local rayGiftClaimDelay = 0.3 -- New variable for Ray Gift delay
local goldenChestUnlockDelay = 0.3 -- New variable for Golden Chest delay
local walkSpeed = 16
local selectedEgg = "Spotted Egg"
local eggTypes = {"Spotted Egg", "Iceshard Egg", "Spikey Egg", "Magma Egg", "Crystal Egg", "Lunar Egg", "Void Egg", "Hell Egg", "Nightmare Egg", "Rainbow Egg"}

-- Find remote
local success, err = pcall(function()
    remoteEvent = replicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
    remoteFunction = replicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function")
end)

if not success then
    warn("Failed to find remote. Game may have updated.")
    return
end

-- Remote args
local blowArgs = {"BlowBubble"}
local sellArgs = {"SellBubble"}
local sellV2Args = {"SellBubble"}
local hatchArgs = {
    ["Spotted Egg"] = {"HatchEgg", "Spotted Egg", 1},
    ["Iceshard Egg"] = {"HatchEgg", "Iceshard Egg", 1},
    ["Spikey Egg"] = {"HatchEgg", "Spikey Egg", 1},
    ["Magma Egg"] = {"HatchEgg", "Magma Egg", 1},
    ["Crystal Egg"] = {"HatchEgg", "Crystal Egg", 1},
    ["Lunar Egg"] = {"HatchEgg", "Lunar Egg", 1},
    ["Void Egg"] = {"HatchEgg", "Void Egg", 1},
    ["Hell Egg"] = {"HatchEgg", "Hell Egg", 1},
    ["Nightmare Egg"] = {"HatchEgg", "Nightmare Egg", 1},
    ["Rainbow Egg"] = {"HatchEgg", "Rainbow Egg", 1}
}
local equipBestArgs = {"EquipBestPets"}
local gumPurchaseArgs = {
    {"GumShopPurchase", "Cherry"},
    {"GumShopPurchase", "Pizza"},
    {"GumShopPurchase", "Watermelon"},
    {"GumShopPurchase", "Chocolate"},
    {"GumShopPurchase", "Contrast"},
    {"GumShopPurchase", "Gold"},
    {"GumShopPurchase", "Lemon"},
    {"GumShopPurchase", "Donut"},
    {"GumShopPurchase", "Swirl"},
    {"GumShopPurchase", "Molten"}
}
local storagePurchaseArgs = {
    {"GumShopPurchase", "Chewy Gum"},
    {"GumShopPurchase", "Epic Gum"},
    {"GumShopPurchase", "Ultra Gum"},
    {"GumShopPurchase", "Omega Gum"},
    {"GumShopPurchase", "Unreal Gum"},
    {"GumShopPurchase", "Cosmic Gum"},
    {"GumShopPurchase", "XL Gum"},
    {"GumShopPurchase", "Mega Gum"},
    {"GumShopPurchase", "Quantum Gum"},
    {"GumShopPurchase", "Alien Gum"},
    {"GumShopPurchase", "Radioactive Gum"},
    {"GumShopPurchase", "Experiment #52"}
}
local openAlienShopArgs = {"OpenShop", "alien-shop"}
local upgradePetsArgs = {"UpgradeMastery", "Pets"}
local seasonClaimArgs = {"ClaimSeason"}
local chestClaimArgs = {"ClaimChest", "Giant Chest"}
local voidChestClaimArgs = {"ClaimChest", "Void Chest"}
local freeSpinArgs = {"ClaimFreeWheelSpin"}
local wheelSpinArgs = {"WheelSpin"}
local wheelQueueArgs = {"ClaimWheelSpinQueue"}
local rayGiftArgs = {"ClaimRiftGift", "gift-rift"} -- New args for Ray Gift
local goldenChestArgs = {"UnlockRiftChest", "golden-chest"} -- New args for Golden Chest

-- Auto Blow Bubble Function
local function blowBubble()
    if autoBlowEnabled then
        pcall(function()
            remoteEvent:FireServer(unpack(blowArgs))
        end)
    end
end

-- Auto Sell Function
local function autoSell()
    if autoSellEnabled then
        pcall(function()
            remoteEvent:FireServer(unpack(sellArgs))
        end)
    end
end

-- Auto Sell V2 Function (Works in Twilight)
local function autoSellV2()
    if autoSellV2Enabled then
        pcall(function()
            remoteEvent:FireServer(unpack(sellV2Args))
        end)
    end
end

-- Hatch Egg Function
local function hatchEgg(eggType)
    if hatchArgs[eggType] then
        pcall(function()
            remoteEvent:FireServer(unpack(hatchArgs[eggType]))
        end)
    end
end

-- Auto Hatch Function
local function autoHatch()
    if autoHatchEnabled then
        hatchEgg(selectedEgg)
    end
end

-- Auto Claim Rewards Function
local function autoClaim()
    if autoClaimEnabled then
        for i = 1, 10 do
            pcall(function()
                local claimArgs = {"ClaimPrize", i}
                remoteEvent:FireServer(unpack(claimArgs))
            end)
        end
    end
end

-- Auto Claim Playtime Function
local function autoClaimPlaytime()
    if autoClaimPlaytimeEnabled then
        for i = 1, 9 do
            pcall(function()
                local playtimeArgs = {"ClaimPlaytime", i}
                remoteFunction:InvokeServer(unpack(playtimeArgs))
            end)
        end
    end
end

-- Auto Claim Season Function
local function autoClaimSeason()
    if autoClaimSeasonEnabled then
        pcall(function()
            remoteEvent:FireServer(unpack(seasonClaimArgs))
        end)
    end
end

-- Auto Arcade Rewards Function
local function autoArcadeRewards()
    if autoArcadeRewardsEnabled then
        for i = 1, 3 do
            pcall(function()
                local arcadeArgs = {"DoggyJumpWin", i}
                remoteEvent:FireServer(unpack(arcadeArgs))
            end)
        end
    end
end

-- Auto Claim Chest Function
local function autoClaimChest()
    if autoClaimChestEnabled then
        pcall(function()
            remoteEvent:FireServer(unpack(chestClaimArgs))
        end)
    end
end

-- Auto Claim Void Chest Function
local function autoClaimVoidChest()
    if autoClaimVoidChestEnabled then
        pcall(function()
            remoteEvent:FireServer(unpack(voidChestClaimArgs))
        end)
    end
end

-- Auto Claim Ray Gift Function (New)
local function autoClaimRayGift()
    if autoClaimRayGiftEnabled then
        pcall(function()
            remoteEvent:FireServer(unpack(rayGiftArgs))
        end)
    end
end

-- Auto Unlock Golden Chest Function (New)
local function autoUnlockGoldenChest()
    if autoUnlockGoldenChestEnabled then
        pcall(function()
            remoteEvent:FireServer(unpack(goldenChestArgs))
        end)
    end
end

-- Auto Free Spin Function
local function autoFreeSpin()
    if autoFreeSpinEnabled then
        pcall(function()
            remoteEvent:FireServer(unpack(freeSpinArgs))
        end)
    end
end

-- Auto Wheel Spin and Claim Function
local function autoWheelSpin()
    if autoWheelSpinEnabled then
        pcall(function()
            remoteFunction:InvokeServer(unpack(wheelSpinArgs))
            remoteEvent:FireServer(unpack(wheelQueueArgs))
        end)
    end
end

-- Equip Best Pets Function
local function equipBestPets()
    pcall(function()
        remoteEvent:FireServer(unpack(equipBestArgs))
    end)
end

-- Auto Gum Purchase Function
local function autoPurchaseGum()
    if autoGumPurchaseEnabled then
        for _, args in ipairs(gumPurchaseArgs) do
            pcall(function()
                remoteEvent:FireServer(unpack(args))
            end)
        end
    end
end

-- Auto Storage Purchase Function
local function autoPurchaseStorage()
    if autoStoragePurchaseEnabled then
        for _, args in ipairs(storagePurchaseArgs) do
            pcall(function()
                remoteEvent:FireServer(unpack(args))
            end)
        end
    end
end

-- Auto Upgrade Pets Function
local function autoUpgradePets()
    if autoUpgradePetsEnabled then
        pcall(function()
            remoteEvent:FireServer(unpack(upgradePetsArgs))
        end)
    end
end

-- Auto Upgrade Buffs Function
local function autoUpgradeBuffs()
    if autoUpgradeBuffsEnabled then
        pcall(function()
            local args = {"UpgradeMastery", "Buffs"}
            remoteEvent:FireServer(unpack(args))
        end)
    end
end

-- Open Alien Shop Function
local function openAlienShop()
    pcall(function()
        remoteEvent:FireServer(unpack(openAlienShopArgs))
    end)
end

-- Walk Speed Function
local function setWalkSpeed(speed)
    pcall(function()
        if not player.Character then
            player.CharacterAppearanceLoaded:Wait()
        end
        local character = player.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
        else
            warn("Failed to set walk speed: Humanoid not found in player's character.")
        end
    end)
end

-- Infinite Jump Function
local function setupInfiniteJump()
    userInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled and player.Character then
            pcall(function()
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end)
end

-- Main Tab
local MainTab = Window:NewTab("Main")

-- Automation Section
local AutoSection = MainTab:NewSection("Automation")

-- Auto Blow Toggle
AutoSection:NewToggle("Auto Blow Bubble", "Blows bubbles automatically", function(state)
    autoBlowEnabled = state
    if state then
        task.spawn(function()
            while autoBlowEnabled do
                blowBubble()
                task.wait(0.1)
            end
        end)
    end
end)

-- Auto Sell Toggle
AutoSection:NewToggle("Auto Sell Bubble", "Sells bubbles automatically", function(state)
    autoSellEnabled = state
    if state then
        task.spawn(function()
            while autoSellEnabled do
                autoSell()
                task.wait(sellDelay)
            end
        end)
    end
end)

-- Auto Sell V2 Toggle
AutoSection:NewToggle("Auto Sell V2 Bubble", "Sells bubbles automatically (Works in Twilight)", function(state)
    autoSellV2Enabled = state
    if state then
        task.spawn(function()
            while autoSellV2Enabled do
                autoSellV2()
                task.wait(sellDelay)
            end
        end)
    end
end)

-- Sell Delay Slider
AutoSection:NewSlider("Sell Delay", "Seconds between sells", 100, 1, function(value)
    sellDelay = value
end)

-- Rewards Section
local RewardsSection = MainTab:NewSection("Rewards")

-- Auto Claim Toggle
RewardsSection:NewToggle("Auto Claim Rewards", "Claims all rewards automatically", function(state)
    autoClaimEnabled = state
    if state then
        task.spawn(function()
            while autoClaimEnabled do
                autoClaim()
                task.wait(claimDelay)
            end
        end)
    end
end)

-- Claim Delay Slider
RewardsSection:NewSlider("Claim Delay", "Seconds between claim attempts", 5, 0.5, function(value)
    claimDelay = value
end)

-- Auto Claim Playtime Toggle
RewardsSection:NewToggle("Auto Claim Playtime", "Claims playtime rewards automatically", function(state)
    autoClaimPlaytimeEnabled = state
    if state then
        task.spawn(function()
            while autoClaimPlaytimeEnabled do
                autoClaimPlaytime()
                task.wait(playtimeClaimDelay)
            end
        end)
    end
end)

-- Playtime Claim Delay Slider
RewardsSection:NewSlider("Playtime Claim Delay", "Seconds between playtime claims", 5, 0.5, function(value)
    playtimeClaimDelay = value
end)

-- Auto Claim Season Toggle
RewardsSection:NewToggle("Auto Claim Season", "Claims season rewards automatically", function(state)
    autoClaimSeasonEnabled = state
    if state then
        task.spawn(function()
            while autoClaimSeasonEnabled do
                autoClaimSeason()
                task.wait(seasonClaimDelay)
            end
        end)
    end
end)

-- Season Claim Delay Slider
RewardsSection:NewSlider("Season Claim Delay", "Seconds between season claims", 5, 0.5, function(value)
    seasonClaimDelay = value
end)

-- Auto Arcade Rewards Toggle
RewardsSection:NewToggle("Arcade Game Rewards", "Claims arcade rewards automatically", function(state)
    autoArcadeRewardsEnabled = state
    if state then
        task.spawn(function()
            while autoArcadeRewardsEnabled do
                autoArcadeRewards()
                task.wait(arcadeClaimDelay)
            end
        end)
    end
end)

-- Arcade Claim Delay Slider
RewardsSection:NewSlider("Arcade Claim Delay", "Seconds between arcade claims", 5, 0.5, function(value)
    arcadeClaimDelay = value
end)

-- Auto Claim Chest Toggle
RewardsSection:NewToggle("Auto Claim Giant Chest", "Claims Giant Chest automatically", function(state)
    autoClaimChestEnabled = state
    if state then
        task.spawn(function()
            while autoClaimChestEnabled do
                autoClaimChest()
                task.wait(chestClaimDelay)
            end
        end)
    end
end)

-- Chest Claim Delay Slider
RewardsSection:NewSlider("Chest Claim Delay", "Seconds between chest claims", 3, 0.3, function(value)
    chestClaimDelay = value
end)

-- Auto Claim Void Chest Toggle
RewardsSection:NewToggle("Auto Claim Void Chest", "Claims Void Chest automatically", function(state)
    autoClaimVoidChestEnabled = state
    if state then
        task.spawn(function()
            while autoClaimVoidChestEnabled do
                autoClaimVoidChest()
                task.wait(voidChestClaimDelay)
            end
        end)
    end
end)

-- Void Chest Claim Delay Slider
RewardsSection:NewSlider("Void Chest Claim Delay", "Seconds between void chest claims", 3, 0.3, function(value)
    voidChestClaimDelay = value
end)

-- Auto Claim Ray Gift Toggle (New)
RewardsSection:NewToggle("Auto Claim Ray Gift", "Claims Ray Gift automatically", function(state)
    autoClaimRayGiftEnabled = state
    if state then
        task.spawn(function()
            while autoClaimRayGiftEnabled do
                autoClaimRayGift()
                task.wait(rayGiftClaimDelay)
            end
        end)
    end
end)

-- Ray Gift Claim Delay Slider (New)
RewardsSection:NewSlider("Ray Gift Claim Delay", "Seconds between ray gift claims", 3, 0.3, function(value)
    rayGiftClaimDelay = value
end)

-- Auto Unlock Golden Chest Toggle (New)
RewardsSection:NewToggle("Auto Unlock Golden Chest", "Unlocks Golden Chest automatically", function(state)
    autoUnlockGoldenChestEnabled = state
    if state then
        task.spawn(function()
            while autoUnlockGoldenChestEnabled do
                autoUnlockGoldenChest()
                task.wait(goldenChestUnlockDelay)
            end
        end)
    end
end)

-- Golden Chest Unlock Delay Slider (New)
RewardsSection:NewSlider("Golden Chest Unlock Delay", "Seconds between golden chest unlocks", 3, 0.3, function(value)
    goldenChestUnlockDelay = value
end)

-- Note for Golden Chest (New)
RewardsSection:NewLabel("Note: Activate Golden Chest when you have a Golden Key")

-- Auto Free Spin Toggle
RewardsSection:NewToggle("Auto Claim Free Spin", "Claims free wheel spin automatically", function(state)
    autoFreeSpinEnabled = state
    if state then
        task.spawn(function()
            while autoFreeSpinEnabled do
                autoFreeSpin()
                task.wait(freeSpinDelay)
            end
        end)
    end
end)

-- Free Spin Delay Slider
RewardsSection:NewSlider("Free Spin Delay", "Seconds between free spin claims", 3, 0.3, function(value)
    freeSpinDelay = value
end)

-- Auto Wheel Spin Toggle
RewardsSection:NewToggle("Auto Wheel Spin & Claim", "Spins wheel and claims rewards automatically", function(state)
    autoWheelSpinEnabled = state
    if state then
        task.spawn(function()
            while autoWheelSpinEnabled do
                autoWheelSpin()
                task.wait(wheelSpinDelay)
            end
        end)
    end
end)

-- Wheel Spin Delay Slider
RewardsSection:NewSlider("Wheel Spin Delay", "Seconds between wheel spins", 3, 0.3, function(value)
    wheelSpinDelay = value
end)

-- Equip Best Pets Button
RewardsSection:NewButton("Equip Best Pets", "Equips your best pets", function()
    equipBestPets()
end)

-- Shop Tab
local ShopTab = Window:NewTab("Shop")

-- Gum Shop Section
local GumShopSection = ShopTab:NewSection("Gum Shop")

-- Auto Gum Purchase Toggle
GumShopSection:NewToggle("Auto Purchase Gum", "Purchases all gum types", function(state)
    autoGumPurchaseEnabled = state
    if state then
        task.spawn(function()
            while autoGumPurchaseEnabled do
                autoPurchaseGum()
                task.wait(gumPurchaseDelay)
            end
        end)
    end
end)

-- Gum Purchase Delay Slider
GumShopSection:NewSlider("Gum Purchase Delay", "Seconds between purchases", 5, 0.5, function(value)
    gumPurchaseDelay = value
end)

-- Storage Shop Section
local StorageShopSection = ShopTab:NewSection("Storage Shop")

-- Auto Storage Purchase Toggle
StorageShopSection:NewToggle("Auto Purchase Storage", "Purchases all storage types", function(state)
    autoStoragePurchaseEnabled = state
    if state then
        task.spawn(function()
            while autoStoragePurchaseEnabled do
                autoPurchaseStorage()
                task.wait(storagePurchaseDelay)
            end
        end)
    end
end)

-- Storage Purchase Delay Slider
StorageShopSection:NewSlider("Storage Purchase Delay", "Seconds between purchases", 5, 0.5, function(value)
    storagePurchaseDelay = value
end)

-- Alien Shop Section
local AlienShopSection = ShopTab:NewSection("Alien Shop")

-- Open Alien Shop Button
AlienShopSection:NewButton("Open Alien Shop", "Opens the Alien Shop", function()
    openAlienShop()
end)

-- Upgrades Section
local UpgradesSection = ShopTab:NewSection("Upgrades")

-- Auto Upgrade Pets Toggle
UpgradesSection:NewToggle("Auto Upgrade Pets", "Upgrades pets automatically", function(state)
    autoUpgradePetsEnabled = state
    if state then
        task.spawn(function()
            while autoUpgradePetsEnabled do
                autoUpgradePets()
                task.wait(upgradeDelay)
            end
        end)
    end
end)

-- Upgrade Delay Slider
UpgradesSection:NewSlider("Upgrade Delay", "Seconds between upgrades", 5, 0.5, function(value)
    upgradeDelay = value
end)

-- Auto Upgrade Buffs Toggle
UpgradesSection:NewToggle("Auto Upgrade Buffs", "Upgrades buffs automatically", function(state)
    autoUpgradeBuffsEnabled = state
    if state then
        task.spawn(function()
            while autoUpgradeBuffsEnabled do
                autoUpgradeBuffs()
                task.wait(buffsUpgradeDelay)
            end
        end)
    end
end)

-- Buffs Upgrade Delay Slider
UpgradesSection:NewSlider("Buffs Upgrade Delay", "Seconds between buffs upgrades", 5, 0.5, function(value)
    buffsUpgradeDelay = value
end)

-- Egg Hatching Tab
local EggTab = Window:NewTab("Egg Hatching")

-- Egg Hatching Section
local HatchSection = EggTab:NewSection("Egg Controls")

-- Egg Selection Dropdown
HatchSection:NewDropdown("Select Egg", "Choose egg to hatch", eggTypes, function(value)
    selectedEgg = value
end)

-- Auto Hatch Toggle
HatchSection:NewToggle("Auto Hatch Egg", "Hatches selected egg automatically", function(state)
    autoHatchEnabled = state
    if state then
        task.spawn(function()
            while autoHatchEnabled do
                autoHatch()
                task.wait(hatchDelay)
            end
        end)
    end
end)

-- Hatch Delay Slider
HatchSection:NewSlider("Hatch Delay", "Seconds between hatches", 5, 0.3, function(value)
    hatchDelay = value
end)

-- Manual Hatch Buttons
HatchSection:NewButton("Hatch Spotted Egg", "Hatch one Spotted Egg", function()
    hatchEgg("Spotted Egg")
end)

HatchSection:NewButton("Hatch Iceshard Egg", "Hatch one Iceshard Egg", function()
    hatchEgg("Iceshard Egg")
end)

HatchSection:NewButton("Hatch Spikey Egg", "Hatch one Spikey Egg", function()
    hatchEgg("Spikey Egg")
end)

HatchSection:NewButton("Hatch Magma Egg", "Hatch one Magma Egg", function()
    hatchEgg("Magma Egg")
end)

HatchSection:NewButton("Hatch Crystal Egg", "Hatch one Crystal Egg", function()
    hatchEgg("Crystal Egg")
end)

HatchSection:NewButton("Hatch Lunar Egg", "Hatch one Lunar Egg", function()
    hatchEgg("Lunar Egg")
end)

HatchSection:NewButton("Hatch Void Egg", "Hatch one Void Egg", function()
    hatchEgg("Void Egg")
end)

HatchSection:NewButton("Hatch Hell Egg", "Hatch one Hell Egg", function()
    hatchEgg("Hell Egg")
end)

HatchSection:NewButton("Hatch Nightmare Egg", "Hatch one Nightmare Egg", function()
    hatchEgg("Nightmare Egg")
end)

HatchSection:NewButton("Hatch Rainbow Egg", "Hatch one Rainbow Egg", function()
    hatchEgg("Rainbow Egg")
end)

-- Teleport Tab
local TeleportTab = Window:NewTab("Teleport")

-- Islands Section
local IslandsSection = TeleportTab:NewSection("Islands")

-- Teleport Buttons
IslandsSection:NewButton("Main City", "Teleport to Main City", function()
    pcall(function()
        local teleportArgs = {"Teleport", "Workspace.Worlds.The Overworld.PortalSpawn"}
        remoteEvent:FireServer(unpack(teleportArgs))
    end)
end)

IslandsSection:NewButton("Floating Island", "Teleport to Floating Island", function()
    pcall(function()
        local teleportArgs = {"Teleport", "Workspace.Worlds.The Overworld.Islands.Floating Island.Island.Portal.Spawn"}
        remoteEvent:FireServer(unpack(teleportArgs))
    end)
end)

IslandsSection:NewButton("Outer Space", "Teleport to Outer Space", function()
    pcall(function()
        local teleportArgs = {"Teleport", "Workspace.Worlds.The Overworld.Islands.Outer Space.Island.Portal.Spawn"}
        remoteEvent:FireServer(unpack(teleportArgs))
    end)
end)

IslandsSection:NewButton("Twilight", "Teleport to Twilight", function()
    pcall(function()
        local teleportArgs = {"Teleport", "Workspace.Worlds.The Overworld.Islands.Twilight.Island.Portal.Spawn"}
        remoteEvent:FireServer(unpack(teleportArgs))
    end)
end)

IslandsSection:NewButton("The Void", "Teleport to The Void", function()
    pcall(function()
        local teleportArgs = {"Teleport", "Workspace.Worlds.The Overworld.Islands.The Void.Island.Portal.Spawn"}
        remoteEvent:FireServer(unpack(teleportArgs))
    end)
end)

IslandsSection:NewButton("Zen", "Teleport to Zen", function()
    pcall(function()
        local teleportArgs = {"Teleport", "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn"}
        remoteEvent:FireServer(unpack(teleportArgs))
    end)
end)

-- Misc Tab
local MiscTab = Window:NewTab("Misc")

-- Misc Section
local MiscSection = MiscTab:NewSection("Player Modifications")

-- Walk Speed Slider
MiscSection:NewSlider("Walk Speed", "Adjust player walk speed", 100, 16, function(value)
    walkSpeed = value
    setWalkSpeed(walkSpeed)
end)

-- Infinite Jump Toggle
MiscSection:NewToggle("Infinite Jump", "Allows jumping in mid-air", function(state)
    infiniteJumpEnabled = state
    if state then
        setupInfiniteJump()
    end
end)

-- Settings Tab
local SettingsTab = Window:NewTab("Settings")

-- Script Settings Section
local SettingsSection = SettingsTab:NewSection("Script Settings")

-- Server Hop Button
SettingsSection:NewButton("Server Hop", "Joins a new server", function()
    pcall(function()
        local teleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        teleportService:Teleport(placeId, player)
    end)
end)

-- Unload Hack Button
SettingsSection:NewButton("Unload Hack", "Destroys the UI and stops the script", function()
    pcall(function()
        autoBlowEnabled = false
        autoSellEnabled = false
        autoSellV2Enabled = false
        autoHatchEnabled = false
        autoClaimEnabled = false
        autoGumPurchaseEnabled = false
        autoStoragePurchaseEnabled = false
        autoUpgradePetsEnabled = false
        autoUpgradeBuffsEnabled = false
        autoClaimPlaytimeEnabled = false
        autoClaimSeasonEnabled = false
        autoArcadeRewardsEnabled = false
        autoClaimChestEnabled = false
        autoClaimVoidChestEnabled = false
        autoFreeSpinEnabled = false
        autoWheelSpinEnabled = false
        autoClaimRayGiftEnabled = false -- Added to stop Ray Gift loop
        autoUnlockGoldenChestEnabled = false -- Added to stop Golden Chest loop
        infiniteJumpEnabled = false
        Window:Destroy()
    end)
end)

-- Discord Link Button
SettingsSection:NewButton("Discord Link", "Copies the Discord link to clipboard", function()
    pcall(function()
        local discordLink = "https://discord.gg/GmpPDF9MK5"
        setclipboard(discordLink)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Discord Link",
            Text = "Link copied to clipboard!",
            Duration = 3
        })
    end)
end)

-- Notification
AutoSection:NewLabel("Script Created By Green Land")
