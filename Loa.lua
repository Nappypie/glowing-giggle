-- Arqel UI Loader
-- Crimson/Red/Black Theme

local genv = getgenv()

-- Services
local HttpService = cloneref(game:GetService('HttpService'))
local TweenService = cloneref(game:GetService('TweenService'))
local Players = cloneref(game:GetService('Players'))
local UserInputService = cloneref(game:GetService('UserInputService'))
local CoreGui = cloneref(game:GetService('CoreGui'))
local RunService = cloneref(game:GetService('RunService'))

-- Get cached icons
local Icons = genv.ArqelIcons or {}

-- Helper function to get icon
local function GetIcon(name)
    return Icons[name] or ""
end

-- Color Palette
local Colors = {
    Dim = Color3.fromRGB(5, 5, 5),
    LoaderBg = Color3.fromRGB(15, 10, 10),
    ContentBg = Color3.fromRGB(0, 0, 0),
    
    StrokeDark = Color3.fromRGB(33, 15, 15),
    StrokeLight = Color3.fromRGB(40, 20, 20),
    StrokeAccent = Color3.fromRGB(180, 30, 30),
    
    TextWhite = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(220, 220, 220),
    TextPlaceholder = Color3.fromRGB(100, 70, 70),
    
    ButtonStatic = Color3.fromRGB(47, 47, 47),
    InputBg = Color3.fromRGB(15, 15, 15),
    InputBgVerify = Color3.fromRGB(94, 94, 94),
    
    Primary = Color3.fromRGB(120, 20, 30),
    AccentGradient1 = Color3.fromRGB(139, 0, 0),
    AccentGradient2 = Color3.fromRGB(200, 40, 40),
    
    IconNormal = Color3.fromRGB(255, 180, 180),
    IconActive = Color3.fromRGB(255, 220, 220),
    IconDim = Color3.fromRGB(200, 100, 100),
    
    Success = Color3.fromRGB(83, 156, 70),
    SuccessBg = Color3.fromRGB(10, 20, 8),
    
    Fail = Color3.fromRGB(200, 50, 50),
    FailBg = Color3.fromRGB(30, 10, 10),
    
    NotificationBg = Color3.fromRGB(25, 15, 15),
    NotificationText = Color3.fromRGB(255, 180, 180),
    
    Crimson = Color3.fromRGB(180, 30, 30),
    CrimsonDark = Color3.fromRGB(120, 20, 30),
}

-- Fonts
local Fonts = {
    Main = Font.new('rbxasset://fonts/families/Nunito.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Main2 = Enum.Font.Nunito,
    Header = Enum.Font.GothamBold,
    SubHeader = Enum.Font.GothamMedium,
    Simple = Enum.Font.SourceSans,
}

-- Settings
local Settings = {
    AnimStyle = Enum.EasingStyle.Exponential,
    AnimSpeed = 0.8,
    CornerRadius = UDim.new(0, 8),
    PillRadius = UDim.new(1, 0),
    AnimationColor = Color3.fromRGB(180, 30, 30),
    AnimationTransparency = 0.7,
    Custom = {
        Remember = true,
        BackgroundTransparent = true,
    },
}

-- Tween Infos
local TweenFast = TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local TweenMedium = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local TweenSlow = TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

-- State
local ArqelUI = {}
ArqelUI._gui = nil
ArqelUI._mainLoader = nil
ArqelUI._token = nil
ArqelUI._keyFunction = nil

-- Keys table (public configuration)
ArqelUI.Keys = {
    MainTitle = 'Arqel',
    MainDesc = 'Authenticate to Access Arqel',
    DiscordLink = '',
    KeyLink = '',
    Directory = 'Arqel',
    Keyless = false,
    Premium = false,
    GUIAnimations = true,
    Updates = {},
    NotificationCount = 0,
    activeNotifications = {},
    
    Assets = {
        Logo = {
            ID = 'rbxassetid://122944092730557',
            Size = UDim2.new(0, 95, 0, 95),
        },
    },
    
    Colors = Colors,
    Fonts = Fonts,
    Settings = Settings,
}

-- Utility: Create instance with properties
local function Create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties) do
        if prop ~= "Parent" then
            instance[prop] = value
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

