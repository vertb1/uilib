-- UI Library Core Functions
local Library = {}
Library.__index = Library

-- Utility Functions
local function RGB(r, g, b)
    return Color3.fromRGB(r, g, b)
end

local function Lerp(delta, from, to)
    if (delta > 1) then return to end
    if (delta < 0) then return from end
    return from + (to - from) * delta
end

local function ColorRange(value, ranges)
    if value <= ranges[1].start then return ranges[1].color end
    if value >= ranges[#ranges].start then return ranges[#ranges].color end
    
    local selected = #ranges
    for i = 1, #ranges - 1 do
        if value < ranges[i + 1].start then
            selected = i
            break
        end
    end
    
    local minColor = ranges[selected]
    local maxColor = ranges[selected + 1]
    local lerpValue = (value - minColor.start) / (maxColor.start - minColor.start)
    
    return Color3.new(
        Lerp(lerpValue, minColor.color.r, maxColor.color.r),
        Lerp(lerpValue, minColor.color.g, maxColor.color.g),
        Lerp(lerpValue, minColor.color.b, maxColor.color.b)
    )
end

local function clamp(value, min, max)
    if value > max then return max
    elseif value < min then return min
    else return value end
end

-- Core Services
local INPUT_SERVICE = game:GetService("UserInputService")
local RUN_SERVICE = game:GetService("RunService")
local PLAYERS = game:GetService("Players")
local LOCAL_PLAYER = PLAYERS.LocalPlayer
local LOCAL_MOUSE = LOCAL_PLAYER:GetMouse()
local SCREEN_SIZE = workspace.CurrentCamera.ViewportSize

-- Drawing Management
local Draw = {}
local allRenderObjects = {}

function Draw:UnRender()
    for _, group in pairs(allRenderObjects) do
        for _, obj in pairs(group) do
            if obj and type(obj) ~= "number" and obj.__OBJECT_EXISTS then
                obj:Remove()
            end
        end
    end
    allRenderObjects = {}
end

function Draw:OutlinedRect(visible, pos_x, pos_y, width, height, clr, tablename)
    local rect = Drawing.new("Square")
    rect.Visible = visible
    rect.Position = Vector2.new(pos_x, pos_y)
    rect.Size = Vector2.new(width, height)
    rect.Color = RGB(clr[1], clr[2], clr[3])
    rect.Filled = false
    rect.Thickness = 1
    rect.Transparency = clr[4] / 255
    table.insert(tablename, rect)
    
    if not table.find(allRenderObjects, tablename) then
        table.insert(allRenderObjects, tablename)
    end
    
    return rect
end

function Draw:FilledRect(visible, pos_x, pos_y, width, height, clr, tablename)
    local rect = Drawing.new("Square")
    rect.Visible = visible
    rect.Position = Vector2.new(pos_x, pos_y)
    rect.Size = Vector2.new(width, height)
    rect.Color = RGB(clr[1], clr[2], clr[3])
    rect.Filled = true
    rect.Thickness = 0
    rect.Transparency = clr[4] / 255
    table.insert(tablename, rect)
    
    if not table.find(allRenderObjects, tablename) then
        table.insert(allRenderObjects, tablename)
    end
    
    return rect
end

function Draw:Line(visible, thickness, start_x, start_y, end_x, end_y, clr, tablename)
    local line = Drawing.new("Line")
    line.Visible = visible
    line.Thickness = thickness
    line.From = Vector2.new(start_x, start_y)
    line.To = Vector2.new(end_x, end_y)
    line.Color = RGB(clr[1], clr[2], clr[3])
    line.Transparency = clr[4] / 255
    table.insert(tablename, line)
    
    if not table.find(allRenderObjects, tablename) then
        table.insert(allRenderObjects, tablename)
    end
    
    return line
end

function Draw:Image(visible, imagedata, pos_x, pos_y, width, height, transparency, tablename)
    local img = Drawing.new("Image")
    img.Visible = visible
    img.Position = Vector2.new(pos_x, pos_y)
    img.Size = Vector2.new(width, height)
    img.Transparency = transparency
    img.Data = imagedata
    table.insert(tablename, img)
    
    if not table.find(allRenderObjects, tablename) then
        table.insert(allRenderObjects, tablename)
    end
    
    return img
end

function Draw:Text(text, font, visible, pos_x, pos_y, size, centered, clr, tablename)
    local txt = Drawing.new("Text")
    txt.Text = text
    txt.Visible = visible
    txt.Position = Vector2.new(pos_x, pos_y)
    txt.Size = size
    txt.Center = centered
    txt.Color = RGB(clr[1], clr[2], clr[3])
    txt.Transparency = clr[4] / 255
    txt.Outline = false
    txt.Font = font or 2
    table.insert(tablename, txt)
    
    if not table.find(allRenderObjects, tablename) then
        table.insert(allRenderObjects, tablename)
    end
    
    return txt
end

function Draw:OutlinedText(text, font, visible, pos_x, pos_y, size, centered, clr, clr2, tablename)
    local txt = Drawing.new("Text")
    txt.Text = text
    txt.Visible = visible
    txt.Position = Vector2.new(pos_x, pos_y)
    txt.Size = size
    txt.Center = centered
    txt.Color = RGB(clr[1], clr[2], clr[3])
    txt.Transparency = clr[4] / 255
    txt.Outline = true
    txt.OutlineColor = RGB(clr2[1], clr2[2], clr2[3])
    txt.Font = font or 2
    
    if not table.find(allRenderObjects, tablename) then
        table.insert(allRenderObjects, tablename)
    end
    
    if tablename then
        table.insert(tablename, txt)
    end
    
    return txt
end

function Draw:Triangle(visible, filled, pa, pb, pc, clr, tablename)
    clr = clr or { 255, 255, 255, 1 }
    local tri = Drawing.new("Triangle")
    tri.Visible = visible
    tri.Transparency = clr[4] or 1
    tri.Color = RGB(clr[1], clr[2], clr[3])
    tri.Thickness = 1
    
    if pa and pb and pc then
        tri.PointA = Vector2.new(pa[1], pa[2])
        tri.PointB = Vector2.new(pb[1], pb[2])
        tri.PointC = Vector2.new(pc[1], pc[2])
    end
    
    tri.Filled = filled
    table.insert(tablename, tri)
    
    if tablename and not table.find(allRenderObjects, tablename) then
        table.insert(allRenderObjects, tablename)
    end
    
    return tri
end

function Draw:Circle(visible, pos_x, pos_y, size, thickness, sides, clr, tablename)
    local circle = Drawing.new("Circle")
    circle.Position = Vector2.new(pos_x, pos_y)
    circle.Visible = visible
    circle.Radius = size
    circle.Thickness = thickness
    circle.NumSides = sides
    circle.Transparency = clr[4]
    circle.Filled = false
    circle.Color = RGB(clr[1], clr[2], clr[3])
    table.insert(tablename, circle)
    
    if not table.find(allRenderObjects, tablename) then
        table.insert(allRenderObjects, tablename)
    end
    
    return circle
end

function Draw:FilledCircle(visible, pos_x, pos_y, size, thickness, sides, clr, tablename)
    local circle = Drawing.new("Circle")
    circle.Position = Vector2.new(pos_x, pos_y)
    circle.Visible = visible
    circle.Radius = size
    circle.Thickness = thickness
    circle.NumSides = sides
    circle.Transparency = clr[4]
    circle.Filled = true
    circle.Color = RGB(clr[1], clr[2], clr[3])
    table.insert(tablename, circle)
    
    if not table.find(allRenderObjects, tablename) then
        table.insert(allRenderObjects, tablename)
    end
    
    return circle
end

-- Notification System
local notifications = {}

function CreateNotification(text, customcolor)
    local gap = 25
    local width = 18
    local alpha = 255
    local time = 0
    local estep = 0
    local eestep = 0.02
    local insety = 0
    
    local Note = {
        enabled = true,
        targetPos = Vector2.new(50, 33),
        size = Vector2.new(200, width),
        drawings = {
            outline = Draw:OutlinedRect(true, 0, 0, 202, width + 2, {0, 0, 0, 255}, {}),
            fade = Draw:OutlinedRect(true, 0, 0, 202, width + 2, {0, 0, 0, 255}, {}),
        },
        
        Remove = function(self, d)
            if d.Position.x < d.Size.x then
                for k, drawing in pairs(self.drawings) do
                    drawing:Remove()
                    drawing = false
                end
                self.enabled = false
            end
        end,
        
        Update = function(self, num, listLength, dt)
            local pos = self.targetPos
            local indexOffset = (listLength - num) * gap
            
            if insety < indexOffset then
                insety -= (insety - indexOffset) * 0.2
            else
                insety = indexOffset
            end
            
            local size = self.size
            local tpos = Vector2.new(pos.x - size.x / time - (alpha / 255) * (255 - alpha) / 255 * size.x, pos.y + insety)
            self.pos = tpos
            
            local locRect = {
                x = math.ceil(tpos.x),
                y = math.ceil(tpos.y),
                w = math.floor(size.x - (255 - alpha) / 255 * 70),
                h = size.y,
            }
            
            local fade = math.min(time * 12, alpha)
            fade = fade > 255 and 255 or fade < 0 and 0 or fade
            
            if self.enabled then
                local linenum = 1
                for i, drawing in pairs(self.drawings) do
                    drawing.Transparency = fade / 255
                    
                    if type(i) == "number" then
                        drawing.Position = Vector2.new(locRect.x + 1, locRect.y + i)
                        drawing.Size = Vector2.new(locRect.w - 2, 1)
                    elseif i == "text" then
                        drawing.Position = tpos + Vector2.new(6, 2)
                    elseif i == "outline" then
                        drawing.Position = Vector2.new(locRect.x, locRect.y)
                        drawing.Size = Vector2.new(locRect.w, locRect.h)
                    elseif i == "fade" then
                        drawing.Position = Vector2.new(locRect.x - 1, locRect.y - 1)
                        drawing.Size = Vector2.new(locRect.w + 2, locRect.h + 2)
                        local t = (200 - fade) / 255 / 3
                        drawing.Transparency = t < 0.4 and 0.4 or t
                    elseif i:find("line") then
                        drawing.Position = Vector2.new(locRect.x + linenum, locRect.y + 1)
                        local mencol = customcolor or RGB(127, 72, 163)
                        local color = linenum == 1 and mencol or RGB(mencol.R * 255 - 40, mencol.G * 255 - 40, mencol.B * 255 - 40)
                        if drawing.Color ~= color then
                            drawing.Color = color
                        end
                        linenum += 1
                    end
                end
                
                time += estep * dt * 128
                estep += eestep * dt * 64
            end
        end,
        
        Fade = function(self, num, len, dt)
            if self.pos.x > self.targetPos.x - 0.2 * len or self.fading then
                if not self.fading then
                    estep = 0
                end
                self.fading = true
                alpha -= estep / 4 * len * dt * 50
                eestep += 0.01 * dt * 100
            end
            if alpha <= 0 then
                self:Remove(self.drawings[1])
            end
        end,
    }
    
    for i = 1, Note.size.y - 2 do
        local c = 0.28 - i / 80
        Note.drawings[i] = Draw:FilledRect(true, 0, 0, 200, 1, {c * 255, c * 255, c * 255, 255}, {})
    end
    
    local color = RGB(127, 72, 163)
    Note.drawings.text = Draw:OutlinedText(text, 2, true, 0, 0, 13, false, {255, 255, 255, 255}, {0, 0, 0}, {})
    
    if Note.drawings.text.TextBounds.x + 7 > Note.size.x then
        Note.size = Vector2.new(Note.drawings.text.TextBounds.x + 7, Note.size.y)
    end
    
    Note.drawings.line = Draw:FilledRect(true, 0, 0, 1, Note.size.y - 2, {color.R * 255, color.G * 255, color.B * 255, 255}, {})
    Note.drawings.line1 = Draw:FilledRect(true, 0, 0, 1, Note.size.y - 2, {color.R * 255, color.G * 255, color.B * 255, 255}, {})
    
    table.insert(notifications, Note)
    return Note
end

-- UI Configuration and Theme
Library.DefaultSettings = {
    menuWidth = 500,
    menuHeight = 600,
    menuColor = {127, 72, 163},
    accentColor = {127, 72, 163},
    textColor = {255, 255, 255, 255},
    outlineColor = {0, 0, 0, 255},
    backgroundColor = {35, 35, 35, 255},
    topBarColor = {40, 40, 40, 255},
    groupboxColor = {30, 30, 30, 255},
    toggleInactiveColor = {50, 50, 50, 255},
    sliderBackgroundColor = {30, 30, 30, 255}
}

local function map(X, A, B, C, D)
    return (X - A) / (B - A) * (D - C) + C
end

-- Event System
local Event = {}

function Event.new(eventName)
    local newEvent = {}
    local callbacks = {}
    local disconnectList = {}
    
    function newEvent:Connect(func)
        table.insert(callbacks, func)
        local disconnected = false
        
        return function()
            if not disconnected then
                disconnected = true
                disconnectList[func] = true
            end
        end
    end
    
    function newEvent:Fire(...)
        local args = {...}
        local n = #callbacks
        local j = 0
        
        for i = 1, n do
            local func = callbacks[i]
            if disconnectList[func] then
                disconnectList[func] = nil
            else
                j = j + 1
                callbacks[j] = func
            end
        end
        
        for i = j + 1, n do
            callbacks[i] = nil
        end
        
        for i = 1, j do
            task.spawn(function(...)
                pcall(callbacks[i], ...)
            end, unpack(args))
        end
    end
    
    return newEvent
end

-- UI Components
function Library:CreateWindow(settings)
    settings = settings or {}
    
    local window = setmetatable({}, {__index = self})
    window.w = settings.Width or self.DefaultSettings.menuWidth
    window.h = settings.Height or self.DefaultSettings.menuHeight
    window.x = settings.X or math.floor((SCREEN_SIZE.x / 2) - (window.w / 2))
    window.y = settings.Y or math.floor((SCREEN_SIZE.y / 2) - (window.h / 2))
    window.title = settings.Title or "UI Library"
    window.open = true
    window.fading = false
    window.fadestart = 0
    window.mc = settings.Color or self.DefaultSettings.menuColor
    window.activetab = 1
    window.tabnames = {}
    window.tabs = {}
    window.options = {}
    window.keybind = settings.Keybind or Enum.KeyCode.Delete
    window.postable = {}
    window.drawings = {}
    window.connections = {}
    window.clrs = {
        norm = {},
        dark = {},
        togz = {}
    }
    
    -- Create the main menu elements
    Draw:OutlinedRect(true, 0, 0, window.w, window.h, {0, 0, 0, 255}, window.drawings) -- main border
    Draw:OutlinedRect(true, 1, 1, window.w - 2, window.h - 2, {20, 20, 20, 255}, window.drawings) -- secondary border
    Draw:OutlinedRect(true, 2, 2, window.w - 3, 1, {window.mc[1], window.mc[2], window.mc[3], 255}, window.drawings) -- top line colored
    table.insert(window.clrs.norm, window.drawings[#window.drawings])
    Draw:OutlinedRect(true, 2, 3, window.w - 3, 1, {window.mc[1] - 40, window.mc[2] - 40, window.mc[3] - 40, 255}, window.drawings) -- top line darker
    table.insert(window.clrs.dark, window.drawings[#window.drawings])
    Draw:OutlinedRect(true, 2, 4, window.w - 3, 1, {20, 20, 20, 255}, window.drawings)
    
    -- Create gradient background
    for i = 0, 19 do
        Draw:FilledRect(true, 2, 5 + i, window.w - 4, 1, {20, 20, 20, 255}, window.drawings)
        window.drawings[6 + i].Color = ColorRange(i, {
            [1] = {start = 0, color = RGB(50, 50, 50)}, 
            [2] = {start = 20, color = RGB(35, 35, 35)}
        })
    end
    Draw:FilledRect(true, 2, 25, window.w - 4, window.h - 27, {35, 35, 35, 255}, window.drawings)
    
    -- Add title
    Draw:OutlinedText(window.title, 2, true, 6, 6, 13, false, {255, 255, 255, 255}, {0, 0, 0}, window.drawings)
    
    -- Create inner frame
    Draw:OutlinedRect(true, 8, 22, window.w - 16, window.h - 30, {0, 0, 0, 255}, window.drawings)
    Draw:OutlinedRect(true, 9, 23, window.w - 18, window.h - 32, {20, 20, 20, 255}, window.drawings)
    Draw:OutlinedRect(true, 10, 24, window.w - 19, 1, {window.mc[1], window.mc[2], window.mc[3], 255}, window.drawings)
    table.insert(window.clrs.norm, window.drawings[#window.drawings])
    Draw:OutlinedRect(true, 10, 25, window.w - 19, 1, {window.mc[1] - 40, window.mc[2] - 40, window.mc[3] - 40, 255}, window.drawings)
    table.insert(window.clrs.dark, window.drawings[#window.drawings])
    Draw:OutlinedRect(true, 10, 26, window.w - 19, 1, {20, 20, 20, 255}, window.drawings)
    
    -- Create inner gradient
    for i = 0, 14 do
        Draw:FilledRect(true, 10, 27 + (i * 2), window.w - 20, 2, {45, 45, 45, 255}, window.drawings)
        window.drawings[#window.drawings].Color = ColorRange(i, {
            [1] = {start = 0, color = RGB(50, 50, 50)}, 
            [2] = {start = 15, color = RGB(35, 35, 35)}
        })
    end
    Draw:FilledRect(true, 10, 57, window.w - 20, window.h - 67, {35, 35, 35, 255}, window.drawings)
    
    -- Add tab selection
    function window:AddTab(name)
        local tab = {}
        tab.name = name
        tab.content = {}
        
        table.insert(self.tabnames, name)
        table.insert(self.tabs, tab)
        self.options[name] = {}
        
        -- Add tab button
        local tabIndex = #self.tabs
        local tabWidth = (window.w - 20) / #self.tabs
        local tabX = 10 + ((tabIndex - 1) * tabWidth)
        
        Draw:FilledRect(true, tabX, 27, tabWidth, 32, {30, 30, 30, 255}, self.drawings)
        Draw:OutlinedRect(true, tabX, 27, tabWidth, 32, {20, 20, 20, 255}, self.drawings)
        Draw:OutlinedText(name, 2, true, tabX + tabWidth/2, 35, 13, true, {255, 255, 255, 255}, {0, 0, 0}, self.drawings)
        
        if tabIndex == 1 then
            -- Create tab indicator for first tab
            Draw:OutlinedRect(true, 11, 58, tabWidth - 2, 2, {35, 35, 35, 255}, self.drawings)
        end
        
        return tab
    end
    
    -- Set active tab
    function window:SetTab(tabIndex)
        if self.tabs[tabIndex] then
            self.activetab = tabIndex
            
            -- Update tab indicator
            local tabWidth = (window.w - 20) / #self.tabs
            for i, _ in ipairs(self.tabs) do
                -- Update tab text color based on active status
                local tabTextIndex = 15 + (i * 3)
                if i == tabIndex then
                    self.drawings[tabTextIndex].Color = RGB(255, 255, 255)
                else
                    self.drawings[tabTextIndex].Color = RGB(170, 170, 170)
                end
            end
            
            -- Show active tab content, hide others
            for tabName, tabContent in pairs(self.options) do
                for groupName, groupContent in pairs(tabContent) do
                    for elemName, element in pairs(groupContent) do
                        local isVisible = (self.tabnames[tabIndex] == tabName)
                        -- Set visibility based on the element type
                        if element[2] == "toggle" then
                            for _, drawing in ipairs(element[4]) do
                                drawing.Visible = isVisible
                            end
                        elseif element[2] == "slider" then
                            for _, drawing in ipairs(element[4]) do
                                drawing.Visible = isVisible
                            end
                        elseif element[2] == "dropdown" then
                            for _, drawing in ipairs(element[4]) do
                                drawing.Visible = isVisible
                            end
                        elseif element[2] == "button" then
                            for _, drawing in ipairs(element[4]) do
                                drawing.Visible = isVisible
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- Create main UI control functions
    function window:AddGroupbox(tabName, name, x, y, width, height)
        if not self.options[tabName] then
            self.options[tabName] = {}
        end
        
        self.options[tabName][name] = {}
        local boxDrawings = {}
        
        Draw:OutlinedRect(true, x, y, width, height, {0, 0, 0, 255}, boxDrawings)
        Draw:OutlinedRect(true, x + 1, y + 1, width - 2, height - 2, {20, 20, 20, 255}, boxDrawings)
        Draw:OutlinedRect(true, x + 2, y + 2, width - 3, 1, {self.mc[1], self.mc[2], self.mc[3], 255}, boxDrawings)
        table.insert(self.clrs.norm, boxDrawings[#boxDrawings])
        Draw:OutlinedRect(true, x + 2, y + 3, width - 3, 1, {self.mc[1] - 40, self.mc[2] - 40, self.mc[3] - 40, 255}, boxDrawings)
        table.insert(self.clrs.dark, boxDrawings[#boxDrawings])
        Draw:OutlinedRect(true, x + 2, y + 4, width - 3, 1, {20, 20, 20, 255}, boxDrawings)
        
        for i = 0, 7 do
            Draw:FilledRect(true, x + 2, y + 5 + (i * 2), width - 4, 2, {45, 45, 45, 255}, boxDrawings)
            boxDrawings[#boxDrawings].Color = ColorRange(i, {
                [1] = {start = 0, color = RGB(45, 45, 45)}, 
                [2] = {start = 7, color = RGB(35, 35, 35)}
            })
        end
        
        Draw:OutlinedText(name, 2, true, x + 6, y + 5, 13, false, {255, 255, 255, 255}, {0, 0, 0}, boxDrawings)
        
        -- Add drawings to the tab
        for _, drawing in ipairs(boxDrawings) do
            table.insert(self.drawings, drawing)
            -- Set initial visibility based on active tab
            drawing.Visible = (self.tabnames[self.activetab] == tabName)
        end
        
        return {
            AddToggle = function(elemName, default, tooltip)
                return window:AddToggle(tabName, name, elemName, default, tooltip, x + 8, y + 20)
            end,
            
            AddSlider = function(elemName, default, min, max, suffix)
                return window:AddSlider(tabName, name, elemName, default, min, max, suffix, x + 8, y + 20)
            end,
            
            AddDropdown = function(elemName, default, options)
                return window:AddDropdown(tabName, name, elemName, default, options, x + 8, y + 20)
            end,
            
            AddButton = function(elemName, callback)
                return window:AddButton(tabName, name, elemName, callback, x + 8, y + 20)
            end,
            
            AddColorPicker = function(elemName, default)
                return window:AddColorPicker(tabName, name, elemName, default, x + 8, y + 20)
            end
        }
    end
    
    -- Toggle element
    function window:AddToggle(tabName, groupName, name, default, tooltip, x, y)
        if not self.options[tabName] then
            self.options[tabName] = {}
        end
        
        if not self.options[tabName][groupName] then
            self.options[tabName][groupName] = {}
        end
        
        local toggleDrawings = {}
        local y_pos = y
        
        -- For each toggle added to the group, increment y_pos
        for _, _ in pairs(self.options[tabName][groupName]) do
            y_pos = y_pos + 20
        end
        
        -- Create toggle box
        Draw:OutlinedRect(true, x, y_pos, 12, 12, {30, 30, 30, 255}, toggleDrawings)
        Draw:OutlinedRect(true, x + 1, y_pos + 1, 10, 10, {0, 0, 0, 255}, toggleDrawings)
        
        -- Create inner toggle fill
        for i = 0, 3 do
            Draw:FilledRect(true, x + 2, y_pos + 2 + (i * 2), 8, 2, 
                default and {self.mc[1], self.mc[2], self.mc[3], 255} or {50, 50, 50, 255}, 
                toggleDrawings)
            
            if default then
                toggleDrawings[#toggleDrawings].Color = ColorRange(i, {
                    [1] = {start = 0, color = RGB(self.mc[1], self.mc[2], self.mc[3])}, 
                    [2] = {start = 3, color = RGB(self.mc[1] - 40, self.mc[2] - 40, self.mc[3] - 40)}
                })
            else
                toggleDrawings[#toggleDrawings].Color = ColorRange(i, {
                    [1] = {start = 0, color = RGB(50, 50, 50)}, 
                    [2] = {start = 3, color = RGB(30, 30, 30)}
                })
            end
        end

        -- Create toggle text
        Draw:OutlinedText(name, 2, true, x + 16, y_pos - 1, 13, false, {255, 255, 255, 255}, {0, 0, 0}, toggleDrawings)
        
        -- Save toggle data
        self.options[tabName][groupName][name] = {
            default, -- Value 
            "toggle", -- Type
            {x, y_pos}, -- Position
            toggleDrawings, -- Drawings
            tooltip, -- Tooltip
            Event.new("ToggleChanged") -- Event
        }
        
        -- Add toggle to drawings
        for _, drawing in ipairs(toggleDrawings) do
            table.insert(self.drawings, drawing)
            drawing.Visible = (self.tabnames[self.activetab] == tabName)
        end
        
        -- Toggle function
        local toggle = self.options[tabName][groupName][name]
        
        function toggle:SetValue(value)
            toggle[1] = value
            
            for i = 1, 4 do
                if value then
                    toggle[4][i].Color = ColorRange(i-1, {
                        [1] = {start = 0, color = RGB(window.mc[1], window.mc[2], window.mc[3])}, 
                        [2] = {start = 3, color = RGB(window.mc[1] - 40, window.mc[2] - 40, window.mc[3] - 40)}
                    })
                else
                    toggle[4][i].Color = ColorRange(i-1, {
                        [1] = {start = 0, color = RGB(50, 50, 50)}, 
                        [2] = {start = 3, color = RGB(30, 30, 30)}
                    })
                end
            end
            
            toggle[6]:Fire(value)
        end
        
        function toggle:GetValue()
            return toggle[1]
        end
        
        function toggle:OnChanged(callback)
            return toggle[6]:Connect(callback)
        end
        
        return toggle
    end
    
    -- Slider element
    function window:AddSlider(tabName, groupName, name, default, min, max, suffix, x, y)
        if not self.options[tabName] then
            self.options[tabName] = {}
        end
        
        if not self.options[tabName][groupName] then
            self.options[tabName][groupName] = {}
        end
        
        suffix = suffix or ""
        local sliderDrawings = {}
        local y_pos = y
        
        -- For each element added to the group, increment y_pos
        for _, _ in pairs(self.options[tabName][groupName]) do
            y_pos = y_pos + 40 -- Sliders need more vertical space
        end
        
        -- Create slider text
        Draw:OutlinedText(name, 2, true, x, y_pos - 3, 13, false, {255, 255, 255, 255}, {0, 0, 0}, sliderDrawings)
        
        local sliderWidth = 180
        
        -- Create slider background
        for i = 0, 3 do
            Draw:FilledRect(true, x + 2, y_pos + 14 + (i * 2), sliderWidth - 4, 2, {50, 50, 50, 255}, sliderDrawings)
            sliderDrawings[#sliderDrawings].Color = ColorRange(i, {
                [1] = {start = 0, color = RGB(50, 50, 50)}, 
                [2] = {start = 3, color = RGB(30, 30, 30)}
            })
        end
        
        -- Create slider fill
        local fillWidth = (sliderWidth - 4) * ((default - min) / (max - min))
        for i = 0, 3 do
            Draw:FilledRect(true, x + 2, y_pos + 14 + (i * 2), fillWidth, 2, {0, 0, 0, 255}, sliderDrawings)
            sliderDrawings[#sliderDrawings].Color = ColorRange(i, {
                [1] = {start = 0, color = RGB(self.mc[1], self.mc[2], self.mc[3])}, 
                [2] = {start = 3, color = RGB(self.mc[1] - 40, self.mc[2] - 40, self.mc[3] - 40)}
            })
        end
        
        -- Create slider outline
        Draw:OutlinedRect(true, x, y_pos + 12, sliderWidth, 12, {30, 30, 30, 255}, sliderDrawings)
        Draw:OutlinedRect(true, x + 1, y_pos + 13, sliderWidth - 2, 10, {0, 0, 0, 255}, sliderDrawings)
        
        -- Create value text
        local valueText = Draw:OutlinedText(tostring(default) .. suffix, 2, true, x + (sliderWidth * 0.5), y_pos + 11, 13, true, {255, 255, 255, 255}, {0, 0, 0}, sliderDrawings)
        
        -- Save slider data
        self.options[tabName][groupName][name] = {
            default, -- Value
            "slider", -- Type
            {x, y_pos, sliderWidth}, -- Position and width
            sliderDrawings, -- Drawings
            false, -- Dragging state
            {min, max}, -- Min/Max values
            {x + 1, y_pos + 12}, -- Slider bar position
            suffix, -- Suffix
            Event.new("SliderChanged") -- Event
        }
        
        -- Add slider to drawings
        for _, drawing in ipairs(sliderDrawings) do
            table.insert(self.drawings, drawing)
            drawing.Visible = (self.tabnames[self.activetab] == tabName)
        end
        
        -- Slider functions
        local slider = self.options[tabName][groupName][name]
        
        function slider:SetValue(value)
            value = clamp(value, slider[6][1], slider[6][2])
            slider[1] = value
            
            -- Update slider fill
            local fillWidth = (slider[3][3] - 4) * ((value - slider[6][1]) / (slider[6][2] - slider[6][1]))
            for i = 5, 8 do
                slider[4][i].Size = Vector2.new(fillWidth, 2)
            end
            
            -- Update value text
            slider[4][11].Text = tostring(value) .. slider[8]
            
            slider[9]:Fire(value)
        end
        
        function slider:GetValue()
            return slider[1]
        end
        
        function slider:OnChanged(callback)
            return slider[9]:Connect(callback)
        end
        
        return slider
    end
    
    -- Dropdown element
    function window:AddDropdown(tabName, groupName, name, default, options, x, y)
        if not self.options[tabName] then
            self.options[tabName] = {}
        end
        
        if not self.options[tabName][groupName] then
            self.options[tabName][groupName] = {}
        end
        
        local dropdownDrawings = {}
        local y_pos = y
        
        -- For each element added to the group, increment y_pos
        for _, _ in pairs(self.options[tabName][groupName]) do
            y_pos = y_pos + 40 -- Dropdowns need more vertical space
        end
        
        -- Create dropdown text
        Draw:OutlinedText(name, 2, true, x, y_pos - 3, 13, false, {255, 255, 255, 255}, {0, 0, 0}, dropdownDrawings)
        
        local dropdownWidth = 180
        
        -- Create dropdown background
        for i = 0, 7 do
            Draw:FilledRect(true, x + 2, y_pos + 14 + (i * 2), dropdownWidth - 4, 2, {0, 0, 0, 255}, dropdownDrawings)
            dropdownDrawings[#dropdownDrawings].Color = ColorRange(i, {
                [1] = {start = 0, color = RGB(50, 50, 50)}, 
                [2] = {start = 7, color = RGB(35, 35, 35)}
            })
        end
        
        -- Create dropdown outline
        Draw:OutlinedRect(true, x, y_pos + 12, dropdownWidth, 22, {30, 30, 30, 255}, dropdownDrawings)
        Draw:OutlinedRect(true, x + 1, y_pos + 13, dropdownWidth - 2, 20, {0, 0, 0, 255}, dropdownDrawings)
        
        -- Create dropdown value text
        local valueText = Draw:OutlinedText(options[default] or "Select...", 2, true, x + 6, y_pos + 16, 13, false, {255, 255, 255, 255}, {0, 0, 0}, dropdownDrawings)
        
        -- Create dropdown arrow
        Draw:OutlinedText("-", 2, true, x + dropdownWidth - 17, y_pos + 16, 13, false, {255, 255, 255, 255}, {0, 0, 0}, dropdownDrawings)
        
        -- Create dropdown list (initially invisible)
        local dropdownListDrawings = {}
        local totalHeight = #options * 21 + 2
        
        -- Dropdown list background
        Draw:OutlinedRect(false, x, y_pos + 34, dropdownWidth, totalHeight, {30, 30, 30, 255}, dropdownListDrawings)
        Draw:OutlinedRect(false, x + 1, y_pos + 35, dropdownWidth - 2, totalHeight - 2, {0, 0, 0, 255}, dropdownListDrawings)
        Draw:FilledRect(false, x + 2, y_pos + 36, dropdownWidth - 4, totalHeight - 4, {40, 40, 40, 255}, dropdownListDrawings)
        
        -- Dropdown list items
        local optionDrawings = {}
        for i, optionText in ipairs(options) do
            local optionY = y_pos + 36 + (i - 1) * 21
            local textColor = i == default and {self.mc[1], self.mc[2], self.mc[3], 255} or {255, 255, 255, 255}
            
            Draw:OutlinedText(optionText, 2, false, x + 6, optionY, 13, false, textColor, {0, 0, 0}, dropdownListDrawings)
            table.insert(optionDrawings, dropdownListDrawings[#dropdownListDrawings])
            
            if i < #options then
                Draw:FilledRect(false, x + 4, optionY + 18, dropdownWidth - 8, 1, {30, 30, 30, 255}, dropdownListDrawings)
            end
        end
        
        -- Add dropdown list to main drawings
        for _, drawing in ipairs(dropdownListDrawings) do
            table.insert(self.drawings, drawing)
            drawing.Visible = false -- Initially hidden
        end
        
        -- Save dropdown data
        self.options[tabName][groupName][name] = {
            default, -- Selected index
            "dropdown", -- Type
            {x, y_pos, dropdownWidth}, -- Position and width
            dropdownDrawings, -- Dropdown drawings
            false, -- Open state
            options, -- Options
            dropdownListDrawings, -- Dropdown list drawings
            optionDrawings, -- Option text drawings
            Event.new("DropdownChanged") -- Event
        }
        
        -- Add dropdown to drawings
        for _, drawing in ipairs(dropdownDrawings) do
            table.insert(self.drawings, drawing)
            drawing.Visible = (self.tabnames[self.activetab] == tabName)
        end
        
        -- Dropdown functions
        local dropdown = self.options[tabName][groupName][name]
        
        function dropdown:SetValue(index)
            if type(index) == "string" then
                -- Find index by name
                for i, option in ipairs(dropdown[6]) do
                    if option == index then
                        index = i
                        break
                    end
                end
            end
            
            if dropdown[6][index] then
                dropdown[1] = index
                dropdown[4][10].Text = dropdown[6][index]
                
                -- Update option colors
                for i, optionText in ipairs(dropdown[8]) do
                    optionText.Color = i == index and 
                        RGB(window.mc[1], window.mc[2], window.mc[3]) or 
                        RGB(255, 255, 255)
                end
                
                dropdown[9]:Fire(index, dropdown[6][index])
            end
        end
        
        function dropdown:GetValue()
            return dropdown[1], dropdown[6][dropdown[1]]
        end
        
        function dropdown:OnChanged(callback)
            return dropdown[9]:Connect(callback)
        end
        
        function dropdown:SetOpen(state)
            dropdown[5] = state
            
            for _, drawing in ipairs(dropdown[7]) do
                drawing.Visible = state and (self.tabnames[self.activetab] == tabName)
            end
        end
        
        return dropdown
    end
    
    -- Button element
    function window:AddButton(tabName, groupName, name, callback, x, y)
        if not self.options[tabName] then
            self.options[tabName] = {}
        end
        
        if not self.options[tabName][groupName] then
            self.options[tabName][groupName] = {}
        end
        
        local buttonDrawings = {}
        local y_pos = y
        
        -- For each element added to the group, increment y_pos
        for _, _ in pairs(self.options[tabName][groupName]) do
            y_pos = y_pos + 28 -- Buttons need more vertical space
        end
        
        local buttonWidth = 180
        
        -- Create button background
        for i = 0, 8 do
            Draw:FilledRect(true, x + 2, y_pos + 2 + (i * 2), buttonWidth - 4, 2, {0, 0, 0, 255}, buttonDrawings)
            buttonDrawings[#buttonDrawings].Color = ColorRange(i, {
                [1] = {start = 0, color = RGB(50, 50, 50)}, 
                [2] = {start = 8, color = RGB(35, 35, 35)}
            })
        end
        
        -- Create button outline
        Draw:OutlinedRect(true, x, y_pos, buttonWidth, 22, {30, 30, 30, 255}, buttonDrawings)
        Draw:OutlinedRect(true, x + 1, y_pos + 1, buttonWidth - 2, 20, {0, 0, 0, 255}, buttonDrawings)
        
        -- Create button text
        local buttonText = Draw:OutlinedText(name, 2, true, x + buttonWidth/2, y_pos + 4, 13, true, {255, 255, 255, 255}, {0, 0, 0}, buttonDrawings)
        
        -- Save button data
        self.options[tabName][groupName][name] = {
            false, -- Pressed state
            "button", -- Type
            {x, y_pos - 1, buttonWidth}, -- Position and width
            buttonDrawings, -- Drawings
            callback, -- Callback function
            name, -- Name
            groupName, -- Groupbox name
            tabName, -- Tab name
            Event.new("ButtonPressed") -- Event
        }
        
        -- Add button to drawings
        for _, drawing in ipairs(buttonDrawings) do
            table.insert(self.drawings, drawing)
            drawing.Visible = (self.tabnames[self.activetab] == tabName)
        end
        
        local button = self.options[tabName][groupName][name]
        
        function button:Press()
            -- Create press effect
            for i = 0, 8 do
                button[4][i+1].Color = ColorRange(i, {
                    [1] = {start = 0, color = RGB(35, 35, 35)}, 
                    [2] = {start = 8, color = RGB(50, 50, 50)}
                })
            end
            
            button[1] = true
            
            -- Run callback
            if button[5] then
                task.spawn(button[5])
            end
            
            button[9]:Fire()
            
            -- Reset button after a short delay
            task.delay(0.15, function()
                for i = 0, 8 do
                    button[4][i+1].Color = ColorRange(i, {
                        [1] = {start = 0, color = RGB(50, 50, 50)}, 
                        [2] = {start = 8, color = RGB(35, 35, 35)}
                    })
                end
                button[1] = false
            end)
        end
        
        function button:OnPressed(callback)
            return button[9]:Connect(callback)
        end
        
        return button
    end
    
    -- Color picker element
    function window:AddColorPicker(tabName, groupName, name, defaultColor, x, y)
        if not self.options[tabName] then
            self.options[tabName] = {}
        end
        
        if not self.options[tabName][groupName] then
            self.options[tabName][groupName] = {}
        end
        
        defaultColor = defaultColor or Color3.fromRGB(255, 255, 255)
        local r, g, b = defaultColor.R * 255, defaultColor.G * 255, defaultColor.B * 255
        
        local colorPickerDrawings = {}
        local y_pos = y
        
        -- For each element added to the group, increment y_pos
        for _, _ in pairs(self.options[tabName][groupName]) do
            y_pos = y_pos + 20
        end
        
        -- Create color picker label
        Draw:OutlinedText(name, 2, true, x, y_pos - 1, 13, false, {255, 255, 255, 255}, {0, 0, 0}, colorPickerDrawings)
        
        -- Create color preview
        Draw:OutlinedRect(true, x + 150, y_pos - 1, 28, 14, {30, 30, 30, 255}, colorPickerDrawings)
        Draw:OutlinedRect(true, x + 151, y_pos, 26, 12, {0, 0, 0, 255}, colorPickerDrawings)
        Draw:FilledRect(true, x + 152, y_pos + 1, 24, 10, {r, g, b, 255}, colorPickerDrawings)
        
        -- Create color picker popup (initially invisible)
        local popupWidth, popupHeight = 280, 211
        local popupDrawings = {}
        
        -- Color picker frame
        Draw:FilledRect(false, x, y_pos + 20, popupWidth, popupHeight, {35, 35, 35, 255}, popupDrawings)
        Draw:OutlinedRect(false, x, y_pos + 20, popupWidth, popupHeight, {0, 0, 0, 255}, popupDrawings)
        Draw:OutlinedRect(false, x + 1, y_pos + 21, popupWidth - 2, popupHeight - 2, {20, 20, 20, 255}, popupDrawings)
        Draw:OutlinedRect(false, x + 2, y_pos + 22, popupWidth - 3, 1, {self.mc[1], self.mc[2], self.mc[3], 255}, popupDrawings)
        Draw:OutlinedRect(false, x + 2, y_pos + 23, popupWidth - 3, 1, {self.mc[1] - 40, self.mc[2] - 40, self.mc[3] - 40, 255}, popupDrawings)
        Draw:OutlinedRect(false, x + 2, y_pos + 24, popupWidth - 3, 1, {20, 20, 20, 255}, popupDrawings)
        
        -- Color picker title
        Draw:OutlinedText("Color Picker", 2, false, x + 7, y_pos + 25, 13, false, {255, 255, 255, 255}, {0, 0, 0}, popupDrawings)
        
        -- Close button
        Draw:OutlinedText("x", 2, false, x + popupWidth - 12, y_pos + 25, 13, false, {255, 255, 255, 255}, {0, 0, 0}, popupDrawings)
        
        -- Main color area
        Draw:OutlinedRect(false, x + 10, y_pos + 45, 160, 160, {30, 30, 30, 255}, popupDrawings)
        Draw:OutlinedRect(false, x + 11, y_pos + 46, 158, 158, {0, 0, 0, 255}, popupDrawings)
        Draw:FilledRect(false, x + 12, y_pos + 47, 156, 156, {255, 0, 0, 255}, popupDrawings) -- Will be filled with a gradient
        
        -- Hue slider
        Draw:OutlinedRect(false, x + 176, y_pos + 45, 14, 160, {30, 30, 30, 255}, popupDrawings)
        Draw:OutlinedRect(false, x + 177, y_pos + 46, 12, 158, {0, 0, 0, 255}, popupDrawings)
        
        -- Current color preview
        Draw:OutlinedText("New Color", 2, false, x + 198, y_pos + 45, 13, false, {255, 255, 255, 255}, {0, 0, 0}, popupDrawings)
        Draw:OutlinedRect(false, x + 197, y_pos + 59, 75, 40, {30, 30, 30, 255}, popupDrawings)
        Draw:OutlinedRect(false, x + 198, y_pos + 60, 73, 38, {0, 0, 0, 255}, popupDrawings)
        Draw:FilledRect(false, x + 199, y_pos + 61, 71, 36, {r, g, b, 255}, popupDrawings)
        
        -- Old color preview
        Draw:OutlinedText("Old Color", 2, false, x + 198, y_pos + 105, 13, false, {255, 255, 255, 255}, {0, 0, 0}, popupDrawings)
        Draw:OutlinedRect(false, x + 197, y_pos + 119, 75, 40, {30, 30, 30, 255}, popupDrawings)
        Draw:OutlinedRect(false, x + 198, y_pos + 120, 73, 38, {0, 0, 0, 255}, popupDrawings)
        Draw:FilledRect(false, x + 199, y_pos + 121, 71, 36, {r, g, b, 255}, popupDrawings)
        
        -- Apply button
        Draw:OutlinedText("[ Apply ]", 2, false, x + 235, y_pos + popupHeight - 23, 13, true, {255, 255, 255, 255}, {0, 0, 0}, popupDrawings)
        
        -- Color selector indicators
        local hueIndicator = {}
        Draw:OutlinedRect(false, x + 175, y_pos + 45, 16, 5, {0, 0, 0, 255}, hueIndicator)
        Draw:OutlinedRect(false, x + 176, y_pos + 46, 14, 3, {255, 255, 255, 255}, hueIndicator)
        
        local colorIndicator = {}
        Draw:OutlinedRect(false, x + 10, y_pos + 45, 5, 5, {0, 0, 0, 255}, colorIndicator)
        Draw:OutlinedRect(false, x + 11, y_pos + 46, 3, 3, {255, 255, 255, 255}, colorIndicator)
        
        -- Add indicators to popup drawings
        for _, drawing in ipairs(hueIndicator) do
            table.insert(popupDrawings, drawing)
        end
        
        for _, drawing in ipairs(colorIndicator) do
            table.insert(popupDrawings, drawing)
        end
        
        -- Add popup to main drawings
        for _, drawing in ipairs(popupDrawings) do
            table.insert(self.drawings, drawing)
            drawing.Visible = false -- Initially hidden
        end
        
        -- Save color picker data
        self.options[tabName][groupName][name] = {
            {r, g, b}, -- Current color (RGB)
            "colorpicker", -- Type
            {x, y_pos}, -- Position
            colorPickerDrawings, -- Color picker drawings
            false, -- Open state
            popupDrawings, -- Popup drawings
            { -- Color picker internal state
                hsv = {h = 0, s = 1, v = 1},
                dragging_m = false,
                dragging_r = false,
                color_x = x + 12,
                color_y = y_pos + 47,
                hue_y = y_pos + 45,
                indicators = {
                    hue = hueIndicator,
                    color = colorIndicator
                }
            },
            Event.new("ColorChanged") -- Event
        }
        
        -- Add color picker to drawings
        for _, drawing in ipairs(colorPickerDrawings) do
            table.insert(self.drawings, drawing)
            drawing.Visible = (self.tabnames[self.activetab] == tabName)
        end
        
        -- Color picker functions
        local colorPicker = self.options[tabName][groupName][name]
        
        function colorPicker:SetColor(color)
            if type(color) == "table" and #color >= 3 then
                colorPicker[1] = {color[1], color[2], color[3]}
            elseif typeof(color) == "Color3" then
                colorPicker[1] = {color.R * 255, color.G * 255, color.B * 255}
            end
            
            -- Update color preview
            colorPicker[4][3].Color = RGB(colorPicker[1][1], colorPicker[1][2], colorPicker[1][3])
            
            -- If popup is open, update the new color preview
            if colorPicker[5] then
                colorPicker[6][13].Color = RGB(colorPicker[1][1], colorPicker[1][2], colorPicker[1][3])
            end
            
            colorPicker[8]:Fire(colorPicker[1])
        end
        
        function colorPicker:GetColor()
            return colorPicker[1]
        end
        
        function colorPicker:GetColorRGB()
            return RGB(colorPicker[1][1], colorPicker[1][2], colorPicker[1][3])
        end
        
        function colorPicker:OnChanged(callback)
            return colorPicker[8]:Connect(callback)
        end
        
        function colorPicker:SetOpen(state)
            colorPicker[5] = state
            
            for _, drawing in ipairs(colorPicker[6]) do
                drawing.Visible = state and (self.tabnames[self.activetab] == tabName)
            end
            
            if state then
                -- Store the old color
                colorPicker[6][16].Color = RGB(colorPicker[1][1], colorPicker[1][2], colorPicker[1][3])
            end
        end
        
        return colorPicker
    end
    
    -- Mouse handling
    function window:HandleMouse()
        if not self.open then return end
        
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        local inMenu = mousePos.X > self.x and mousePos.X < self.x + self.w and 
                       mousePos.Y > self.y - 32 and mousePos.Y < self.y + self.h
        
        -- Handle tabs
        if INPUT_SERVICE:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            for i, _ in ipairs(self.tabs) do
                local tabWidth = (self.w - 20) / #self.tabs
                local tabX = self.x + 10 + ((i - 1) * tabWidth)
                
                if mousePos.X >= tabX and mousePos.X <= tabX + tabWidth and
                   mousePos.Y >= self.y + 27 and mousePos.Y <= self.y + 59 then
                    self:SetTab(i)
                    break
                end
            end
            
            -- Handle elements
            for tabName, tabContent in pairs(self.options) do
                if self.tabnames[self.activetab] == tabName then
                    for groupName, groupContent in pairs(tabContent) do
                        for elemName, element in pairs(groupContent) do
                            -- Toggle handling
                            if element[2] == "toggle" then
                                if mousePos.X >= self.x + element[3][1] and 
                                   mousePos.X <= self.x + element[3][1] + 30 + element[4][5].TextBounds.x and
                                   mousePos.Y >= self.y + element[3][2] and 
                                   mousePos.Y <= self.y + element[3][2] + 16 then
                                    element:SetValue(not element[1])
                                end
                            -- Slider handling
                            elseif element[2] == "slider" and element[5] then
                                local newVal = (element[6][2] - element[6][1]) * 
                                ((mousePos.X - self.x - element[3][1]) / element[3][3])
                  newVal = math.floor(newVal + element[6][1])
                  
                  if newVal < element[6][1] then newVal = element[6][1] end
                  if newVal > element[6][2] then newVal = element[6][2] end
                  
                  element:SetValue(newVal)
              elseif element[2] == "slider" and not element[5] then
                  if mousePos.X >= self.x + element[3][1] and 
                     mousePos.X <= self.x + element[3][1] + element[3][3] and
                     mousePos.Y >= self.y + element[3][2] and 
                     mousePos.Y <= self.y + element[3][2] + 28 then
                      element[5] = true
                  end
              -- Dropdown handling
              elseif element[2] == "dropdown" then
                  if not element[5] then
                      if mousePos.X >= self.x + element[3][1] and 
                         mousePos.X <= self.x + element[3][1] + element[3][3] and
                         mousePos.Y >= self.y + element[3][2] and 
                         mousePos.Y <= self.y + element[3][2] + 22 then
                          element:SetOpen(true)
                      end
                  else
                      -- Handle dropdown outside click
                      if not (mousePos.X >= self.x + element[3][1] and 
                              mousePos.X <= self.x + element[3][1] + element[3][3] and
                              mousePos.Y >= self.y + element[3][2] and 
                              mousePos.Y <= self.y + element[3][2] + 22 + #element[6] * 21) then
                          element:SetOpen(false)
                      end
                      
                      -- Handle dropdown item click
                      for i, opt in ipairs(element[6]) do
                          local optY = element[3][2] + 36 + (i - 1) * 21
                          
                          if mousePos.X >= self.x + element[3][1] and 
                             mousePos.X <= self.x + element[3][1] + element[3][3] and
                             mousePos.Y >= self.y + optY and 
                             mousePos.Y <= self.y + optY + 21 then
                              element:SetValue(i)
                              element:SetOpen(false)
                              break
                          end
                      end
                  end
              -- Button handling
              elseif element[2] == "button" then
                  if mousePos.X >= self.x + element[3][1] and 
                     mousePos.X <= self.x + element[3][1] + element[3][3] and
                     mousePos.Y >= self.y + element[3][2] and 
                     mousePos.Y <= self.y + element[3][2] + 22 then
                      element:Press()
                  end
              -- Color picker handling
              elseif element[2] == "colorpicker" then
                  if not element[5] then
                      if mousePos.X >= self.x + element[3][1] + 150 and 
                         mousePos.X <= self.x + element[3][1] + 178 and
                         mousePos.Y >= self.y + element[3][2] - 1 and 
                         mousePos.Y <= self.y + element[3][2] + 13 then
                          element:SetOpen(true)
                      end
                  else
                      local state = element[7]
                      
                      -- Handle colorpicker close button
                      if mousePos.X >= self.x + element[3][1] + 268 and 
                         mousePos.X <= self.x + element[3][1] + 280 and
                         mousePos.Y >= self.y + element[3][2] + 22 and 
                         mousePos.Y <= self.y + element[3][2] + 36 then
                          element:SetOpen(false)
                      -- Handle colorpicker main area
                      elseif mousePos.X >= state.color_x and 
                             mousePos.X <= state.color_x + 156 and
                             mousePos.Y >= state.color_y and 
                             mousePos.Y <= state.color_y + 156 then
                          state.dragging_m = true
                      -- Handle colorpicker hue slider
                      elseif mousePos.X >= self.x + element[3][1] + 176 and 
                             mousePos.X <= self.x + element[3][1] + 190 and
                             mousePos.Y >= self.y + element[3][2] + 45 and 
                             mousePos.Y <= self.y + element[3][2] + 205 then
                          state.dragging_r = true
                      -- Handle colorpicker apply button
                      elseif mousePos.X >= self.x + element[3][1] + 197 and 
                             mousePos.X <= self.x + element[3][1] + 272 and
                             mousePos.Y >= self.y + element[3][2] + 187 and 
                             mousePos.Y <= self.y + element[3][2] + 207 then
                          element:SetColor(element[1])
                          element:SetOpen(false)
                      end
                      
                      -- Handle color picker main area drag
                      if state.dragging_m then
                          local x = clamp(mousePos.X, state.color_x, state.color_x + 156)
                          local y = clamp(mousePos.Y, state.color_y, state.color_y + 156)
                          
                          -- Move color selector indicator
                          for _, drawing in ipairs(state.indicators.color) do
                              drawing.Position = Vector2.new(x - 2, y - 2)
                          end
                          
                          -- Calculate saturation and value from position
                          local s = (x - state.color_x) / 156
                          local v = 1 - ((y - state.color_y) / 156)
                          
                          state.hsv.s = s
                          state.hsv.v = v
                          
                          -- Convert HSV to RGB
                          local color = Color3.fromHSV(state.hsv.h, s, v)
                          local r, g, b = math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255)
                          
                          -- Update new color preview
                          element[6][13].Color = color
                          element[1] = {r, g, b}
                      end
                      
                      -- Handle hue slider drag
                      if state.dragging_r then
                          local y = clamp(mousePos.Y, self.y + element[3][2] + 45, self.y + element[3][2] + 205)
                          
                          -- Move hue indicator
                          for _, drawing in ipairs(state.indicators.hue) do
                              drawing.Position = Vector2.new(self.x + element[3][1] + 175, y)
                          end
                          
                          -- Calculate hue from position
                          local h = 1 - ((y - (self.y + element[3][2] + 45)) / 160)
                          state.hsv.h = h
                          
                          -- Update main color area
                          element[6][9].Color = Color3.fromHSV(h, 1, 1)
                          
                          -- Convert HSV to RGB
                          local color = Color3.fromHSV(h, state.hsv.s, state.hsv.v)
                          local r, g, b = math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255)
                          
                          -- Update new color preview
                          element[6][13].Color = color
                          element[1] = {r, g, b}
                      end
                      
                      -- Handle outside click
                      if not (mousePos.X >= self.x + element[3][1] and 
                              mousePos.X <= self.x + element[3][1] + 280 and
                              mousePos.Y >= self.y + element[3][2] + 20 and 
                              mousePos.Y <= self.y + element[3][2] + 231) and
                         not (mousePos.X >= self.x + element[3][1] + 150 and 
                              mousePos.X <= self.x + element[3][1] + 178 and
                              mousePos.Y >= self.y + element[3][2] - 1 and 
                              mousePos.Y <= self.y + element[3][2] + 13) then
                          element:SetOpen(false)
                      end
                  end
              end
          end
      end
  end
end
else
-- Reset dragging states when mouse is released
for tabName, tabContent in pairs(self.options) do
  if self.tabnames[self.activetab] == tabName then
      for groupName, groupContent in pairs(tabContent) do
          for elemName, element in pairs(groupContent) do
              if element[2] == "slider" then
                  element[5] = false
              elseif element[2] == "colorpicker" and element[5] then
                  element[7].dragging_m = false
                  element[7].dragging_r = false
              end
          end
      end
  end
end
end
end

-- Main menu functions
function window:Toggle()
self.open = not self.open

if self.open then
-- Fade in
self.fading = true
self.fadestart = tick()

-- Show menu
for _, drawing in ipairs(self.drawings) do
  drawing.Visible = true
end

-- Activate initial tab
self:SetTab(self.activetab)
else
-- Fade out
self.fading = true
self.fadestart = tick()
end
end

function window:SetTransparency(transparency)
for _, drawing in ipairs(self.drawings) do
drawing.Transparency = transparency / 255
end
end

function window:Close()
self.open = false

for _, drawing in ipairs(self.drawings) do
drawing.Visible = false
end
end

function window:Unload()
-- Disconnect all connections
for _, connection in pairs(self.connections) do
if connection.Disconnect then
  connection:Disconnect()
end
end

-- Remove all drawings
Draw:UnRender()

-- Clear any global references
self.connections = {}
self.options = {}
self.tabs = {}
self.drawings = {}
end

-- Event handling
self.connections.renderStepped = RUN_SERVICE.RenderStepped:Connect(function(dt)
if window.fading then
if window.open then
  -- Fade in
  local fadeTime = (tick() - window.fadestart) * 10
  local transparency = math.floor(fadeTime * 255)
  
  if transparency >= 255 then
      window.fading = false
      window:SetTransparency(255)
  else
      window:SetTransparency(transparency)
  end
else
  -- Fade out
  local fadeTime = (tick() - window.fadestart) * 10
  local transparency = 255 - math.floor(fadeTime * 255)
  
  if transparency <= 0 then
      window.fading = false
      window:SetTransparency(0)
      
      -- Hide menu
      for _, drawing in ipairs(window.drawings) do
          drawing.Visible = false
      end
  else
      window:SetTransparency(transparency)
  end
end
end

-- Update notifications
local smallest = math.huge
local activeNotifications = {}

for i, note in ipairs(notifications) do
if note and note.enabled then
  table.insert(activeNotifications, note)
  smallest = smallest > i and i or smallest
else
  table.remove(notifications, i)
end
end

for i, note in ipairs(activeNotifications) do
note:Update(i, #activeNotifications, dt)

if i <= math.ceil(#activeNotifications / 10) or note.fading then
  note:Fade(i, #activeNotifications, dt)
end
end

-- Process mouse input if menu is open
if window.open and not window.fading then
window:HandleMouse()
end
end)

-- Handle keybind
self.connections.inputBegan = INPUT_SERVICE.InputBegan:Connect(function(input)
if input.KeyCode == self.keybind then
window:Toggle()
end
end)

return window
end

-- API for external use
function Library:Init(settings)
settings = settings or {}

local ui = {
Windows = {},
DefaultSettings = self.DefaultSettings
}

function ui:CreateWindow(windowSettings)
windowSettings = windowSettings or {}
local window = Library:CreateWindow(windowSettings)
table.insert(self.Windows, window)
return window
end

function ui:SetTheme(color)
if typeof(color) == "Color3" then
color = {color.R * 255, color.G * 255, color.B * 255}
end

for _, window in ipairs(self.Windows) do
window.mc = color

-- Update menu color
for _, drawing in ipairs(window.clrs.norm) do
  drawing.Color = RGB(color[1], color[2], color[3])
end

for _, drawing in ipairs(window.clrs.dark) do
  drawing.Color = RGB(color[1] - 40, color[2] - 40, color[3] - 40)
end

-- Update elements
for _, tabContent in pairs(window.options) do
  for _, groupContent in pairs(tabContent) do
      for _, element in pairs(groupContent) do
          if element[2] == "toggle" and element[1] then
              for i = 1, 4 do
                  element[4][i].Color = ColorRange(i-1, {
                      [1] = {start = 0, color = RGB(color[1], color[2], color[3])}, 
                      [2] = {start = 3, color = RGB(color[1] - 40, color[2] - 40, color[3] - 40)}
                  })
              end
          elseif element[2] == "slider" then
              for i = 5, 8 do
                  element[4][i].Color = ColorRange(i-5, {
                      [1] = {start = 0, color = RGB(color[1], color[2], color[3])}, 
                      [2] = {start = 3, color = RGB(color[1] - 40, color[2] - 40, color[3] - 40)}
                  })
              end
          end
      end
  end
end
end
end

function ui:Notify(text, customcolor)
return CreateNotification(text, customcolor)
end

function ui:Unload()
for _, window in ipairs(self.Windows) do
window:Unload()
end
self.Windows = {}
end

-- Set initial theme if provided
if settings.Theme then
ui:SetTheme(settings.Theme)
end

return ui
end

return Library
