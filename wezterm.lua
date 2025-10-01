--- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 13
config.font = wezterm.font 'UbuntuMono Nerd Font'
-- config.color_scheme = 'AdventureTime'

-- Key shortcut
config.keys = {
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'D',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'F',
    mods = 'CMD|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  }
}

config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = "Disabled"

-- Finally, return the configuration to wezterm:
return config
