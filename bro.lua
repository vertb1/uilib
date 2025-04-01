local UILibrary = {}

-- Core services
local INPUT_SERVICE = game:GetService("UserInputService")
local RUN_SERVICE = game:GetService("RunService")

-- Default settings
UILibrary.Settings = {
    Title = "UI Library",
    Width = 500,
    Height = 600,
    Color = {127, 72, 163}, -- Default purple
    Keybind = Enum.KeyCode.Delete
}

-- Core drawing functions
local Draw = {}

function Draw:FilledRect(visible, x, y, width, height, color, table)
    local rect = Drawing.new("Square")
    rect.Visible = visible
    rect.Position = Vector2.new(x, y)
    rect.Size = Vector2.new(width, height)
    rect.Color = Color3.fromRGB(color[1], color[2], color[3])
    rect.Filled = true
    rect.Transparency = color[4] / 255
    table.insert(table, rect)
    return rect
end

function Draw:OutlinedRect(visible, x, y, width, height, color, table)
    local rect = Drawing.new("Square")
    rect.Visible = visible
    rect.Position = Vector2.new(x, y)
    rect.Size = Vector2.new(width, height)
    rect.Color = Color3.fromRGB(color[1], color[2], color[3])
    rect.Filled = false
    rect.Thickness = 1
    rect.Transparency = color[4] / 255
    table.insert(table, rect)
    return rect
end

function Draw:Text(text, font, visible, x, y, size, centered, color, table)
    local textObj = Drawing.new("Text")
    textObj.Text = text
    textObj.Visible = visible
    textObj.Position = Vector2.new(x, y)
    textObj.Size = size
    textObj.Center = centered
    textObj.Color = Color3.fromRGB(color[1], color[2], color[3])
    textObj.Transparency = color[4] / 255
    textObj.Outline = false
    textObj.Font = font
    table.insert(table, textObj)
    return textObj
end

