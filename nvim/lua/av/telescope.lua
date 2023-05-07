local status, telescope = pcall(require, 'telescope')
if not status then
  return
end
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ['<C-c>'] = actions.close,
      },
      n = {
        ['<C-c>'] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      layout_strategy = 'horizontal',
      layout_config = {
        width = 0.75,
        height = 0.75,
      },
      theme = 'dropdown',
      --theme = 'cursor',
      --theme = 'ivy',
    },
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'frecency')
pcall(telescope.load_extension, 'git_worktree')
