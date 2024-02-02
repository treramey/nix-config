local wezterm = require("wezterm")
local act = wezterm.action

local colors = {
	base = "#1e1e2e",
	maroon = "#eba0ac",
	lavender = "#b4befe",

	surface0 = "#313244",
	overlay0 = "#6c7086",
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	overlay1 = "#7f849c",
	surface1 = "#45475a",
	crust = "#11111b",
}

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local index = tab.tab_index
	local title = tab_title(tab)

	local index_bg = colors.overlay0
	local index_fg = colors.surface0

	local title_bg = colors.surface0
	local title_fg = colors.overlay0

	local intensity = "Normal"
	local italic = false

	if tab.is_active then
		index_bg = colors.lavender
		index_fg = colors.crust

		title_bg = colors.base
		title_fg = colors.lavender

		intensity = "Bold"
		italic = true
	elseif hover then
		index_bg = colors.overlay1
		index_fg = colors.base

		title_bg = colors.surface1
		title_fg = colors.overlay1
		intensity = "Bold"
	end

	return {
		{ Attribute = { Italic = italic } },
		{ Attribute = { Intensity = intensity } },
		{ Background = { Color = index_bg } },
		{ Foreground = { Color = index_fg } },
		{ Text = " " .. index + 1 .. " " },

		{ Background = { Color = title_bg } },
		{ Foreground = { Color = title_fg } },
		{ Text = " " .. title .. " " },
	}
end)

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%a %b %-d %H:%M")

	local leader = colors.rosewater
	if window:leader_is_active() then
		leader = colors.maroon
	end

	local current = 1
	local panes = pane:tab():panes()
	for index, value in pairs(panes) do
		if value:pane_id() == pane:pane_id() then
			current = index
			break
		end
	end

	window:set_right_status(wezterm.format({
		{ Foreground = { Color = colors.flamingo } },
		{ Text = "" },
		{ Background = { Color = colors.flamingo } },
		{ Foreground = { Color = colors.crust } },
		{ Text = " " },
		{ Background = { Color = colors.flamingo } },
		{ Foreground = { Color = colors.crust } },
		{ Text = current .. "-" .. #panes .. " " },

		{ Foreground = { Color = leader } },
		{ Text = "" },
		{ Foreground = { Color = colors.crust } },
		{ Background = { Color = leader } },
		{ Text = date .. " " },
	}))
end)

local config = {
	leader = { key = "Space", mods = "CTRL" },

	audible_bell = "Disabled",
	check_for_updates = false,

	color_scheme = "Catppuccin Mocha",

	window_decorations = "RESIZE",
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

	font_size = 16.0,
	font = wezterm.font_with_fallback({
		"Input Nerd Font",
		"JetBrains Mono",
	}),

	default_cursor_style = "SteadyBar",

	window_background_opacity = 0.82,
	macos_window_background_blur = 20,

	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,

	disable_default_key_bindings = true,
	keys = {
		{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
		{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

		{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

		{ key = "-", mods = "LEADER", action = act.SplitPane({ direction = "Down", size = { Percent = 30 } }) },
		{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

		{ key = " ", mods = "LEADER", action = "TogglePaneZoomState" },

		{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },

		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

		{ key = "K", mods = "LEADER", action = act.RotatePanes("Clockwise") },
		{ key = "J", mods = "LEADER", action = act.RotatePanes("CounterClockwise") },

		{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
		{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
		{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
		{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
		{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
		{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
		{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
		{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
		{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },

		-- which pane
		{ key = "w", mods = "LEADER", action = act.PaneSelect },

		{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
	},
	key_tables = {
		resize_pane = {
			{ key = "LeftArrow", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
			{ key = "DownArrow", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
			{ key = "UpArrow", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
			{ key = "RightArrow", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
			-- Cancel the mode by pressing escape
			{ key = "Escape", action = "PopKeyTable" },
		},
	},
}

return config
