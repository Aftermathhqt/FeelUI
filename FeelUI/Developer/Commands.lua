-- Call Interface
local UI, Settings, Assets, Language = select(2, ...):Call()

-- Lib Globals

-- WoW Globals
local C_UI_Reload = C_UI.Reload

-- Locales
local Commands = {}

-- Functions

-- Init
SLASH_RELOADUI1 = '/rl'
SlashCmdList.RELOADUI = C_UI_Reload
