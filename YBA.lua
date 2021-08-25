  repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
  local player = game.Players.LocalPlayer
  local char = player.Character or player.CharacterAdded:Wait()
  local hrp = char:WaitForChild("HumanoidRootPart")
  local hum = char:WaitForChild("Humanoid")
  local runService = game:GetService("RunService")
  local virtualUser = game:GetService("VirtualUser")
  local mouse = player:GetMouse()
  local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()
  local RemoteEvent = char:WaitForChild("RemoteEvent")
  local Quest = player.PlayerStats.Quest
  local repStorage = game:GetService("ReplicatedStorage")
  local Living = workspace.Living
  local ItemSpawns = workspace["Item_Spawns"]
  local ts = game:GetService("TweenService")

  getgenv().standAttachTarget = "None"
  getgenv().item = "none"
  _G.canwalkspeed = false
  _G.canjump = false
  local walkspeed = 16
  local jumpPower = 50

  local attachdistance = 0

  local properties = {

      autoStory = false,
      autoAttach = false,
      autoStand = false,
      shinyFarm = false,
      autoArcade = false,
      itemFarm = false,
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

local autoArcadeTable = {
  ["NPC"] = "Item Machine",
  ["Option"] = "Option1",
  ["Dialogue"] = "Dialogue1"
}

local webhookcheck =
is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
secure_load and "Sentinel" or
KRNL_LOADED and "Krnl" or
SONA_LOADED and "Sona" or
"Kid with shit exploit"
 
function weebhookjoin()
  local url = "https://discord.com/api/webhooks/880015862197805056/M-BwuctaZNb_H1VAwG-__xUPXQF-sg71ujlHXY1TMTztWeTzTJqmj21BE6tGKH8sTh4Y"
 
local data = {
   ["content"] = "nothing here",
   ["embeds"] = {
       {
           ["title"] = "**WRY**",
           ["description"] = "Username: " .. game.Players.LocalPlayer.Name.." with **"..webhookcheck.."**",
           ["type"] = "rich",
           ["color"] = tonumber(0x7269da),
           ["image"] = {
               ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                   tostring(game:GetService("Players").LocalPlayer.Name)
           }
       }
   }
}

local newdata = game:GetService("HttpService"):JSONEncode(data)
 
local headers = {
   ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)
end

weebhookjoin()

function weebhookshiny(Skin)
   
  local url = "https://discord.com/api/webhooks/880015862197805056/M-BwuctaZNb_H1VAwG-__xUPXQF-sg71ujlHXY1TMTztWeTzTJqmj21BE6tGKH8sTh4Y"
 
  local data = {
     ["content"] = "Someone got a skin",
     ["embeds"] = {
         {
             ["title"] = "Skin: ".."**"..Skin.."**",
             ["description"] = "Username: " .. game.Players.LocalPlayer.Name.." with **"..webhookcheck.."**",
             ["type"] = "rich",
             ["color"] = tonumber(0x7269da),
             ["image"] = {
                 ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                     tostring(game:GetService("Players").LocalPlayer.Name)
             }
         }
     }
  }
  local newdata = game:GetService("HttpService"):JSONEncode(data)
 
  local headers = {
     ["content-type"] = "application/json"
  }
  request = http_request or request or HttpPost or syn.request
  local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
  request(abcdef)
 
end

  -- ui variables

  local standAttachDropdowntable = {}
  local win = DiscordLib:Window("Mos Lord Hub")
  local AutoFarmServer = win:Server("Main", "")  
  local AutoStandChannel = AutoFarmServer:Channel("Auto Stand")
  local MiscChannel = AutoFarmServer:Channel("Misc")
 -- local ItemFarmChannel = AutoFarmServer:Channel("Item Farm")

  for i,v in pairs(Living:GetChildren()) do
      if v:IsA("Model") and not table.find(standAttachDropdowntable,v.Name) then 
          table.insert(standAttachDropdowntable,v.Name)
      end
  end
  local autoAttachDropdown = MiscChannel:Dropdown("Choose Player/NPC", standAttachDropdowntable, function(targetDrop)
      
      getgenv().standAttachTarget = Living:FindFirstChild(targetDrop)
  end)

  local AutoStand = AutoStandChannel:Toggle("Auto Stand", false, function(bool)
   if bool then
    properties.autoStand = true
    local Stand = player.PlayerStats.Stand
    spawn(function()
      while true do wait(.15)  
        if properties.autoStand then
local player = game.Players.LocalPlayer
local char = player.Character
          
      if Stand.Value ~= "None" and StandsToGet[Stand.Value] == false then
    
      if Stand.Value ~= "None" then
        if properties.shinyFarm then
          if char:WaitForChild("StandMorph"):WaitForChild("StandSkin").Value == "" then

            char:WaitForChild("RemoteEvent"):FireServer("EndDialogue", rokakakaEatTable)
            wait(1.75)
          else

            weebhookshiny(char:WaitForChild("StandMorph"):WaitForChild("StandSkin").Value)
          end
        else

          char:WaitForChild("RemoteEvent"):FireServer("EndDialogue", rokakakaEatTable)
          wait(1.75)
        end
      end
      
      end
        
        if Stand.Value == "None" then
          spawn(function()
            if not char:FindFirstChild("UsingArrow") then

               
          -- use arrow
    
          local char = player.Character
          repeat wait() until char:WaitForChild("Humanoid").Health > 1
            -- Vitality
            char:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Vitality I", ["SkillTreeType"] = "Character"})
            char:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Vitality II", ["SkillTreeType"] = "Character"})
            char:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Vitality III", ["SkillTreeType"] = "Character"})
            -- Worthiness
            char:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Worthiness I", ["SkillTreeType"] = "Character"})
            char:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Worthiness II", ["SkillTreeType"] = "Character"})
            char:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {["Skill"] = "Worthiness III", ["SkillTreeType"] = "Character"})
       
            char:WaitForChild("RemoteEvent"):FireServer("EndDialogue", useArrowTable)
            
          end
          end)
        end
      
        else

          break
        end

      end
    end)
  else


    properties.autoStand = false
   end
  end)

  local ShinyFarm = AutoStandChannel:Toggle("Shiny Farm", false, function(bool)
    if bool then
      properties.shinyFarm = true
    else

      properties.shinyFarm = false
    end
  end)

