CONFIG_RELOAD_NOTIFICATIONS = false
START_IN_FULL_SCREEN = false

local wezterm = require 'wezterm'
local _config = require('./config')
local _keybindings = require('./keybindings')

local config = wezterm.config_builder()
config = _config

config.keys = _keybindings

if CONFIG_RELOAD_NOTIFICATIONS then
	wezterm.on('window-config-reloaded',
		function(window, pane)
			window:toast_notification('wezterm', 'configuration reloaded!', nil, 2000)
		end)
end

if START_IN_FULL_SCREEN then
	wezterm.on('gui-startup',
		function()
			local tab, pane, window = wezterm.mux.spawn_window({})
			window:gui_window():maximize()
		end)
end

return config
