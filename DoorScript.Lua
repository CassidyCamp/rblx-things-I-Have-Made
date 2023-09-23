-- Declaring The Hinge Of The Door
local Hinge = script.Parent.PrimaryPart
-- Declares The Opened Value
local opened = false
-- Opens The Door On Click
function OpenDoor()
-- If the opened value is false Then Set The Value To True
	if opened == false then
		opened = true
-- for loop 
		for i = 1, 21 do
			script.Parent:SetPrimaryPartCFrame(Hinge.CFrame*CFrame.Angles(0, math.rad(5), 0))
			wait()
		end
	else
		opened = false
		for i = 1, 21 do
			script.Parent:SetPrimaryPartCFrame(Hinge.CFrame*CFrame.Angles(0, math.rad(-5), 0))
			wait()
		end
	end
end
-- connect the mouseclick on the clickdetector to the open door function
script.Parent.Handle1.ClickDetector.MouseClick:Connect(OpenDoor)
script.Parent.Handle2.ClickDetector.MouseClick:Connect(OpenDoor)
