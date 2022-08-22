--[[
	 ______ _____ _   _ _____ _________     __
	|  ____|_   _| \ | |_   _|__   __\ \   / /
	| |__    | | |  \| | | |    | |   \ \_/ /
	|  __|   | | | . ` | | |    | |    \   /
	| |     _| |_| |\  |_| |_   | |     | |
	|_|    |_____|_| \_|_____|  |_|     |_|

	Source:
		http://finity.vip/scripts/finity_lib.lua
	Version:
		0.1.5
	Date:
		August 25th, 2020
	Author:
		detourious @ v3rmillion.net / detourious#1153  @ discord.gg
	Contributors:
		ic3 @ v3rmillion.net -- Adding color picker, editing slider, fixing some other bugs
		TaskManager#7996 @ discord.gg / Task Manager @ v3rmillion.net -- Helping to add SetValue functions to some unsupported cheat types

--]]

local CONTEXTACTIONSERVICE = game:GetService('ContextActionService')
local PLAYERSERVICE = game:GetService('Players')
local USERINPUTSERVICE = game:GetService('UserInputService')
local TWEENSERVICE = game:GetService("TweenService")


local finity = {}

finity.theme = { -- light
	main_container = Color3.fromRGB(249, 249, 255),
	separator_color = Color3.fromRGB(223, 219, 228),

	text_color = Color3.fromRGB(96, 96, 96),

	category_button_background = Color3.fromRGB(223, 219, 228),
	category_button_border = Color3.fromRGB(200, 196, 204),

	checkbox_checked = Color3.fromRGB(114, 214, 112),
	checkbox_outer = Color3.fromRGB(198, 189, 202),
	checkbox_inner = Color3.fromRGB(249, 239, 255),

	slider_color = Color3.fromRGB(114, 214, 112),
	slider_color_sliding = Color3.fromRGB(114, 214, 112),
	slider_background = Color3.fromRGB(198, 188, 202),
	slider_text = Color3.fromRGB(112, 112, 112),

	textbox_background = Color3.fromRGB(198, 189, 202),
	textbox_background_hover = Color3.fromRGB(215, 206, 227),
	textbox_text = Color3.fromRGB(112, 112, 112),
	textbox_text_hover = Color3.fromRGB(50, 50, 50),
	textbox_placeholder = Color3.fromRGB(178, 178, 178),

	dropdown_background = Color3.fromRGB(198, 189, 202),
	dropdown_text = Color3.fromRGB(112, 112, 112),
	dropdown_text_hover = Color3.fromRGB(50, 50, 50),
	dropdown_scrollbar_color = Color3.fromRGB(198, 189, 202),

	button_background = Color3.fromRGB(198, 189, 202),
	button_background_hover = Color3.fromRGB(215, 206, 227),
	button_background_down = Color3.fromRGB(178, 169, 182),

	scrollbar_color = Color3.fromRGB(198, 189, 202),
}

finity.dark_theme = { -- dark
	main_container = Color3.fromRGB(32, 32, 33),
	separator_color = Color3.fromRGB(63, 63, 65),

	text_color = Color3.fromRGB(206, 206, 206),

	category_button_background = Color3.fromRGB(63, 62, 65),
	category_button_border = Color3.fromRGB(72, 71, 74),

	checkbox_checked = Color3.fromRGB(132, 255, 130),
	checkbox_outer = Color3.fromRGB(84, 81, 86),
	checkbox_inner = Color3.fromRGB(132, 132, 136),

	slider_color = Color3.fromRGB(177, 177, 177),
	slider_color_sliding = Color3.fromRGB(132, 255, 130),
	slider_background = Color3.fromRGB(88, 84, 90),
	slider_text = Color3.fromRGB(177, 177, 177),

	textbox_background = Color3.fromRGB(103, 103, 106),
	textbox_background_hover = Color3.fromRGB(137, 137, 141),
	textbox_text = Color3.fromRGB(195, 195, 195),
	textbox_text_hover = Color3.fromRGB(232, 232, 232),
	textbox_placeholder = Color3.fromRGB(135, 135, 138),

	dropdown_background = Color3.fromRGB(88, 88, 91),
	dropdown_text = Color3.fromRGB(195, 195, 195),
	dropdown_text_hover = Color3.fromRGB(232, 232, 232),
	dropdown_scrollbar_color = Color3.fromRGB(118, 118, 121),

	button_background = Color3.fromRGB(103, 103, 106),
	button_background_hover = Color3.fromRGB(137, 137, 141),
	button_background_down = Color3.fromRGB(70, 70, 81),

	scrollbar_color = Color3.fromRGB(118, 118, 121),
}

local mouse = game:GetService("Players").LocalPlayer:GetMouse()

function finity:Create(class, properties)
	local object = Instance.new(class)

	for prop, val in next, properties do
		if object[prop] and prop ~= "Parent" then
			object[prop] = val
		end
	end

	return object
end

function finity:Ripple(Button, x, y)
	local Ripple = finity:Create("ImageLabel",
		{
			Name = "Circle",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0,x - Button.AbsolutePosition.X, 0, y - Button.AbsolutePosition.Y - 36),
			ZIndex = 10,
			BackgroundTransparency = 1,
			Image = "rbxassetid://3570695787",
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(100, 100, 100, 100)
		}
	)

	local Ripple = Instance.new("ImageLabel")
	Ripple.Name = "Circle"
	Ripple.Parent = Button
	Ripple.ZIndex = 10
	Ripple.BackgroundTransparency = 1
	Ripple.AnchorPoint = Vector2.new(0.5, 0.5)
	Ripple.Position = UDim2.new(0,x - Button.AbsolutePosition.X, 0, y - Button.AbsolutePosition.Y - 36)
	Ripple.Image = "rbxassetid://3570695787"
	Ripple.ScaleType = Enum.ScaleType.Slice
	Ripple.SliceCenter = Rect.new(100, 100, 100, 100)
	local RippleFx = game:GetService('TweenService'):Create(Ripple, TweenInfo.new(0.5), {Size = UDim2.new(0, 300, 0, 300), ImageTransparency = 0.95})
	RippleFx:Play()
	game.Debris:AddItem(Ripple, 0.5)
end

function finity:addShadow(object, transparency)
	local shadow = self:Create("ImageLabel", {
		Name = "Shadow",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 4),
		Size = UDim2.new(1, 6, 1, 6),
		Image = "rbxassetid://1316045217",
		ImageTransparency = transparency and true or 0.5,
		ImageColor3 = Color3.fromRGB(35, 35, 35),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(10, 10, 118, 118)
	})

	shadow.Parent = object
end

function finity.new(isdark, gprojectName, thinProject, ModifizedSize)
	local finityObject = {}
	local self2 = finityObject
	local self = finity

	-- Destroy Ui
    for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v:IsA(v, "ScreenGui") then
            for i2, v2 in pairs(v:GetChildren()) do
                -- 'Container' (Since Finity uses this)
                if (typeof(v2) == "Instance" and v2.Name == "Container") then
                    v2.Parent:Destroy()
                    break;
                end
            end
        end
    end

	local theme = finity.theme
	local projectName = false
	local thinMenu = false

	if isdark == true then theme = finity.dark_theme end
	if gprojectName then projectName = gprojectName end
	if thinProject then thinMenu = thinProject end

	local toggled = true
	local typing = false
	local firstCategory = true
	local savedposition = UDim2.new(0.5, 0, 0.5, 0)

	local CarouselOpened = false

	local finityData
	finityData = {
		UpConnection = nil,
		ToggleKey = Enum.KeyCode.RightShift,
	}




	local BlurFX = finity:Create("BlurEffect", {Size = 20})
	BlurFX.Parent = game.Lighting

	local function toggleUI(input, inputState)
		if inputState == Enum.UserInputState.End then
			return
		end
		toggled = not toggled

		if toggled then
			game:GetService("TweenService"):Create(self2.container, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = savedposition}):Play()
			game:GetService("TweenService"):Create(BlurFX, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = 20}):Play()
		else
			savedposition = self2.container.Position
			game:GetService("TweenService"):Create(self2.container, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, savedposition.X.Offset, 1.5, 0)}):Play()
			game:GetService("TweenService"):Create(BlurFX, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = 0}):Play()
		end
	end

	self2.ChangeToggleKey = function(NewKey)
		finityData.ToggleKey = NewKey

		if not projectName then
			self2.tip.Text = "Press '".. string.sub(tostring(NewKey), 14) .."' to hide this menu"
		end
		CONTEXTACTIONSERVICE:UnbindAction("ToggleUI")
		CONTEXTACTIONSERVICE:BindAction("ToggleUI", toggleUI, false, finityData.ToggleKey)
	end

	self2.ChangeTitle = function(text)
		self2.tip.Text = text
	end

	self2.ChangeBackgroundImage = function(ImageID, Transparency)
		self2.container.Image = ImageID

		if Transparency then
			self2.container.ImageTransparency = Transparency
		else
			self2.container.ImageTransparency = 0.8
		end
	end

	CONTEXTACTIONSERVICE:BindAction("ToggleUI", toggleUI, false, finityData.ToggleKey)

	self2.userinterface = self:Create("ScreenGui", {
		Name = "UI Modified",
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		ResetOnSpawn = false,
	})

	self2.container = self:Create("ImageLabel", {
		Active = true,
		Name = "Container",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 0,
		BackgroundColor3 = theme.main_container,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 725, 0, 450),
		ZIndex = 2,
		ImageTransparency = 1
	})

	self2.modal = self:Create("TextButton", {
		Text = "";
		Transparency = 1;
		Modal = false;
	}) self2.modal.Parent = self2.userinterface;

	if ModifizedSize and typeof(ModifizedSize) == "UDim2" then
		self2.container.Size = ModifizedSize;
	end

	-- Custom Drag --
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		self2.container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	self2.container.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = self2.container.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	self2.container.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	USERINPUTSERVICE.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	-- Gradient --
	self2.GradientFrame = self:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 1),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, -0.25, 1, 1),
		Size = UDim2.new(1, -1, 0, 1),
		ZIndex = 20
	})

	self2.UIGradient = self:Create("UIGradient", {
		Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.14, Color3.fromRGB(255, 125, 0)), ColorSequenceKeypoint.new(0.29, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.43, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.57, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.71, Color3.fromRGB(75, 0, 130)), ColorSequenceKeypoint.new(0.86, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
	})

	self2.GradientFrame.Parent = self2.container
	self2.UIGradient.Parent = self2.GradientFrame


	self2.sidebar = self:Create("Frame", {
		Name = "Sidebar",
		BackgroundColor3 = Color3.new(0.976471, 0.937255, 1),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.new(0.745098, 0.713726, 0.760784),
		Size = UDim2.new(0, 120, 1, -30),
		Position = UDim2.new(0, 0, 0, 30),
		ZIndex = 2,
	})

	self2.categories = self:Create("Frame", {
		Name = "Categories",
		BackgroundColor3 = Color3.new(0.976471, 0.937255, 1),
		ClipsDescendants = true,
		BackgroundTransparency = 1,
		BorderColor3 = Color3.new(0.745098, 0.713726, 0.760784),
		Size = UDim2.new(1, -120, 1, -30),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 30),
		ZIndex = 2,
	})
	self2.categories.ClipsDescendants = true

	self2.topbar = self:Create("Frame", {
		Name = "Topbar",
		ZIndex = 2,
		Size = UDim2.new(1,0,0,30),
		BackgroundTransparency = 2
	})

	self2.tip = self:Create("TextLabel", {
		Name = "TopbarTip",
		ZIndex = 2,
		Size = UDim2.new(1, -30, 0, 30),
		Position = UDim2.new(0, 30, 0, 0),
		Text = "Press '".. string.sub(tostring(self.ToggleKey), 14) .."' to hide this menu",
		Font = Enum.Font.GothamSemibold,
		TextSize = 15,
		RichText = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		TextColor3 = theme.text_color,
	})

	if projectName then
		self2.tip.Text = projectName
	else
		self2.tip.Text = "Press '".. string.sub(tostring(self.ToggleKey), 14) .."' to hide this menu"
	end

	local separator = self:Create("Frame", {
		Name = "Separator",
		BackgroundColor3 = theme.separator_color,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 118, 0, 30),
		Size = UDim2.new(0, 1, 1, -30),
		ZIndex = 6,
	})
	separator.Parent = self2.container
	separator = nil

	local separator = self:Create("Frame", {
		Name = "Separator",
		BackgroundColor3 = theme.separator_color,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 30),
		Size = UDim2.new(1, 0, 0, 1),
		ZIndex = 6,
	})
	separator.Parent = self2.container
	separator = nil

	local uipagelayout = self:Create("UIPageLayout", {
		Padding = UDim.new(0, 10),
		FillDirection = Enum.FillDirection.Vertical,
		TweenTime = 0.7,
		EasingStyle = Enum.EasingStyle.Quad,
		EasingDirection = Enum.EasingDirection.InOut,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	uipagelayout.Parent = self2.categories
	uipagelayout = nil

	local uipadding = self:Create("UIPadding", {
		PaddingTop = UDim.new(0, 3),
		PaddingLeft = UDim.new(0, 2)
	})
	uipadding.Parent = self2.sidebar
	uipadding = nil

	local uilistlayout = self:Create("UIListLayout", {
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	uilistlayout.Parent = self2.sidebar
	uilistlayout = nil

	--[[
	local Logo = self:Create("ImageLabel", {
		Name = "Logo",
		Transparency = 1,
		Size = UDim2.new(0, 75, 0, 75),
		ZIndex = 2,
		Image = "http://www.roblox.com/asset/?id=5850610883"
	})
	Logo.Parent = self2.sidebar


	Logo.MouseEnter:Connect(function()
		TWEENSERVICE:Create(Logo, TweenInfo.new(0.1), {Size = UDim2.new(0, 80, 0, 80)}):Play()
	end)

	Logo.MouseLeave:Connect(function()
		TWEENSERVICE:Create(Logo, TweenInfo.new(0.1), {Size = UDim2.new(0, 75, 0, 75)}):Play()
	end)
	]]

	-- Keybinds --
	local CarouselFrame = finity:Create("Frame", {
		Name = "CarouselFrame",
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(-0.4, 0, 0.5, 0),
		Size = UDim2.new(0, 240, 0.35, 0)
	})
	CarouselFrame.Parent = self2.userinterface
	CarouselFrame.ClipsDescendants = true

	local CarouselSlider = finity:Create("Frame", {
		Name = "CarouselSlider",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 1, 0)
	})
	CarouselSlider.Parent = CarouselFrame

	local UIListLayout = finity:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 5)
	})
	UIListLayout.Parent = CarouselSlider

	-- Dragging --
	local UserInputService = game:GetService("UserInputService")
	local dragging
	local dragInput
	local dragStart
	local startPos

	CarouselSlider:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		for i,v in ipairs(CarouselSlider:GetChildren()) do
			if v:IsA("UIListLayout") or v:IsA("LocalScript") then
				continue
			end
			local CenterY = CarouselFrame:FindFirstAncestorOfClass("ScreenGui").AbsoluteSize.Y/2
			local ContentAnchor = v.AbsoluteSize.Y/2
			local CarouselAbsolutePos = v.AbsolutePosition.Y + ContentAnchor
			local DistanceToCenter = math.abs(CarouselAbsolutePos - CenterY)

			local SizeRange = 0.25 - 1.2

			local Size = (SizeRange*DistanceToCenter)/CenterY

			local Size = Size + 1

			game:GetService("TweenService"):Create(v, TweenInfo.new(0.2), {Size = UDim2.new(Size, 0, 0, 40)}):Play()
		end
	end)

	local function update(input)
		local delta = input.Position - dragStart
		local DeltaY = delta.Y
		local FinalY = (startPos.Y.Offset + DeltaY)/1.5
		local FinalY = math.clamp(FinalY, -(CarouselFrame.AbsoluteSize.Y + 20)/2, (CarouselFrame.AbsoluteSize.Y + 20)/2)
		CarouselSlider.Position = UDim2.new(0.5, 0, 0.5, FinalY)
	end

	CarouselSlider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = CarouselSlider.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	CarouselSlider.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	-- Dynamic Sizing --
	CarouselSlider.Size = UDim2.new(1, 0, CarouselSlider.UIListLayout.AbsoluteContentSize.Y, 0)
	CarouselSlider.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		CarouselSlider.Size = UDim2.new(1, 0, CarouselSlider.UIListLayout.AbsoluteContentSize.Y, 0)
	end)

	local CarouselFrameAbsoluteSize = CarouselFrame.AbsoluteSize

	USERINPUTSERVICE.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and toggled == false then
			if mouse.X < CarouselFrameAbsoluteSize.X/5 and CarouselOpened == false then
				game:GetService("TweenService"):Create(CarouselFrame, TweenInfo.new(1), {Position = UDim2.new(0.01, 0, 0.5, 0)}):Play()
				CarouselOpened = true
			elseif CarouselOpened == true and mouse.X > CarouselFrameAbsoluteSize.X + 125 then
				game:GetService("TweenService"):Create(CarouselFrame, TweenInfo.new(1), {Position = UDim2.new(-0.4, 0, 0.5, 0)}):Play()
				CarouselOpened = false
			end
		elseif CarouselFrame.Position.X.Scale > 0 and toggled == true then
			CarouselFrame.Position = UDim2.new(-0.25, 0, 0.5, 0)
		end
	end)


	function self2:Category(name)
		local category = {}

		category.button = finity:Create("TextButton", {
			Name = name,
			BackgroundColor3 = theme.category_button_background,
			BackgroundTransparency = 1,
			BorderMode = Enum.BorderMode.Inset,
			BorderColor3 = theme.category_button_border,
			Size = UDim2.new(1, -4, 0, 25),
			ZIndex = 2,
			AutoButtonColor = false,
			Font = Enum.Font.GothamSemibold,
			Text = name,
			TextColor3 = theme.text_color,
			TextSize = 14
		})

		category.container = finity:Create("ScrollingFrame", {
			Name = name,
			BackgroundTransparency = 1,
			ScrollBarThickness = 4,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 2,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarImageColor3 = theme.scrollbar_color or Color3.fromRGB(118, 118, 121),
			BottomImage = "rbxassetid://967852042",
			MidImage = "rbxassetid://967852042",
			TopImage = "rbxassetid://967852042",
			ScrollBarImageTransparency = 1 --
		})

		category.hider = finity:Create("Frame", {
			Name = "Hider",
			BackgroundTransparency = 0, --
			BorderSizePixel = 0,
			BackgroundColor3 = theme.main_container,
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 5
		})

		category.L = finity:Create("Frame", {
			Name = "L",
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 10, 0, 3),
			Size = UDim2.new(0.5, -20, 1, -3),
			ZIndex = 2
		})

		if not thinProject then
			category.R = finity:Create("Frame", {
				Name = "R",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -10, 0, 3),
				Size = UDim2.new(0.5, -20, 1, -3),
				ZIndex = 2
			})
		end

		if thinProject then
			category.L.Size = UDim2.new(1, -20, 1, -3)
		end

		if firstCategory then
			game:GetService("TweenService"):Create(category.hider, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
			game:GetService("TweenService"):Create(category.container, TweenInfo.new(0.3), {ScrollBarImageTransparency = 0}):Play()
		end

		do
			local uilistlayout = finity:Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			local uilistlayout2 = finity:Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			local function computeSizeChange()
				local largestListSize = 0

				largestListSize = uilistlayout.AbsoluteContentSize.Y

				if uilistlayout2.AbsoluteContentSize.Y > largestListSize then
					largestListSize = largestListSize
				end

				category.container.CanvasSize = UDim2.new(0, 0, 0, largestListSize + 5)
			end

			uilistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(computeSizeChange)
			uilistlayout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(computeSizeChange)

			uilistlayout.Parent = category.L
			uilistlayout2.Parent = category.R
		end

		category.button.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(category.button, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
		end)
		category.button.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(category.button, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
		end)
		category.button.MouseButton1Down:Connect(function()
			for _, categoryf in next, self2.userinterface["Container"]["Categories"]:GetChildren() do
				if categoryf:IsA("ScrollingFrame") then
					if categoryf ~= category.container then
						game:GetService("TweenService"):Create(categoryf.Hider, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
						game:GetService("TweenService"):Create(categoryf, TweenInfo.new(0.3), {ScrollBarImageTransparency = 1}):Play()
					end
				end
			end

			game:GetService("TweenService"):Create(category.button, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
			game:GetService("TweenService"):Create(category.hider, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
			game:GetService("TweenService"):Create(category.container, TweenInfo.new(0.3), {ScrollBarImageTransparency = 0}):Play()

			self2.categories["UIPageLayout"]:JumpTo(category.container)
		end)
		category.button.MouseButton1Up:Connect(function()
			game:GetService("TweenService"):Create(category.button, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
		end)

		category.container.Parent = self2.categories
		category.button.Parent = self2.sidebar

		if not thinProject then
			category.R.Parent = category.container
		end

		category.L.Parent = category.container
		category.hider.Parent = category.container

		local function calculateSector()
			if thinProject then
				return "L"
			end

			local R = #category.R:GetChildren() - 1
			local L = #category.L:GetChildren() - 1

			if L > R then
				return "R"
			else
				return "L"
			end
		end

		function category:Sector(name)
			local sector = {}

			sector.frame = finity:Create("Frame", {
				Name = name,
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 25),
				ZIndex = 2
			})

			sector.container = finity:Create("Frame", {
				Name = "Container",
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 22),
				Size = UDim2.new(1, -5, 1, -30),
				ZIndex = 2
			})

			sector.title = finity:Create("TextLabel", {
				Name = "Title",
				Text = name,
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -5, 0, 25),
				ZIndex = 2,
				Font = Enum.Font.GothamSemibold,
				TextColor3 = theme.text_color,
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
			})

			local uilistlayout = finity:Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			uilistlayout.Changed:Connect(function()
				pcall(function()
					sector.frame.Size = UDim2.new(1, 0, 0, sector.container["UIListLayout"].AbsoluteContentSize.Y + 25)
					sector.container.Size = UDim2.new(1, 0, 0, sector.container["UIListLayout"].AbsoluteContentSize.Y)
				end)
			end)
			uilistlayout.Parent = sector.container
			uilistlayout = nil

			-- Setting Parents --
			sector.frame.Parent = category[calculateSector()]
			sector.container.Parent = sector.frame
			sector.title.Parent = sector.frame

			-- Contents --
			local function CreateUiContentFrame(FrameName, FontChosen)
				local ContentItems = {}
				ContentItems.value = nil

				ContentItems.frame = finity:Create("Frame", {
					Name = name,
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 25),
					ZIndex = 2,
				})

				ContentItems.label = finity:Create("TextLabel", {
					Name = "Title",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					Font = FontChosen or Enum.Font.GothamMedium,
					TextColor3 = theme.text_color,
					TextSize = 14,
					Text = FrameName,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left
				})

				ContentItems.container	= finity:Create("Frame", {
					Name = "Container",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(0, 150, 0, 22),
					ZIndex = 2,
				})

				ContentItems.frame.Parent = sector.container
				ContentItems.label.Parent = ContentItems.frame
				ContentItems.container.Parent = ContentItems.frame

				function ContentItems:RefreshBase(RefreshText)
					ContentItems.label.Text = RefreshText
				end

				return ContentItems
			end

			function sector:Toggle(name, callback, status)
				local cheat = CreateUiContentFrame(name, Enum.Font.Gotham)

				if status then
					cheat.value = status
				else
					cheat.value = false
				end

				cheat.checkbox = finity:Create("Frame", {
					Name = "Checkbox",
					AnchorPoint = Vector2.new(1, 0),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 0, 0, 0),
					Size = UDim2.new(0, 25, 0, 25),
					ZIndex = 2,
				})

				cheat.outerbox = finity:Create("ImageLabel", {
					Name = "Outer",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 2,
					Image = "rbxassetid://3570695787",
					ImageColor3 = theme.checkbox_outer,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.06,
				})

				cheat.checkboxbutton = finity:Create("ImageButton", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					Name = "CheckboxButton",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0, 14, 0, 14),
					ZIndex = 2,
					Image = "rbxassetid://3570695787",
					ImageColor3 = theme.checkbox_inner,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.04
				})

				if status then
					game:GetService("TweenService"):Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
					game:GetService("TweenService"):Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
				end

				cheat.checkboxbutton.MouseEnter:Connect(function()
					local lightertheme = Color3.fromRGB((theme.checkbox_outer.R * 255) + 20, (theme.checkbox_outer.G * 255) + 20, (theme.checkbox_outer.B * 255) + 20)
					game:GetService("TweenService"):Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = lightertheme}):Play()
				end)

				cheat.checkboxbutton.MouseLeave:Connect(function()
					if not cheat.value then
						game:GetService("TweenService"):Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_outer}):Play()
					else
						game:GetService("TweenService"):Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
					end
				end)
				cheat.checkboxbutton.MouseButton1Down:Connect(function()
					if cheat.value then
						game:GetService("TweenService"):Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_outer}):Play()
					else
						game:GetService("TweenService"):Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
					end
				end)
				cheat.checkboxbutton.MouseButton1Up:Connect(function()
					cheat.value = not cheat.value

					if callback then
						coroutine.wrap(callback)(cheat.value)
					end

					if cheat.value then
						game:GetService("TweenService"):Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
					else
						game:GetService("TweenService"):Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_outer}):Play()
						game:GetService("TweenService"):Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_inner}):Play()
					end
				end)

				cheat.checkboxbutton.Parent = cheat.outerbox
				cheat.outerbox.Parent = cheat.container

				local RefreshLibrary = {}

				function RefreshLibrary:SetValue(value)
					cheat.value = value

					if callback then
						coroutine.wrap(callback)(cheat.value)
					end

					if cheat.value then
						game:GetService("TweenService"):Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
						game:GetService("TweenService"):Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
					else
						game:GetService("TweenService"):Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_outer}):Play()
						game:GetService("TweenService"):Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_inner}):Play()
					end
				end

				function RefreshLibrary:Refresh(text)
					cheat:RefreshBase(text)
				end

				return RefreshLibrary
			end

			function sector:Slider(name, data, callback)
				local cheat = CreateUiContentFrame(name, Enum.Font.Gotham)

				cheat.value = 0

				local suffix = data.suffix or ""
				local minimum = data.min or 0
				local maximum = data.max or 1
				local default = data.default
				local precise = data.precise or false

				local moveconnection
				local releaseconnection

				cheat.sliderbar = finity:Create("ImageButton", {
					Name = "Sliderbar",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 0, 6),
					ZIndex = 2,
					Image = "rbxassetid://3570695787",
					ImageColor3 = theme.slider_background,
					ImageTransparency = 0.5,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.02,
				})

				cheat.numbervalue = finity:Create("TextLabel", {
					Name = "Value",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 5, 0.5, 0),
					Size = UDim2.new(1, 0, 0, 13),
					ZIndex = 2,
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Text = "",
					TextTransparency = 1,
					TextColor3 = theme.slider_text,
					TextSize = 13,
				})

				cheat.visiframe = finity:Create("ImageLabel", {
					Name = "Frame",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Size = UDim2.new(0.5, 0, 1, 0),
					ZIndex = 2,
					Image = "rbxassetid://3570695787",
					ImageColor3 = theme.slider_color,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.02
				})

				if data.default then
					local size = math.clamp(data.default - cheat.sliderbar.AbsolutePosition.X, 0, 150)
					local percent = size / 150
					local perc = default/maximum
					cheat.value = math.floor((minimum + (maximum - minimum) * percent) * 100) / 100
					game:GetService("TweenService"):Create(cheat.visiframe, TweenInfo.new(0.1), {Size = UDim2.new(perc, 0, 1, 0)}):Play()
					if callback then
						coroutine.wrap(callback)(cheat.value)
					end
				end

				cheat.sliderbar.MouseButton1Down:Connect(function()
					local size = math.clamp(mouse.X - cheat.sliderbar.AbsolutePosition.X, 0, 150)
					local percent = size / 150

					cheat.value = math.floor((minimum + (maximum - minimum) * percent) * 100) / 100

					if precise then
						cheat.numbervalue.Text = math.ceil(tostring(cheat.value)) .. suffix
					else
						cheat.numbervalue.Text = tostring(cheat.value) .. suffix
					end

					if callback then
						local CalledVariable = cheat.value
						if data.precise then
							CalledVariable = math.ceil(cheat.value)
						end
						coroutine.wrap(callback)(CalledVariable)
					end

					game:GetService("TweenService"):Create(cheat.visiframe, TweenInfo.new(0.1), {
						Size = UDim2.new(size / 150, 0, 1, 0),
						ImageColor3 = theme.slider_color_sliding
					}):Play()

					game:GetService("TweenService"):Create(cheat.numbervalue, TweenInfo.new(0.1), {
						Position = UDim2.new(size / 150, 5, 0.5, 0),
						TextTransparency = 0
					}):Play()

					moveconnection = mouse.Move:Connect(function()
						local size = math.clamp(mouse.X - cheat.sliderbar.AbsolutePosition.X, 0, 150)
						local percent = size / 150

						cheat.value = math.floor((minimum + (maximum - minimum) * percent) * 100) / 100
						if precise then
							cheat.numbervalue.Text = math.ceil(tostring(cheat.value)) .. suffix
						else
							cheat.numbervalue.Text = tostring(cheat.value) .. suffix
						end

						if callback then
							local s, e = pcall(function()
								if data.precise then
									callback(math.ceil(cheat.value))
								else
									callback(cheat.value)
								end
							end)

							if not s then warn("error: ".. e) end
						end

						game:GetService("TweenService"):Create(cheat.visiframe, TweenInfo.new(0.1), {
							Size = UDim2.new(size / 150, 0, 1, 0),
							ImageColor3 = theme.slider_color_sliding
						}):Play()

						local Position = UDim2.new(size / 150, 5, 0.5, 0);

						if Position.Width.Scale >= 0.6 then
							Position = UDim2.new(1, -cheat.numbervalue.TextBounds.X, 0.5, 10);
						end

						game:GetService("TweenService"):Create(cheat.numbervalue, TweenInfo.new(0.1), {
							Position = Position,
							TextTransparency = 0
						}):Play()
					end)

					releaseconnection = game:GetService("UserInputService").InputEnded:Connect(function(Mouse)
						if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then

							game:GetService("TweenService"):Create(cheat.visiframe, TweenInfo.new(0.1), {
								ImageColor3 = theme.slider_color
							}):Play()

							game:GetService("TweenService"):Create(cheat.numbervalue, TweenInfo.new(0.1), {
								TextTransparency = 1
							}):Play()

							moveconnection:Disconnect()
							moveconnection = nil
							releaseconnection:Disconnect()
							releaseconnection = nil
						end
					end)
				end)

				cheat.visiframe.Parent = cheat.sliderbar
				cheat.numbervalue.Parent = cheat.sliderbar
				cheat.sliderbar.Parent = cheat.container

				local RefreshFunctions = {}

				function RefreshFunctions:SetValue(value)
					local size = math.clamp(value - cheat.sliderbar.AbsolutePosition.X, 0, 150)
					local percent = size / 150
					local perc = default / maximum
					cheat.value = math.floor((minimum + (maximum - minimum) * percent) * 100) / 100
					game:GetService("TweenService"):Create(cheat.visiframe, TweenInfo.new(0.1), {
						Size = UDim2.new(perc, 0, 1, 0),
					}):Play()
					if callback then
						coroutine.wrap(callback)(cheat.value)
					end
				end

				function RefreshFunctions:Refresh(name)
					cheat:RefreshBase(name)
				end

				return RefreshFunctions
			end

			function sector:Dropdown(name, data, callback)
				local cheat = CreateUiContentFrame(name, Enum.Font.Gotham);

				if data then
					cheat.value = data[1]
				else
					cheat.value = 'none'
				end

				local options

				if data and data then
					options = data
				end

				cheat.dropped = false

				cheat.dropdown = finity:Create("ImageButton", {
					Name = "Dropdown",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					Image = "rbxassetid://3570695787",
					ImageColor3 = theme.dropdown_background,
					ImageTransparency = 0.5,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.02
				})

				cheat.selected = finity:Create("TextLabel", {
					Name = "Selected",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 0),
					Size = UDim2.new(1, -35, 1, 0),
					ZIndex = 2,
					Font = Enum.Font.Gotham,
					Text = tostring(cheat.value),
					TextColor3 = theme.dropdown_text,
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left
				})

				cheat.list = finity:Create("ScrollingFrame", {
					Name = "List",
					BackgroundColor3 = Color3.fromRGB(45, 45, 50),
					BackgroundTransparency = 0.25,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, 100),
					ZIndex = 3,
					BottomImage = "rbxassetid://967852042",
					MidImage = "rbxassetid://967852042",
					TopImage = "rbxassetid://967852042",
					ScrollBarThickness = 4,
					VerticalScrollBarInset = Enum.ScrollBarInset.None,
					ScrollBarImageColor3 = theme.dropdown_scrollbar_color
				})

				local uilistlayout = finity:Create("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 2)
				})
				uilistlayout.Parent = cheat.list
				uilistlayout = nil
				local uipadding = finity:Create("UIPadding", {
					PaddingLeft = UDim.new(0, 2)
				})
				uipadding.Parent = cheat.list
				uipadding = nil

				local function refreshOptions()
					if cheat.dropped then
						cheat.fadelist()
					end

					for _, child in next, cheat.list:GetChildren() do
						if child:IsA("TextButton") then
							child:Destroy()
						end
					end

					for i, v in ipairs(options) do
						local button = finity:Create("TextButton", {
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 20),
							ZIndex = 3,
							Font = Enum.Font.Gotham,
							Text = v,
							TextColor3 = theme.dropdown_text,
							TextSize = 13
						})

						button.Parent = cheat.list

						button.MouseEnter:Connect(function()
							game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {TextColor3 = theme.dropdown_text_hover}):Play()
						end)
						button.MouseLeave:Connect(function()
							game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {TextColor3 = theme.dropdown_text}):Play()
						end)
						button.MouseButton1Click:Connect(function()
							if cheat.dropped then
								cheat.value = v
								cheat.selected.Text = v

								cheat.fadelist()

								if callback then
									coroutine.wrap(callback)(cheat.value)
								end
							end
						end)


						game:GetService("TweenService"):Create(button, TweenInfo.new(0), {TextTransparency = 1}):Play()
					end

					game:GetService("TweenService"):Create(cheat.list, TweenInfo.new(0), {Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0), CanvasSize = UDim2.new(0, 0, 0, cheat.list["UIListLayout"].AbsoluteContentSize.Y), ScrollBarImageTransparency = 1, BackgroundTransparency = 1}):Play()
				end


				function cheat.fadelist()
					cheat.dropped = not cheat.dropped

					if cheat.dropped then
						for _, button in next, cheat.list:GetChildren() do
							if button:IsA("TextButton") then
								game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
							end
						end

						game:GetService("TweenService"):Create(cheat.list, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, math.clamp(cheat.list["UIListLayout"].AbsoluteContentSize.Y, 0, 150)), Position = UDim2.new(0, 0, 1, 0), ScrollBarImageTransparency = 0, BackgroundTransparency = 0.25}):Play()
					else
						for _, button in ipairs(cheat.list:GetChildren()) do
							if button:IsA("TextButton") then
								game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
							end
						end

						game:GetService("TweenService"):Create(cheat.list, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0), ScrollBarImageTransparency = 1, BackgroundTransparency = 1}):Play()
					end
				end

				cheat.dropdown.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(cheat.selected, TweenInfo.new(0.1), {TextColor3 = theme.dropdown_text_hover}):Play()
				end)
				cheat.dropdown.MouseLeave:Connect(function()
					game:GetService("TweenService"):Create(cheat.selected, TweenInfo.new(0.1), {TextColor3 = theme.dropdown_text}):Play()
				end)
				cheat.dropdown.MouseButton1Click:Connect(function()
					cheat.fadelist()
				end)

				refreshOptions()

				cheat.selected.Parent = cheat.dropdown
				cheat.dropdown.Parent = cheat.container
				cheat.list.Parent = cheat.container

				local RefreshFunctions = {}

				function RefreshFunctions:RefreshOptions(newoptions)
					options = newoptions
					cheat.value = data[1]
					cheat.selected.Text = data[1]

					refreshOptions()
				end

				function RefreshFunctions:SetValue(value)
					cheat.selected.Text = value
					cheat.value = value

					if cheat.dropped then
						cheat.fadelist()
					end

					if callback then
						coroutine.wrap(callback)(cheat.value)
					end
				end

				return RefreshFunctions
			end

			function sector:Textbox(name, placeholder, callback)
				local cheat = CreateUiContentFrame(name, Enum.Font.Gotham);

				cheat.background = finity:Create("ImageLabel", {
					Name = "Background",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					Image = "rbxassetid://3570695787",
					ImageColor3 = theme.textbox_background,
					ImageTransparency = 0.5,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.02
				})

				cheat.textbox = finity:Create("TextBox", {
					Name = "Textbox",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					Font = Enum.Font.Gotham,
					Text = "",
					TextColor3 = theme.textbox_text,
					PlaceholderText = placeholder or "Value",
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Center,
					ClearTextOnFocus = false
				})

				cheat.background.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(cheat.textbox, TweenInfo.new(0.1), {TextColor3 = theme.textbox_text_hover}):Play()
				end)
				cheat.background.MouseLeave:Connect(function()
					game:GetService("TweenService"):Create(cheat.textbox, TweenInfo.new(0.1), {TextColor3 = theme.textbox_text}):Play()
				end)
				cheat.textbox.Focused:Connect(function()
					typing = true

					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.textbox_background_hover}):Play()
				end)
				cheat.textbox.FocusLost:Connect(function()
					typing = false

					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.textbox_background}):Play()
					game:GetService("TweenService"):Create(cheat.textbox, TweenInfo.new(0.1), {TextColor3 = theme.textbox_text}):Play()

					cheat.value = cheat.textbox.Text

					if callback then
						local s, e = pcall(function()
							callback(cheat.value)
						end)

						if not s then warn("error: "..e) end
					end
				end)

				function cheat:SetValue(value)
					cheat.value = tostring(value)
					cheat.textbox.Text = tostring(value)
				end

				cheat.background.Parent = cheat.container
				cheat.textbox.Parent = cheat.container

				return cheat
			end

			function sector:Button(name, buttontext, callback)
				local cheat = CreateUiContentFrame(name, Enum.Font.Gotham)

				cheat.background = finity:Create("ImageLabel", {
					Name = "Background",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					Image = "rbxassetid://3570695787",
					ImageColor3 = theme.button_background,
					ImageTransparency = 0.5,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.02
				})

				cheat.button = finity:Create("TextButton", {
					Name = "Button",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					Font = Enum.Font.Gotham,
					Text = buttontext or "Button",
					TextColor3 = theme.textbox_text,
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Center
				})

				cheat.background.ClipsDescendants = true

				cheat.button.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.button_background_hover}):Play()
				end)
				cheat.button.MouseLeave:Connect(function()
					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.button_background}):Play()
				end)
				cheat.button.MouseButton1Down:Connect(function(x, y)
					finity:Ripple(cheat.background, x, y)
					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.button_background_down}):Play()
				end)
				cheat.button.MouseButton1Up:Connect(function()
					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.button_background}):Play()

					if callback then
						coroutine.wrap(callback)()
					end
				end)

				cheat.background.Parent = cheat.container
				cheat.button.Parent = cheat.container
			end

			function sector:Label(text)
				local cheat = CreateUiContentFrame(text, Enum.Font.Gotham)

				local RefreshFunctions = {}

				function RefreshFunctions:Refresh(text)
					cheat:RefreshBase(text)
				end

				return RefreshFunctions
			end

			function sector:Keybind(name, bind, callback, changedcallback, BindAction)
				local cheat = CreateUiContentFrame(name, Enum.Font.Gotham)

				local callback_bind = tostring(USERINPUTSERVICE:GetStringForKeyCode(bind))
				if callback_bind == "" then
					callback_bind = tostring(bind.Name)
				end
				local connection
				cheat.holding = false

				cheat.background = finity:Create("ImageLabel", {
					Name = "Background",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					Image = "rbxassetid://3570695787",
					ImageColor3 = theme.button_background,
					ImageTransparency = 0.5,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.02
				})

				cheat.button = finity:Create("TextButton", {
					Name = "Button",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					Font = Enum.Font.Gotham,
					Text = "Click to Bind",
					TextColor3 = theme.textbox_text,
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Center
				})

				cheat.button.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.button_background_hover}):Play()
				end)
				cheat.button.MouseLeave:Connect(function()
					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.button_background}):Play()
				end)
				cheat.button.MouseButton1Down:Connect(function()
					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.button_background_down}):Play()
				end)
				cheat.button.MouseButton2Down:Connect(function()
					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.button_background_down}):Play()
				end)


				-- Carousel Keys --
				cheat.CarouselContent = finity:Create("Frame", {
					Name = "CarouselContent",
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = theme.main_container,
				})

				cheat.Edges = finity:Create("UICorner", {
					Name = "Edges",
					CornerRadius = UDim.new(0.15, 0),
				})

				cheat.Title = finity:Create("TextLabel", {
					Name = "Title",
					BackgroundTransparency = 1,
					Position = UDim2.new(0.05, 0, 0, 0),
					Size = UDim2.new(0.7, 0, 1, 0),
					Font = Enum.Font.GothamBold,
					Text = name,
					TextColor3 = theme.textbox_text,
					TextXAlignment = Enum.TextXAlignment.Left
				})
				cheat.Title.TextScaled = true

				cheat.Bind = finity:Create("TextLabel", {
					Name = "Bind",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = theme.button_background,
					Position = UDim2.new(0.875, 0, 0.5, 0),
					Size = UDim2.new(0.25, 0, 0.75, 0),
					Font = Enum.Font.GothamBlack,
					Text = callback_bind,
					TextColor3 = theme.textbox_text,
					TextSize = 25
				})

				cheat.BindEdge = finity:Create("UICorner", {
					CornerRadius = UDim.new(0.15, 0),
					Name = "Edges"
				})

				cheat.Squaring = finity:Create("UIAspectRatioConstraint", {
					Name = "Squaring"
				})

				cheat.CarouselContent.Parent = CarouselSlider
				cheat.Edges.Parent = cheat.CarouselContent
				cheat.Title.Parent = cheat.CarouselContent
				cheat.Bind.Parent = cheat.CarouselContent
				cheat.BindEdge.Parent = cheat.Bind
				cheat.Squaring.Parent = cheat.Bind


				local function BindEvent(input, InputState)
					if InputState == Enum.UserInputState.End then
						return
					end
					cheat.holding = true
					if callback then
						coroutine.wrap(callback)()
					end
				end

				cheat.button.MouseButton1Up:Connect(function()
					game:GetService("TweenService"):Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.button_background}):Play()
					cheat.button.Text = "Press key..."

					if connection then
						connection:Disconnect()
						connection = nil
					end
					cheat.holding = false

					connection = game:GetService("UserInputService").InputBegan:Connect(function(Input)
						if Input.UserInputType.Name == "Keyboard" and Input.KeyCode ~= finityData.ToggleKey and Input.KeyCode ~= Enum.KeyCode.Backspace then
							local BoundKey = tostring(USERINPUTSERVICE:GetStringForKeyCode(Input.KeyCode))
							if BoundKey == "" then
								BoundKey = tostring(Input.KeyCode.Name)
							end

							cheat.button.Text = "Bound to " .. BoundKey

							cheat.Bind.Text = BoundKey

							if connection then
								connection:Disconnect()
								connection = nil
							end

							CONTEXTACTIONSERVICE:UnbindAction(name .. callback_bind)

							callback_bind = BoundKey
							cheat.value = Input.KeyCode

							if BindAction == true or BindAction == nil then
								CONTEXTACTIONSERVICE:BindAction(name .. BoundKey, BindEvent, false, Input.KeyCode)
							end

							if changedcallback and type(changedcallback) == "function" then
								coroutine.wrap(changedcallback)(Input.KeyCode)
							end

						elseif Input.KeyCode == Enum.KeyCode.Backspace then
							callback_bind = nil
							cheat.button.Text = "Click to Bind"
							cheat.value = nil
							cheat.holding = false

							if connection then
								connection:Disconnect()
								connection = nil
							end
						elseif Input.KeyCode == finityData.ToggleKey then
							cheat.button.Text = "Invalid Key";
							cheat.value = nil
						end
					end)
				end)

				function cheat:SetValue(value)
					cheat.value = tostring(value)
					cheat.button.Text = "Bound to " .. tostring(value)
				end

				if callback_bind then
					cheat.button.Text = "Bound to " .. callback_bind
					if BindAction == true or BindAction == nil then
						CONTEXTACTIONSERVICE:BindAction(name .. callback_bind, BindEvent, false, bind)
					end
				end

				cheat.background.Parent = cheat.container
				cheat.button.Parent = cheat.container
				
				return cheat
			end

			return sector
		end


		firstCategory = false

		return category
	end

	function self2:Settings()
		local SettingsCatagory = self2:Category("Settings")

		local Options = SettingsCatagory:Sector("UI Options")
		Options:Keybind('Toggle Key', finityData.ToggleKey, nil, function(key)
			self2.ChangeToggleKey(key)
		end, false)
	end

	self:addShadow(self2.container, 0)

	self2.categories.ClipsDescendants = true

	if not game:GetService("RunService"):IsStudio() then
		self2.userinterface.Parent = game:GetService("CoreGui")
	else
		self2.userinterface.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	end

	self2.container.Parent = self2.userinterface
	self2.categories.Parent = self2.container
	self2.sidebar.Parent = self2.container
	self2.topbar.Parent = self2.container
	self2.tip.Parent = self2.topbar

	return self2, finityData
end

return finity