-- Window creation
function UILibrary:CreateWindow(settings)
    local window = {}
    window.x = settings.X or 100
    window.y = settings.Y or 100
    window.width = settings.Width or self.Settings.Width
    window.height = settings.Height or self.Settings.Height
    window.title = settings.Title or self.Settings.Title
    window.color = settings.Color or self.Settings.Color
    window.open = true
    window.tabs = {}
    window.tabButtons = {}
    window.activeTab = 1
    window.elements = {}
    window.drawings = {}
    
    -- Initialize main window frame
    Draw:OutlinedRect(true, window.x, window.y, window.width, window.height, {0, 0, 0, 255}, window.drawings)
    Draw:OutlinedRect(true, window.x+1, window.y+1, window.width-2, window.height-2, {20, 20, 20, 255}, window.drawings)
    Draw:OutlinedRect(true, window.x+2, window.y+2, window.width-3, 1, window.color, window.drawings)
    
    -- Title bar
    Draw:FilledRect(true, window.x+2, window.y+5, window.width-4, 20, {40, 40, 40, 255}, window.drawings)
    Draw:Text(window.title, 2, true, window.x+6, window.y+6, 13, false, {255, 255, 255, 255}, window.drawings)
    
    -- Setup functions
    window.AddTab = function(name)
        local tab = {
            name = name,
            groupboxes = {},
            visible = #window.tabs == 0, -- First tab is visible by default
            elements = {}
        }
        
        local tabIndex = #window.tabs + 1
        window.tabs[tabIndex] = tab
        
        -- Create tab button
        local tabWidth = (window.width - 20) / 6 -- Assuming max 6 tabs
        local tabX = window.x + 10 + ((tabIndex - 1) * tabWidth)
        
        Draw:FilledRect(true, tabX, window.y+27, tabWidth, 20, {30, 30, 30, 255}, window.drawings)
        local tabText = Draw:Text(name, 2, true, tabX + (tabWidth/2), window.y+30, 13, true, {255, 255, 255, 255}, window.drawings)
        
        window.tabButtons[tabIndex] = {
            rect = window.drawings[#window.drawings-1],
            text = tabText,
            x = tabX,
            y = window.y+27,
            width = tabWidth,
            height = 20
        }
        
        -- Tab content area
        if #window.tabs > 1 then
            -- Hide this tab's content since it's not the first tab
            tabText.Color = Color3.fromRGB(170, 170, 170)
        end
        
        return tab
    end
    
    window.SetActiveTab = function(index)
        if window.tabs[index] then
            for i, tab in ipairs(window.tabs) do
                tab.visible = (i == index)
                window.tabButtons[i].text.Color = (i == index) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 170, 170)
            end
            window.activeTab = index
        end
    end
    
    -- Tab click handler
    local function TabClickHandler()
        if window.open and INPUT_SERVICE:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            for i, tabButton in ipairs(window.tabButtons) do
                if mousePos.X >= tabButton.x and mousePos.X <= tabButton.x + tabButton.width and
                   mousePos.Y >= tabButton.y and mousePos.Y <= tabButton.y + tabButton.height then
                    window.SetActiveTab(i)
                    break
                end
            end
        end
    end
    
    -- Toggle menu visibility with keybind
    local function KeybindHandler(input)
        if input.KeyCode == (settings.Keybind or self.Settings.Keybind) then
            window.open = not window.open
            for _, drawing in ipairs(window.drawings) do
                drawing.Visible = window.open
            end
        end
    end
    
    -- Connect input events
    window.connections = {}
    window.connections.inputBegan = INPUT_SERVICE.InputBegan:Connect(KeybindHandler)
    window.connections.renderStepped = RUN_SERVICE.RenderStepped:Connect(TabClickHandler)
    
    -- Add elements to the window
    window.AddToggle = function(tab, name, default, tooltip, callback)
        if not window.tabs[tab] then return end
        
        local toggle = {
            type = "toggle",
            name = name,
            value = default or false,
            tooltip = tooltip,
            callback = callback,
            elements = {}
        }
        
        local toggleY = #window.tabs[tab].elements * 24 + 50
        
        -- Toggle background
        Draw:OutlinedRect(window.tabs[tab].visible, window.x+20, window.y+toggleY, 12, 12, {30, 30, 30, 255}, window.drawings)
        Draw:OutlinedRect(window.tabs[tab].visible, window.x+21, window.y+toggleY+1, 10, 10, {0, 0, 0, 255}, window.drawings)
        
        toggle.elements.bg = window.drawings[#window.drawings]
        
        -- Toggle fill
        for i = 0, 3 do
            Draw:FilledRect(window.tabs[tab].visible, window.x+22, window.y+toggleY+2+(i*2), 8, 2, 
                default and {window.color[1], window.color[2], window.color[3], 255} or {50, 50, 50, 255}, 
                window.drawings)
            toggle.elements[i] = window.drawings[#window.drawings]
        end
        
        -- Toggle text
        Draw:Text(name, 2, window.tabs[tab].visible, window.x+36, window.y+toggleY-1, 13, false, {255, 255, 255, 255}, window.drawings)
        toggle.elements.text = window.drawings[#window.drawings]
        
        -- Add to elements list
        table.insert(window.tabs[tab].elements, toggle)
        
        -- Toggle function
        toggle.SetValue = function(value)
            toggle.value = value
            for i = 0, 3 do
                toggle.elements[i].Color = value and 
                    Color3.fromRGB(window.color[1], window.color[2], window.color[3]) or 
                    Color3.fromRGB(50, 50, 50)
            end
            if toggle.callback then
                toggle.callback(value)
            end
        end
        
        return toggle
    end
    
    -- Add slider function
    window.AddSlider = function(tab, name, default, min, max, suffix, callback)
        if not window.tabs[tab] then return end
        
        local slider = {
            type = "slider",
            name = name,
            value = default or min,
            min = min,
            max = max,
            suffix = suffix or "",
            callback = callback,
            elements = {}
        }
        
        local sliderY = #window.tabs[tab].elements * 24 + 50
        
        -- Slider text
        Draw:Text(name, 2, window.tabs[tab].visible, window.x+20, window.y+sliderY-3, 13, false, {255, 255, 255, 255}, window.drawings)
        slider.elements.text = window.drawings[#window.drawings]
        
        -- Slider track
        Draw:OutlinedRect(window.tabs[tab].visible, window.x+20, window.y+sliderY+12, window.width-60, 12, {30, 30, 30, 255}, window.drawings)
        Draw:OutlinedRect(window.tabs[tab].visible, window.x+21, window.y+sliderY+13, window.width-62, 10, {0, 0, 0, 255}, window.drawings)
        
        -- Slider fill
        local fillWidth = ((slider.value - slider.min) / (slider.max - slider.min)) * (window.width-62)
        for i = 0, 3 do
            Draw:FilledRect(window.tabs[tab].visible, window.x+22, window.y+sliderY+14+(i*2), fillWidth, 2, 
                {window.color[1], window.color[2], window.color[3], 255}, window.drawings)
            slider.elements[i] = window.drawings[#window.drawings]
        end
        
        -- Slider value text
        Draw:Text(tostring(slider.value) .. slider.suffix, 2, window.tabs[tab].visible, 
            window.x + (window.width/2), window.y+sliderY+11, 13, true, {255, 255, 255, 255}, window.drawings)
        slider.elements.valueText = window.drawings[#window.drawings]
        
        -- Add to elements list
        table.insert(window.tabs[tab].elements, slider)
        
        -- Slider set value function
        slider.SetValue = function(value)
            value = math.max(slider.min, math.min(slider.max, value))
            slider.value = value
            
            local fillWidth = ((value - slider.min) / (slider.max - slider.min)) * (window.width-62)
            for i = 0, 3 do
                slider.elements[i].Size = Vector2.new(fillWidth, 2)
            end
            
            slider.elements.valueText.Text = tostring(value) .. slider.suffix
            
            if slider.callback then
                slider.callback(value)
            end
        end
        
        return slider
    end
    
    -- Add more UI element functions as needed
    
    window.Unload = function()
        -- Disconnect all connections
        for _, connection in pairs(window.connections) do
            connection:Disconnect()
        end
        
        -- Remove all drawings
        for _, drawing in ipairs(window.drawings) do
            drawing:Remove()
        end
        
        window = nil
    end
    
    return window
end

-- Example usage:
-- local UI = loadstring(game:HttpGet("your_url_here"))()
-- local Window = UI:CreateWindow({Title = "My UI", Keybind = Enum.KeyCode.RightShift})
-- local Tab1 = Window.AddTab("Main")
-- local MyToggle = Window.AddToggle(1, "My Toggle", false, "This is a tooltip", function(value) print("Toggle:", value) end)
-- local MySlider = Window.AddSlider(1, "My Slider", 50, 0, 100, "%", function(value) print("Slider:", value) end)

return UILibrary
