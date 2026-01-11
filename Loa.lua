-- Arqel UI Loader
-- Crimson/Red/Black Theme

local genv = getgenv()
local _callcloneref4 = cloneref(game:GetService('HttpService'))
local _callcloneref7 = cloneref(game:GetService('TweenService'))

cloneref(game:GetService('Players'))
cloneref(game:GetService('UserInputService'))
cloneref(game:GetService('CoreGui'))

local _callcloneref19 = cloneref(game:GetService('RunService'))

-- Load Nebula Icons
local NebulaIcons = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()

-- Helper function to get icons
local function GetIcon(name, source)
    source = source or "Lucide"
    return NebulaIcons:GetIcon(name, source)
end

-- Color Definitions (Crimson/Red/Black Theme)
local _call23 = Color3.fromRGB(15, 10, 10) -- LoaderBg
local _call25 = Color3.fromRGB(0, 0, 0) -- ContentBg
local _call27 = Color3.fromRGB(33, 15, 15) -- StrokeDark
local _call33 = Color3.fromRGB(255, 255, 255) -- TextWhite
local _call39 = Color3.fromRGB(47, 47, 47) -- ButtonStatic
local _call55 = Color3.fromRGB(200, 100, 100) -- IconDim

-- Font Definitions
local _Nunito75 = Enum.Font.Nunito
local _GothamBold77 = Enum.Font.GothamBold
local _GothamMedium79 = Enum.Font.GothamMedium

-- Size Definitions
local _call83 = UDim2.new(0, 95, 0, 95)
local _call85 = UDim.new(0, 8)

-- Animation Style
local _Exponential91 = Enum.EasingStyle.Exponential

genv.ArqelKeySystem = genv.ArqelKeySystem or false

