if isfile("menu_plex.font") then
	delfile("menu_plex.font")
end

writefile("ProggyClean.ttf", game:HttpGet("https://github.com/f1nobe7650/other/raw/main/ProggyClean.ttf"))

-- // Custom Font
do
	getsynasset = getcustomasset or getsynasset
	Font = setreadonly(Font, false);
	function Font:Register(Name, Weight, Style, Asset)
		if not isfile(Name .. ".font") then
			if not isfile(Asset.Id) then
				writefile(Asset.Id, Asset.Font);
			end;
			--
			local Data = {
				name = Name,
				faces = {{
					name = "Regular",
					weight = Weight,
					style = Style,
					assetId = getsynasset(Asset.Id);
				}}
			};
			--
			writefile(Name .. ".font", game:GetService("HttpService"):JSONEncode(Data));
			return getsynasset(Name .. ".font");
		else 
			warn("Font already registered");
		end;
	end;
	--
	function Font:GetRegistry(Name)
		if isfile(Name .. ".font") then
			return getsynasset(Name .. ".font");
		end;
	end;

	Font:Register("menu_plex", 400, "normal", {Id = "ProggyClean.ttf", Font = ""});
end

if not LPH_OBFUSCATED then
    getfenv().LPH_NO_VIRTUALIZE = function(...) return (...) end;
end

local font = Enum.Font.Ubuntu;
local Library = {};
local Library = {
	Open = true;
	Folders = {
		main = "test";
		configs = "test/Configs";
	};
	Accent = Color3.fromRGB(132,108,188);
	Pages = {};
	Sections = {};
	Flags = {};
	UnNamedFlags = 0;
	ThemeObjects = {};
	Instances = {};
	Holder = nil;
	PageHolder = nil;
	Gradient = nil;
	UIGradient = nil;
	CopiedColor = Color3.new(1,1,1);
	CopiedAlpha = 0;
	AllowedCharacters = {
		[1] = ' ',
		[2] = '!',
		[3] = '"',
		[4] = '#',
		[5] = '$',
		[6] = '%',
		[7] = '&',
		[8] = "'",
		[9] = '(',
		[10] = ')',
		[11] = '*',
		[12] = '+',
		[13] = ',',
		[14] = '-',
		[15] = '.',
		[16] = '/',
		[17] = '0',
		[18] = '1',
		[19] = '2',
		[20] = '3',
		[21] = '4',
		[22] = '5',
		[23] = '6',
		[24] = '7',
		[25] = '8',
		[26] = '9',
		[27] = ':',
		[28] = ';',
		[29] = '<',
		[30] = '=',
		[31] = '>',
		[32] = '?',
		[33] = '@',
		[34] = 'A',
		[35] = 'B',
		[36] = 'C',
		[37] = 'D',
		[38] = 'E',
		[39] = 'F',
		[40] = 'G',
		[41] = 'H',
		[42] = 'I',
		[43] = 'J',
		[44] = 'K',
		[45] = 'L',
		[46] = 'M',
		[47] = 'N',
		[48] = 'O',
		[49] = 'P',
		[50] = 'Q',
		[51] = 'R',
		[52] = 'S',
		[53] = 'T',
		[54] = 'U',
		[55] = 'V',
		[56] = 'W',
		[57] = 'X',
		[58] = 'Y',
		[59] = 'Z',
		[60] = '[',
		[61] = "\\",
		[62] = ']',
		[63] = '^',
		[64] = '_',
		[65] = '`',
		[66] = 'a',
		[67] = 'b',
		[68] = 'c',
		[69] = 'd',
		[70] = 'e',
		[71] = 'f',
		[72] = 'g',
		[73] = 'h',
		[74] = 'i',
		[75] = 'j',
		[76] = 'k',
		[77] = 'l',
		[78] = 'm',
		[79] = 'n',
		[80] = 'o',
		[81] = 'p',
		[82] = 'q',
		[83] = 'r',
		[84] = 's',
		[85] = 't',
		[86] = 'u',
		[87] = 'v',
		[88] = 'w',
		[89] = 'x',
		[90] = 'y',
		[91] = 'z',
		[92] = '{',
		[93] = '|',
		[94] = '}',
		[95] = '~'
	};
	ShiftCharacters = {
		["1"] = "!",
		["2"] = "@",
		["3"] = "#",
		["4"] = "$",
		["5"] = "%",
		["6"] = "^",
		["7"] = "&",
		["8"] = "*",
		["9"] = "(",
		["0"] = ")",
		["-"] = "_",
		["="] = "+",
		["["] = "{",
		["\\"] = "|",
		[";"] = ":",
		["'"] = "\"",
		[","] = "<",
		["."] = ">",
		["/"] = "?",
		["`"] = "~"
	};
	Keys = {
		[Enum.KeyCode.LeftShift] = "LShift",
		[Enum.KeyCode.RightShift] = "RShift",
		[Enum.KeyCode.LeftControl] = "LCtrl",
		[Enum.KeyCode.RightControl] = "RCtrl",
		[Enum.KeyCode.LeftAlt] = "LAlt",
		[Enum.KeyCode.RightAlt] = "RAlt",
		[Enum.KeyCode.CapsLock] = "Caps",
		[Enum.KeyCode.One] = "1",
		[Enum.KeyCode.Two] = "2",
		[Enum.KeyCode.Three] = "3",
		[Enum.KeyCode.Four] = "4",
		[Enum.KeyCode.Five] = "5",
		[Enum.KeyCode.Six] = "6",
		[Enum.KeyCode.Seven] = "7",
		[Enum.KeyCode.Eight] = "8",
		[Enum.KeyCode.Nine] = "9",
		[Enum.KeyCode.Zero] = "0",
		[Enum.KeyCode.KeypadOne] = "Num1",
		[Enum.KeyCode.KeypadTwo] = "Num2",
		[Enum.KeyCode.KeypadThree] = "Num3",
		[Enum.KeyCode.KeypadFour] = "Num4",
		[Enum.KeyCode.KeypadFive] = "Num5",
		[Enum.KeyCode.KeypadSix] = "Num6",
		[Enum.KeyCode.KeypadSeven] = "Num7",
		[Enum.KeyCode.KeypadEight] = "Num8",
		[Enum.KeyCode.KeypadNine] = "Num9",
		[Enum.KeyCode.KeypadZero] = "Num0",
		[Enum.KeyCode.Minus] = "-",
		[Enum.KeyCode.Equals] = "=",
		[Enum.KeyCode.Tilde] = "~",
		[Enum.KeyCode.LeftBracket] = "[",
		[Enum.KeyCode.RightBracket] = "]",
		[Enum.KeyCode.RightParenthesis] = ")",
		[Enum.KeyCode.LeftParenthesis] = "(",
		[Enum.KeyCode.Semicolon] = ",",
		[Enum.KeyCode.Quote] = "'",
		[Enum.KeyCode.BackSlash] = "\\",
		[Enum.KeyCode.Comma] = ",",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Slash] = "/",
		[Enum.KeyCode.Asterisk] = "*",
		[Enum.KeyCode.Plus] = "+",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Backquote] = "`",
		[Enum.UserInputType.MouseButton1] = "MB1",
		[Enum.UserInputType.MouseButton2] = "MB2",
		[Enum.UserInputType.MouseButton3] = "MB3"
	};
	Connections = {};
	Font = Enum.Font.Ubuntu;
	FontSize = 12;
	Notifs = {};
	KeyList = nil;
	UIKey = Enum.KeyCode.End;
	ScreenGUI = nil;
}

local InputService = game:GetService("UserInputService");
local TeleportService = game:GetService("TeleportService");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");
local StarterGui = game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local VirtualUser = game:GetService("VirtualUser");
local PathFindingService = game:GetService("PathfindingService");

