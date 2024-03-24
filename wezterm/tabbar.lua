local wezterm = require 'wezterm'

local tab_bar = {
	active_tab = {
		bg_color = '#2b2042',
		fg_color = '#c0c0c0',
		intensity = 'Normal',
		underline = 'Single',
		italic = false,
		strikethrough = false,
	},

	inactive_tab = {
		bg_color = '#1b1032',
		fg_color = '#808080',
	},

	inactive_tab_hover = {
		bg_color = '#3b3052',
		fg_color = '#909090',
		italic = true,
	},

	new_tab = {
		bg_color = '#1b1032',
		fg_color = '#808080',
	},

	new_tab_hover = {
		bg_color = '#3b3052',
		fg_color = '#909090',
		italic = true,
	},
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local tab_bar_style = {
	-- active_tab_left = wezterm.format {
	-- 	{ Background = { Color = '#0b0022' } },
	-- 	{ Foreground = { Color = '#2b2042' } },
	-- 	{ Text = SOLID_LEFT_ARROW },
	-- },
	-- active_tab_right = wezterm.format {
	-- 	{ Background = { Color = '#0b0022' } },
	-- 	{ Foreground = { Color = '#2b2042' } },
	-- 	{ Text = SOLID_RIGHT_ARROW },
	-- },
	-- inactive_tab_left = wezterm.format {
	-- 	{ Background = { Color = '#0b0022' } },
	-- 	{ Foreground = { Color = '#1b1032' } },
	-- 	{ Text = SOLID_LEFT_ARROW },
	-- },
	-- inactive_tab_right = wezterm.format {
	-- 	{ Background = { Color = '#0b0022' } },
	-- 	{ Foreground = { Color = '#1b1032' } },
	-- 	{ Text = SOLID_RIGHT_ARROW },
	-- },

}


return { tab_bar = tab_bar, tab_bar_style = tab_bar_style }
