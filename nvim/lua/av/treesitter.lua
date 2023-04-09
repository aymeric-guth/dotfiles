local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

treesitter.setup({
  ensure_installed = {
    'bash',
    'c',
    'cmake',
    'cpp',
    -- 'c_sharp',
    'css',
    'dockerfile',
    'go',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'make',
    'markdown',
    'ninja',
    'python',
    'rust',
    'sql',
    'toml',
    'vim',
    'vimdoc',
    'yaml',
  },
  sync_install = false,
  auto_install = true,
  autopairs = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = true },
  text_object = { enable = true },
  indent = {
    enable = true,
    disable = { 'python' },
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },

    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },

    swap = {
      enable = true,
      swap_next = {
        ['<leader>tS'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>ts'] = '@parameter.inner',
      },
    },
  },
})

local ok, _ = pcall(require, 'nvim-treesitter/playground')
if not ok then
  return
end
require('nvim-treesitter/playground').setup()