return {
    AddSettings = function(...) end,
    AdjustTextbox = function(...) end,
    
    Notify = function(self, options)
        options = options or {}
        local Title = options.Title or "Arqel"
        local Description = options.Description or "Notification"
        local Duration = options.Duration or 5
        local Type = options.Type or "info"
        
        local iconMap = {
            info = GetIcon("info", "Lucide"),
            success = GetIcon("check-circle", "Lucide"),
            warn = GetIcon("alert-triangle", "Lucide"),
            alert = GetIcon("alert-circle", "Lucide")
        }
        
        local colorMap = {
            info = Color3.fromRGB(180, 30, 30),
            success = Color3.fromRGB(83, 156, 70),
            warn = Color3.fromRGB(255, 170, 0),
            alert = Color3.fromRGB(200, 50, 50)
        }
        
        local icon = iconMap[Type] or iconMap.info
        local barColor = colorMap[Type] or colorMap.info
        
        task.spawn(function()
            local gui = gethui():FindFirstChild('ArqelUI')
            if not gui then return end
            
            local notifFrame = gui:FindFirstChild('Notifications')
            if not notifFrame then return end
            
            local _call375 = Instance.new('Frame')
            _call375.Name = 'Notification'
            _call375.Parent = notifFrame.NotificationsFrame.NotificationsList
            _call375.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
            _call375.BorderSizePixel = 0
            _call375.Position = UDim2.new(1, 2, 0, 0)
            _call375.Size = UDim2.new(0, 260, 0, 73)
            
            local corner = Instance.new('UICorner')
            corner.CornerRadius = UDim.new(0, 5)
            corner.Parent = _call375
            
            local leftBar = Instance.new('Frame')
            leftBar.Name = 'LeftBar'
            leftBar.Parent = _call375
            leftBar.BackgroundColor3 = barColor
            leftBar.BorderSizePixel = 0
            leftBar.Position = UDim2.new(0, 0, 0, 0)
            leftBar.Size = UDim2.new(0, 3, 1, 0)
            
            local barBg = Instance.new('Frame')
            barBg.Name = 'BarBackground'
            barBg.Parent = _call375
            barBg.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
            barBg.BorderSizePixel = 0
            barBg.Position = UDim2.new(0, 0, 1, -3)
            barBg.Size = UDim2.new(1, 0, 0, 3)
            
            local bar = Instance.new('Frame')
            bar.Name = 'Bar'
            bar.Parent = barBg
            bar.BackgroundColor3 = barColor
            bar.BorderSizePixel = 0
            bar.Size = UDim2.new(1, 0, 1, 0)
            
            local mainFrame = Instance.new('Frame')
            mainFrame.Name = 'MainFrame'
            mainFrame.Parent = _call375
            mainFrame.BackgroundTransparency = 1
            mainFrame.Size = UDim2.new(1, 0, 1, 0)
            
            local layout = Instance.new('UIListLayout')
            layout.Parent = mainFrame
            layout.FillDirection = Enum.FillDirection.Horizontal
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            
            local leftFrame = Instance.new('Frame')
            leftFrame.Name = 'LeftFrame'
            leftFrame.Parent = mainFrame
            leftFrame.BackgroundTransparency = 1
            leftFrame.Size = UDim2.new(0, 60, 1, 0)
            
            local padding = Instance.new('UIPadding')
            padding.Parent = leftFrame
            padding.PaddingBottom = UDim.new(0, 17)
            padding.PaddingLeft = UDim.new(0, 12)
            padding.PaddingRight = UDim.new(0, 12)
            padding.PaddingTop = UDim.new(0, 17)
            
            local iconLabel = Instance.new('ImageLabel')
            iconLabel.Parent = leftFrame
            iconLabel.BackgroundTransparency = 1
            iconLabel.Size = UDim2.new(1, 0, 1, 0)
            iconLabel.Image = icon
            
            local rightFrame = Instance.new('Frame')
            rightFrame.Name = 'RightFrame'
            rightFrame.Parent = mainFrame
            rightFrame.BackgroundTransparency = 1
            rightFrame.Size = UDim2.new(0, 200, 1, 0)
            
            local rightPadding = Instance.new('UIPadding')
            rightPadding.Parent = rightFrame
            rightPadding.PaddingTop = UDim.new(0, 12)
            
            local rightLayout = Instance.new('UIListLayout')
            rightLayout.Parent = rightFrame
            rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            local titleLabel = Instance.new('TextLabel')
            titleLabel.Parent = rightFrame
            titleLabel.BackgroundTransparency = 1
            titleLabel.Size = UDim2.new(0, 190, 0, 15)
            titleLabel.Font = _Nunito75
            titleLabel.Text = Title
            titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            titleLabel.TextSize = 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local descLabel = Instance.new('TextLabel')
            descLabel.Parent = rightFrame
            descLabel.BackgroundTransparency = 1
            descLabel.Size = UDim2.new(0, 190, 0, 15)
            descLabel.Font = _Nunito75
            descLabel.Text = Description
            descLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            descLabel.TextSize = 11
            descLabel.TextTransparency = 0.7
            descLabel.TextWrapped = true
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local slideIn = _callcloneref7:Create(_call375, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 27, 0, 0)
            })
            slideIn:Play()
            
            local barTween = _callcloneref7:Create(bar, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
                Size = UDim2.new(0, 0, 1, 0)
            })
            barTween:Play()
            
            task.delay(Duration, function()
                local slideOut = _callcloneref7:Create(_call375, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.new(1, 2, 0, 0)
                })
                slideOut:Play()
                task.wait(0.3)
                _call375:Destroy()
            end)
        end)
    end,
    
    Fail = function(self)
        self:Notify({
            Title = "Arqel",
            Description = "Invalid Key",
            Duration = 5,
            Type = "alert"
        })
    end,
    
    LoadConfig = function(self)
        if _callcloneref19:IsStudio() then return end
        
        if isfile('ArqelLibrary/Configs/settings.json') then
            local success, data = pcall(function()
                return _callcloneref4:JSONDecode(readfile('ArqelLibrary/Configs/settings.json'))
            end)
            
            if success then
                return data
            end
        end
        
        return {
            Remember = true,
            BackgroundTransparent = true
        }
    end,
    
    Initialize = function(self, config)
        config = config or {}
        
        local MainLoader = config.MainLoader
        local Function = config.Function
        local KeyLink = config.KeyLink or ""
        local Token = config.Token or ""
        local Keyless = config.Keyless or false
        local Premium = config.Premium or false
        
        makefolder('ArqelLibrary')
        makefolder('ArqelLibrary/Configs')
        makefolder('ArqelLibrary/Bin')
        
        if _callcloneref19:IsStudio() then return end
        
        local _call124 = Instance.new('ScreenGui')
        _call124.Name = 'ArqelUI'
        _call124.Parent = gethui()
        _call124.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        _call124.Enabled = true
        _call124.DisplayOrder = 100
        _call124.IgnoreGuiInset = true
        _call124.ResetOnSpawn = false
        
        local _call129 = Instance.new('CanvasGroup')
        _call129.Name = 'Background'
        _call129.Parent = _call124
        _call129.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
        _call129.BackgroundTransparency = 0
        _call129.BorderSizePixel = 0
        _call129.Size = UDim2.new(1, 0, 1, 0)
        _call129.GroupTransparency = 1
        
        local _call135 = Instance.new('Frame')
        _call135.Name = 'Loader'
        _call135.Parent = _call129
        _call135.AnchorPoint = Vector2.new(0.5, 0.5)
        _call135.BackgroundColor3 = _call23
        _call135.BorderSizePixel = 0
        _call135.BackgroundTransparency = 1
        _call135.ClipsDescendants = true
        _call135.Position = UDim2.new(0.5, 0, 0.5, 0)
        _call135.Size = UDim2.new(0, 360, 0, 480)
        
        local _call143 = Instance.new('CanvasGroup')
        _call143.Name = 'ContentHolder'
        _call143.Parent = _call135
        _call143.AnchorPoint = Vector2.new(0.5, 0.5)
        _call143.BackgroundColor3 = _call25
        _call143.BackgroundTransparency = 0.2
        _call143.Position = UDim2.new(0.5, 0, 0.5, 0)
        _call143.Size = UDim2.new(0, 360, 1, 0)
        
        local _call153 = Instance.new('UICorner')
        _call153.CornerRadius = UDim.new(0, 12)
        _call153.Parent = _call143
        
        local _call163 = Instance.new('UIStroke')
        _call163.Parent = _call143
        _call163.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        _call163.Color = _call27
        _call163.Transparency = 0
        _call163.Thickness = 1
        
        -- Create notifications container
        local notifContainer = Instance.new('ScreenGui')
        notifContainer.Name = 'Notifications'
        notifContainer.Parent = _call124
        notifContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        notifContainer.DisplayOrder = 101
        notifContainer.IgnoreGuiInset = true
        
        local notifFrame = Instance.new('Frame')
        notifFrame.Name = 'NotificationsFrame'
        notifFrame.Parent = notifContainer
        notifFrame.BackgroundTransparency = 1
        notifFrame.Size = UDim2.new(1, 0, 1, 0)
        
        local notifList = Instance.new('Frame')
        notifList.Name = 'NotificationsList'
        notifList.Parent = notifFrame
        notifList.BackgroundTransparency = 1
        notifList.Position = UDim2.new(1, -290, 0, 20)
        notifList.Size = UDim2.new(0, 280, 1, -40)
        
        local notifLayout = Instance.new('UIListLayout')
        notifLayout.Parent = notifList
        notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
        notifLayout.Padding = UDim.new(0, 10)
        
        -- Animate GUI in
        local fadeIn = _callcloneref7:Create(_call129, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
            GroupTransparency = 0
        })
        fadeIn:Play()
        
        -- Store references
        self._gui = _call124
        self._loader = _call135
        self._content = _call143
    end,
    
    Keys = {
        MainDesc = '',
        Assets = {
            Logo = {
                ID = 'rbxassetid://122944092730557',
                Size = _call83,
            },
        },
        Keyless = false,
        Updates = {},
        Directory = 'Arqel',
        Settings = {
            AnimStyle = _Exponential91,
            Custom = {
                Remember = true,
                BackgroundTransparent = true,
            },
            AnimationColor = Color3.fromRGB(120, 20, 30),
            AnimationTransparency = 0.7,
            AnimSpeed = 0.8,
            PillRadius = UDim.new(1, 0),
            CornerRadius = _call85,
        },
        activeNotifications = {},
        NotificationCount = 0,
        GUIAnimations = true,
        Colors = {
            FailBg = Color3.fromRGB(20, 9, 9),
            NotificationBg = Color3.fromRGB(25, 15, 15),
            AccentGradient1 = Color3.fromRGB(139, 0, 0),
            InputBgVerify = Color3.fromRGB(94, 94, 94),
            StrokeLight = Color3.fromRGB(29, 29, 29),
            InputBg = Color3.fromRGB(15, 15, 15),
            AccentGradient2 = Color3.fromRGB(200, 40, 40),
            StrokeAccent = Color3.fromRGB(180, 30, 30),
            StrokeDark = _call27,
            NotificationText = Color3.fromRGB(255, 180, 180),
            IconDim = _call55,
            Fail = Color3.fromRGB(156, 63, 99),
            TextPlaceholder = Color3.fromRGB(79, 60, 60),
            Primary = Color3.fromRGB(120, 20, 30),
            IconActive = Color3.fromRGB(255, 220, 220),
            TextDim = Color3.fromRGB(220, 220, 220),
            ContentBg = _call25,
            TextWhite = _call33,
            Dim = Color3.fromRGB(5, 5, 5),
            ButtonStatic = _call39,
            Success = Color3.fromRGB(83, 156, 70),
            IconNormal = Color3.fromRGB(255, 180, 180),
            LoaderBg = _call23,
            SuccessBg = Color3.fromRGB(10, 20, 8),
        },
        Fonts = {
            Simple = Enum.Font.SourceSans,
            SubHeader = _GothamMedium79,
            Main = Font.new('rbxasset://fonts/families/Nunito.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal),
            Main2 = _Nunito75,
            Header = _GothamBold77,
        },
        Premium = false,
        DiscordLink = '',
        MainTitle = 'Arqel',
        KeyLink = '',
    },
    
    AddUpdate = function(self, updateData)
        table.insert(self.Keys.Updates, updateData)
    end,
    
    Authorize = function(self, token)
        if token == self._token then
            self:Notify({
                Title = "Arqel",
                Description = "Key Verified Successfully",
                Duration = 3,
                Type = "success"
            })
            
            task.wait(1)
            
            if self._gui then
                local fadeOut = _callcloneref7:Create(self._gui.Background, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                    GroupTransparency = 1
                })
                fadeOut:Play()
                task.wait(0.5)
                self._gui:Destroy()
            end
            
            if self._mainLoader then
                self._mainLoader()
            end
        else
            self:Fail()
        end
    end,
    
    SaveConfig = function(self, data)
        if _callcloneref19:IsStudio() then return end
        
        local _call612 = _callcloneref4:JSONEncode(data or {
            Remember = true,
            BackgroundTransparent = true,
        })
        
        writefile('ArqelLibrary/Configs/settings.json', _call612)
    end,
}
