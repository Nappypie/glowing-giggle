-- Arqel UI Installer
-- Crimson/Red/Black Theme

local _callcloneref4 = cloneref(game:GetService('HttpService'))
local _callcloneref7 = cloneref(game:GetService('TweenService'))

cloneref(game:GetService('Players'))

local _call16 = TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local _call28 = Instance.new('ScreenGui')
local _call30 = Instance.new('TextLabel')
local _call32 = Instance.new('TextLabel')
local _call34 = Instance.new('ImageLabel')
local _call36 = Instance.new('Frame')
local _call38 = Instance.new('Frame')
local _call40 = Instance.new('Frame')
local _call42 = Instance.new('Frame')
local _call44 = Instance.new('UIScale')
local _call46 = Instance.new('Frame')
local _call48 = Instance.new('UICorner')
local _call50 = Instance.new('Frame')
local _call52 = Instance.new('UIListLayout')
local _call54 = Instance.new('UIListLayout')
local _call56 = Instance.new('Frame')
local _call58 = Instance.new('Frame')
local _call60 = Instance.new('UIListLayout')
local _call62 = Instance.new('UICorner')
local _call64 = Instance.new('UIPadding')
local _call66 = Instance.new('Frame')
local _call68 = Instance.new('UICorner')
local _call70 = Instance.new('UICorner')
local _call72 = Instance.new('UIListLayout')
local _call74 = Instance.new('UICorner')
local _call76 = Instance.new('UIListLayout')
local _call78 = Instance.new('UIPadding')
local _call80 = Instance.new('UIStroke')
local _call82 = Instance.new('UIStroke')

_call28.Parent = game.CoreGui
_call28.Name = 'ArqelUIInstaller'
_call28.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_call28.DisplayOrder = 100
_call28.IgnoreGuiInset = true
_call28.ResetOnSpawn = false

_call40.Name = 'Background'
_call40.Parent = _call28
_call40.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
_call40.BackgroundTransparency = 1
_call40.BorderSizePixel = 0
_call40.Size = UDim2.new(1, 0, 1, 0)

_call42.Name = 'BackgroundFrame'
_call42.Parent = _call40
_call42.BackgroundColor3 = Color3.fromRGB(120, 20, 30)
_call42.BackgroundTransparency = 0.8
_call42.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call42.BorderSizePixel = 0
_call42.Position = UDim2.new(0.354503453, 0, 0.927616954, 0)
_call42.Size = UDim2.new(0, 280, 0, 65)

_call80.Parent = _call42
_call80.Color = Color3.fromRGB(180, 30, 30)
_call80.Transparency = 0.5
_call80.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

_call44.Parent = _call42

_call46.Name = 'MainFrame'
_call46.Parent = _call42
_call46.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
_call46.BackgroundTransparency = 0.3
_call46.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call46.BorderSizePixel = 0
_call46.Size = UDim2.new(1, 0, 1, 0)

_call48.CornerRadius = UDim.new(0, 5)
_call48.Parent = _call46

_call50.Name = 'MiddleFrame'
_call50.Parent = _call46
_call50.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_call50.BackgroundTransparency = 1
_call50.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call50.BorderSizePixel = 0
_call50.LayoutOrder = 1
_call50.Position = UDim2.new(0.25, 0, 0, 0)
_call50.Size = UDim2.new(0.396428585, 70, 1, 0)

_call30.Name = 'MainTitle'
_call30.Parent = _call50
_call30.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_call30.BackgroundTransparency = 1
_call30.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call30.BorderSizePixel = 0
_call30.Size = UDim2.new(1, 0, 0, 25)
_call30.Font = Enum.Font.ArialBold
_call30.Text = ''
_call30.TextColor3 = Color3.fromRGB(255, 255, 255)
_call30.TextSize = 13
_call30.TextXAlignment = Enum.TextXAlignment.Left
_call30.TextYAlignment = Enum.TextYAlignment.Bottom

_call52.Parent = _call50
_call52.SortOrder = Enum.SortOrder.LayoutOrder

_call32.Name = 'MainDesc'
_call32.Parent = _call50
_call32.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_call32.BackgroundTransparency = 1
_call32.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call32.BorderSizePixel = 0
_call32.Size = UDim2.new(1, 0, 0, 34)
_call32.Font = Enum.Font.ArialBold
_call32.Text = ''
_call32.TextColor3 = Color3.fromRGB(255, 255, 255)
_call32.TextSize = 10
_call32.TextTransparency = 0.5
_call32.TextWrapped = true
_call32.TextXAlignment = Enum.TextXAlignment.Left
_call32.TextYAlignment = Enum.TextYAlignment.Top

