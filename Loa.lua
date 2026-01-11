-- Arqel UI Loader
-- Crimson/Red/Black Theme

local genv = getgenv()
local HttpService = cloneref(game:GetService('HttpService'))
local TweenService = cloneref(game:GetService('TweenService'))
local Players = cloneref(game:GetService('Players'))
local UserInputService = cloneref(game:GetService('UserInputService'))
local CoreGui = cloneref(game:GetService('CoreGui'))
local RunService = cloneref(game:GetService('RunService'))

local Icons = genv.ArqelIcons or {}

local function GetIcon(name)
    return Icons[name] or ""
end

local LoaderBg = Color3.fromRGB(15, 10, 10)
local ContentBg = Color3.fromRGB(0, 0, 0)
local StrokeDark = Color3.fromRGB(33, 15, 15)
local TextWhite = Color3.fromRGB(255, 255, 255)
local ButtonStatic = Color3.fromRGB(47, 47, 47)
local IconDim = Color3.fromRGB(200, 100, 100)

local Nunito = Enum.Font.Nunito
local GothamBold = Enum.Font.GothamBold
local GothamMedium = Enum.Font.GothamMedium

local LogoSize = UDim2.new(0, 95, 0, 95)
local CornerRadius = UDim.new(0, 8)
local PillRadius = UDim.new(1, 0)

local Exponential = Enum.EasingStyle.Exponential

local TweenFast = TweenInfo.new(0.3, Exponential, Enum.EasingDirection.Out)
local TweenMedium = TweenInfo.new(0.5, Exponential, Enum.EasingDirection.Out)
local TweenSlow = TweenInfo.new(0.8, Exponential, Enum.EasingDirection.Out)

local ScreenGui
local Background

local ArqelUI = {}

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
            Size = LogoSize,
        },
    },
    
    Settings = {
        AnimStyle = Exponential,
        AnimSpeed = 0.8,
        CornerRadius = CornerRadius,
        PillRadius = PillRadius,
        AnimationColor = Color3.fromRGB(180, 30, 30),
        AnimationTransparency = 0.7,
        Custom = {
            Remember = true,
            BackgroundTransparent = true,
        },
    },
    
    Colors = {
        Dim = Color3.fromRGB(5, 5, 5),
        LoaderBg = LoaderBg,
        ContentBg = ContentBg,
        StrokeDark = StrokeDark,
        StrokeLight = Color3.fromRGB(40, 20, 20),
        StrokeAccent = Color3.fromRGB(180, 30, 30),
        TextWhite = TextWhite,
        TextDim = Color3.fromRGB(220, 220, 220),
        TextPlaceholder = Color3.fromRGB(100, 70, 70),
        ButtonStatic = ButtonStatic,
        InputBg = Color3.fromRGB(15, 15, 15),
        InputBgVerify = Color3.fromRGB(94, 94, 94),
        Primary = Color3.fromRGB(120, 20, 30),
        AccentGradient1 = Color3.fromRGB(139, 0, 0),
        AccentGradient2 = Color3.fromRGB(200, 40, 40),
        IconNormal = Color3.fromRGB(255, 180, 180),
        IconActive = Color3.fromRGB(255, 220, 220),
        IconDim = IconDim,
        Success = Color3.fromRGB(83, 156, 70),
        SuccessBg = Color3.fromRGB(10, 20, 8),
        Fail = Color3.fromRGB(200, 50, 50),
        FailBg = Color3.fromRGB(30, 10, 10),
        NotificationBg = Color3.fromRGB(33, 20, 25),
        NotificationText = Color3.fromRGB(255, 180, 180),
    },
    
    Fonts = {
        Main = Font.new('rbxasset://fonts/families/Nunito.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal),
        Main2 = Nunito,
        Header = GothamBold,
        SubHeader = GothamMedium,
        Simple = Enum.Font.SourceSans,
    },
}

local function TypeText(label, text, speed)
    speed = speed or 0.02
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        task.wait(speed)
    end
end

local function SafeTween(instance, info, props)
    if instance and instance.Parent then
        local tween = TweenService:Create(instance, info, props)
        tween:Play()
        return tween
    end
    return nil
end

function ArqelUI.LoadConfig()
    if RunService:IsStudio() then return nil end
    local path = 'ArqelLibrary/Configs/' .. ArqelUI.Keys.Directory .. '.json'
    if isfile and isfile(path) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(path))
        end)
        if success then
            return data
        end
    end
    return nil
