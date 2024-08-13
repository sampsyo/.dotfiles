local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Ir Black (Gogh)'
config.window_decorations = 'RESIZE|MACOS_FORCE_ENABLE_SHADOW' ..
  '|INTEGRATED_BUTTONS'
config.quit_when_all_windows_are_closed = false

config.font = wezterm.font_with_fallback {
  { family = 'Cascadia Mono', weight = 'Medium' },
  { family = 'Source Code Pro', weight = 'Medium' },
  { family = 'SourceCodePro', weight = 'Medium' },
  'Menlo',
}
config.font_size = 12.0

config.native_macos_fullscreen_mode = true
config.window_background_opacity = 0.87
config.macos_window_background_blur = 40

config.keys = {
  {
    key = 'k',
    mods = 'CMD',
    action = act.ClearScrollback 'ScrollbackAndViewport',
  },
}

return config
