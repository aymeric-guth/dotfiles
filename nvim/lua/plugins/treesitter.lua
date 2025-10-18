return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',

  config = function()
    local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
    if not ok then
      return
    end

    -- [[ Configure Treesitter ]]
    -- See `:help nvim-treesitter`
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'css',
        'dockerfile',
        'go',
        'html',
        'javascript',
        'json',
        'lua',
        'make',
        'markdown',
        'python',
        'sql',
        'toml',
        'vim',
        'vimdoc',
        'yaml',
        'ledger',
      },
      sync_install = false,
      auto_install = true,
      autopairs = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      text_object = { enable = true },
      indent = {
        enable = true,
        disable = { 'python' },
      },
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = '<c-space>',
      --     node_incremental = '<c-space>',
      --     scope_incremental = '<c-s>',
      --     node_decremental = '<M-space>',
      --   },
      -- },
      textobjects = {
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
            ['ai'] = '@conditional.outer',
            ['ii'] = '@conditional.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
            ['l='] = '@assignment.lhs',
            ['r='] = '@assignment.rhs',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
            [']l'] = '@loop.outer',
            [']i'] = '@conditional.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
            [']L'] = '@loop.outer',
            [']I'] = '@conditional.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
            ['[l'] = '@loop.outer',
            ['[i'] = '@conditional.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
            ['[L'] = '@loop.outer',
            ['[I'] = '@conditional.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>ts'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>tS'] = '@parameter.inner',
          },
        },
      },
    })
  end,
}