end

function ArqelUI.SaveConfig(data)
    if RunService:IsStudio() then return end
    local path = 'ArqelLibrary/Configs/' .. ArqelUI.Keys.Directory .. '.json'
    pcall(function()
        writefile(path, HttpService:JSONEncode(data or {
            Remember = true,
            BackgroundTransparent = true,
        }))
    end)
end

function ArqelUI.Notify(options)
    options = options or {}
    local Title = options.Title or "Arqel"
    local Description = options.Description or "Notification"
    local Duration = options.Duration or 5
    local Type = options.Type or "info"
    
    local colorMap = {
        info = ArqelUI.Keys.Colors.StrokeAccent,
        success = ArqelUI.Keys.Colors.Success,
        warn = Color3.fromRGB(255, 170, 0),
        alert = ArqelUI.Keys.Colors.Fail,
    }
    
    local iconMap = {
        info = GetIcon("Info"),
        success = GetIcon("CheckCircle"),
        warn = GetIcon("AlertTriangle"),
        alert = GetIcon("AlertCircle"),
    }
    
    local barColor = colorMap[Type] or colorMap.info
    local iconImage = iconMap[Type] or iconMap.info
    
    task.spawn(function()
        if not ScreenGui then return end
        local Notifications = ScreenGui:FindFirstChild('Notifications')
        if not Notifications then return end
        local NotificationsList = Notifications:FindFirstChild('NotificationsFrame')
        if NotificationsList then
            NotificationsList = NotificationsList:FindFirstChild('NotificationsList')
        end
        if not NotificationsList then return end
        
        local NotifFrame = Instance.new('Frame')
        NotifFrame.Name = 'Notification'
        NotifFrame.Parent = NotificationsList
        NotifFrame.BackgroundColor3 = ArqelUI.Keys.Colors.NotificationBg
        NotifFrame.BorderSizePixel = 0
        NotifFrame.Position = UDim2.new(1, 2, 0, 0)
        NotifFrame.Size = UDim2.new(0, 260, 0, 73)
        
        local NotifCorner = Instance.new('UICorner')
        NotifCorner.CornerRadius = UDim.new(0, 5)
        NotifCorner.Parent = NotifFrame
        
        Instance.new('UIScale').Parent = NotifFrame
        
        local Corners = Instance.new('Folder')
        Corners.Name = 'Corners'
        Corners.Parent = NotifFrame
        
        local TopRight = Instance.new('Frame')
        TopRight.Name = 'TopRight'
        TopRight.Parent = Corners
        TopRight.BackgroundColor3 = ArqelUI.Keys.Colors.NotificationBg
        TopRight.BorderSizePixel = 0
        TopRight.Position = UDim2.new(0.946, 0, -0.001, 0)
        TopRight.Size = UDim2.new(0.054, 0, 0.077, 0)
        
        local BottomRight = Instance.new('Frame')
        BottomRight.Name = 'BottomRight'
        BottomRight.Parent = Corners
        BottomRight.BackgroundColor3 = ArqelUI.Keys.Colors.NotificationBg
        BottomRight.BorderSizePixel = 0
        BottomRight.Position = UDim2.new(0.947, 0, 0.92, 1)
        BottomRight.Size = UDim2.new(0.054, 0, 0.067, 0)
        
        local BottomLeft = Instance.new('Frame')
        BottomLeft.Name = 'BottomLeft'
        BottomLeft.Parent = Corners
        BottomLeft.BackgroundColor3 = ArqelUI.Keys.Colors.NotificationBg
        BottomLeft.BorderSizePixel = 0
        BottomLeft.Position = UDim2.new(0, -1, 0.92, 1)
        BottomLeft.Size = UDim2.new(0.054, 0, 0.067, 0)
        
        local LeftBar = Instance.new('Frame')
        LeftBar.Name = 'LeftBar'
        LeftBar.Parent = NotifFrame
        LeftBar.BackgroundColor3 = barColor
        LeftBar.BorderSizePixel = 0
        LeftBar.Position = UDim2.new(1, 0, 0, 0)
        LeftBar.Size = UDim2.new(0, 3, 1.03, 0)
        
        local BarBackground = Instance.new('Frame')
        BarBackground.Name = 'BarBackground'
        BarBackground.Parent = NotifFrame
        BarBackground.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
        BarBackground.BorderSizePixel = 0
        BarBackground.Position = UDim2.new(0, -1, 0.999, 0)
        BarBackground.Size = UDim2.new(1, 0, 0, 3)
        
        local Bar = Instance.new('Frame')
        Bar.Name = 'Bar'
        Bar.Parent = BarBackground
        Bar.BackgroundColor3 = barColor
        Bar.BorderSizePixel = 0
        Bar.Size = UDim2.new(1.01, 0, 0, 3)
        
        local MainFrame = Instance.new('Frame')
        MainFrame.Name = 'MainFrame'
        MainFrame.Parent = NotifFrame
        MainFrame.BackgroundTransparency = 1
        MainFrame.Size = UDim2.new(0, 260, 0, 70)
        
        local MainLayout = Instance.new('UIListLayout')
        MainLayout.Parent = MainFrame
        MainLayout.FillDirection = Enum.FillDirection.Horizontal
        MainLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        local LeftFrame = Instance.new('Frame')
        LeftFrame.Name = 'LeftFrame'
        LeftFrame.Parent = MainFrame
        LeftFrame.BackgroundTransparency = 1
        LeftFrame.Size = UDim2.new(0, 60, 1, 0)
        
        local LeftPadding = Instance.new('UIPadding')
        LeftPadding.Parent = LeftFrame
        LeftPadding.PaddingBottom = UDim.new(0, 17)
        LeftPadding.PaddingLeft = UDim.new(0, 12)
        LeftPadding.PaddingRight = UDim.new(0, 12)
        LeftPadding.PaddingTop = UDim.new(0, 17)
        
        local IconLabel = Instance.new('ImageLabel')
        IconLabel.Parent = LeftFrame
        IconLabel.BackgroundTransparency = 1
        IconLabel.Size = UDim2.new(1, 0, 1, 0)
        IconLabel.Image = iconImage
        IconLabel.ImageColor3 = barColor
        
        local RightFrame = Instance.new('Frame')
        RightFrame.Name = 'RightFrame'
        RightFrame.Parent = MainFrame
        RightFrame.BackgroundTransparency = 1
        RightFrame.Size = UDim2.new(0, 200, 1, 0)
        
        local RightPadding = Instance.new('UIPadding')
        RightPadding.Parent = RightFrame
        RightPadding.PaddingTop = UDim.new(0, 12)
        
        local RightLayout = Instance.new('UIListLayout')
        RightLayout.Parent = RightFrame
        RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        local TitleLabel = Instance.new('TextLabel')
        TitleLabel.Parent = RightFrame
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Size = UDim2.new(0, 190, 0, 15)
        TitleLabel.Font = Nunito
        TitleLabel.Text = ''
        TitleLabel.TextColor3 = TextWhite
        TitleLabel.TextSize = 14
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local DescLabel = Instance.new('TextLabel')
        DescLabel.Parent = RightFrame
        DescLabel.BackgroundTransparency = 1
        DescLabel.Size = UDim2.new(0, 190, 0, 15)
        DescLabel.Font = Nunito
        DescLabel.Text = ''
        DescLabel.TextColor3 = TextWhite
        DescLabel.TextSize = 11
        DescLabel.TextTransparency = 0.7
        DescLabel.TextWrapped = true
        DescLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        SafeTween(NotifFrame, TweenMedium, {Position = UDim2.new(0, 0, 0, 0)})
        
        task.spawn(TypeText, TitleLabel, Title, 0.02)
        task.spawn(TypeText, DescLabel, Description, 0.02)
        
        SafeTween(Bar, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
        
        task.delay(Duration, function()
            if NotifFrame and NotifFrame.Parent then
                SafeTween(NotifFrame, TweenFast, {Position = UDim2.new(1, 2, 0, 0)})
                task.wait(0.3)
                if NotifFrame and NotifFrame.Parent then
                    NotifFrame:Destroy()
                end
            end
        end)
    end)
end

function ArqelUI.Fail()
    ArqelUI.Notify({
        Title = "Arqel",
        Description = "Invalid Key",
        Duration = 5,
        Type = "alert"
    })
    
    if ArqelUI._keyBox then
        local originalPos = ArqelUI._keyBox.Position
        for i = 1, 5 do
            SafeTween(ArqelUI._keyBox, TweenInfo.new(0.05), {Position = originalPos + UDim2.new(0, 5, 0, 0)})
            task.wait(0.05)
            SafeTween(ArqelUI._keyBox, TweenInfo.new(0.05), {Position = originalPos + UDim2.new(0, -5, 0, 0)})
            task.wait(0.05)
        end
        SafeTween(ArqelUI._keyBox, TweenInfo.new(0.05), {Position = originalPos})
    end
end

function ArqelUI.Authorize(token)
    if token == ArqelUI._token then
        ArqelUI.Notify({
            Title = "Arqel",
            Description = "Key Verified Successfully",
            Duration = 3,
            Type = "success"
        })
        
        if ArqelUI._keyInput and ArqelUI.Keys.Settings.Custom.Remember then
            ArqelUI.SaveConfig({Key = ArqelUI._keyInput, Remember = true})
        end
        
        task.wait(1)
        
        if Background then
            SafeTween(Background, TweenMedium, {GroupTransparency = 1})
        end
        
        task.wait(0.5)
        
        if ScreenGui then
            ScreenGui:Destroy()
            ScreenGui = nil
        end
        
        if ArqelUI._mainLoader then
            ArqelUI._mainLoader()
        end
    else
        ArqelUI.Fail()
    end
end

function ArqelUI.AddSettings(config)
    if not ArqelUI._customSettings then
        ArqelUI._customSettings = {}
    end
    table.insert(ArqelUI._customSettings, config)
end

function ArqelUI.AddUpdate(updateData, order)
    table.insert(ArqelUI.Keys.Updates, updateData)
end

function ArqelUI.AdjustTextbox() end

function ArqelUI.Initialize(config)
    config = config or {}
    
    ArqelUI._mainLoader = config.MainLoader
    ArqelUI._keyFunction = config.Function
    ArqelUI._token = config.Token or ""
    ArqelUI.Keys.KeyLink = config.KeyLink or ""
    ArqelUI.Keys.Keyless = config.Keyless or false
    ArqelUI.Keys.Premium = config.Premium or false
    
    local savedConfig = ArqelUI.LoadConfig()
    if savedConfig and savedConfig.Key and savedConfig.Remember then
        ArqelUI._keyInput = savedConfig.Key
        if ArqelUI._keyFunction then
            ArqelUI._keyFunction(savedConfig.Key)
            return
        end
    end
    
    if ArqelUI.Keys.Keyless then
        if ArqelUI._mainLoader then
            ArqelUI._mainLoader()
        end
        return
    end
    
    pcall(function()
        if makefolder then
            if not isfolder('ArqelLibrary') then makefolder('ArqelLibrary') end
            if not isfolder('ArqelLibrary/Configs') then makefolder('ArqelLibrary/Configs') end
            if not isfolder('ArqelLibrary/Bin') then makefolder('ArqelLibrary/Bin') end
        end
    end)
    
    ScreenGui = Instance.new('ScreenGui')
    ScreenGui.Name = 'ArqelUI'
    ScreenGui.Parent = gethui()
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Enabled = true
    ScreenGui.DisplayOrder = 100
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    
    Background = Instance.new('CanvasGroup')
    Background.Name = 'Background'
    Background.Parent = ScreenGui
    Background.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    Background.BackgroundTransparency = 0
    Background.BorderSizePixel = 0
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.GroupTransparency = 1
    
    local Loader = Instance.new('Frame')
    Loader.Name = 'Loader'
    Loader.Parent = Background
    Loader.AnchorPoint = Vector2.new(0.5, 0.5)
    Loader.BackgroundColor3 = LoaderBg
    Loader.BorderSizePixel = 0
    Loader.BackgroundTransparency = 1
    Loader.ClipsDescendants = true
    Loader.Position = UDim2.new(0.5, 0, 0.5, 0)
    Loader.Size = UDim2.new(0, 360, 0, 480)
    
    local ContentHolder = Instance.new('CanvasGroup')
    ContentHolder.Name = 'ContentHolder'
    ContentHolder.Parent = Loader
    ContentHolder.AnchorPoint = Vector2.new(0.5, 0.5)
    ContentHolder.BackgroundColor3 = ContentBg
    ContentHolder.BackgroundTransparency = 0.2
    ContentHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
    ContentHolder.Size = UDim2.new(0, 360, 1, 0)
    
    local ContentCorner = Instance.new('UICorner')
    ContentCorner.CornerRadius = UDim.new(0, 12)
    ContentCorner.Parent = ContentHolder
    
    local ContentConstraint = Instance.new('UISizeConstraint')
    ContentConstraint.Parent = ContentHolder
    ContentConstraint.MaxSize = Vector2.new(360, 460)
    
    local ContentPadding = Instance.new('UIPadding')
    ContentPadding.Name = 'UIPadding'
    ContentPadding.Parent = ContentHolder
    ContentPadding.PaddingBottom = UDim.new(0, 18)
    
    local ContentStroke = Instance.new('UIStroke')
    ContentStroke.Parent = ContentHolder
    ContentStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ContentStroke.Color = StrokeDark
    ContentStroke.Thickness = 1
    
    local TopFrame = Instance.new('Frame')
    TopFrame.Name = 'TopFrame'
    TopFrame.Parent = ContentHolder
    TopFrame.BackgroundTransparency = 1
    TopFrame.BorderSizePixel = 0
    TopFrame.Size = UDim2.new(1, 0, 0.154, 100)
    
    local TopLayout = Instance.new('UIListLayout')
    TopLayout.Parent = TopFrame
    TopLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TopLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TopLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    
    local LogoFrame = Instance.new('Frame')
    LogoFrame.Name = 'LogoFrame'
    LogoFrame.Parent = TopFrame
    LogoFrame.BackgroundTransparency = 1
    LogoFrame.BorderSizePixel = 0
    LogoFrame.LayoutOrder = 0
    LogoFrame.Size = UDim2.new(0, 100, 0, 100)
    
    local LogoLayout = Instance.new('UIListLayout')
    LogoLayout.Parent = LogoFrame
    LogoLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    LogoLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LogoLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    
    local Logo = Instance.new('ImageLabel')
    Logo.Name = 'Logo'
    Logo.Parent = LogoFrame
    Logo.BackgroundTransparency = 1
    Logo.BorderSizePixel = 0
    Logo.Size = ArqelUI.Keys.Assets.Logo.Size
    Logo.Image = ArqelUI.Keys.Assets.Logo.ID
    
    local LogoCorner = Instance.new('UICorner')
    LogoCorner.CornerRadius = CornerRadius
    LogoCorner.Parent = Logo
    
    local LoaderTitle = Instance.new('TextLabel')
    LoaderTitle.Name = 'LoaderTitle'
    LoaderTitle.Parent = TopFrame
    LoaderTitle.BackgroundTransparency = 1
    LoaderTitle.BorderSizePixel = 0
    LoaderTitle.LayoutOrder = 1
    LoaderTitle.Size = UDim2.new(1, 0, 0, 30)
    LoaderTitle.Font = GothamBold
    LoaderTitle.Text = ArqelUI.Keys.MainTitle
    LoaderTitle.TextColor3 = TextWhite
    LoaderTitle.TextSize = 20
    LoaderTitle.TextTransparency = 0.2
    
    local LoaderDesc = Instance.new('TextLabel')
    LoaderDesc.Name = 'LoaderDesc'
    LoaderDesc.Parent = TopFrame
    LoaderDesc.BackgroundTransparency = 1
    LoaderDesc.BorderSizePixel = 0
    LoaderDesc.LayoutOrder = 2
    LoaderDesc.Size = UDim2.new(1, 0, 0, 30)
    LoaderDesc.Font = GothamMedium
    LoaderDesc.Text = ArqelUI.Keys.MainDesc
    LoaderDesc.TextColor3 = TextWhite
    LoaderDesc.TextSize = 12
    LoaderDesc.TextTransparency = 0.7
    
    local DownFrame = Instance.new('Frame')
    DownFrame.Name = 'DownFrame'
    DownFrame.Parent = ContentHolder
    DownFrame.BackgroundTransparency = 1
    DownFrame.LayoutOrder = 2
    DownFrame.BorderSizePixel = 0
    DownFrame.Size = UDim2.new(1, 0, 0, 230)
    
    local DownLayout = Instance.new('UIListLayout')
    DownLayout.Parent = DownFrame
    DownLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    DownLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DownLayout.Padding = UDim.new(0, 10)
    
    local MainFrame = Instance.new('Frame')
    MainFrame.Name = 'MainFrame'
    MainFrame.Parent = DownFrame
    MainFrame.BackgroundTransparency = 1
    MainFrame.BorderSizePixel = 0
    MainFrame.LayoutOrder = 0
    MainFrame.Size = UDim2.new(0.85, 0, 0, 160)
    
    local MainFrameLayout = Instance.new('UIListLayout')
    MainFrameLayout.Parent = MainFrame
    MainFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    MainFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
    MainFrameLayout.Padding = UDim.new(0, 10)
    
    local KeyBackground = Instance.new('Frame')
    KeyBackground.Name = 'KeyBackground'
    KeyBackground.Parent = MainFrame
    KeyBackground.BackgroundTransparency = 1
    KeyBackground.BorderSizePixel = 0
    KeyBackground.LayoutOrder = 0
    KeyBackground.Size = UDim2.new(1, 0, 0, 40)
    
    local KeyBox = Instance.new('Frame')
    KeyBox.Name = 'KeyBox'
    KeyBox.Parent = KeyBackground
    KeyBox.BackgroundColor3 = ArqelUI.Keys.Colors.InputBg
    KeyBox.BorderSizePixel = 0
    KeyBox.Size = UDim2.new(1, 0, 1, 0)
    
    ArqelUI._keyBox = KeyBox
    
    local KeyBoxCorner = Instance.new('UICorner')
    KeyBoxCorner.CornerRadius = CornerRadius
    KeyBoxCorner.Parent = KeyBox
    
    local KeyBoxStroke = Instance.new('UIStroke')
    KeyBoxStroke.Parent = KeyBox
    KeyBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    KeyBoxStroke.Color = StrokeDark
    KeyBoxStroke.Thickness = 1
    
    local KeyBoxPadding = Instance.new('UIPadding')
    KeyBoxPadding.Parent = KeyBox
    KeyBoxPadding.PaddingLeft = UDim.new(0, 12)
    KeyBoxPadding.PaddingRight = UDim.new(0, 12)
    
    local KeyBoxImage = Instance.new('ImageLabel')
    KeyBoxImage.Name = 'KeyBoxImage'
    KeyBoxImage.Parent = KeyBox
    KeyBoxImage.BackgroundTransparency = 1
    KeyBoxImage.Position = UDim2.new(0, 0, 0.5, -10)
    KeyBoxImage.Size = UDim2.new(0, 20, 0, 20)
    KeyBoxImage.Image = GetIcon("Key")
    KeyBoxImage.ImageColor3 = IconDim
    
    local KeyInput = Instance.new('TextBox')
    KeyInput.Name = 'KeyInput'
    KeyInput.Parent = KeyBox
    KeyInput.BackgroundTransparency = 1
    KeyInput.Position = UDim2.new(0, 28, 0, 0)
    KeyInput.Size = UDim2.new(1, -28, 1, 0)
    KeyInput.Font = Nunito
    KeyInput.PlaceholderText = "Enter Key..."
    KeyInput.PlaceholderColor3 = ArqelUI.Keys.Colors.TextPlaceholder
    KeyInput.Text = ""
    KeyInput.TextColor3 = TextWhite
    KeyInput.TextSize = 14
    KeyInput.TextXAlignment = Enum.TextXAlignment.Left
    KeyInput.ClearTextOnFocus = false
    
    KeyInput.Focused:Connect(function()
        SafeTween(KeyBoxStroke, TweenFast, {Color = ArqelUI.Keys.Colors.StrokeAccent})
        SafeTween(KeyBoxImage, TweenFast, {ImageColor3 = ArqelUI.Keys.Colors.StrokeAccent})
    end)
    
    KeyInput.FocusLost:Connect(function()
        SafeTween(KeyBoxStroke, TweenFast, {Color = StrokeDark})
        SafeTween(KeyBoxImage, TweenFast, {ImageColor3 = IconDim})
    end)
    
    local GetLicenseButton = Instance.new('TextButton')
    GetLicenseButton.Name = 'GetLicenseButton'
    GetLicenseButton.Parent = MainFrame
    GetLicenseButton.BackgroundColor3 = ButtonStatic
    GetLicenseButton.BorderSizePixel = 0
    GetLicenseButton.LayoutOrder = 1
    GetLicenseButton.Size = UDim2.new(1, 0, 0, 38)
    GetLicenseButton.Font = Nunito
    GetLicenseButton.Text = ArqelUI.Keys.Premium and "Discord" or "Get License Key"
    GetLicenseButton.TextColor3 = TextWhite
    GetLicenseButton.TextSize = 14
    GetLicenseButton.AutoButtonColor = false
    
    local GetLicenseCorner = Instance.new('UICorner')
    GetLicenseCorner.CornerRadius = CornerRadius
    GetLicenseCorner.Parent = GetLicenseButton
    
    GetLicenseButton.MouseEnter:Connect(function()
        SafeTween(GetLicenseButton, TweenFast, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)})
    end)
    
    GetLicenseButton.MouseLeave:Connect(function()
        SafeTween(GetLicenseButton, TweenFast, {BackgroundColor3 = ButtonStatic})
    end)
    
    GetLicenseButton.MouseButton1Click:Connect(function()
        local link = ArqelUI.Keys.Premium and ArqelUI.Keys.DiscordLink or ArqelUI.Keys.KeyLink
        if link and link ~= "" then
            if setclipboard then setclipboard(link) end
            ArqelUI.Notify({Title = "Arqel", Description = "Link copied to clipboard!", Duration = 3, Type = "success"})
        end
    end)
    
    local InitializeButton = Instance.new('TextButton')
    InitializeButton.Name = 'InitializeButton'
    InitializeButton.Parent = MainFrame
    InitializeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InitializeButton.BorderSizePixel = 0
    InitializeButton.LayoutOrder = 2
    InitializeButton.Size = UDim2.new(1, 0, 0, 42)
    InitializeButton.Font = GothamBold
    InitializeButton.Text = "INITIALIZE"
    InitializeButton.TextColor3 = TextWhite
    InitializeButton.TextSize = 14
    InitializeButton.AutoButtonColor = false
    
    local InitializeCorner = Instance.new('UICorner')
    InitializeCorner.CornerRadius = PillRadius
    InitializeCorner.Parent = InitializeButton
    
    local InitializeGradient = Instance.new('UIGradient')
    InitializeGradient.Parent = InitializeButton
    InitializeGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ArqelUI.Keys.Colors.AccentGradient1),
        ColorSequenceKeypoint.new(1, ArqelUI.Keys.Colors.AccentGradient2)
    })
    InitializeGradient.Rotation = 90
    
    local GlossyShine = Instance.new('Frame')
    GlossyShine.Name = 'GlossyShine'
    GlossyShine.Parent = InitializeButton
    GlossyShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GlossyShine.BackgroundTransparency = 0.85
    GlossyShine.BorderSizePixel = 0
    GlossyShine.Size = UDim2.new(1, 0, 0.4, 0)
    
    local GlossyCorner = Instance.new('UICorner')
    GlossyCorner.CornerRadius = PillRadius
    GlossyCorner.Parent = GlossyShine
    
    local GlossyGradient = Instance.new('UIGradient')
    GlossyGradient.Parent = GlossyShine
    GlossyGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    GlossyGradient.Rotation = 90
    
    InitializeButton.MouseEnter:Connect(function()
        SafeTween(InitializeGradient, TweenFast, {Offset = Vector2.new(0.1, 0)})
    end)
    
    InitializeButton.MouseLeave:Connect(function()
        SafeTween(InitializeGradient, TweenFast, {Offset = Vector2.new(0, 0)})
    end)
    
    InitializeButton.MouseButton1Click:Connect(function()
        local inputText = KeyInput.Text
        if inputText and inputText ~= "" then
            ArqelUI._keyInput = inputText
            if ArqelUI._keyFunction then
                ArqelUI._keyFunction(inputText)
            end
        else
            ArqelUI.Notify({Title = "Arqel", Description = "Please enter a key", Duration = 3, Type = "warn"})
        end
    end)
    
    local BottomFrame = Instance.new('Frame')
    BottomFrame.Name = 'BottomFrame'
    BottomFrame.Parent = DownFrame
    BottomFrame.BackgroundTransparency = 1
    BottomFrame.BorderSizePixel = 0
    BottomFrame.LayoutOrder = 1
    BottomFrame.Size = UDim2.new(1, 0, 0, 22)
    
    local BottomLayout = Instance.new('UIListLayout')
    BottomLayout.Parent = BottomFrame
    BottomLayout.FillDirection = Enum.FillDirection.Horizontal
    BottomLayout.SortOrder = Enum.SortOrder.LayoutOrder
    BottomLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    BottomLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    BottomLayout.Padding = UDim.new(0, 12)
    
    local SettingsButton = Instance.new('ImageButton')
    SettingsButton.Name = 'SettingsButton'
    SettingsButton.Parent = BottomFrame
    SettingsButton.BackgroundTransparency = 1
    SettingsButton.BorderSizePixel = 0
    SettingsButton.LayoutOrder = 0
    SettingsButton.Size = UDim2.new(0, 16, 0, 16)
    SettingsButton.Image = GetIcon("Settings")
    SettingsButton.ImageColor3 = IconDim
    SettingsButton.AutoButtonColor = false
    
    SettingsButton.MouseEnter:Connect(function()
        SafeTween(SettingsButton, TweenFast, {ImageColor3 = ArqelUI.Keys.Colors.StrokeAccent})
    end)
    
    SettingsButton.MouseLeave:Connect(function()
        SafeTween(SettingsButton, TweenFast, {ImageColor3 = IconDim})
    end)
    
    local CopyButton = Instance.new('ImageButton')
    CopyButton.Name = 'CopyButton'
    CopyButton.Parent = BottomFrame
    CopyButton.BackgroundTransparency = 1
    CopyButton.BorderSizePixel = 0
    CopyButton.LayoutOrder = 1
    CopyButton.Size = UDim2.new(0, 16, 0, 16)
    CopyButton.Image = GetIcon("Copy")
    CopyButton.ImageColor3 = IconDim
    CopyButton.AutoButtonColor = false
    
    CopyButton.MouseEnter:Connect(function()
        SafeTween(CopyButton, TweenFast, {ImageColor3 = ArqelUI.Keys.Colors.StrokeAccent})
    end)
    
    CopyButton.MouseLeave:Connect(function()
        SafeTween(CopyButton, TweenFast, {ImageColor3 = IconDim})
    end)
    
    CopyButton.MouseButton1Click:Connect(function()
        local link = ArqelUI.Keys.Premium and ArqelUI.Keys.DiscordLink or ArqelUI.Keys.KeyLink
        if link and link ~= "" and setclipboard then
            setclipboard(link)
            ArqelUI.Notify({Title = "Arqel", Description = "Link copied!", Duration = 2, Type = "success"})
        end
    end)
    
    local UpdatesButton = Instance.new('ImageButton')
    UpdatesButton.Name = 'UpdatesButton'
    UpdatesButton.Parent = BottomFrame
    UpdatesButton.BackgroundTransparency = 1
    UpdatesButton.BorderSizePixel = 0
    UpdatesButton.LayoutOrder = 2
    UpdatesButton.Size = UDim2.new(0, 16, 0, 16)
    UpdatesButton.Image = GetIcon("Refresh")
    UpdatesButton.ImageColor3 = IconDim
    UpdatesButton.AutoButtonColor = false
    
    UpdatesButton.MouseEnter:Connect(function()
        SafeTween(UpdatesButton, TweenFast, {ImageColor3 = ArqelUI.Keys.Colors.StrokeAccent})
    end)
    
    UpdatesButton.MouseLeave:Connect(function()
        SafeTween(UpdatesButton, TweenFast, {ImageColor3 = IconDim})
    end)
    
    local Notifications = Instance.new('ScreenGui')
    Notifications.Name = 'Notifications'
    Notifications.Parent = ScreenGui
    Notifications.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Notifications.DisplayOrder = 101
    Notifications.IgnoreGuiInset = true
    
    local NotificationsFrame = Instance.new('Frame')
    NotificationsFrame.Name = 'NotificationsFrame'
    NotificationsFrame.Parent = Notifications
    NotificationsFrame.BackgroundTransparency = 1
    NotificationsFrame.Position = UDim2.new(1, -280, 0, 20)
    NotificationsFrame.Size = UDim2.new(0, 270, 1, -40)
    
    local NotificationsList = Instance.new('Frame')
    NotificationsList.Name = 'NotificationsList'
    NotificationsList.Parent = NotificationsFrame
    NotificationsList.BackgroundTransparency = 1
    NotificationsList.Size = UDim2.new(1, 0, 1, 0)
    
    local NotificationsLayout = Instance.new('UIListLayout')
    NotificationsLayout.Parent = NotificationsList
    NotificationsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotificationsLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NotificationsLayout.Padding = UDim.new(0, 10)
    
    SafeTween(Background, TweenMedium, {GroupTransparency = 0})
end

return ArqelUI
