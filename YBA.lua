repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
-- variables
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local functions = {}

local properties = {
    autoStand = false,
    canEatRoka = false,
}

local StandsToGet = {
    ["Platinum Sun"] = false, 
    ["White Poison"] = false, 
    ["Violet Fog"] = false, 
    ["Six Pistols"] = false, 
    ["Airsmith"] = false, 
    ["Scarlet King"] = false, 
    ["Golden Spirit"] = false, 
    ["Zipper Fingers"] = false, 
    ["Ms. Vice President"] = false,
    ["Ice Album"] = false,
    ["Ocean Boy"] = false,
    ["That Hand"] = false,
    ["Shining Sapphire"] = false,
    ["Deadly King"] = false,
    ["Yellow Hot Chili Pepper"] = false,
    ["Violet Vine"] = false,
    ["Tentacle Green"] = false,
    ["Grey Rapier"] = false,
    ["Magician's Ember"] = false,
    ["Void"] = false,
    ["The Universe"] = false,
    ["Anubiz"] = false
}

local Stands = {
    "Platinum Sun", 
    "White Poison", 
    "Violet Fog", 
    "Six Pistols", 
    "Airsmith", 
    "Scarlet King", 
    "Golden Spirit", 
    "Zipper Fingers", 
    "Ms. Vice President",
    "Ice Album",
    "Ocean Boy",
    "That Hand",
    "Shining Sapphire",
    "Deadly King",
    "Yellow Hot Chili Pepper",
    "Violet Vine",
    "Tentacle Green",
    "Grey Rapier",
    "Magician's Ember",
    "Void",
    "The Universe",
    "Anubiz"
}

local rokakakaEatTable = {

    ["NPC"] = "Rokakaka",
    ["Option"] = "Option1",
    ["Dialogue"] = "Dialogue2"
 }
 
 local useArrowTable = {
     ["NPC"] = "Mysterious Arrow",
     ["Option"] = "Option1",
     ["Dialogue"] = "Dialogue2"
 }
 

 local kavo = Library.CreateLib("Mos Lord Hub", "BloodTheme")
 local StandsPage = kavo:NewTab("Stands")
 -- functions
functions.addWorthiness = function()
    wait()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character


    -- Vitality
    Character:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Vitality I", ["SkillTreeType"] = "Character"})
    Character:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Vitality II", ["SkillTreeType"] = "Character"})
    Character:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Vitality III", ["SkillTreeType"] = "Character"})
    -- Worthiness
    Character:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Worthiness I", ["SkillTreeType"] = "Character"})
    Character:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Worthiness II", ["SkillTreeType"] = "Character"})
    Character:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Worthiness III", ["SkillTreeType"] = "Character"})
end

functions.EatRoka = function()
    if properties.canEatRoka then
    
        local Player = game.Players.LocalPlayer
        local StandValue = Player.PlayerStats.Stand
        print("oh")     
       if StandsToGet[StandValue.Value] == false then
       
        print("oh2")
        local Character = Player.Character 
    
        Character:WaitForChild("RemoteEvent"):FireServer("EndDialogue", rokakakaEatTable)
        
        spawn(function()
            properties.canEatRoka = false    
            wait(.5)
            properties.canEatRoka = true
        end)
          
        end
    end
end

functions.useArrow = function()
    local Player = game.Players.LocalPlayer
        
    wait(.35)
    local Character = Player.Character
print("arrow used")
    Character:WaitForChild("RemoteEvent"):FireServer("EndDialogue", useArrowTable)
    
    
end

functions.autoStand = function()
   spawn(function()
    while true do wait()
        if properties.autoStand then

            local Player = game.Players.LocalPlayer
        local StandValue = Player.PlayerStats.Stand
            if StandValue.Value == "None" then
                
                properties.canEatRoka = false
                wait(.1)
                functions.addWorthiness()
                wait(.25)
                functions.useArrow()
            end
            if StandValue.Value ~= "None" then
                wait(.25)

                properties.canEatRoka = true
                functions.EatRoka()
            end
        else
            break
        end
    end
   end)
end


local AutoStandsSection = StandsPage:NewSection("Auto Stand")

local autoStandToggle = AutoStandsSection:NewToggle("Auto Stand", "Toggles Auto Stand", function(Value)
  if Value then
        properties.autoStand = true
        
        functions.autoStand()
        print("Auto Stand on")
    else
        properties.autoStand = false
        print("Auto Stand off")
    end
end)

local StandsSection = StandsPage:NewSection("Stands")

for i = 1,#Stands do
    local standToggle = StandsSection:NewToggle(Stands[i], "Stand", function(Value)
        if Value then
            wait()
            StandsToGet[Stands[i]] = true
        else
            wait()
            StandsToGet[Stands[i]] = false
        end
    end)
end