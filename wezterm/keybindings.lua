local wezterm = require 'wezterm'
local action = wezterm.action

local bindings = {
	-- command palette
	{ key = 'p', mods = 'CTRL', action = action.ActivateCommandPalette },
	-- new tab, ctrl + tab -> switch, ctrl + d -> delete
	{ key = 't', mods = 'CTRL', action = action.SpawnTab 'CurrentPaneDomain' },
	-- vertical split[?]
	{ key = '|', mods = 'CTRL|SHIFT',  action = action.SplitVertical { domain = 'CurrentPaneDomain' }, },
	-- horizontal split[?]
	{ key = '\\', mods = 'CTRL',  action = action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
}

return bindings
