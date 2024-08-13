local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Ayu Dark (Gogh)'
config.window_decorations = 'RESIZE|MACOS_FORCE_ENABLE_SHADOW'
config.quit_when_all_windows_are_closed = false

config.font = wezterm.font_with_fallback {
  'Source Code Pro',
  'SourceCodePro',
  'Menlo',
}
config.font_size = 13.0

config.native_macos_fullscreen_mode = true
config.window_background_opacity = 0.85
config.macos_window_background_blur = 40

config.keys = {
  {
    key = 'k',
    mods = 'CMD',
    action = act.ClearScrollback 'ScrollbackAndViewport',
  },
}

return config
