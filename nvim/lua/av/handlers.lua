return {
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  opts = { noremap = true, silent = true },
  -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

    if client.name ~= 'null-ls' then
      client.server_capabilities.document_formatting = false
      -- client.resolved_capabilities.document_formatting = false
    end
    -- local rc = client.resolved_capabilities
    -- rc.document_formatting = false
    -- rc.document_range_formatting = false
    -- rc.document_highlight = false
    -- rc.document_symbol = false
    -- rc.workspace_symbol = false
    -- rc.rename = false
    -- rc.hover = false
    -- rc.completion = false
    -- rc.code_action = false
    -- rc.documenrt_publish_diagnostics = false
  end,

  -- Setup lspconfig.
  capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
  lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  },
}
