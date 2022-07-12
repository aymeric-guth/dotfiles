function ColorTokyoNight()
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.cmd[[colorscheme tokyonight]]
end

function ColorGruvboxCommunity()
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.gruvbox_contrast_light = 'hard'
    vim.cmd[[colorscheme gruvbox]]
end

function ColorGruvboxBaby()
    vim.g.gruvbox_baby_background_color = 'dark'
    vim.g.gruvbox_baby_transparent_mode = true
    -- vim.g.gruvbox_baby_keyword_style = "italic"
    -- vim.g.gruvbox_baby_comment_style = "italic"
    -- vim.g.gruvbox_baby_variable_style = "NONE"
    -- vim.g.gruvbox_baby_highlights = "NONE"
    -- vim.g.gruvbox_baby_function_style = "bold"
    vim.g.gruvbox_baby_telescope_theme = true
    vim.cmd[[colorscheme gruvbox-baby]]
end

ColorGruvboxBaby()
-- ColorGruvboxCommunity()
-- ColorTokyoNight()
