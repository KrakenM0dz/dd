-- UI Library
local UI = {}

-- Create a new frame
function UI:createFrame(parent, size, position, backgroundColor)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = backgroundColor or Color3.fromRGB(255, 255, 255)
    frame.Parent = parent
    return frame
end

-- Create a new button
function UI:createButton(parent, size, position, text, onClick)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 20
    button.Parent = parent

    button.MouseButton1Click:Connect(onClick)

    return button
end

-- Create a toggle switch
function UI:createToggle(parent, size, position, label, onToggle)
    local toggle = Instance.new("Frame")
    toggle.Size = size
    toggle.Position = position
    toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    toggle.Parent = parent

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.Text = label
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 20
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = toggle

    local switch = Instance.new("TextButton")
    switch.Size = UDim2.new(0, 50, 0, 25)
    switch.Position = UDim2.new(0, 100, 0, 0)
    switch.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    switch.Text = "ON"
    switch.TextColor3 = Color3.fromRGB(255, 255, 255)
    switch.Parent = toggle

    local isOn = true

    switch.MouseButton1Click:Connect(function()
        isOn = not isOn
        if isOn then
            switch.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            switch.Text = "ON"
        else
            switch.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            switch.Text = "OFF"
        end
        if onToggle then
            onToggle(isOn)
        end
    end)

    return toggle
end

-- Create a text box
function UI:createTextBox(parent, size, position, placeholder, onChanged)
    local textBox = Instance.new("TextBox")
    textBox.Size = size
    textBox.Position = position
    textBox.PlaceholderText = placeholder
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    textBox.TextSize = 20
    textBox.Parent = parent

    textBox.FocusLost:Connect(function()
        if onChanged then
            onChanged(textBox.Text)
        end
    end)

    return textBox
end

-- Create a label
function UI:createLabel(parent, size, position, text)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.TextSize = 20
    label.Parent = parent
    return label
end

return UI