-- Utility: Safe tween
local function SafeTween(instance, tweenInfo, properties)
    if instance and instance.Parent then
        local tween = TweenService:Create(instance, tweenInfo, properties)
        tween:Play()
        return tween
    end
    return nil
end

-- Utility: Type text animation
local function TypeText(label, text, speed)
    speed = speed or 0.02
    label.Text = ""
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        task.wait(speed)
    end
end

-- Load saved config
function ArqelUI:LoadConfig()
    local configPath = 'ArqelLibrary/Configs/' .. self.Keys.Directory .. '.json'
    
    if isfile(configPath) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(configPath))
        end)
        
        if success and data then
            return data
        end
    end
    
    return nil
end

-- Save config
function ArqelUI:SaveConfig(data)
    local configPath = 'ArqelLibrary/Configs/' .. self.Keys.Directory .. '.json'
    
    local success, err = pcall(function()
        writefile(configPath, HttpService:JSONEncode(data))
    end)
    
    return success
end

-- Notify function
function ArqelUI:Notify(options)
    options = options or {}
    local Title = options.Title or "Arqel"
    local Description = options.Description or "Notification"
    local Duration = options.Duration or 5
    local Type = options.Type or "info"
    
    local iconMap = {
        info = GetIcon("Info"),
        success = GetIcon("CheckCircle"),
        warn = GetIcon("AlertTriangle"),
        alert = GetIcon("AlertCircle"),
    }
    
    local colorMap = {
        info = Colors.Crimson,
        success = Colors.Success,
        warn = Color3.fromRGB(255, 170, 0),
        alert = Colors.Fail,
    }
    
    local icon = iconMap[Type] or iconMap.info
    local barColor = colorMap[Type] or colorMap.info
    
    task.spawn(function()
        local gui = self._gui
        if not gui then return end
        
        local notifContainer = gui:FindFirstChild('NotificationsContainer')
        if not notifContainer then return end
        
        local notifList = notifContainer:FindFirstChild('NotificationsList')
        if not notifList then return end
        
        -- Create notification frame
        local notifFrame = Create('Frame', {
            Name = 'Notification',
            Parent = notifList,
            BackgroundColor3 = Colors.NotificationBg,
            BorderSizePixel = 0,
            Position = UDim2.new(1, 10, 0, 0),
            Size = UDim2.new(1, 0, 0, 73),
        })
        
        Create('UICorner', {
            Parent = notifFrame,
            CornerRadius = UDim.new(0, 6),
        })
        
        Create('UIStroke', {
            Parent = notifFrame,
            Color = Colors.StrokeDark,
            Transparency = 0.5,
            Thickness = 1,
        })
        
        -- Left accent bar
        local leftBar = Create('Frame', {
            Name = 'LeftBar',
            Parent = notifFrame,
            BackgroundColor3 = barColor,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(0, 3, 1, 0),
        })
        
        Create('UICorner', {
            Parent = leftBar,
            CornerRadius = UDim.new(0, 6),
        })
        
        -- Progress bar background
        local barBg = Create('Frame', {
            Name = 'BarBackground',
            Parent = notifFrame,
            BackgroundColor3 = Color3.fromRGB(48, 48, 48),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 1, -3),
            Size = UDim2.new(1, 0, 0, 3),
        })
        
        -- Progress bar
        local progressBar = Create('Frame', {
            Name = 'ProgressBar',
            Parent = barBg,
            BackgroundColor3 = barColor,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
        })
        
        -- Main content frame
        local mainFrame = Create('Frame', {
            Name = 'MainFrame',
            Parent = notifFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, -3),
        })
        
        Create('UIListLayout', {
            Parent = mainFrame,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
        })
        
        -- Icon frame
        local iconFrame = Create('Frame', {
            Name = 'IconFrame',
            Parent = mainFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 50, 1, 0),
        })
        
        Create('UIPadding', {
            Parent = iconFrame,
            PaddingBottom = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 5),
            PaddingTop = UDim.new(0, 15),
        })
        
        Create('ImageLabel', {
            Parent = iconFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Image = icon,
            ImageColor3 = barColor,
        })
        
        -- Text frame
        local textFrame = Create('Frame', {
            Name = 'TextFrame',
            Parent = mainFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -50, 1, 0),
        })
        
        Create('UIPadding', {
            Parent = textFrame,
            PaddingTop = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 10),
        })
        
        Create('UIListLayout', {
            Parent = textFrame,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 2),
        })
        
        Create('TextLabel', {
            Name = 'Title',
            Parent = textFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 18),
            Font = Fonts.Main2,
            Text = Title,
            TextColor3 = Colors.TextWhite,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        
        Create('TextLabel', {
            Name = 'Description',
            Parent = textFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 30),
            Font = Fonts.Main2,
            Text = Description,
            TextColor3 = Colors.TextWhite,
            TextTransparency = 0.5,
            TextSize = 12,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
        })
        
        -- Slide in
        SafeTween(notifFrame, TweenMedium, {
            Position = UDim2.new(0, 0, 0, 0)
        })
        
        -- Progress bar countdown
        SafeTween(progressBar, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, 1, 0)
        })
        
        -- Auto remove
        task.delay(Duration, function()
            if notifFrame and notifFrame.Parent then
                SafeTween(notifFrame, TweenFast, {
                    Position = UDim2.new(1, 10, 0, 0)
                })
                task.wait(0.3)
                if notifFrame and notifFrame.Parent then
                    notifFrame:Destroy()
                end
            end
        end)
    end)
