-- Call Interface
local UI, Settings, Assets, Language = select(2, ...):Call()

-- Lib Globals
local _G = _G

-- WoW Globals
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

-- Locales
UI.Modules = {}

-- Functions
local Hook = function(self, Global, Hook)
	if (_G[Global]) then
		local Func

		if (self[Global]) then
			Func = self[Global]
		elseif (Hook and self[Hook]) then
			Func = self[Hook]
		end

		if (Func) then
			hooksecurefunc(Global, Func)
		end
	end
end

-- Register a Module
function UI:RegisterModule(Name)
	if (self.Modules[Name]) then
		return self.Modules[Name]
	end

	local Module = CreateFrame('Frame', 'Feel_' .. Name, UIParent, 'BackdropTemplate')

	Module.Name = Name
	Module.Hook = Hook
	Module.Loaded = false

	self.Modules[Name] = Module
	self.Modules[#self.Modules + 1] = Module

	return Module
end

-- Call a registered Module
function UI:CallModule(Name)
	if (self.Modules[Name]) then
		return self.Modules[Name]
	end
end

-- Load Module
function UI:LoadModule(Name)
	if (not self.Modules[Name]) then
		return
	end

	local Module = self.Modules[Name]

	if ((not Module.Loaded) and Module.Load) then
		Module:Load()

		Module.Loaded = true
	end
end

-- Load all Modules
function UI:LoadModules()
	for Index = 1, #self.Modules do
		if (self.Modules[Index].Load and not self.Modules[Index].Loaded) then
			self.Modules[Index]:Load()

			self.Modules[Index].Loaded = true
		end
	end
end

-- Init
local OnEvent = function(self, event, addon)
	if (event == "PLAYER_LOGIN") then
		UI:LoadModules()

		self:UnregisterEvent(event)
	end
end

local EventFrame = CreateFrame('Frame')
EventFrame:RegisterEvent('PLAYER_LOGIN')
EventFrame:SetScript('OnEvent', OnEvent)
