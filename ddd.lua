-- UI Library
local UI = {}

-- Create a new UI Frame (Container)
function UI.CreateFrame(parent, size, position, backgroundColor, borderRadius)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = backgroundColor
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.3
    frame.Parent = parent

    if borderRadius then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, borderRadius)
        corner.Parent = frame
    end
    
    return frame
end

-- Create a Button
function UI.CreateButton(parent, size, position, text, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.Parent = parent

    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    return button
end

-- Create a Toggle Switch
function UI.CreateToggle(parent, size, position, text, defaultState, callback)
    local toggleFrame = UI.CreateFrame(parent, size, position, Color3.fromRGB(35, 35, 35), 5)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Parent = toggleFrame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.5, 0, 1, 0)
    toggle.Position = UDim2.new(0.5, 0, 0, 0)
    toggle.BackgroundColor3 = defaultState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    toggle.Text = ""
    toggle.Parent = toggleFrame
    
    toggle.MouseButton1Click:Connect(function()
        defaultState = not defaultState
        toggle.BackgroundColor3 = defaultState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        if callback then callback(defaultState) end
    end)
    
    return toggleFrame
end

-- Create Tabs (Basic Tab System)
function UI.CreateTabSystem(parent, tabNames)
    local tabContainer = UI.CreateFrame(parent, UDim2.new(0, 400, 0, 300), UDim2.new(0.5, -200, 0.5, -150), Color3.fromRGB(40, 40, 40), 10)
    local tabButtonsFrame = UI.CreateFrame(tabContainer, UDim2.new(1, 0, 0, 50), UDim2.new(0, 0, 0, 0), Color3.fromRGB(30, 30, 30), 0)
    local contentFrame = UI.CreateFrame(tabContainer, UDim2.new(1, 0, 1, -50), UDim2.new(0, 0, 0, 50), Color3.fromRGB(60, 60, 60), 10)

    local activeTab
    local function setActiveTab(index)
        if activeTab then
            activeTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        activeTab = tabButtonsFrame:FindFirstChild(tabNames[index])
        activeTab.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        
        -- Update content based on the selected tab
        -- You can customize the content frame for each tab
        contentFrame:ClearAllChildren()
        local contentLabel = Instance.new("TextLabel")
        contentLabel.Text = "Content of " .. tabNames[index]
        contentLabel.Size = UDim2.new(1, 0, 1, 0)
        contentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        contentLabel.BackgroundTransparency = 1
        contentLabel.Parent = contentFrame
    end

    -- Create buttons for tabs
    for i, tabName in ipairs(tabNames) do
        local button = UI.CreateButton(tabButtonsFrame, UDim2.new(0, 100, 0, 50), UDim2.new(0, (i - 1) * 100, 0, 0), tabName, function()
            setActiveTab(i)
        end)
    end

    -- Set default active tab
    setActiveTab(1)
end

return UI