end

-- Fail function
function ArqelUI:Fail()
    self:Notify({
        Title = "Arqel",
        Description = "Invalid Key",
        Duration = 5,
        Type = "alert"
    })
    
    -- Shake animation on input box
    if self._keyBox then
        local originalPos = self._keyBox.Position
        for i = 1, 5 do
            SafeTween(self._keyBox, TweenInfo.new(0.05), {
                Position = originalPos + UDim2.new(0, 5, 0, 0)
            })
            task.wait(0.05)
            SafeTween(self._keyBox, TweenInfo.new(0.05), {
                Position = originalPos + UDim2.new(0, -5, 0, 0)
            })
            task.wait(0.05)
        end
        SafeTween(self._keyBox, TweenInfo.new(0.05), {
            Position = originalPos
        })
    end
end

-- Authorize function
function ArqelUI:Authorize(token)
    if token == self._token then
        self:Notify({
            Title = "Arqel",
            Description = "Key Verified Successfully",
            Duration = 3,
            Type = "success"
        })
        
        -- Save key if remember is enabled
        local keyInput = self._keyInput
        if keyInput and Settings.Custom.Remember then
            self:SaveConfig({
                Key = keyInput,
                Remember = true,
            })
        end
        
        task.wait(1)
        
        -- Fade out GUI
        if self._gui then
            local background = self._gui:FindFirstChild('Background')
            if background then
                SafeTween(background, TweenMedium, {
                    GroupTransparency = 1
                })
            end
            task.wait(0.5)
            self._gui:Destroy()
            self._gui = nil
        end
        
        -- Run main loader
        if self._mainLoader then
            self._mainLoader()
        end
    else
        self:Fail()
    end
end

-- Add Settings function
function ArqelUI:AddSettings(settingConfig)
    -- Store settings for later use
    if not self._customSettings then
        self._customSettings = {}
    end
    table.insert(self._customSettings, settingConfig)
end

-- Add Update function
function ArqelUI:AddUpdate(updateData)
    table.insert(self.Keys.Updates, updateData)
end

