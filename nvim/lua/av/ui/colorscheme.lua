local status_ok, colorscheme = pcall(require, 'gruvbox-baby')
if not status_ok then
  return
end

function ColorTokyoNight()
  vim.g.tokyonight_transparent_sidebar = true
  vim.g.tokyonight_transparent = true
  vim.cmd([[colorscheme tokyonight]])
end

function ColorGruvboxCommunity()
  vim.g.gruvbox_contrast_dark = 'hard'
  vim.g.gruvbox_contrast_light = 'hard'
  vim.cmd([[colorscheme gruvbox]])
end

function ColorGruvboxBaby()
  vim.g.gruvbox_baby_background_color = 'dark'
  vim.g.gruvbox_baby_transparent_mode = true
  -- vim.g.gruvbox_baby_keyword_style = "italic"
  -- vim.g.gruvbox_baby_comment_style = "italic"
  -- vim.g.gruvbox_baby_variable_style = "NONE"
  -- vim.g.gruvbox_baby_highlights = "NONE"
  -- vim.g.gruvbox_baby_function_style = "bold"
  -- local colors = require('gruvbox-baby.colors').config()
  -- vim.g.gruvbox_baby_highlights = { Normal = { fg = colors.orange } }
  vim.g.gruvbox_baby_telescope_theme = true
  vim.cmd([[colorscheme gruvbox-baby]])
end

function GruvboxMaterial()
  vim.g.gruvbox_material_background = 'hard'
  vim.g.gruvbox_material_foreground = 'material'
  vim.cmd([[colorscheme gruvbox-material]])
  -- g.gruvbox_material_disable_italic_comment~
  -- g.gruvbox_material_enable_bold~
  -- g.gruvbox_material_enable_italic~
  -- g.gruvbox_material_cursor~
  -- g.gruvbox_material_transparent_background~
  -- g.gruvbox_material_visual~
  -- g.gruvbox_material_menu_selection_background~
  -- g.gruvbox_material_sign_column_background~
  -- g.gruvbox_material_spell_foreground~
  -- g.gruvbox_material_ui_contrast~
  -- g.gruvbox_material_show_eob~
  -- g.gruvbox_material_diagnostic_text_highlight~
  -- g.gruvbox_material_diagnostic_line_highlight~
  -- g.gruvbox_material_diagnostic_virtual_text~
  -- g.gruvbox_material_current_word~
  -- g.gruvbox_material_disable_terminal_colors~
  -- g.gruvbox_material_statusline_style~
  -- g.gruvbox_material_lightline_disable_bold~
  -- g.gruvbox_material_better_performance~
  -- g.gruvbox_material_colors_override~
end

-- ColorGruvboxBaby()
-- ColorGruvboxCommunity()
-- ColorTokyoNight()
GruvboxMaterial()
