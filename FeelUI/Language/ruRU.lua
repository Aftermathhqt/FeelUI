-- Call Interface
local UI, Settings, Assets, Language = select(2, ...):Call()

if (UI.UserLocale ~= 'ruRU') then
	return
end

-- Test
Language['This is a wonderfull test'] = 'This is a wonderfull test'