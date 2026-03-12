local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Fonts
config.bidi_enabled = true
config.bidi_direction = 'AutoLeftToRight'
config.font = wezterm.font_with_fallback {
  'JetBrainsMono Nerd Font',
  'Thabit',
}
config.font_size = 12.0

-- Window
config.window_background_opacity = 0.90 -- Nice transparency
config.window_decorations = "RESIZE" -- No title bar
config.enable_tab_bar = false -- Minimal look

-- Window Sizing
config.initial_cols = 120
config.initial_rows = 35


-- Custom COSMIC Red Theme
config.color_schemes = {
  ['Cosmic Red'] = {
    -- The background is nearly black to allow the opacity to shine through
    background = '#030004',
    foreground = '#e0e0e0',

    cursor_bg = '#B12142',
    cursor_fg = '#050505',
    cursor_border = '#B12142',

    selection_fg = '#e0e0e0',
    selection_bg = '#B12142',

    scrollbar_thumb = '#333333',
    split = '#333333',

    ansi = {
      '#1c1c1c', -- Black (Dark Grey)
      '#B12142', -- Red (Your Accent)
      '#76946A', -- Green (Muted Forest)
      '#D7A55C', -- Yellow (Muted Gold)
      '#6C7A96', -- Blue (Muted Slate)
      '#957FB8', -- Magenta (Muted Lavender)
      '#7FA2AC', -- Cyan (Muted Teal)
      '#e0e0e0', -- White
    },
    brights = {
      '#444444', -- Bright Black
      '#D94562', -- Bright Red (Slightly brighter version of accent)
      '#98BB6C', -- Bright Green
      '#EBCB8B', -- Bright Yellow
      '#7E9CD8', -- Bright Blue
      '#C0A0DD', -- Bright Magenta
      '#7FB4CA', -- Bright Cyan
      '#ffffff', -- Bright White
    },
  },
}

config.color_scheme = 'Cosmic Red'

-- Shell
config.default_prog = { '/bin/bash' }

return config
