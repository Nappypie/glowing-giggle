-- Arqel UI Installer
-- Load this file first

local genv = getgenv()

-- Prevent double execution
if genv.ArqelKeySystem == true then
    return genv.ArqelLibrary
end

-- Services
local HttpService = cloneref(game:GetService('HttpService'))
local TweenService = cloneref(game:GetService('TweenService'))
local Players = cloneref(game:GetService('Players'))
local CoreGui = cloneref(game:GetService('CoreGui'))

-- Tween Info
local AnimInfo = TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

-- Create Installer GUI
local InstallerGui = Instance.new('ScreenGui')
local Background = Instance.new('Frame')
local BackgroundFrame = Instance.new('Frame')
local BackgroundStroke = Instance.new('UIStroke')
local BackgroundScale = Instance.new('UIScale')
local MainFrame = Instance.new('Frame')
local MainCorner = Instance.new('UICorner')
local MiddleFrame = Instance.new('Frame')
local MiddleLayout = Instance.new('UIListLayout')
local MainTitle = Instance.new('TextLabel')
local MainDesc = Instance.new('TextLabel')
local MainLayout = Instance.new('UIListLayout')
local IconFrame = Instance.new('Frame')
local IconPadding = Instance.new('UIPadding')
local Icon = Instance.new('Frame')
local IconImage = Instance.new('ImageLabel')
local IconLayout = Instance.new('UIListLayout')
local IconCorner = Instance.new('UICorner')
local IconStroke = Instance.new('UIStroke')
local AnimationMainFrame = Instance.new('Frame')
local AnimationFrame = Instance.new('Frame')
local AnimationFrameCorner = Instance.new('UICorner')
local Animation = Instance.new('Frame')
local AnimationCorner = Instance.new('UICorner')
local AnimationLayout = Instance.new('UIListLayout')
local BackgroundFrameCorner = Instance.new('UICorner')
local BackgroundLayout = Instance.new('UIListLayout')
local BackgroundPadding = Instance.new('UIPadding')

-- Colors
local CrimsonPrimary = Color3.fromRGB(180, 30, 30)
local CrimsonDark = Color3.fromRGB(120, 20, 30)
local CrimsonStroke = Color3.fromRGB(113, 61, 80)
local Black = Color3.fromRGB(5, 5, 5)
local White = Color3.fromRGB(255, 255, 255)

-- Setup Installer GUI
InstallerGui.Name = 'ArqelUIInstaller'
InstallerGui.Parent = CoreGui
InstallerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
InstallerGui.DisplayOrder = 100
InstallerGui.IgnoreGuiInset = true
InstallerGui.ResetOnSpawn = false

Background.Name = 'Background'
Background.Parent = InstallerGui
Background.BackgroundColor3 = Black
Background.BackgroundTransparency = 1
Background.BorderSizePixel = 0
Background.Size = UDim2.new(1, 0, 1, 0)

BackgroundFrame.Name = 'BackgroundFrame'
BackgroundFrame.Parent = Background
BackgroundFrame.BackgroundColor3 = CrimsonDark
BackgroundFrame.BackgroundTransparency = 0.8
BackgroundFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
BackgroundFrame.BorderSizePixel = 0
BackgroundFrame.Position = UDim2.new(0.354503453, 0, 0.927616954, 0)
BackgroundFrame.Size = UDim2.new(0, 280, 0, 65)

BackgroundStroke.Parent = BackgroundFrame
BackgroundStroke.Color = CrimsonPrimary
BackgroundStroke.Transparency = 0.5
BackgroundStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

BackgroundScale.Parent = BackgroundFrame

MainFrame.Name = 'MainFrame'
MainFrame.Parent = BackgroundFrame
MainFrame.BackgroundColor3 = Black
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Size = UDim2.new(1, 0, 1, 0)

MainCorner.CornerRadius = UDim.new(0, 5)
MainCorner.Parent = MainFrame

MiddleFrame.Name = 'MiddleFrame'
MiddleFrame.Parent = MainFrame
MiddleFrame.BackgroundColor3 = White
MiddleFrame.BackgroundTransparency = 1
MiddleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MiddleFrame.BorderSizePixel = 0
MiddleFrame.LayoutOrder = 1
MiddleFrame.Position = UDim2.new(0.25, 0, 0, 0)
MiddleFrame.Size = UDim2.new(0.396428585, 70, 1, 0)

MainTitle.Name = 'MainTitle'
MainTitle.Parent = MiddleFrame
MainTitle.BackgroundColor3 = White
MainTitle.BackgroundTransparency = 1
MainTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainTitle.BorderSizePixel = 0
MainTitle.Size = UDim2.new(1, 0, 0, 25)
MainTitle.Font = Enum.Font.ArialBold
MainTitle.Text = ''
MainTitle.TextColor3 = White
MainTitle.TextSize = 13
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.TextYAlignment = Enum.TextYAlignment.Bottom

