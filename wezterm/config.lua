local wezterm = require 'wezterm'

local config = {
	color_scheme = 'Catppuccin Mocha',
	font = wezterm.font 'jetBrainsMono Nerd Font',
	font_size = 16.0,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = true,
	command_palette_rows = 99,
	window_background_opacity = 0.9,
	tab_bar_at_bottom = true,
}

return config
