local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

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


vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files(require('telescope.themes').get_dropdown({ previewer = false }))
end, { desc = '[f]ind [f]iles' })

vim.keymap.set('n', '<leader>fF', function()
  builtin.find_files({
    no_ignore = true,
    hidden = true,
    no_ignore_vcs = true,
    no_ignore_parent = true,
  })
end, { desc = '[f]ind [F]files (no ignore)' })

vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[f]ind [g]rep' })
vim.keymap.set('n', '<leader>fG', function()
  builtin.live_grep({
    additional_args = function(opts)
      return { '--no-ignore' }
    end,
  })
end, { desc = '[f]ind live [G]rep (no ignore)' })

vim.keymap.set('n', '<leader>fB', builtin.buffers, { desc = '[f]ind [B]uffers (all)' })
vim.keymap.set(
  'n',
  '<leader>fb',
  builtin.current_buffer_fuzzy_find,
  { desc = '[f]ind [b]uffer (current)' }
)
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[f]ind [k]eymaps' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[f]ind [s]tring' })

-- Help
vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = '[f]ind [m]an pages' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind [h]help tags' })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '[f]ind [c]ommands' })
vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = '[f]ind vim [o]ptions' })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = '[f]ind [r]egisters' })
vim.keymap.set('n', '<leader>fa', builtin.autocommands, { desc = '[f]ind [a]utocommands' })
vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = '[f]ind [t]reesitter' })

vim.keymap.set(
  'n',
  '<leader>fld',
  builtin.lsp_document_symbols,
  { desc = '[f]ind [l]sp [d]ocument' }
)
vim.keymap.set(
  'n',
  '<leader>flw',
  builtin.lsp_workspace_symbols,
  { desc = '[f]ind [l]sp [w]orkspace' }
)
