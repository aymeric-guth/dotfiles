local status, telescope = pcall(require, 'telescope')
if not status then
  return
end
local actions = require('telescope.actions')

-- local file_browser = telescope.extensions.file_browser
-- if not file_browser then
--     return
-- end
-- local fb_actions = file_browser.actions

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
    -- file_browser = {
    --   initial_mode = 'normal',
    --   hijack_netrw = true,
    --   mappings = {
    --     ['i'] = {
    --       ['<A-c>'] = fb_actions.create,
    --       ['<S-CR>'] = fb_actions.create_from_prompt,
    --       ['<A-r>'] = fb_actions.rename,
    --       ['<A-m>'] = fb_actions.move,
    --       ['<A-y>'] = fb_actions.copy,
    --       ['<A-d>'] = fb_actions.remove,
    --       ['<C-o>'] = fb_actions.open,
    --       ['<C-g>'] = fb_actions.goto_parent_dir,
    --       ['<C-e>'] = fb_actions.goto_home_dir,
    --       ['<C-w>'] = fb_actions.goto_cwd,
    --       ['<C-t>'] = fb_actions.change_cwd,
    --       ['<C-f>'] = fb_actions.toggle_browser,
    --       ['<C-h>'] = fb_actions.toggle_hidden,
    --       ['<C-s>'] = fb_actions.toggle_all,
    --     },
    --     ['n'] = {
    --       ['c'] = fb_actions.create,
    --       ['r'] = fb_actions.rename,
    --       ['m'] = fb_actions.move,
    --       ['y'] = fb_actions.copy,
    --       ['d'] = fb_actions.remove,
    --       ['l'] = actions.select_default,
    --       ['h'] = function(prompt_bufnr, _)
    --         fb_actions.goto_parent_dir(prompt_bufnr, false)
    --       end,
    --       ['e'] = fb_actions.goto_home_dir,
    --       ['w'] = fb_actions.goto_cwd,
    --       ['t'] = fb_actions.change_cwd,
    --       ['f'] = fb_actions.toggle_browser,
    --       ['s'] = fb_actions.toggle_hidden,
    --       -- ['h'] = fb_actions.toggle_hidden,
    --       -- ['s'] = fb_actions.toggle_all,
    --     },
    --   },
    -- },
  },
})

telescope.load_extension('fzf')
telescope.load_extension('frecency')
-- telescope.load_extension('file_browser')
