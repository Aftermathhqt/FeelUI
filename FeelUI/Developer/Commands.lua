-- Call Interface
local UI, Settings, Assets, Language = select(2, ...):Call()

-- Lib Globals
local _G = _G
local select = select
local unpack = unpack
local print = print

-- WoW Globals
local C_UI_Reload = C_UI.Reload

-- Locales
local Commands = {}

-- Functions

-- Init
do -- Blizzard Commands
	local SlashCmdList = _G.SlashCmdList

	-- DeveloperConsole (without starting with `-console`)
	if not SlashCmdList.DEVCON then
		local DevConsole = _G.DeveloperConsole
		if DevConsole then
			_G.SLASH_DEVCON1 = '/devcon'
			SlashCmdList.DEVCON = function()
				DevConsole:Toggle()
			end
		end
	end

	-- ReloadUI: /rl, /reloadui, /reload  NOTE: /reload is from SLASH_RELOAD
	if not SlashCmdList.RELOADUI then
		_G.SLASH_RELOADUI1 = '/rl'
		_G.SLASH_RELOADUI2 = '/reloadui'
		SlashCmdList.RELOADUI = _G.ReloadUI
	end

	-- Stopwatch: /sw, /timer, /stopwatch
	hooksecurefunc(_G, 'UIParentLoadAddOn', function(name)
		if name == 'Blizzard_TimeManager' and not SlashCmdList.STOPWATCH then
			SlashCmdList.STOPWATCH = _G.Stopwatch_Toggle
		end
	end)
end

local Split = function(cmd)
	if cmd:find('%s') then
		return strsplit(' ', cmd)
	else
		return cmd
	end
end

local EventTraceEnabled = false
local EventTrace = CreateFrame('Frame')
EventTrace:SetScript('OnEvent', function(self, event)
	if (event ~= 'GET_ITEM_INFO_RECEIVED' and event ~= 'COMBAT_LOG_EVENT_UNFILTERED') then
		A.Print(event)
	end
end)

SlashCmdList['UICONFIG'] = function(cmd)
	local arg1, arg2 = Split(cmd)
	
	if (arg1 == 'events' or arg1 == 'trace') then
		if (EventTraceEnabled) then
			EventTrace:UnregisterAllEvents()

			EventTraceEnabled = false
		else
			EventTrace:RegisterAllEvents()

			EventTraceEnabled = true
		end	
	end
end

SLASH_UICONFIG1 = '/FeelUI'
SLASH_UICONFIG2 = '/feelui'
