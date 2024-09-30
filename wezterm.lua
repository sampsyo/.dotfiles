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

function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local home = os.getenv("HOME")
function short_dir(s)
  if s == "/" then
    return s
  end
  s = string.gsub(s, '/$', '')
  if s == home then
    return "~"
  else
    return basename(s)
  end
end

-- By default, the tab title would show Vim's exit-title string *permanently*
-- if Vim had ever run, even once, in the tab. This is a hacky workaround to
-- detect that title and fall back to the process name instead. Kind of a
-- workaround for wezterm #5800, which would support a "title stack."
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane

    local title = pane.title
    if title == "Thanks for flying Vim" then
      -- Use the process name when the explicit title is not useful.
      title = basename(pane.foreground_process_name)
    end

    if title == "zsh" then
      -- When it's a shell, show the working directory.
      local path = pane.current_working_dir.file_path
      return short_dir(path)
    else
      return title
    end
  end
)

return config
