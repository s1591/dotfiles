local wezterm = require 'wezterm'

local config = {
	color_scheme = 'Catppuccin Mocha', --'rose-pine', --'Rosé Pine (base16)'
	font = wezterm.font 'jetBrainsMono Nerd Font',
	font_size = 16.0,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = true,
	command_palette_rows = 99,
	command_palette_font_size = 16.0,
	command_palette_bg_color = "#191724",
	command_palette_fg_color = "#9CCFD8",
	window_background_opacity = 0.9,
	--window_decorations = "RESIZE",
	tab_bar_at_bottom = true,
	default_cursor_style = "SteadyBar", -- {Steady,Blinking}Block, Underline, Bar
	force_reverse_video_cursor = true,
	check_for_updates = true,
	show_update_window = true,
	unicode_version = 14,
	default_gui_startup_args = {},
	--default_prog = { 'fish', '-iC', '~/Documents/scripts/term_boot' }
	enable_wayland = true,
	enable_scroll_bar = false,
}

return config
