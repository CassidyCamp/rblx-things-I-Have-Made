local mouse = game.Players.LocalPlayer:GetMouse()
-- Instance A New Tool Here
tool = Instance.new("Tool")
-- Make It Not Require A Handle
tool.RequiresHandle = false
-- Renders The Tool Name As "Click Teleport"
tool.Name = "Click Teleport"
-- If The Tool Is Activated Then It Teleports The Players Humanoid Root Part To The Mouse
tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,2.5,0)
pos = CFrame.new(pos.X,pos.Y,pos.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)
-- Puts The Tool In The Local Players Backpack
tool.Parent = game.Players.LocalPlayer.Backpack

-- This Is A Pretty Simple Script So If You Use It There Is No Need To Credit Me :)