-- Initialize function (main entry point)
function ArqelUI:Initialize(config)
    config = config or {}
    
    self._mainLoader = config.MainLoader
    self._keyFunction = config.Function
    self._token = config.Token or ""
    self.Keys.KeyLink = config.KeyLink or ""
    self.Keys.Keyless = config.Keyless or false
    self.Keys.Premium = config.Premium or false
    
    -- Check for saved key
    local savedConfig = self:LoadConfig()
    if savedConfig and savedConfig.Key and savedConfig.Remember then
        if self._keyFunction then
            self._keyInput = savedConfig.Key
            self._keyFunction(savedConfig.Key)
            return
        end
    end
    
    -- Keyless mode - skip GUI
    if self.Keys.Keyless then
        if self._mainLoader then
            self._mainLoader()
        end
        return
    end
    
    -- Create main GUI
    local screenGui = Create('ScreenGui', {
        Name = 'ArqelUI',
        Parent = gethui(),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 100,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
    })
    
    self._gui = screenGui
    
    -- Background
    local background = Create('CanvasGroup', {
        Name = 'Background',
        Parent = screenGui,
        BackgroundColor3 = Colors.Dim,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        GroupTransparency = 1,
    })
    
    -- Main loader frame
    local loader = Create('Frame', {
        Name = 'Loader',
        Parent = background,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Colors.LoaderBg,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 360, 0, 420),
    })
    
    Create('UICorner', {
        Parent = loader,
        CornerRadius = UDim.new(0, 12),
    })
    
    Create('UIStroke', {
        Parent = loader,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Colors.StrokeDark,
        Thickness = 1,
    })
    
    -- Content holder
    local content = Create('Frame', {
        Name = 'Content',
        Parent = loader,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
    })
    
    Create('UIPadding', {
        Parent = content,
        PaddingBottom = UDim.new(0, 20),
        PaddingLeft = UDim.new(0, 25),
        PaddingRight = UDim.new(0, 25),
        PaddingTop = UDim.new(0, 25),
    })
    
    Create('UIListLayout', {
        Parent = content,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 15),
    })
    
    -- Logo frame
    local logoFrame = Create('Frame', {
        Name = 'LogoFrame',
        Parent = content,
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Size = self.Keys.Assets.Logo.Size,
    })
    
    Create('ImageLabel', {
        Name = 'Logo',
        Parent = logoFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Image = self.Keys.Assets.Logo.ID,
        ScaleType = Enum.ScaleType.Fit,
    })
    
    -- Title
    Create('TextLabel', {
        Name = 'Title',
        Parent = content,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Size = UDim2.new(1, 0, 0, 30),
        Font = Fonts.Header,
        Text = self.Keys.MainTitle,
        TextColor3 = Colors.TextWhite,
        TextSize = 24,
    })
    
    -- Description
    Create('TextLabel', {
        Name = 'Description',
        Parent = content,
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        Size = UDim2.new(1, 0, 0, 20),
        Font = Fonts.SubHeader,
        Text = self.Keys.MainDesc,
        TextColor3 = Colors.TextDim,
        TextTransparency = 0.3,
        TextSize = 14,
    })
    
    -- Key input frame
    local keyFrame = Create('Frame', {
        Name = 'KeyFrame',
        Parent = content,
        BackgroundColor3 = Colors.InputBg,
        LayoutOrder = 4,
        Size = UDim2.new(1, 0, 0, 45),
    })
    
    self._keyBox = keyFrame
    
    Create('UICorner', {
        Parent = keyFrame,
        CornerRadius = Settings.CornerRadius,
    })
    
    Create('UIStroke', {
        Parent = keyFrame,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Colors.StrokeDark,
        Thickness = 1,
    })
    
    Create('UIPadding', {
        Parent = keyFrame,
        PaddingLeft = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),
    })
    
    -- Key icon
    local keyIcon = Create('ImageLabel', {
        Name = 'KeyIcon',
        Parent = keyFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.5, -10),
        Size = UDim2.new(0, 20, 0, 20),
        Image = GetIcon("Key"),
        ImageColor3 = Colors.IconDim,
    })
    
    -- Key input
    local keyInput = Create('TextBox', {
        Name = 'KeyInput',
        Parent = keyFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 30, 0, 0),
        Size = UDim2.new(1, -30, 1, 0),
        Font = Fonts.Main2,
        PlaceholderText = "Enter Key...",
        PlaceholderColor3 = Colors.TextPlaceholder,
        Text = "",
        TextColor3 = Colors.TextWhite,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
    })
    
    -- Focus effects
    keyInput.Focused:Connect(function()
        SafeTween(keyFrame:FindFirstChildOfClass('UIStroke'), TweenFast, {
            Color = Colors.Crimson
        })
        SafeTween(keyIcon, TweenFast, {
            ImageColor3 = Colors.Crimson
        })
    end)
    
    keyInput.FocusLost:Connect(function()
        SafeTween(keyFrame:FindFirstChildOfClass('UIStroke'), TweenFast, {
            Color = Colors.StrokeDark
        })
        SafeTween(keyIcon, TweenFast, {
            ImageColor3 = Colors.IconDim
        })
    end)
    
    -- Buttons frame
    local buttonsFrame = Create('Frame', {
        Name = 'ButtonsFrame',
        Parent = content,
        BackgroundTransparency = 1,
        LayoutOrder = 5,
        Size = UDim2.new(1, 0, 0, 45),
    })
    
    Create('UIListLayout', {
        Parent = buttonsFrame,
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 10),
    })
    
    -- Get Key / Discord button
    local getKeyBtn = Create('TextButton', {
        Name = 'GetKeyButton',
        Parent = buttonsFrame,
        BackgroundColor3 = Colors.ButtonStatic,
        LayoutOrder = 1,
        Size = UDim2.new(0.48, 0, 1, 0),
        Font = Fonts.Main2,
        Text = self.Keys.Premium and "Discord" or "Get Key",
        TextColor3 = Colors.TextWhite,
        TextSize = 14,
        AutoButtonColor = false,
    })
    
    Create('UICorner', {
        Parent = getKeyBtn,
        CornerRadius = Settings.CornerRadius,
    })
    
    -- Get Key button hover effect
    getKeyBtn.MouseEnter:Connect(function()
        SafeTween(getKeyBtn, TweenFast, {
            BackgroundColor3 = Colors.CrimsonDark
        })
    end)
    
    getKeyBtn.MouseLeave:Connect(function()
        SafeTween(getKeyBtn, TweenFast, {
            BackgroundColor3 = Colors.ButtonStatic
        })
    end)
    
    -- Get Key button click
    getKeyBtn.MouseButton1Click:Connect(function()
        local link = self.Keys.Premium and self.Keys.DiscordLink or self.Keys.KeyLink
        if link and link ~= "" then
            if setclipboard then
                setclipboard(link)
            end
            if request then
                request({
                    Url = "http://127.0.0.1/open?url=" .. link,
                    Method = "GET",
                })
            end
        end
    end)
    
    -- Verify button
    local verifyBtn = Create('TextButton', {
        Name = 'VerifyButton',
        Parent = buttonsFrame,
        BackgroundColor3 = Colors.Crimson,
        LayoutOrder = 2,
        Size = UDim2.new(0.48, 0, 1, 0),
        Font = Fonts.Main2,
        Text = "Verify",
        TextColor3 = Colors.TextWhite,
        TextSize = 14,
        AutoButtonColor = false,
    })
    
    Create('UICorner', {
        Parent = verifyBtn,
        CornerRadius = Settings.CornerRadius,
    })
    
    -- Verify button hover effect
    verifyBtn.MouseEnter:Connect(function()
        SafeTween(verifyBtn, TweenFast, {
            BackgroundColor3 = Colors.AccentGradient2
        })
    end)
    
    verifyBtn.MouseLeave:Connect(function()
        SafeTween(verifyBtn, TweenFast, {
            BackgroundColor3 = Colors.Crimson
        })
    end)
    
    -- Verify button click
    verifyBtn.MouseButton1Click:Connect(function()
        local inputText = keyInput.Text
        if inputText and inputText ~= "" then
            self._keyInput = inputText
            if self._keyFunction then
                self._keyFunction(inputText)
            end
        else
            self:Notify({
                Title = "Arqel",
                Description = "Please enter a key",
                Duration = 3,
                Type = "warn"
            })
        end
    end)
    
    -- Bottom buttons frame
    local bottomFrame = Create('Frame', {
        Name = 'BottomFrame',
        Parent = content,
        BackgroundTransparency = 1,
        LayoutOrder = 6,
        Size = UDim2.new(1, 0, 0, 30),
    })
    
    Create('UIListLayout', {
        Parent = bottomFrame,
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 15),
    })
    
    -- Settings button
    local settingsBtn = Create('ImageButton', {
        Name = 'SettingsButton',
        Parent = bottomFrame,
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Size = UDim2.new(0, 22, 0, 22),
        Image = GetIcon("Settings"),
        ImageColor3 = Colors.IconDim,
    })
    
    settingsBtn.MouseEnter:Connect(function()
        SafeTween(settingsBtn, TweenFast, {
            ImageColor3 = Colors.Crimson
        })
    end)
    
    settingsBtn.MouseLeave:Connect(function()
        SafeTween(settingsBtn, TweenFast, {
            ImageColor3 = Colors.IconDim
        })
    end)
    
    -- Copy button
    local copyBtn = Create('ImageButton', {
        Name = 'CopyButton',
        Parent = bottomFrame,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Size = UDim2.new(0, 22, 0, 22),
        Image = GetIcon("Copy"),
        ImageColor3 = Colors.IconDim,
    })
    
    copyBtn.MouseEnter:Connect(function()
        SafeTween(copyBtn, TweenFast, {
            ImageColor3 = Colors.Crimson
        })
    end)
    
    copyBtn.MouseLeave:Connect(function()
        SafeTween(copyBtn, TweenFast, {
            ImageColor3 = Colors.IconDim
        })
    end)
    
    copyBtn.MouseButton1Click:Connect(function()
        local link = self.Keys.Premium and self.Keys.DiscordLink or self.Keys.KeyLink
        if link and link ~= "" and setclipboard then
            setclipboard(link)
            self:Notify({
                Title = "Arqel",
                Description = "Link copied to clipboard",
                Duration = 2,
                Type = "success"
            })
        end
    end)
    
    -- Updates button
    local updatesBtn = Create('ImageButton', {
        Name = 'UpdatesButton',
        Parent = bottomFrame,
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        Size = UDim2.new(0, 22, 0, 22),
        Image = GetIcon("Refresh"),
        ImageColor3 = Colors.IconDim,
    })
    
    updatesBtn.MouseEnter:Connect(function()
        SafeTween(updatesBtn, TweenFast, {
            ImageColor3 = Colors.Crimson
        })
    end)
    
    updatesBtn.MouseLeave:Connect(function()
        SafeTween(updatesBtn, TweenFast, {
            ImageColor3 = Colors.IconDim
        })
    end)
    
    -- Notifications container
    local notifContainer = Create('Frame', {
        Name = 'NotificationsContainer',
        Parent = screenGui,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -290, 0, 20),
        Size = UDim2.new(0, 270, 1, -40),
    })
    
    local notifList = Create('Frame', {
        Name = 'NotificationsList',
        Parent = notifContainer,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
    })
    
    Create('UIListLayout', {
        Parent = notifList,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 10),
    })
    
    -- Fade in animation
    SafeTween(background, TweenMedium, {
        GroupTransparency = 0
    })
    
    -- Scale in animation for loader
    loader.Size = UDim2.new(0, 0, 0, 0)
    SafeTween(loader, TweenSlow, {
        Size = UDim2.new(0, 360, 0, 420)
    })
end

return ArqelUI