_call54.Parent = _call46
_call54.FillDirection = Enum.FillDirection.Horizontal
_call54.SortOrder = Enum.SortOrder.LayoutOrder

_call56.Name = 'IconFrame'
_call56.Parent = _call46
_call56.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_call56.BackgroundTransparency = 1
_call56.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call56.BorderSizePixel = 0
_call56.Size = UDim2.new(0, 65, 1, 0)

_call58.Name = 'Icon'
_call58.Parent = _call56
_call58.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
_call58.BackgroundTransparency = 0.2
_call58.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call58.BorderSizePixel = 0
_call58.Size = UDim2.new(1, 0, 1, 0)

_call82.Parent = _call58
_call82.Color = Color3.fromRGB(113, 61, 80)
_call82.Transparency = 0.8
_call82.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

_call34.Name = 'ImageIcon'
_call34.Parent = _call58
_call34.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_call34.BackgroundTransparency = 1
_call34.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call34.BorderSizePixel = 0
_call34.Position = UDim2.new(0.235294119, 0, 0.274509817, 0)
_call34.Size = UDim2.new(0, 30, 0, 30)
_call34.Image = 'rbxassetid://122944092730557'

_call60.Parent = _call58
_call60.HorizontalAlignment = Enum.HorizontalAlignment.Center
_call60.SortOrder = Enum.SortOrder.LayoutOrder
_call60.VerticalAlignment = Enum.VerticalAlignment.Center

_call62.Parent = _call58

_call64.Parent = _call56
_call64.PaddingBottom = UDim.new(0, 7)
_call64.PaddingLeft = UDim.new(0, 7)
_call64.PaddingRight = UDim.new(0, 7)
_call64.PaddingTop = UDim.new(0, 7)

_call66.Name = 'AnimationMainFrame'
_call66.Parent = _call46
_call66.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_call66.BackgroundTransparency = 1
_call66.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call66.BorderSizePixel = 0
_call66.LayoutOrder = 3
_call66.Position = UDim2.new(0.896428585, 0, 0, 0)
_call66.Size = UDim2.new(-0.14642857, 70, 1, 0)

_call36.Name = 'AnimationFrame'
_call36.Parent = _call66
_call36.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
_call36.BackgroundTransparency = 0.15
_call36.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call36.BorderSizePixel = 0
_call36.Position = UDim2.new(0.206896558, 0, 0.306569248, 0)
_call36.Size = UDim2.new(0, 12, 0, 12)

_call68.CornerRadius = UDim.new(1, 0)
_call68.Parent = _call36

_call38.Name = 'Animation'
_call38.Parent = _call36
_call38.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
_call38.BackgroundTransparency = 0.15
_call38.BorderColor3 = Color3.fromRGB(0, 0, 0)
_call38.BorderSizePixel = 0
_call38.Size = UDim2.new(0, 12, 0, 12)

_call70.CornerRadius = UDim.new(1, 0)
_call70.Parent = _call38

_call72.Parent = _call66
_call72.SortOrder = Enum.SortOrder.LayoutOrder
_call72.VerticalAlignment = Enum.VerticalAlignment.Center

_call74.CornerRadius = UDim.new(0, 5)
_call74.Parent = _call42

_call76.Parent = _call40
_call76.HorizontalAlignment = Enum.HorizontalAlignment.Center
_call76.SortOrder = Enum.SortOrder.LayoutOrder
_call76.VerticalAlignment = Enum.VerticalAlignment.Bottom

_call78.Parent = _call40
_call78.PaddingBottom = UDim.new(0, -75)

task.wait(2)

local _call233 = _callcloneref7:Create(_call78, _call16, {
    PaddingBottom = UDim.new(0, 15),
})

_call233:Play()

task.spawn(function() end)

makefolder('ArqelLibrary')
makefolder('ArqelLibrary/Configs')
makefolder('ArqelLibrary/Bin')

_call30.Text = 'Arqel'
_call32.Text = 'Checking files...'

task.wait(0.4)

_call30.Text = 'Arqel'
_call32.Text = 'Loading resources...'

task.wait(0.3)

local _call249 = game:HttpGet([[https://raw.githubusercontent.com/Nappypie/glowing-giggle/refs/heads/main/Loa.lua]])

writefile('ArqelLibrary/Loader.lua', _call249)

_call30.Text = 'Arqel'
_call32.Text = 'Launching...'

task.wait(0.5)

local _call258 = _callcloneref7:Create(_call28.Background.UIPadding, _call16, {
    PaddingBottom = UDim.new(0, -75),
})

_call258:Play()
task.wait(1)
_call28:Destroy()

return loadstring(_call249)() 
