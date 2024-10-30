local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI --

local swimLeagueGui = Instance.new("ScreenGui")
swimLeagueGui.Name = "SwimLeagueGui"
swimLeagueGui.DisplayOrder = 10
swimLeagueGui.Parent = playerGui

-- Body

local body = Instance.new("Frame")
body.Name = "Body"
body.Size = UDim2.new(0.15, 0, 0.05, 0)
body.Position = UDim2.new(0, 50, 0, 50)
body.BackgroundColor3 = Color3.fromRGB(97, 97, 97)
body.Parent = swimLeagueGui

local bodyCorner = Instance.new("UICorner")
bodyCorner.CornerRadius = UDim.new(0.25, 0)
bodyCorner.Parent = body

local bodyUIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
bodyUIAspectRatioConstraint.AspectRatio = 5.331
bodyUIAspectRatioConstraint.Parent = body

-- CheckBox

local checkBox = Instance.new("TextButton")
checkBox.Name = "CheckBox"
checkBox.Size = UDim2.new(0.143, 0, 0.76, 0)
checkBox.Position = UDim2.new(0.821, 0, 0.12, 0)
checkBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
checkBox.Parent = body

local checkBoxCorner = Instance.new("UICorner")
checkBoxCorner.CornerRadius = UDim.new(0.25, 0)
checkBoxCorner.Parent = checkBox

-- Inside

local inside = Instance.new("Frame")
inside.Name = "Inside"
inside.Size = UDim2.new(0.8, 0, 0.8, 0)
inside.Position = UDim2.new(0.1, 0, 0.1, 0)
inside.BackgroundColor3 = Color3.fromRGB(132, 132, 132)
inside.Parent = checkBox

local insideCorner = Instance.new("UICorner")
insideCorner.CornerRadius = UDim.new(0.25, 0)
insideCorner.Parent = inside

-- Icon

local icon = Instance.new("Frame")
icon.Name = "Inside"
icon.Size = UDim2.new(0.8, 0, 0.8, 0)
icon.Position = UDim2.new(0.1, 0, 0.1, 0)
icon.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
icon.Visible = false
icon.Parent = inside

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0.25, 0)
iconCorner.Parent = icon

-- Title

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "Swim League Tool ( Auto )"
title.Size = UDim2.new(0.768, 0, 0.76, 0)
title.Position = UDim2.new(0.027, 0, 0.12, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextSize = 25
title.Parent = body

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0.25, 0)
titleCorner.Parent = title

local titleUITextSizeConstraint = Instance.new("UITextSizeConstraint")
titleUITextSizeConstraint.MaxTextSize = 25
titleUITextSizeConstraint.Parent = title

-------

local isHover = false

body.MouseEnter:Connect(function()
	isHover = true
end)

body.MouseLeave:Connect(function()
	isHover = false
end)

local isHolding = false
local tempPosition = Vector2.new(0, 0)
local mouse = player:GetMouse()

mouse.Button1Down:Connect(function()
	if not isHover then return end
	tempPosition = Vector2.new(body.Position.X.Offset - mouse.X, body.Position.Y.Offset - mouse.Y)
	body.Position = UDim2.new(0, mouse.X + tempPosition.X, 0, mouse.Y + tempPosition.Y)
	isHolding = true
end)

mouse.Button1Up:Connect(function()
	isHolding = false
end)

mouse.Move:Connect(function()
	if isHolding then
		body.Position = UDim2.new(0, mouse.X + tempPosition.X, 0, mouse.Y + tempPosition.Y)
	end
end)

local isAuto = false

checkBox.MouseButton1Click:Connect(function()
	isAuto = not isAuto
	icon.Visible = isAuto
end)

spawn(function()
	RunService.Heartbeat:Connect(function(deltaTime)
		if not isAuto then return end
		
		local machineUseGui = playerGui:WaitForChild("MachineUseGui")
		local contentFrame = machineUseGui:WaitForChild("ContentFrame")
		
		if not contentFrame.ButtonArea.AutoTrainBtn.Visible then
			ReplicatedStorage.AutoTrain.Bindable.OpenAutoTrain:Invoke()
		end
		
		ReplicatedStorage:WaitForChild("Train"):WaitForChild("Remote"):WaitForChild("TrainAnimeHasEnded"):FireServer()
	end)
end)