local utility = {
	Circle = nil, 
	bodyParts = {}, 
	target = nil, 
	angle = 0, 
	drawings = {}, 
	folders = {}
};
local framework = {connections = {}};
local Flags = {}; 
local flags = Library.Flags;
local ESP = {};
local IgnoreList = {};
local HitReg = {};
local loadingTime = tick() 
local Visuals = {   
    ["Drawings"] = {},
	["Bases"] = {},
	["Base"] = {},
	["Settings"] = { 
		["Line"] = {
		    Thickness = 1,
		    Color = Color3.fromRGB(0, 255, 0)
	    },
		["Text"] = {
			Size = 13,
			Center = true,
			Outline = true,
			Font = Drawing.Fonts.Plex,
			Color = Color3.fromRGB(255, 255, 255)
		},
		["Square"] = {
			Thickness = 1,
			Color = Color3.fromRGB(255, 255, 255),
			Filled = false,
		},
		["Triangle"] = {
			Color = Color3.fromRGB(255, 255, 255),
			Filled = true,
			Visible = false,
			Thickness = 1,
		},
		["Image"] = {
			Transparency = 1,
			Data = game:HttpGet("https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
		}
	},
}
local sfx = {["Bameware"] = "16910460773",["Skeet"] = "4753603610",["Bonk"] = "3765689841",["Lazer Beam"] = "130791043",["Windows XP Error"] = "160715357",["TF2 Hitsound"] = "3455144981",["TF2 Critical"] = "296102734",["TF2 Bat"] = "3333907347",['Bow Hit'] = "1053296915",['Bow'] = "3442683707",['OSU'] = "7147454322",['Minecraft Hit'] = "4018616850",['Steve'] = "5869422451",['1nn'] = "7349055654",['Rust'] = "3744371091",["TF2 Pan"] = "3431749479",["Neverlose"] = "8679627751",["Mario"] = "5709456554",};
local sfx_names = {"Bameware", "Skeet", "Bonk", "Lazer Beam", "Windows XP Error", "TF2 Hitsound", "TF2 Critical", "TF2 Bat", "Bow Hit", "Bow", "OSU", "Minecraft Hit", "Steve", "1nn", "Rust", "TF2 Pan", "Neverlose", "Mario"};
local LocalPlayer = Players.LocalPlayer; 
local Mouse = LocalPlayer:GetMouse();
local Camera = Workspace.Camera;
local viewportSize = game.Workspace.Camera.ViewportSize;
local hitmodule = game:GetObjects("rbxassetid://7255773215")[1]; hitmodule.Parent = ReplicatedStorage;
local Offset = game:GetService("GuiService"):GetGuiInset().Y;
local NotifiactionSGui = Instance.new("ScreenGui", game.CoreGui); NotifiactionSGui.Enabled = true
local NewVector2 = Vector2.new;
local NewVector3 = Vector3.new;
local NewCFrame = CFrame.new; 
local Angle = CFrame.Angles; 
local NewHex = Color3.fromHex;
local Floor = math.floor;
local Random = math.random; 
local Find = table.find;
local Round = math.round;
local Cos = math.cos;
local Sin = math.sin;
local Rad = math.rad; 
local Clamp = math.clamp; 
local Ceil = math.ceil; 
local Pi = math.pi;
local Sqrt = math.sqrt;
local Lighting_Save = {["ColorShift_Bottom"] = Lighting.ColorShift_Bottom, ["Ambient"]=Lighting.Ambient, ["OutdoorAmbient"]=Lighting.OutdoorAmbient, ["ColorShift_Top"]=Lighting.ColorShift_Top, ["FogColor"]=Lighting.FogColor, ["FogEnd"]=Lighting.FogEnd, ["FogStart"]=Lighting.FogStart, ["ClockTime"]=Lighting.ClockTime, ["Brightness"]=Lighting.Brightness}
local bodyClone = game:GetObjects("rbxassetid://8246626421")[1]; bodyClone.Humanoid:Destroy(); bodyClone.Head.Face:Destroy(); bodyClone.Parent = game.Workspace; bodyClone.HumanoidRootPart.Velocity = Vector3.new(); bodyClone.HumanoidRootPart.CFrame = NewCFrame(9999,9999,9999); bodyClone.HumanoidRootPart.Transparency = 1; bodyClone.HumanoidRootPart.CanCollide = false 
local visualizeChams = Instance.new("Highlight"); visualizeChams.Enabled = true; visualizeChams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; visualizeChams.FillColor = Color3.fromRGB(102, 60, 153); visualizeChams.OutlineColor =  Color3.fromRGB(0, 0, 0); visualizeChams.Adornee = bodyClone; visualizeChams.OutlineTransparency = 0.2; visualizeChams.FillTransparency = 0.5; visualizeChams.Parent = game.CoreGui
local targetHighlight = Instance.new("Highlight", game.CoreGui); targetHighlight.Enabled = true; targetHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; targetHighlight.FillColor = Color3.fromRGB(0,0,0); targetHighlight.OutlineColor = Color3.fromRGB(255,255,255); targetHighlight.OutlineTransparency = 0.5; targetHighlight.FillTransparency = 0;
local IgnoreList = {};
local Tween = {};
local crosshair_Lines = {}; 
local crosshair_Outlines = {}; 
local C_Desync = {Enabled = false, OldPosition = nil, PredictedPosition = nil};
local connections = {};
local highlights = {};
local Dropdowns = {}; 
local Pickers = {}; 
local VisValues = {}; 
local Typing = false; 
local aimAssistTarget; 
local checks; 
local prediction; 
local partClosest; 
local antiCheattick = 0; 
local CursorSize = 0; 
local statsTick = 0;
local crosshair_LineAmount = 4;
local crosshair_SpinAngle = 0; 
local crosshair_tick = 0;
local buying = false; 
local PlaceHolderUI = Instance.new("ScreenGui", game.CoreGui);
PlaceHolderUI.Name = "KeybindListGui"
PlaceHolderUI.DisplayOrder = 100
PlaceHolderUI.ResetOnSpawn = false
PlaceHolderUI.Enabled = false
local Languages = {
    A = {English = "A", Arabic = "أ", Albanian = "A", Japanese = "あ", Spanish = "A", Russian = "А", Chinese = "阿", Urdu = "ا", French = "A", Portuguese = "A", Hindi = "अ"},
    B = {English = "B", Arabic = "ب", Albanian = "B", Japanese = "い", Spanish = "B", Russian = "Б", Chinese = "波", Urdu = "ب", French = "B", Portuguese = "B", Hindi = "ब"},
    C = {English = "C", Arabic = "ت", Albanian = "C", Japanese = "う", Spanish = "C", Russian = "Ц", Chinese = "西", Urdu = "س", French = "C", Portuguese = "C", Hindi = "स"},
    D = {English = "D", Arabic = "د", Albanian = "D", Japanese = "え", Spanish = "D", Russian = "Д", Chinese = "德", Urdu = "ڈ", French = "D", Portuguese = "D", Hindi = "ड"},
    E = {English = "E", Arabic = "إ", Albanian = "E", Japanese = "お", Spanish = "E", Russian = "Е", Chinese = "俄", Urdu = "اے", French = "E", Portuguese = "E", Hindi = "ए"},
    F = {English = "F", Arabic = "ف", Albanian = "F", Japanese = "か", Spanish = "F", Russian = "Ф", Chinese = "夫", Urdu = "ف", French = "F", Portuguese = "F", Hindi = "फ"},
    G = {English = "G", Arabic = "ج", Albanian = "G", Japanese = "き", Spanish = "G", Russian = "Г", Chinese = "吉", Urdu = "ج", French = "G", Portuguese = "G", Hindi = "ग"},
    H = {English = "H", Arabic = "ح", Albanian = "H", Japanese = "く", Spanish = "H", Russian = "Х", Chinese = "艾尺", Urdu = "ح", French = "H", Portuguese = "H", Hindi = "ह"},
    I = {English = "I", Arabic = "ي", Albanian = "I", Japanese = "け", Spanish = "I", Russian = "И", Chinese = "伊", Urdu = "آئی", French = "I", Portuguese = "I", Hindi = "इ"},
    J = {English = "J", Arabic = "ج", Albanian = "J", Japanese = "こ", Spanish = "J", Russian = "Й", Chinese = "杰", Urdu = "جے", French = "J", Portuguese = "J", Hindi = "ज"},
    K = {English = "K", Arabic = "ك", Albanian = "K", Japanese = "さ", Spanish = "K", Russian = "К", Chinese = "开", Urdu = "کے", French = "K", Portuguese = "K", Hindi = "क"},
    L = {English = "L", Arabic = "ل", Albanian = "L", Japanese = "し", Spanish = "L", Russian = "Л", Chinese = "艾勒", Urdu = "ل", French = "L", Portuguese = "L", Hindi = "ल"},
    M = {English = "M", Arabic = "م", Albanian = "M", Japanese = "す", Spanish = "M", Russian = "М", Chinese = "艾马", Urdu = "م", French = "M", Portuguese = "M", Hindi = "म"},
    N = {English = "N", Arabic = "ن", Albanian = "N", Japanese = "せ", Spanish = "N", Russian = "Н", Chinese = "艾娜", Urdu = "ن", French = "N", Portuguese = "N", Hindi = "न"},
    O = {English = "O", Arabic = "أو", Albanian = "O", Japanese = "そ", Spanish = "O", Russian = "О", Chinese = "哦", Urdu = "او", French = "O", Portuguese = "O", Hindi = "ओ"},
    P = {English = "P", Arabic = "ب", Albanian = "P", Japanese = "た", Spanish = "P", Russian = "П", Chinese = "屁", Urdu = "پ", French = "P", Portuguese = "P", Hindi = "प"},
    Q = {English = "Q", Arabic = "ق", Albanian = "Q", Japanese = "ち", Spanish = "Q", Russian = "К", Chinese = "丘", Urdu = "ق", French = "Q", Portuguese = "Q", Hindi = "क्यू"},
    R = {English = "R", Arabic = "ر", Albanian = "R", Japanese = "つ", Spanish = "R", Russian = "Р", Chinese = "艾儿", Urdu = "ر", French = "R", Portuguese = "R", Hindi = "र"},
    S = {English = "S", Arabic = "س", Albanian = "S", Japanese = "て", Spanish = "S", Russian = "С", Chinese = "艾丝", Urdu = "س", French = "S", Portuguese = "S", Hindi = "एस"},
    T = {English = "T", Arabic = "ت", Albanian = "T", Japanese = "と", Spanish = "T", Russian = "Т", Chinese = "提", Urdu = "ٹ", French = "T", Portuguese = "T", Hindi = "ट"},
    U = {English = "U", Arabic = "أو", Albanian = "U", Japanese = "な", Spanish = "U", Russian = "У", Chinese = "优", Urdu = "یو", French = "U", Portuguese = "U", Hindi = "यू"},
    V = {English = "V", Arabic = "ف", Albanian = "V", Japanese = "に", Spanish = "V", Russian = "В", Chinese = "维", Urdu = "وی", French = "V", Portuguese = "V", Hindi = "व"},
    W = {English = "W", Arabic = "و", Albanian = "W", Japanese = "ぬ", Spanish = "W", Russian = "В", Chinese = "豆贝尔维", Urdu = "ڈبلیو", French = "W", Portuguese = "W", Hindi = "डब्ल्यू"},
    X = {English = "X", Arabic = "إكس", Albanian = "X", Japanese = "ね", Spanish = "X", Russian = "Х", Chinese = "艾克斯", Urdu = "اکس", French = "X", Portuguese = "X", Hindi = "एक्स"},
    Y = {English = "Y", Arabic = "ي", Albanian = "Y", Japanese = "の", Spanish = "Y", Russian = "У", Chinese = "伊儿", Urdu = "وائی", French = "Y", Portuguese = "Y", Hindi = "वाई"},
    Z = {English = "Z", Arabic = "ز", Albanian = "Z", Japanese = "は", Spanish = "Z", Russian = "З", Chinese = "贼德", Urdu = "زیڈ", French = "Z", Portuguese = "Z", Hindi = "जेड"}
}
local utx = {} 
local Messages = {}
local drawingCache = {} 

utility.folders["Part Chams"] = Instance.new("Folder", Workspace);
utility.folders["Hit Chams"] = Instance.new("Folder", Workspace);
Library.__index = Library;
Library.Pages.__index = Library.Pages;
Library.Sections.__index = Library.Sections;

-- // Functions
	-- // Library Functions
	do
		function Library:Connection(Signal, Callback)
			local Con = Signal:Connect(Callback)
			return Con
		end
		--  
		function Library:updateNotifsPositions(position)
			for i, v in pairs(Library.Notifs) do 
				local Position
				if position == "Middle" then
					Position = NewVector2(viewportSize.X/2 - (v["Objects"][3].TextBounds.X + 10)/2, 600)
				elseif position == "Right" then
					Position = NewVector2(viewportSize.X - v["Objects"][3].TextBounds.X - 30, 20)
				else
					Position = NewVector2(20, 20)
				end
				game:GetService("TweenService"):Create(v.Container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0,Position.X,0,Position.Y + (i * 35))}):Play()
			end 
		end
		-- 
		function Library:Notification(message, duration, color, position)
			local notification = {Container = nil, Objects = {}}
			-- 
			local NotifContainer = Instance.new('Frame', NotifiactionSGui)
			local Background = Instance.new('Frame', NotifContainer)
			local Outline = Instance.new('Frame', Background)
			local UIStroke = Instance.new('UIStroke', Outline)
			local TextLabel = Instance.new('TextLabel', Background)
			local Accemt = Instance.new('Frame', Background)
			local Progress = Instance.new('Frame', Background)
			--
			local Position
			if position == "Middle" then
				Position = NewVector2(viewportSize.X/2 - (TextLabel.TextBounds.X + 10)/2, 600)
			elseif position == "Right" then
				Position = NewVector2(viewportSize.X - TextLabel.TextBounds.X - 30, 20)
			else
				Position = NewVector2(20, 20)
			end
			--
			NotifContainer.Name = "NotifContainer"
			NotifContainer.Position = UDim2.new(0,Position.X, 0, Position.Y)
			NotifContainer.Size = UDim2.new(0,TextLabel.TextBounds.X + 10,0,25)
			NotifContainer.BackgroundColor3 = Color3.new(1,1,1)
			NotifContainer.BackgroundTransparency = 1
			NotifContainer.BorderSizePixel = 0
			NotifContainer.BorderColor3 = Color3.new(0,0,0)
			NotifContainer.ZIndex = 99999999
			notification.Container = NotifContainer
			--
			Background.Name = "Background"
			Background.Size = UDim2.new(1,0,1,0)
			Background.BackgroundColor3 = Color3.new(0.0588,0.0588,0.0784)
			Background.BorderColor3 = Color3.new(0.1373,0.1373,0.1569)
			table.insert(notification.Objects, Background)
			--
			Outline.Name = "Outline"
			Outline.Position = UDim2.new(0,-1,0,-1)
			Outline.Size = UDim2.new(1,2,1,2)
			Outline.BackgroundColor3 = Color3.new(1,1,1)
			Outline.BackgroundTransparency = 1
			Outline.BorderSizePixel = 0
			Outline.BorderColor3 = Color3.new(0,0,0)
			table.insert(notification.Objects, Outline)
			--
			TextLabel.Name = "TextLabel"
			TextLabel.Position = UDim2.new(0,5,0,0)
			TextLabel.Size = UDim2.new(1,-10,1,0)
			TextLabel.BackgroundColor3 = Color3.new(1,1,1)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.BorderColor3 = Color3.new(0,0,0)
			TextLabel.Text = message
			TextLabel.TextColor3 = Color3.new(0.9216,0.9216,0.9216)
			TextLabel.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			TextLabel.TextSize = Library.FontSize + 2
			TextLabel.AutomaticSize = Enum.AutomaticSize.X
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(notification.Objects, TextLabel)
			--
			Accemt.Name = "Accemt"
			Accemt.Size = UDim2.new(1,0,0,1)
			Accemt.BackgroundColor3 = Library.Accent
			Accemt.BorderSizePixel = 0
			Accemt.BorderColor3 = Color3.new(0,0,0)
			table.insert(notification.Objects, Accemt)
			--
			Progress.Name = "Progress"
			Progress.Position = UDim2.new(0,0,1,-1)
			Progress.Size = UDim2.new(0,0,0,1)
			Progress.BackgroundColor3 = Color3.new(1,0,0)
			Progress.BorderSizePixel = 0
			Progress.BorderColor3 = Color3.new(0,0,0)
			table.insert(notification.Objects, Progress)
		
			if color ~= nil then
				Progress.BackgroundColor3 = color
				Accemt.BackgroundColor3 = color
			end
		
			function notification:remove()
				table.remove(Library.Notifs, table.find(Library.Notifs, notification))
				Library:updateNotifsPositions(position)
				notification.Container:Destroy()
			end
		
			task.spawn(function()
				Background.AnchorPoint = NewVector2(1,0)
				local Tween1 = game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {AnchorPoint = NewVector2(0,0)}):Play()
				local Tween2 = game:GetService("TweenService"):Create(Progress, TweenInfo.new(duration or 5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,0,1)}):Play()
				game:GetService("TweenService"):Create(Progress, TweenInfo.new(duration or 5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.new(0,1,0)}):Play()
				task.wait(duration)
				game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {AnchorPoint = NewVector2(1,0)}):Play()
				for i,v in next, notification.Objects do
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				end
				game:GetService("TweenService"):Create(TextLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
				game:GetService("TweenService"):Create(UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
			end)
		
			task.delay(0.25 + duration + 0.25, function()
				notification:remove()
			end)
		
			table.insert(Library.Notifs, notification)
			NotifContainer.Position = UDim2.new(0,Position.X,0,Position.Y + (table.find(Library.Notifs, notification) * 35))
			NotifContainer.Size = UDim2.new(0,TextLabel.TextBounds.X + 10,0,25)
			Library:updateNotifsPositions(position)

			return notification
		end
		--
		function Library:Disconnect(Connection)
			Connection:Disconnect()
		end
		--
		function Library:Round(Number, Float)
			return Float * math.floor(Number / Float)
		end
		--
		function Library.NextFlag()
			Library.UnNamedFlags = Library.UnNamedFlags + 1
			return string.format("%.14g", Library.UnNamedFlags)
		end
		--
		function Library:GetConfig()
			local Config = ""
			for Index, Value in pairs(self.Flags) do
				if
					Index ~= "ConfigConfig_List"
					and Index ~= "ConfigConfig_Load"
					and Index ~= "ConfigConfig_Save"
				then
					local Value2 = Value
					local Final = ""
					--
					if typeof(Value2) == "Color3" then
						local hue, sat, val = Value2:ToHSV()
						--
						Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, 1)
					elseif typeof(Value2) == "table" and Value2.Color and Value2.Transparency then
						local hue, sat, val = Value2.Color:ToHSV()
						--
						Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, Value2.Transparency)
					elseif typeof(Value2) == "table" and Value.Mode then
						local Values = Value.current
						--
						Final = ("key(%s,%s,%s)"):format(Values[1] or "nil", Values[2] or "nil", Value.Mode)
					elseif Value2 ~= nil then
						if typeof(Value2) == "boolean" then
							Value2 = ("bool(%s)"):format(tostring(Value2))
						elseif typeof(Value2) == "table" then
							local New = "table("
							--
							for Index2, Value3 in pairs(Value2) do
								New = New .. Value3 .. ","
							end
							--
							if New:sub(#New) == "," then
								New = New:sub(0, #New - 1)
							end
							--
							Value2 = New .. ")"
						elseif typeof(Value2) == "string" then
							Value2 = ("string(%s)"):format(Value2)
						elseif typeof(Value2) == "number" then
							Value2 = ("number(%s)"):format(Value2)
						end
						--
						Final = Value2
					end
					--
					Config = Config .. Index .. ": " .. tostring(Final) .. "\n"
				end
			end
			--
			return Config
		end
		--
		function Library:LoadConfig(Config)
			for i = 1, 10 do 
				local Table = string.split(Config, "\n")
				local Table2 = {}
				for Index, Value in pairs(Table) do
					local Table3 = string.split(Value, ":")
					--
					if Table3[1] ~= "ConfigConfig_List" and #Table3 >= 2 then
						local Value = Table3[2]:sub(2, #Table3[2])
						--
						if Value:sub(1, 3) == "rgb" then
							local Table4 = string.split(Value:sub(5, #Value - 1), ",")
							--
							Value = Table4
						elseif Value:sub(1, 3) == "key" then
							local Table4 = string.split(Value:sub(5, #Value - 1), ",")
							--
							if Table4[1] == "nil" and Table4[2] == "nil" then
								Table4[1] = nil
								Table4[2] = nil
							end
							--
							Value = Table4
						elseif Value:sub(1, 4) == "bool" then
							local Bool = Value:sub(6, #Value - 1)
							--
							Value = Bool == "true"
						elseif Value:sub(1, 5) == "table" then
							local Table4 = string.split(Value:sub(7, #Value - 1), ",")
							--
							Value = Table4
						elseif Value:sub(1, 6) == "string" then
							local String = Value:sub(8, #Value - 1)
							--
							Value = String
						elseif Value:sub(1, 6) == "number" then
							local Number = tonumber(Value:sub(8, #Value - 1))
							--
							Value = Number
						end
						--
						Table2[Table3[1]] = Value
					end
				end 
				--
				for i, v in pairs(Table2) do
					if Flags[i] then
						if typeof(Flags[i]) == "table" then
							Flags[i]:Set(v)
						else
							Flags[i](v)
						end
					end
				end
			end
		end
		--
		function Library:SetOpen(bool)
			if typeof(bool) == 'boolean' then
				Library.Open = bool;
				Library.Holder.Visible = bool;
			end
		end;
		--
		function Library:ChangeAccent(Color)
			Library.Accent = Color

			for obj, theme in next, Library.ThemeObjects do
				if theme:IsA("Frame") or theme:IsA("TextButton") then
					theme.BackgroundColor3 = Color
				elseif theme:IsA("TextLabel") then
					theme.TextColor3 = Color
				elseif theme:IsA("TextButton") and theme.BackgroundTransparency == 1 then
					theme.TextColor3 = Color
				end
			end
		end
		--
		function Library:IsMouseOverFrame(Frame)
			local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

			if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
				and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

				return true;
			end;
		end;
		-- 
		function Library:KeybindList()
			local KeyList = {Keybinds = {}, Dragging = false, DragOffset = UDim2.new(0,0,0,0)};
			Library.KeyList = KeyList
			--
			local KeyOutline = Instance.new('Frame', PlaceHolderUI)
			local KeyInline = Instance.new('Frame', KeyOutline)
			local KeyAccent = Instance.new('Frame', KeyInline)
			local KeyHolder = Instance.new('Frame', KeyInline)
			local UIListLayout = Instance.new('UIListLayout', KeyHolder)
			local KeyTitle = Instance.new('TextLabel', KeyInline)
			local LineThing = Instance.new('Frame', KeyInline)
			local DragArea = Instance.new('TextButton', KeyInline)
			--
			KeyOutline.Name = "KeyOutline"
			KeyOutline.Position = UDim2.new(0.02,0,0.5,0)
			KeyOutline.BackgroundColor3 = Color3.new(0.1765,0.1765,0.1765)
			KeyOutline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
			KeyOutline.AnchorPoint = NewVector2(0,0.5)
			KeyOutline.AutomaticSize = Enum.AutomaticSize.Y
			KeyOutline.Size = UDim2.new(0,180,0,22)
			--
			KeyInline.Name = "KeyInline"
			KeyInline.Position = UDim2.new(0,1,0,1)
			KeyInline.Size = UDim2.new(1,-2,1,-2)
			KeyInline.BackgroundColor3 = Color3.new(0.0745,0.0745,0.0745)
			KeyInline.BorderSizePixel = 0
			KeyInline.BorderColor3 = Color3.new(0,0,0)
			KeyInline.AutomaticSize = Enum.AutomaticSize.Y
			--
			KeyAccent.Name = "KeyAccent"
			KeyAccent.Size = UDim2.new(1,0,0,1)
			KeyAccent.BackgroundColor3 = Library.Accent
			KeyAccent.BorderSizePixel = 0
			KeyAccent.BorderColor3 = Color3.new(0,0,0)
			table.insert(Library.ThemeObjects, KeyAccent)
			--
			KeyHolder.Name = "KeyHolder"
			KeyHolder.Position = UDim2.new(0,0,0,22)
			KeyHolder.BackgroundColor3 = Color3.new(1,1,1)
			KeyHolder.BackgroundTransparency = 1
			KeyHolder.BorderSizePixel = 0
			KeyHolder.BorderColor3 = Color3.new(0,0,0)
			KeyHolder.AutomaticSize = Enum.AutomaticSize.Y
			KeyHolder.Size = UDim2.new(1,0,0,0)
			--
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0,2)
			--
			KeyTitle.Name = "KeyTitle"
			KeyTitle.Size = UDim2.new(1,0,0,20)
			KeyTitle.BackgroundColor3 = Color3.new(1,1,1)
			KeyTitle.BackgroundTransparency = 1
			KeyTitle.BorderSizePixel = 0
			KeyTitle.BorderColor3 = Color3.new(0,0,0)
			KeyTitle.Text = "Keybinds"
			KeyTitle.TextColor3 = Color3.new(1,1,1)
			KeyTitle.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			KeyTitle.TextSize = 12
			KeyTitle.TextStrokeTransparency = 0
			--
			LineThing.Name = "LineThing"
			LineThing.Position = UDim2.new(0,0,0,20)
			LineThing.Size = UDim2.new(1,0,0,1)
			LineThing.BackgroundColor3 = Color3.new(0.1765,0.1765,0.1765)
			LineThing.BorderSizePixel = 0
			LineThing.BorderColor3 = Color3.new(0,0,0)
			--
			DragArea.Name = "DragArea"
			DragArea.Size = UDim2.new(1,0,0,20)
			DragArea.BackgroundTransparency = 1
			DragArea.BorderSizePixel = 0
			DragArea.Text = ""
			DragArea.ZIndex = 10
			
			-- Dragging functionality
			Library:Connection(DragArea.MouseButton1Down, function(input)
				KeyList.Dragging = true
				KeyList.DragOffset = UDim2.new(0, KeyOutline.AbsolutePosition.X - Mouse.X, 0, KeyOutline.AbsolutePosition.Y - Mouse.Y)
			end)
			
			Library:Connection(game:GetService("UserInputService").InputChanged, function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and KeyList.Dragging then
					KeyOutline.Position = UDim2.new(0, Mouse.X + KeyList.DragOffset.X.Offset, 0, Mouse.Y + KeyList.DragOffset.Y.Offset)
				end
			end)
			
			Library:Connection(game:GetService("UserInputService").InputEnded, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					KeyList.Dragging = false
				end
			end)
			
			-- Functions
			function KeyList:SetVisible(State)
				PlaceHolderUI.Enabled = State;
			end;
			--
			function KeyList:NewKey(Name, Key, Mode)
				local KeyValue = {}
				--
				local NewValue = Instance.new('TextLabel', KeyHolder)
				--
				NewValue.Name = "NewValue"
				NewValue.Size = UDim2.new(1,0,0,15)
				NewValue.BackgroundColor3 = Color3.new(1,1,1)
				NewValue.BackgroundTransparency = 1
				NewValue.BorderSizePixel = 0
				NewValue.BorderColor3 = Color3.new(0,0,0)
				NewValue.Text = tostring(" ["..Name.."] " .. Key .. " (" .. Mode ..") ")
				NewValue.TextColor3 = Color3.new(0.5,0.5,0.5) -- Default inactive color
				NewValue.FontFace = Font.new(Font:GetRegistry("menu_plex"))
				NewValue.TextSize = 12
				NewValue.TextXAlignment = Enum.TextXAlignment.Left
				NewValue.Visible = true
				--
				function KeyValue:SetVisible(State)
					if State then
						-- Active keybind
						NewValue.TextColor3 = Color3.new(1,1,1)
					else
						-- Inactive keybind
						NewValue.TextColor3 = Color3.new(0.5,0.5,0.5)
					end
				end;
				--
				function KeyValue:Update(NewName, NewKey, NewMode)
					NewValue.Text = tostring(" ["..NewName.."] " .. NewKey .. " (" .. NewMode ..") ")
				end;
				
				table.insert(KeyList.Keybinds, KeyValue)
				return KeyValue
			end;
			return KeyList
		end
		--
		function Sections:Dropdown(Properties)
			local Properties = Properties or {};
			local Dropdown = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Open = false,
				Name = Properties.Name or Properties.name or nil,
				Options = (Properties.options or Properties.Options or Properties.values or Properties.Values or {
					"1",
					"2",
					"3",
				}),
				Max = (Properties.Max or Properties.max or nil),
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or nil
				),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
				OptionInsts = {},
			}
			--
			local NewDrop = Instance.new('Frame', Dropdown.Section.Elements.SectionContent)
			local Outline = Instance.new('TextButton', NewDrop)
			local Inline = Instance.new('Frame', Outline)
			local Value = Instance.new('TextLabel', Inline)
			local Icon = Instance.new('TextLabel', Inline)
			local Title = Instance.new('TextLabel', NewDrop)
			local ContainerOutline = Instance.new('Frame', NewDrop)
			local ContainerInline = Instance.new('Frame', ContainerOutline)
			local UIListLayout = Instance.new('UIListLayout', ContainerInline)
			--
			NewDrop.Name = "NewDrop"
			NewDrop.Size = UDim2.new(1,0,0,30)
			NewDrop.BackgroundColor3 = Color3.new(1,1,1)
			NewDrop.BackgroundTransparency = 1
			NewDrop.BorderSizePixel = 0
			NewDrop.BorderColor3 = Color3.new(0,0,0)
			--
			Outline.Name = "Outline"
			Outline.Position = UDim2.new(0,15,1,0)
			Outline.Size = UDim2.new(1,-30,0,16)
			Outline.BackgroundColor3 = Color3.new(0.1765,0.1765,0.1765)
			Outline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
			Outline.AnchorPoint = NewVector2(0,1)
			Outline.Text = ""
			Outline.AutoButtonColor = false
			--
			Inline.Name = "Inline"
			Inline.Position = UDim2.new(0,1,0,1)
			Inline.Size = UDim2.new(1,-2,1,-2)
			Inline.BackgroundColor3 = Color3.new(0.1294,0.1294,0.1294)
			Inline.BorderSizePixel = 0
			Inline.BorderColor3 = Color3.new(0,0,0)
			--
			Value.Name = "Value"
			Value.Position = UDim2.new(0,2,0,0)
			Value.Size = UDim2.new(1,-30,1,0)
			Value.BackgroundColor3 = Color3.new(1,1,1)
			Value.BackgroundTransparency = 1
			Value.BorderSizePixel = 0
			Value.BorderColor3 = Color3.new(0,0,0)
			Value.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			Value.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Value.TextSize = Library.FontSize
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.TextStrokeTransparency = 0
			Value.TextWrapped = true
			--
			Icon.Name = "Icon"
			Icon.Position = UDim2.new(0,-5,0,0)
			Icon.Size = UDim2.new(1,0,1,0)
			Icon.BackgroundColor3 = Color3.new(1,1,1)
			Icon.BackgroundTransparency = 1
			Icon.BorderSizePixel = 0
			Icon.BorderColor3 = Color3.new(0,0,0)
			Icon.Text = "+"
			Icon.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			Icon.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Icon.TextSize = Library.FontSize
			Icon.TextXAlignment = Enum.TextXAlignment.Right
			Icon.TextStrokeTransparency = 0
			--
			Title.Name = "Title"
			Title.Position = UDim2.new(0,15,0,0)
			Title.Size = UDim2.new(1,0,0,10)
			Title.BackgroundColor3 = Color3.new(1,1,1)
			Title.BackgroundTransparency = 1
			Title.BorderSizePixel = 0
			Title.BorderColor3 = Color3.new(0,0,0)
			Title.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			Title.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Title.TextSize = Library.FontSize
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.TextStrokeTransparency = 0
			Title.Text = Dropdown.Name
			--
			ContainerOutline.Name = "ContainerOutline"
			ContainerOutline.Position = UDim2.new(0,15,1,2)
			ContainerOutline.Size = UDim2.new(1,-30,0,10)
			ContainerOutline.BackgroundColor3 = Color3.new(0.1765,0.1765,0.1765)
			ContainerOutline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
			ContainerOutline.Visible = false
			ContainerOutline.AutomaticSize = Enum.AutomaticSize.Y
			ContainerOutline.ZIndex = 5
			--
			ContainerInline.Name = "ContainerInline"
			ContainerInline.Position = UDim2.new(0,1,0,1)
			ContainerInline.Size = UDim2.new(1,-2,1,-2)
			ContainerInline.BackgroundColor3 = Color3.new(0.1294,0.1294,0.1294)
			ContainerInline.BorderSizePixel = 0
			ContainerInline.BorderColor3 = Color3.new(0,0,0)
			ContainerInline.ZIndex = 6;
			--
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			
			-- // Connections
			Library:Connection(Outline.MouseButton1Down, function()
				ContainerOutline.Visible = not ContainerOutline.Visible
				if ContainerOutline.Visible then
					NewDrop.ZIndex = 2
					Icon.Text = "-"
				else
					NewDrop.ZIndex = 1
					Icon.Text = "+"
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if ContainerOutline.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(ContainerOutline) and not Library:IsMouseOverFrame(NewDrop) then
						ContainerOutline.Visible = false
						NewDrop.ZIndex = 1
						Icon.Text = "+"
					end
				end
			end)
			Library:Connection(NewDrop.MouseEnter, function()
				Outline.BorderColor3 = Library.Accent
				table.insert(Library.ThemeObjects, Title)
				Title.TextColor3 = Library.Accent
			end)
			--
			Library:Connection(NewDrop.MouseLeave, function()
				Outline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
				table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Title))
				Title.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			end)
			--
			local chosen = Dropdown.Max and {} or nil
			--
			local function handleoptionclick(option, button, text)
				button.MouseButton1Down:Connect(function()
					if Dropdown.Max then
						if table.find(chosen, option) then
							table.remove(chosen, table.find(chosen, option))

							local textchosen = {}
							local cutobject = false

							for _, opt in next, chosen do
								table.insert(textchosen, opt)
							end

							Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")

							text.TextColor3 = Color3.fromRGB(145,145,145)

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						else
							if #chosen == Dropdown.Max then
								Dropdown.OptionInsts[chosen[1]].text.TextColor3 = Color3.fromRGB(145,145,145)
								table.remove(chosen, 1)
							end

							table.insert(chosen, option)

							local textchosen = {}
							local cutobject = false

							for _, opt in next, chosen do
								table.insert(textchosen, opt)
							end

							Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")

							text.TextColor3 = Color3.fromRGB(255,255,255)

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						end
					else
						for opt, tbl in next, Dropdown.OptionInsts do
							if opt ~= option then
								tbl.text.TextColor3 = Color3.fromRGB(145,145,145)
							end
						end
						chosen = option
						Value.Text = option
						text.TextColor3 = Color3.fromRGB(255,255,255)
						Library.Flags[Dropdown.Flag] = option
						Dropdown.Callback(option)
					end
				end)
			end
			--
			local function createoptions(tbl)
				for _, option in next, tbl do
					Dropdown.OptionInsts[option] = {}
					local NewOption = Instance.new('TextButton', ContainerInline)
					local OptionName = Instance.new('TextLabel', NewOption)
					NewOption.Name = "NewOption"
					NewOption.Size = UDim2.new(1,0,0,15)
					NewOption.BackgroundColor3 = Color3.new(1,1,1)
					NewOption.BackgroundTransparency = 1
					NewOption.BorderSizePixel = 0
					NewOption.BorderColor3 = Color3.new(0,0,0)
					NewOption.Text = ""
					NewOption.TextColor3 = Color3.new(0,0,0)
					NewOption.AutoButtonColor = false
					NewOption.FontFace = Font.new(Font:GetRegistry("menu_plex"))
					NewOption.TextSize = 14
					NewOption.ZIndex = 7;
					Dropdown.OptionInsts[option].button = NewOption
					--
					OptionName.Name = "OptionName"
					OptionName.Position = UDim2.new(0,2,0,0)
					OptionName.Size = UDim2.new(1,0,1,0)
					OptionName.BackgroundColor3 = Color3.new(1,1,1)
					OptionName.BackgroundTransparency = 1
					OptionName.BorderSizePixel = 0
					OptionName.BorderColor3 = Color3.new(0,0,0)
					OptionName.Text = option
					OptionName.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
					OptionName.FontFace = Font.new(Font:GetRegistry("menu_plex"))
					OptionName.TextSize = Library.FontSize
					OptionName.TextXAlignment = Enum.TextXAlignment.Left
					OptionName.TextStrokeTransparency = 0
					OptionName.ZIndex = 8;
					Dropdown.OptionInsts[option].text = OptionName

					handleoptionclick(option, NewOption, OptionName)
				end
			end
			createoptions(Dropdown.Options)
			--
			local set
			set = function(option)
				if Dropdown.Max then
					table.clear(chosen)
					option = type(option) == "table" and option or {}

					for opt, tbl in next, Dropdown.OptionInsts do
						if not table.find(option, opt) then
							tbl.text.TextColor3 = Color3.fromRGB(145,145,145)
						end
					end

					for i, opt in next, option do
						if table.find(Dropdown.Options, opt) and #chosen < Dropdown.Max then
							table.insert(chosen, opt)
							Dropdown.OptionInsts[opt].text.TextColor3 = Color3.fromRGB(255,255,255)
						end
					end

					local textchosen = {}
					local cutobject = false

					for _, opt in next, chosen do
						table.insert(textchosen, opt)
					end

					Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")

					Library.Flags[Dropdown.Flag] = chosen
					Dropdown.Callback(chosen)
				end
			end
			--
			function Dropdown:Set(option)
				if Dropdown.Max then
					set(option)
				else
					for opt, tbl in next, Dropdown.OptionInsts do
						if opt ~= option then
							tbl.text.TextColor3 = Color3.fromRGB(145,145,145)
						end
					end
					if table.find(Dropdown.Options, option) then
						chosen = option
						Value.Text = option
						Dropdown.OptionInsts[option].text.TextColor3 = Color3.fromRGB(255,255,255)
						Library.Flags[Dropdown.Flag] = chosen
						Dropdown.Callback(chosen)
					else
						chosen = nil
						Value.Text = ""
						Library.Flags[Dropdown.Flag] = chosen
						Dropdown.Callback(chosen)
					end
				end
			end
			--
			function Dropdown:Refresh(tbl)
				for _, opt in next, Dropdown.OptionInsts do
					coroutine.wrap(function()
						opt.button:Destroy()
					end)()
				end
				table.clear(Dropdown.OptionInsts)

				createoptions(tbl)

				if Dropdown.Max then
					table.clear(chosen)
				else
					chosen = nil
				end

				Library.Flags[Dropdown.Flag] = chosen
				Dropdown.Callback(chosen)
			end

			-- // Returning
			if Dropdown.Max then
				Flags[Dropdown.Flag] = set
			else
				Flags[Dropdown.Flag] = Dropdown
			end
			Dropdown:Set(Dropdown.State)
			function Dropdown:SetVisible(Bool) 
				NewDrop.Visible = Bool 
			end 
			return Dropdown
		end
		--
		function Sections:Keybind(Properties)
			local Properties = Properties or {}
			local Keybind = {
				Section = self,
				Name = Properties.name or Properties.Name or "Keybind",
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or nil
				),
				Mode = (Properties.mode or Properties.Mode or "Toggle"),
				UseKey = (Properties.UseKey or false),
				Ignore = (Properties.ignore or Properties.Ignore or false),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
				Binding = nil,
			}
			local Key
			local State = false
			--
			local NewKey = Instance.new('Frame', Keybind.Section.Elements.SectionContent)
			local Outline = Instance.new('TextButton', NewKey)
			local Inline = Instance.new('Frame', Outline)
			local Value = Instance.new('TextLabel', Inline)
			local Title = Instance.new('TextLabel', NewKey)
			local ModeOutline = Instance.new('Frame', NewKey)
			local ModeInline = Instance.new('Frame', ModeOutline)
			local UIListLayout = Instance.new('UIListLayout', ModeInline)
			local Hold = Instance.new('TextButton', ModeInline)
			local Toggle = Instance.new('TextButton', ModeInline)
			local Always = Instance.new('TextButton', ModeInline)
			local ListValue = Library.KeyList:NewKey(tostring(Keybind.State):gsub("Enum.KeyCode.", ""), Keybind.Name, Keybind.Mode)
			--
			NewKey.Name = "NewKey"
			NewKey.Size = UDim2.new(1,0,0,12)
			NewKey.BackgroundColor3 = Color3.new(1,1,1)
			NewKey.BackgroundTransparency = 1
			NewKey.BorderSizePixel = 0
			NewKey.BorderColor3 = Color3.new(0,0,0)
			--
			Outline.Name = "Outline"
			Outline.Position = UDim2.new(1,0,0.5,0)
			Outline.Size = UDim2.new(0,40,0,12)
			Outline.BackgroundColor3 = Color3.new(0.1765,0.1765,0.1765)
			Outline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
			Outline.AnchorPoint = NewVector2(1,0.5)
			Outline.Text = ""
			Outline.AutoButtonColor = false
			--
			Inline.Name = "Inline"
			Inline.Position = UDim2.new(0,1,0,1)
			Inline.Size = UDim2.new(1,-2,1,-2)
			Inline.BackgroundColor3 = Color3.new(0.1294,0.1294,0.1294)
			Inline.BorderSizePixel = 0
			Inline.BorderColor3 = Color3.new(0,0,0)
			--
			Value.Name = "Value"
			Value.Size = UDim2.new(1,0,1,0)
			Value.BackgroundColor3 = Color3.new(1,1,1)
			Value.BackgroundTransparency = 1
			Value.BorderSizePixel = 0
			Value.BorderColor3 = Color3.new(0,0,0)
			Value.Text = "MB2"
			Value.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			Value.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Value.TextSize = Library.FontSize
			Value.TextStrokeTransparency = 0
			--
			Title.Name = "Title"
			Title.Position = UDim2.new(0,15,0,0)
			Title.Size = UDim2.new(1,0,0,10)
			Title.BackgroundColor3 = Color3.new(1,1,1)
			Title.BackgroundTransparency = 1
			Title.BorderSizePixel = 0
			Title.BorderColor3 = Color3.new(0,0,0)
			Title.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			Title.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Title.TextSize = Library.FontSize
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.Text = Keybind.Name
			Title.TextStrokeTransparency = 0
			--
			ModeOutline.Name = "ModeOutline"
			ModeOutline.Position = UDim2.new(1,65,0.5,0)
			ModeOutline.Size = UDim2.new(0,60,0,12)
			ModeOutline.BackgroundColor3 = Color3.new(0.1765,0.1765,0.1765)
			ModeOutline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
			ModeOutline.AnchorPoint = NewVector2(1,0.5)
			ModeOutline.AutomaticSize = Enum.AutomaticSize.Y
			ModeOutline.Visible = false
			--
			ModeInline.Name = "ModeInline"
			ModeInline.Position = UDim2.new(0,1,0,1)
			ModeInline.Size = UDim2.new(1,-2,1,-2)
			ModeInline.BackgroundColor3 = Color3.new(0.1294,0.1294,0.1294)
			ModeInline.BorderSizePixel = 0
			ModeInline.BorderColor3 = Color3.new(0,0,0)
			--
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			--
			Hold.Name = "Hold"
			Hold.Size = UDim2.new(1,0,0,15)
			Hold.BackgroundColor3 = Color3.new(1,1,1)
			Hold.BackgroundTransparency = 1
			Hold.BorderSizePixel = 0
			Hold.BorderColor3 = Color3.new(0,0,0)
			Hold.Text = "Hold"
			Hold.TextColor3 = Keybind.Mode == "Hold" and Color3.new(1,1,1) or Color3.new(0.5686,0.5686,0.5686)
			Hold.AutoButtonColor = false
			Hold.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Hold.TextSize = Library.FontSize
			Hold.TextStrokeTransparency = 0
			--
			Toggle.Name = "Toggle"
			Toggle.Size = UDim2.new(1,0,0,15)
			Toggle.BackgroundColor3 = Color3.new(1,1,1)
			Toggle.BackgroundTransparency = 1
			Toggle.BorderSizePixel = 0
			Toggle.BorderColor3 = Color3.new(0,0,0)
			Toggle.Text = "Toggle"
			Toggle.TextColor3 = Keybind.Mode == "Toggle" and Color3.new(1,1,1) or Color3.new(0.5686,0.5686,0.5686)
			Toggle.AutoButtonColor = false
			Toggle.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Toggle.TextSize = Library.FontSize
			Toggle.TextStrokeTransparency = 0
			--
			Always.Name = "Always"
			Always.Size = UDim2.new(1,0,0,15)
			Always.BackgroundColor3 = Color3.new(1,1,1)
			Always.BackgroundTransparency = 1
			Always.BorderSizePixel = 0
			Always.BorderColor3 = Color3.new(0,0,0)
			Always.Text = "Always"
			Always.TextColor3 = Keybind.Mode == "Always" and Color3.new(1,1,1) or Color3.new(0.5686,0.5686,0.5686)
			Always.AutoButtonColor = false
			Always.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Always.TextSize = Library.FontSize
			Always.TextStrokeTransparency = 0
			
			-- // Functions
			local function set(newkey)
				if string.find(tostring(newkey), "Enum") then
					if c then
						c:Disconnect()
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = false
						end
						Keybind.Callback(false)
					end
					if tostring(newkey):find("Enum.KeyCode.") then
						newkey = Enum.KeyCode[tostring(newkey):gsub("Enum.KeyCode.", "")]
					elseif tostring(newkey):find("Enum.UserInputType.") then
						newkey = Enum.UserInputType[tostring(newkey):gsub("Enum.UserInputType.", "")]
					end
					if newkey == Enum.KeyCode.Backspace then
						Key = nil
						if Keybind.UseKey then
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = Key
							end
							Keybind.Callback(Key)
						end
						local text = "None"

						Value.Text = text
						ListValue:Update(text, Keybind.Name, Keybind.Mode)
					elseif newkey ~= nil then
						Key = newkey
						if Keybind.UseKey then
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = Key
							end
							Keybind.Callback(Key)
						end
						local text = (Library.Keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", ""))

						Value.Text = text
						ListValue:Update(text, Keybind.Name, Keybind.Mode)
					end

					Library.Flags[Keybind.Flag .. "_KEY"] = newkey
				elseif table.find({ "Always", "Toggle", "Hold" }, newkey) then
					if not Keybind.UseKey then
						Library.Flags[Keybind.Flag .. "_KEY STATE"] = newkey
						Keybind.Mode = newkey
						ListValue:Update((Library.Keys[Key] or tostring(Key):gsub("Enum.KeyCode.", "")), Toggle.Name, Keybind.Mode)
						if Keybind.Mode == "Always" then
							State = true
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = State
							end
							Keybind.Callback(true)
							ListValue:SetVisible(true)
						end
					end
				else
					State = newkey
					if Keybind.Flag then
						Library.Flags[Keybind.Flag] = newkey
					end
					Keybind.Callback(newkey)
				end
			end
			--
			set(Keybind.State)
			set(Keybind.Mode)
			Outline.MouseButton1Click:Connect(function()
				if not Keybind.Binding then

					Value.Text = "..."

					Keybind.Binding = Library:Connection(
						game:GetService("UserInputService").InputBegan,
						function(input, gpe)
							set(
								input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode
									or input.UserInputType
							)
							Library:Disconnect(Keybind.Binding)
							task.wait()
							Keybind.Binding = nil
						end
					)
				end
			end)
			--
			Library:Connection(game:GetService("UserInputService").InputBegan, function(inp, Chatting)
				if not Chatting then 
					if (inp.KeyCode == Key or inp.UserInputType == Key) and not Keybind.Binding and not Keybind.UseKey then
						if Keybind.Mode == "Hold" then
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = true
							end
							c = Library:Connection(game:GetService("RunService").RenderStepped, function()
								if Keybind.Callback then
									Keybind.Callback(true)
								end
							end)
							ListValue:SetVisible(true)
						elseif Keybind.Mode == "Toggle" then
							State = not State
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = State
							end
							Keybind.Callback(State)
							ListValue:SetVisible(State)
						end
					end 
				end 
			end)
			--
			Library:Connection(game:GetService("UserInputService").InputEnded, function(inp, Chatting)
				if not Chatting then 
					if Keybind.Mode == "Hold" and not Keybind.UseKey then
						if Key ~= "" or Key ~= nil then
							if inp.KeyCode == Key or inp.UserInputType == Key then
								if c then
									c:Disconnect()
									if Keybind.Flag then
										Library.Flags[Keybind.Flag] = false
									end
									if Keybind.Callback then
										Keybind.Callback(false)
									end
									ListValue:SetVisible(false)
								end
							end
						end
					end
				end 
			end)
			Library:Connection(Outline.MouseEnter, function()
				Outline.BorderColor3 = Library.Accent
			end)
			--
			Library:Connection(Outline.MouseLeave, function()
				Outline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
			end)
			--
			Library:Connection(Outline.MouseButton2Down, function()
				ModeOutline.Visible = not ModeOutline.Visible
			end)
			--
			Library:Connection(NewKey.MouseEnter, function()
				table.insert(Library.ThemeObjects, Title)
				Title.TextColor3 = Library.Accent
			end)
			--
			Library:Connection(NewKey.MouseLeave, function()
				table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Title))
				Title.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			end)
			--
			Library:Connection(Hold.MouseButton1Down, function()
				set("Hold")
				Hold.TextColor3 = Color3.new(1,1,1)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
			end)
			--
			Library:Connection(Toggle.MouseButton1Down, function()
				set("Toggle")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.new(1,1,1)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
			end)
			--
			Library:Connection(Always.MouseButton1Down, function()
				set("Always")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.new(1,1,1)
			end)
			--
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input, Chatting)
				if ModeOutline.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(ModeOutline) then
						ModeOutline.Visible = false
					end
				end
			end)
			--
			Library.Flags[Keybind.Flag .. "_KEY"] = Keybind.State
			Library.Flags[Keybind.Flag .. "_KEY STATE"] = Keybind.Mode
			Flags[Keybind.Flag] = set
			Flags[Keybind.Flag .. "_KEY"] = set
			Flags[Keybind.Flag .. "_KEY STATE"] = set
			--
			function Keybind:Set(key)
				set(key)
			end

			-- // Returning
			return Keybind
		end
		--
		function Sections:Colorpicker(Properties)
			local Properties = Properties or {}
			local Colorpicker = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = (Properties.Name or "Colorpicker"),
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or Color3.fromRGB(255, 0, 0)
				),
				Alpha = (
					Properties.alpha
						or Properties.Alpha
						or Properties.transparency
						or Properties.Transparency
						or 1
				),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
				Colorpickers = 0,
			}
			--
			local NewToggle = Instance.new('Frame', Colorpicker.Section.Elements.SectionContent)
			local TextLabel = Instance.new('TextLabel', NewToggle)
			--
			NewToggle.Name = "NewToggle"
			NewToggle.Size = UDim2.new(1,0,0,10)
			NewToggle.BackgroundColor3 = Color3.new(1,1,1)
			NewToggle.BackgroundTransparency = 1
			NewToggle.BorderSizePixel = 0
			NewToggle.BorderColor3 = Color3.new(0,0,0)
			--
			TextLabel.Position = UDim2.new(0,15,0,0)
			TextLabel.Size = UDim2.new(0,100,1,0)
			TextLabel.BackgroundColor3 = Color3.new(1,1,1)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.BorderColor3 = Color3.new(0,0,0)
			TextLabel.Text = Colorpicker.Name
			TextLabel.TextColor3 = Color3.fromRGB(145, 145, 145)
			TextLabel.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			TextLabel.TextSize = Library.FontSize
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.TextStrokeTransparency = 0
			
			Library:Connection(NewToggle.MouseEnter, function()
				table.insert(Library.ThemeObjects, TextLabel)
				TextLabel.TextColor3 = Library.Accent
			end)
			--
			Library:Connection(NewToggle.MouseLeave, function()
				table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, TextLabel))
				TextLabel.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			end)

			-- // Functions
			Colorpicker.Colorpickers = Colorpicker.Colorpickers + 1
			local colorpickertypes = Library:NewPicker(
				Colorpicker.Name,
				Colorpicker.State,
				Colorpicker.Alpha,
				NewToggle,
				Colorpicker.Colorpickers - 1,
				Colorpicker.Flag,
				Colorpicker.Callback
			)

			function Colorpicker:Set(color)
				colorpickertypes:set(color, false, true)
			end

			-- // Returning
			return Colorpicker
		end
		--
		function Sections:Textbox(Properties)
			local Properties = Properties or {}
			local Textbox = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = (Properties.Name or Properties.name or "textbox"),
				Placeholder = (
					Properties.placeholder
						or Properties.Placeholder
						or Properties.holder
						or Properties.Holder
						or ""
				),
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or ""
				),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
			}
			--
			local NewDrop = Instance.new('Frame', Textbox.Section.Elements.SectionContent)
			local Outline = Instance.new('TextButton', NewDrop)
			local Inline = Instance.new('Frame', Outline)
			local Value = Instance.new('TextBox', Inline)
			local Title = Instance.new('TextLabel', NewDrop)
			--
			NewDrop.Name = "NewDrop"
			NewDrop.Size = UDim2.new(1,0,0,30)
			NewDrop.BackgroundColor3 = Color3.new(1,1,1)
			NewDrop.BackgroundTransparency = 1
			NewDrop.BorderSizePixel = 0
			NewDrop.BorderColor3 = Color3.new(0,0,0)
			--
			Outline.Name = "Outline"
			Outline.Position = UDim2.new(0,15,1,0)
			Outline.Size = UDim2.new(1,-30,0,16)
			Outline.BackgroundColor3 = Color3.new(0.1765,0.1765,0.1765)
			Outline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
			Outline.AnchorPoint = NewVector2(0,1)
			Outline.Text = ""
			Outline.AutoButtonColor = false
			--
			Inline.Name = "Inline"
			Inline.Position = UDim2.new(0,1,0,1)
			Inline.Size = UDim2.new(1,-2,1,-2)
			Inline.BackgroundColor3 = Color3.new(0.1294,0.1294,0.1294)
			Inline.BorderSizePixel = 0
			Inline.BorderColor3 = Color3.new(0,0,0)
			--
			Value.Name = "Value"
			Value.Position = UDim2.new(0,2,0,0)
			Value.Size = UDim2.new(1,0,1,0)
			Value.BackgroundColor3 = Color3.new(1,1,1)
			Value.BackgroundTransparency = 1
			Value.BorderSizePixel = 0
			Value.BorderColor3 = Color3.new(0,0,0)
			Value.TextColor3 = Color3.fromRGB(145,145,145)
			Value.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Value.TextSize = Library.FontSize
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.TextStrokeTransparency = 0
			Value.TextWrapped = true
			Value.Text = Textbox.State
			Value.ClearTextOnFocus = false
			--
			Title.Name = "Title"
			Title.Position = UDim2.new(0,15,0,0)
			Title.Size = UDim2.new(1,0,0,10)
			Title.BackgroundColor3 = Color3.new(1,1,1)
			Title.BackgroundTransparency = 1
			Title.BorderSizePixel = 0
			Title.BorderColor3 = Color3.new(0,0,0)
			Title.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			Title.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Title.TextSize = Library.FontSize
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.TextStrokeTransparency = 0
			Title.Text = Textbox.Name
			
			-- // Connections
			Library:Connection(NewDrop.MouseEnter, function()
				Outline.BorderColor3 = Library.Accent
				table.insert(Library.ThemeObjects, Title)
				Title.TextColor3 = Library.Accent
			end)
			--
			Library:Connection(NewDrop.MouseLeave, function()
				Outline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
				table.remove(Library.ThemeObjects, table.find(Library.ThemeObjects, Title))
				Title.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			end)
			Value.FocusLost:Connect(function()
				Textbox.Callback(Value.Text)
				Library.Flags[Textbox.Flag] = Value.Text
			end)
			--
			local function set(str)
				Value.Text = str
				Library.Flags[Textbox.Flag] = str
				Textbox.Callback(str)
			end

			-- // Return
			Flags[Textbox.Flag] = set
			return Textbox
		end
		--
		function Sections:Button(Properties)
			local Properties = Properties or {}
			local Button = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = Properties.Name or "button",
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
			}
			--
			local NewButton = Instance.new('TextButton', Button.Section.Elements.SectionContent)
			local Outline = Instance.new('Frame', NewButton)
			local Inline = Instance.new('Frame', Outline)
			local Value = Instance.new('TextLabel', Inline)
			--
			NewButton.Name = "NewButton"
			NewButton.Size = UDim2.new(1,0,0,14)
			NewButton.BackgroundColor3 = Color3.new(1,1,1)
			NewButton.BackgroundTransparency = 1
			NewButton.BorderSizePixel = 0
			NewButton.BorderColor3 = Color3.new(0,0,0)
			NewButton.Text = ""
			NewButton.TextColor3 = Color3.new(0,0,0)
			NewButton.AutoButtonColor = false
			NewButton.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			NewButton.TextSize = 14
			--
			Outline.Name = "Outline"
			Outline.Position = UDim2.new(0,15,1,0)
			Outline.Size = UDim2.new(1,-30,0,14)
			Outline.BackgroundColor3 = Color3.new(0.1765,0.1765,0.1765)
			Outline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
			Outline.AnchorPoint = NewVector2(0,1)
			--
			Inline.Name = "Inline"
			Inline.Position = UDim2.new(0,1,0,1)
			Inline.Size = UDim2.new(1,-2,1,-2)
			Inline.BackgroundColor3 = Color3.new(0.1294,0.1294,0.1294)
			Inline.BorderSizePixel = 0
			Inline.BorderColor3 = Color3.new(0,0,0)
			--
			Value.Name = "Value"
			Value.Size = UDim2.new(1,0,1,0)
			Value.BackgroundColor3 = Color3.new(1,1,1)
			Value.BackgroundTransparency = 1
			Value.BorderSizePixel = 0
			Value.BorderColor3 = Color3.new(0,0,0)
			Value.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			Value.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			Value.TextSize = Library.FontSize
			Value.Text = Button.Name
			Value.TextStrokeTransparency = 0
			
			Library:Connection(NewButton.MouseEnter, function()
				Outline.BorderColor3 = Library.Accent
			end)
			--
			Library:Connection(NewButton.MouseLeave, function()
				Outline.BorderColor3 = Color3.new(0.0392,0.0392,0.0392)
			end)
			--
			Library:Connection(NewButton.MouseButton1Down, function()
				Button.Callback()
				Value.TextColor3 = Library.Accent
			end)
			--
			Library:Connection(NewButton.MouseButton1Up, function()
				Value.TextColor3 = Color3.new(0.5686,0.5686,0.5686)
			end)
		end
		--
		function Sections:Label(Properties) -- fuck finobe
			local Properties = Properties or {}
			local Label = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = Properties.Name or "label",
				Centered = Properties.Centered or false,
			}
			local NewButton = Instance.new('TextLabel', Label.Section.Elements.SectionContent) -- ya im lazy
			--
			NewButton.Name = "NewButton"
			NewButton.Size = UDim2.new(1,0,0,12)
			NewButton.BackgroundColor3 = Color3.new(1,1,1)
			NewButton.BackgroundTransparency = 1
			NewButton.BorderSizePixel = 0
			NewButton.BorderColor3 = Color3.new(0,0,0)
			NewButton.Text = Label.Name
			NewButton.TextColor3 = Color3.fromRGB(255,255,255)
			NewButton.FontFace = Font.new(Font:GetRegistry("menu_plex"))
			NewButton.TextSize = Library.FontSize
			NewButton.TextXAlignment = Label.Centered and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
			NewButton.TextStrokeTransparency = 0
			NewButton.TextStrokeColor3 = Color3.new(0,0,0)
		end
        return Library
	end