MiddleLayout.Parent = MiddleFrame
MiddleLayout.SortOrder = Enum.SortOrder.LayoutOrder

MainDesc.Name = 'MainDesc'
MainDesc.Parent = MiddleFrame
MainDesc.BackgroundColor3 = White
MainDesc.BackgroundTransparency = 1
MainDesc.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainDesc.BorderSizePixel = 0
MainDesc.Size = UDim2.new(1, 0, 0, 34)
MainDesc.Font = Enum.Font.ArialBold
MainDesc.Text = ''
MainDesc.TextColor3 = White
MainDesc.TextSize = 10
MainDesc.TextTransparency = 0.5
MainDesc.TextWrapped = true
MainDesc.TextXAlignment = Enum.TextXAlignment.Left
MainDesc.TextYAlignment = Enum.TextYAlignment.Top

MainLayout.Parent = MainFrame
MainLayout.FillDirection = Enum.FillDirection.Horizontal
MainLayout.SortOrder = Enum.SortOrder.LayoutOrder

IconFrame.Name = 'IconFrame'
IconFrame.Parent = MainFrame
IconFrame.BackgroundColor3 = White
IconFrame.BackgroundTransparency = 1
IconFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
IconFrame.BorderSizePixel = 0
IconFrame.Size = UDim2.new(0, 65, 1, 0)

Icon.Name = 'Icon'
Icon.Parent = IconFrame
Icon.BackgroundColor3 = CrimsonPrimary
Icon.BackgroundTransparency = 0.2
Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon.BorderSizePixel = 0
Icon.Size = UDim2.new(1, 0, 1, 0)

IconStroke.Parent = Icon
IconStroke.Color = CrimsonStroke
IconStroke.Transparency = 0.8
IconStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

IconImage.Name = 'ImageIcon'
IconImage.Parent = Icon
IconImage.BackgroundColor3 = White
IconImage.BackgroundTransparency = 1
IconImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
IconImage.BorderSizePixel = 0
IconImage.Position = UDim2.new(0.235294119, 0, 0.274509817, 0)
IconImage.Size = UDim2.new(0, 30, 0, 30)
IconImage.Image = 'rbxassetid://122944092730557'

IconLayout.Parent = Icon
IconLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
IconLayout.SortOrder = Enum.SortOrder.LayoutOrder
IconLayout.VerticalAlignment = Enum.VerticalAlignment.Center

IconCorner.Parent = Icon

IconPadding.Parent = IconFrame
IconPadding.PaddingBottom = UDim.new(0, 7)
IconPadding.PaddingLeft = UDim.new(0, 7)
IconPadding.PaddingRight = UDim.new(0, 7)
IconPadding.PaddingTop = UDim.new(0, 7)

AnimationMainFrame.Name = 'AnimationMainFrame'
AnimationMainFrame.Parent = MainFrame
AnimationMainFrame.BackgroundColor3 = White
AnimationMainFrame.BackgroundTransparency = 1
AnimationMainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
AnimationMainFrame.BorderSizePixel = 0
AnimationMainFrame.LayoutOrder = 3
AnimationMainFrame.Position = UDim2.new(0.896428585, 0, 0, 0)
AnimationMainFrame.Size = UDim2.new(-0.14642857, 70, 1, 0)

AnimationFrame.Name = 'AnimationFrame'
AnimationFrame.Parent = AnimationMainFrame
AnimationFrame.BackgroundColor3 = CrimsonPrimary
AnimationFrame.BackgroundTransparency = 0.15
AnimationFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
AnimationFrame.BorderSizePixel = 0
AnimationFrame.Position = UDim2.new(0.206896558, 0, 0.306569248, 0)
AnimationFrame.Size = UDim2.new(0, 12, 0, 12)

AnimationFrameCorner.CornerRadius = UDim.new(1, 0)
AnimationFrameCorner.Parent = AnimationFrame

Animation.Name = 'Animation'
Animation.Parent = AnimationFrame
Animation.BackgroundColor3 = CrimsonPrimary
Animation.BackgroundTransparency = 0.15
Animation.BorderColor3 = Color3.fromRGB(0, 0, 0)
Animation.BorderSizePixel = 0
Animation.Size = UDim2.new(0, 12, 0, 12)

AnimationCorner.CornerRadius = UDim.new(1, 0)
AnimationCorner.Parent = Animation

AnimationLayout.Parent = AnimationMainFrame
AnimationLayout.SortOrder = Enum.SortOrder.LayoutOrder
AnimationLayout.VerticalAlignment = Enum.VerticalAlignment.Center

BackgroundFrameCorner.CornerRadius = UDim.new(0, 5)
BackgroundFrameCorner.Parent = BackgroundFrame

BackgroundLayout.Parent = Background
BackgroundLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
BackgroundLayout.SortOrder = Enum.SortOrder.LayoutOrder
BackgroundLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

