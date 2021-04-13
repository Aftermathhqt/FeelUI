-- Lib Globals
local _G = _G
local select = select
local max = math.max
local min = math.min
local match = string.match

-- WoW Globals
local GetAddOnMetadata = GetAddOnMetadata
local GetCVar = GetCVar
local GetLocale = GetLocale
local GetPhysicalScreenSize = GetPhysicalScreenSize
local GetRealmName = GetRealmName
local GetSpecialization = GetSpecialization
local UnitClass = UnitClass
local UnitFactionGroup = UnitFactionGroup
local UnitGUID = UnitGUID
local UnitLevel = UnitLevel
local UnitName = UnitName
local UnitRace = UnitRace

-- Locales
local Resolution = select(1, GetPhysicalScreenSize()) .. 'x' .. select(2, GetPhysicalScreenSize())
local Windowed = Display_DisplayModeDropDown:windowedmode()
local Fullscreen = Display_DisplayModeDropDown:fullscreenmode()
local PixelPerfectScale = 768 / match(Resolution, '%d+x(%d+)')

-- Build the engine
local AddOnName, Engine = ...

Engine[1] = {} -- UI 
Engine[2] = {} -- Settings
Engine[3] = {} -- Assets
Engine[4] = {} -- Language

-- Modules
Engine[1].Modules = {}

-- Language
local Language = {}

local Index = function(self, key)
	return key
end

setmetatable(Language, { __index = Index })

-- AddOn
Engine[1].UITitle = GetAddOnMetadata('FeelUI', 'Title')
Engine[1].UIVersion = GetAddOnMetadata('FeelUI', 'Version')

-- Player
Engine[1].UserClass = select(2, UnitClass('player'))
Engine[1].UserFaction = UnitFactionGroup('player')
Engine[1].UserGUID = UnitGUID('player')
Engine[1].UserLevel = UnitLevel('player')
Engine[1].UserLocale = GetLocale()
Engine[1].UserName = UnitName('player')
Engine[1].UserRace = select(2, UnitRace('player'))
Engine[1].UserRealm = GetRealmName()
Engine[1].UserSpec = GetSpecialization()

if (Engine[1].UserLocale == 'enGB') then
	Engine[1].UserLocale = 'enUS'
end

-- Game
Engine[1].WindowedMode = Windowed
Engine[1].FullscreenMode = Fullscreen
Engine[1].Resolution = Resolution or (Windowed and GetCVar('gxWindowedResolution')) or GetCVar('gxFullscreenResolution')
Engine[1].ScreenHeight = select(2, GetPhysicalScreenSize())
Engine[1].ScreenWidth = select(1, GetPhysicalScreenSize())
Engine[1].PerfectScale = min(1, max(0.3, 768 / match(Resolution, '%d+x(%d+)')))
Engine[1].Mult = PixelPerfectScale / GetCVar('uiScale')
Engine[1].NoScaleMult = Engine[1].Mult * GetCVar('uiScale')

-- MoveUI
Engine[1].MovingFrameList = {}

-- Update Frames
Engine[1].FrameTable = {}
Engine[1].FontTable = {}
Engine[1].Texture.Table = {}

-- Globals
Engine[1].Dummy = function() return end
Engine[1].TextureCoords = { 0.08, 0.92, 0.08, 0.92 }

-- Skinning
Engine[1].Skinning = {}
Engine[1].Skinning.FeelUI = {}

-- Access Tables
function Engine:Call()
	return self[1], self[2], self[3], self[4]
end

-- Global Access
_G[AddOnName] = Engine
