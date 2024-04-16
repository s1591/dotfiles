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

return { tab_bar = tab_bar }