BackgroundPadding.Parent = Background
BackgroundPadding.PaddingBottom = UDim.new(0, -75)

-- Pulse Animation for loading dot
local pulseUp = true
task.spawn(function()
    while InstallerGui.Parent ~= nil do
        local targetTransparency = pulseUp and 0.6 or 0.15
        local pulseTween = TweenService:Create(Animation, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            BackgroundTransparency = targetTransparency
        })
        pulseTween:Play()
        pulseTween.Completed:Wait()
        pulseUp = not pulseUp
    end
end)

-- Wait before showing
task.wait(1)

-- Slide in animation
local slideIn = TweenService:Create(BackgroundPadding, AnimInfo, {
    PaddingBottom = UDim.new(0, 15)
})
slideIn:Play()

-- Step 1: Checking files
MainTitle.Text = 'Arqel'
MainDesc.Text = 'Checking files...'

task.wait(0.5)

-- Create folders
local folderSuccess, folderError = pcall(function()
    if not isfolder('ArqelLibrary') then
        makefolder('ArqelLibrary')
    end
    if not isfolder('ArqelLibrary/Configs') then
        makefolder('ArqelLibrary/Configs')
    end
    if not isfolder('ArqelLibrary/Bin') then
        makefolder('ArqelLibrary/Bin')
    end
end)

if not folderSuccess then
    MainDesc.Text = 'Folder error: ' .. tostring(folderError)
    task.wait(3)
end

task.wait(0.3)

-- Step 2: Loading icons
MainDesc.Text = 'Loading icons...'

local NebulaIcons = nil
local iconsLoaded = false

local iconSuccess, iconError = pcall(function()
    NebulaIcons = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()
    iconsLoaded = true
end)

if not iconSuccess then
    MainDesc.Text = 'Icon load failed, using fallback...'
    task.wait(1)
    iconsLoaded = false
end

task.wait(0.3)

-- Step 3: Caching assets
MainDesc.Text = 'Caching assets...'

-- Initialize icon cache
genv.ArqelIcons = {}

if iconsLoaded and NebulaIcons then
    local iconList = {
        {name = "Check", icon = "check", source = "Lucide"},
        {name = "CheckCircle", icon = "check-circle", source = "Lucide"},
        {name = "Close", icon = "x", source = "Lucide"},
        {name = "Key", icon = "key", source = "Lucide"},
        {name = "Settings", icon = "settings", source = "Lucide"},
        {name = "Info", icon = "info", source = "Lucide"},
        {name = "AlertTriangle", icon = "alert-triangle", source = "Lucide"},
        {name = "AlertCircle", icon = "alert-circle", source = "Lucide"},
        {name = "Copy", icon = "copy", source = "Lucide"},
        {name = "Refresh", icon = "refresh-cw", source = "Lucide"},
        {name = "ExternalLink", icon = "external-link", source = "Lucide"},
        {name = "XCircle", icon = "x-circle", source = "Lucide"},
        {name = "Eye", icon = "eye", source = "Lucide"},
        {name = "EyeOff", icon = "eye-off", source = "Lucide"},
        {name = "Link", icon = "link", source = "Lucide"},
    }
    
    for _, iconData in ipairs(iconList) do
        local success, result = pcall(function()
            return NebulaIcons:GetIcon(iconData.icon, iconData.source)
        end)
        
        if success and result then
            genv.ArqelIcons[iconData.name] = result
        else
            genv.ArqelIcons[iconData.name] = ""
        end
    end
else
    -- Fallback - empty icons
    local fallbackList = {"Check", "CheckCircle", "Close", "Key", "Settings", "Info", "AlertTriangle", "AlertCircle", "Copy", "Refresh", "ExternalLink", "XCircle", "Eye", "EyeOff", "Link"}
    for _, name in ipairs(fallbackList) do
        genv.ArqelIcons[name] = ""
    end
end

task.wait(0.3)

-- Step 4: Loading main library
MainDesc.Text = 'Loading library...'

local LoaderCode = nil
local loaderSuccess, loaderError = pcall(function()
    LoaderCode = game:HttpGet("https://raw.githubusercontent.com/Nappypie/glowing-giggle/refs/heads/main/Loa.lua")
end)

if not loaderSuccess then
    MainDesc.Text = 'Failed to load library!'
    task.wait(3)
    InstallerGui:Destroy()
    return nil
end

task.wait(0.3)

-- Step 5: Launching
MainDesc.Text = 'Launching...'

task.wait(0.5)

-- Slide out animation
local slideOut = TweenService:Create(BackgroundPadding, AnimInfo, {
    PaddingBottom = UDim.new(0, -75)
})
slideOut:Play()

task.wait(0.8)

-- Destroy installer
InstallerGui:Destroy()

-- Load and return the library
local Library = loadstring(LoaderCode)()

-- Store reference
genv.ArqelLibrary = Library
genv.ArqelKeySystem = true

return Library
