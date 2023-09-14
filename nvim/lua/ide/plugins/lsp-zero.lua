return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    { 'williamboman/mason.nvim' }, -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    { 'jose-elias-alvarez/null-ls.nvim' },
    { 'jayp0521/mason-null-ls.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' }, -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' }, -- Required

    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'ray-x/cmp-treesitter' },
    { 'saadparwaiz1/cmp_luasnip' },
  },

  config = function()
    local lsp = require('lsp-zero')

    lsp.preset('recommended')

    lsp.ensure_installed({
      'clangd',
      'pyright',
      'lua_ls',
      'taplo',
      'bashls',
      'dockerls',
      'ansiblels',
      'gopls',
      'golangci_lint_ls',
      'zls',
    })

    -- Fix Undefined global 'vim'
    lsp.nvim_workspace()

    lsp.set_preferences({
      suggest_lsp_servers = false,
      sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I',
      },
    })

    lsp.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set('n', 'gd', function()
        vim.lsp.buf.definition()
      end, opts)
      vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover()
      end, opts)
      vim.keymap.set('n', '<leader>vws', function()
        vim.lsp.buf.workspace_symbol()
      end, opts)
      vim.keymap.set('n', '<leader>vd', function()
        vim.diagnostic.open_float()
      end, opts)
      vim.keymap.set('n', '[d', function()
        vim.diagnostic.goto_next()
      end, opts)
      vim.keymap.set('n', ']d', function()
        vim.diagnostic.goto_prev()
      end, opts)
      vim.keymap.set('n', '<leader>vca', function()
        vim.lsp.buf.code_action()
      end, opts)
      vim.keymap.set('n', '<leader>vrr', function()
        vim.lsp.buf.references()
      end, opts)
      vim.keymap.set('n', '<leader>vrn', function()
        vim.lsp.buf.rename()
      end, opts)
      vim.keymap.set('i', '<C-h>', function()
        vim.lsp.buf.signature_help()
      end, opts)
    end)

    vim.diagnostic.config({
      virtual_text = true,
    })

    lsp.format_on_save({
      format_opts = {
        async = false,
        timeout_ms = 10000,
      },
      servers = {
        ['null-ls'] = {
          'c',
          'cpp',
          'sh',
          'python',
          'rust',
          'lua',
          'javascript',
          'css',
          'html',
          'json',
          'yaml',
          'dockerfile',
          'yaml.ansible',
          'cmake',
          'go',
        },
      },
    })

    lsp.setup()

    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    local null_ls_opts = {
      formatting.astyle.with({
        filetypes = { 'c', 'cpp', 'cxx' },
        extra_args = {
          '--options=' .. require('os').getenv('DOTFILES') .. '/.astylerc',
          -- '--project=none',
        },
      }),
      code_actions.shellcheck.with({
        filetypes = { 'sh' },
      }),
      -- https://github.com/mvdan/sh
      formatting.shfmt.with({
        filetypes = { 'sh' },
      }),
      diagnostics.cppcheck.with({
        filetypes = { 'c', 'cpp' },
        extra_args = {
          -- '--enable=all',
          '--cppcheck-build-dir='
            .. require('os').getenv('WORKSPACE')
            .. '/build',
          -- '--suppress=missingIncludeSystem,unusedFunction',
          '--std=c11',
          '--platform=unix64',
          '--project=' .. require('os').getenv('WORKSPACE') .. '/build/compile_commands.json',
          -- '--addon=' .. require('os').getenv('DOTFILES') .. '/cppcheck/addons.json',
        },
      }),
      formatting.black.with({
        filetypes = { 'python' },
        extra_args = { '--fast' },
      }),
      formatting.rustfmt.with({
        filetypes = { 'rust' },
      }),
      diagnostics.ruff.with({
        filetypes = { 'python' },
      }),
      formatting.prettierd.with({
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'vue',
          'css',
          'scss',
          'less',
          'html',
          'json',
          'jsonc',
          -- 'yaml',
          -- 'markdown',
          'graphql',
          'handlebars',
        },
      }),
      formatting.stylua.with({
        filetypes = { 'lua' },
      }),
      formatting.taplo.with({ filetypes = { 'toml' } }),
      diagnostics.yamllint.with({ filetypes = { 'yaml' } }),
      diagnostics.hadolint.with({ filetypes = { 'dockerfile' } }),
      diagnostics.ansiblelint.with({ filetypes = { 'yaml.ansible' } }),
      formatting.cmake_format.with({ filetypes = { 'cmake' } }),
      -- formatting.shellharden.with({ filetypes = { 'sh' } }),
      diagnostics.golangci_lint.with({ filetypes = { 'go' } }),
      formatting.gofmt.with({ filetypes = { 'go' } }),
      formatting.goimports.with({ filetypes = { 'go' } }),
      -- formatting.goimports_reviser.with({ filetypes = { 'go' } }),
      formatting.zigfmt,
    }

    null_ls.setup({
      debug = true,
      -- capabilities = handlers.capabilities,
      -- lsp_flags = handlers.lsp_flags,
      sources = null_ls_opts,
      -- you can reuse a shared lspconfig on_attach callback here
    })

    require('mason-null-ls').setup({
      ensure_installed = nil,
      automatic_installation = true,
    })

    local cmp = require('cmp')
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = lsp.defaults.cmp_mappings({
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
    })

    cmp_mappings['<Tab>'] = nil
    cmp_mappings['<S-Tab>'] = nil

    -- lsp.setup_nvim_cmp({
    --   mapping = cmp_mappings,
    -- })
    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'cmdline' },
        { name = 'nvim_lsp_document_symbol' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'treesitter' },
        { name = 'luasnip' },
      },
    })
  end,
}