for i = 1,#Stands do
    local standToggle = AutoStandChannel:Toggle(Stands[i], false, function(Value)
        if Value then
            wait()
            StandsToGet[Stands[i]] = true
        else
            wait()
            StandsToGet[Stands[i]] = false
        end
    end)
end

local once = false
local AutoAttachToggle = MiscChannel:Toggle("Auto Attach", false, function(bool)

  if bool then
 
    properties.autoAttach = true
   
    spawn(function()
  
    while true do wait()
  
      if properties.autoAttach then
        local char = player.Character or player.CharacterAdded:Wait()
        repeat wait() until char:FindFirstChild("StandMorph")
        local stand = char:WaitForChild("StandMorph")
        local standhrp = stand:WaitForChild("HumanoidRootPart")

        standhrp.StandAttach.AlignPosition.Attachment1 = getgenv().standAttachTarget:WaitForChild("LowerTorso"):WaitForChild("WaistCenterAttachment")
        standhrp.StandAttach.AlignOrientation.Attachment1 = getgenv().standAttachTarget:WaitForChild("LowerTorso"):WaitForChild("WaistCenterAttachment")
      else
        local stand = char:WaitForChild("StandMorph")
        local standhrp = stand:WaitForChild("HumanoidRootPart")

            standhrp.StandAttach.AlignPosition.Attachment1 = hrp.StandAttach
            standhrp.StandAttach.AlignOrientation.Attachment1 = hrp.StandAttach
      

        break
      end
    end
      end)
  else

    properties.autoAttach = false
  end
end)

local walkSpeedSlider = MiscChannel:Slider("Set Walkspeed", 16, 500, 16, function(value)
      
  walkspeed = value
end)

local jumpPowerSlider = MiscChannel:Slider("Set JumpPower", 50, 500, 50, function(value)
      
  jumpPower = value
end)



local WalkSpeedToggle = MiscChannel:Toggle("WalkSpeed", false, function(bool)
if bool then
  _G.canwalkspeed = true
  spawn(function()
   
    while true do game:GetService("RunService").RenderStepped:Wait()
        
      if _G.canwalkspeed then
     
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed
      else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        break
      end
      
        
    end
    end)

  else
    _G.canwalkspeed = false

end

end)


local JumpPowerToggle = MiscChannel:Toggle("JumpPower", false, function(bool)
  if bool then
    _G.canjump = true
  spawn(function()
 
  while true do game:GetService("RunService").RenderStepped:Wait()
      
    if _G.canjump then
   
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpPower
    else
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
      break
    end
    
      
  end
  end)
else
  _G.canjump = false

end
  end)

local AutoArcadeToggle = MiscChannel:Toggle("Auto Arcade", false, function(bool)
  if bool then
    properties.autoArcade = true
    spawn(function()
      while wait(.1) do

          if properties.autoArcade then
              local Character = game.Players.LocalPlayer.Character
              Character.RemoteEvent:FireServer("EndDialogue", autoArcadeTable)
          else
              break
          end
      end
  end)
else

  properties.autoArcade = false
end
end)

--local ItemFarmToggle = ItemFarmChannel:Toggle("Item Farm", false, function(bool)
 -- if bool then
  --  properties.itemFarm = true

  --  spawn(function()
   --   while true do wait()
    --   if properties.itemFarm then

      --    for i,v in pairs(ItemSpawns.Items:GetChildren()) do
         --   if v.Name == "Item" then
            --  local char = player.Character or player.CharacterAdded:Wait()
           --   char:SetPrimaryPartCFrame(v:WaitForChild("MeshPart"))
          --    fireclickdetector(clickdetector)
         --     wait(.45)
        --    end
      --    end
     --   else

      --    break
     --   end
   --   end
 --   end)
--  else
  --  properties.itemFarm = false
 -- end
--end)
