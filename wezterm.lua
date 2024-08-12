local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'AdventureTime'
config.window_decorations = 'RESIZE'
config.quit_when_all_windows_are_closed = false

config.keys = {
  {
    key = 'k',
    mods = 'CMD',
    action = act.ClearScrollback 'ScrollbackAndViewport',
  },
}

return config
