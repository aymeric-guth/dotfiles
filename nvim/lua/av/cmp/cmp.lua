local status, cmp = pcall(require, 'cmp')
if not status then
  return
end

local status, luasnip = pcall(require, 'luasnip')
if not status then
  return
end

local status, lspkind = pcall(require, 'lspkind')
if not status then
  return
end

local compare = require('cmp.config.compare')
local icons = require('av.ui.icons')
local kind_icons = icons.kind

vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
vim.api.nvim_set_hl(0, 'CmpItemKindTabnine', { fg = '#CA42F0' })
vim.api.nvim_set_hl(0, 'CmpItemKindEmoji', { fg = '#FDE030' })
vim.api.nvim_set_hl(0, 'CmpItemKindCrate', { fg = '#F64D00' })
vim.api.nvim_set_hl(0, 'CmpItemKindLsp', { fg = '#6CC644' })
vim.api.nvim_set_hl(0, 'CmpItemKindBuffer', { fg = '#CA42F0' })
vim.api.nvim_set_hl(0, 'CmpItemKindPath', { fg = '#FDE030' })
vim.api.nvim_set_hl(0, 'CmpItemKindLua', { fg = '#F64D00' })

local source_mapping = {
  cmp_tabnine = icons.misc.TabNine,
  copilot = icons.git.Octoface,
  nvim_lsp = icons.misc.Robot,
  buffer = icons.misc.Buffer,
  path = icons.misc.Path,
  nvim_lua = icons.misc.Vim,
}

cmp.setup({
  --  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    completion = {
      border = 'rounded',
      winhighlight = 'NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None',
    },
    documentation = {
      border = 'rounded',
      winhighlight = 'NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None',
    },
    experimental = {
      ghost_text = true,
    },
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      before = function(entry, vim_item)
        vim_item.menu = source_mapping[entry.source.name]
        -- vim_item.abbr = entry:get_insert_text() .. '[' .. entry.source.name .. ']'
        return vim_item
      end,
    }),
  },

  sources = cmp.config.sources({
    -- { name = 'cmp_tabnine' },
    { name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),

  sorting = {
    priority_weight = 2,
    comparators = {
      compare.offset,
      compare.exact,
      -- compare.scopes,
      compare.score,
      compare.recently_used,
      compare.locality,
      -- compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
      require('copilot_cmp.comparators').prioritize,
      require('copilot_cmp.comparators').score,
    },
  },
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--     { name = 'buffer' },
--   }),
-- })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' },
  }),
})

vim.cmd([[
    augroup NvimCmp
    au!
    au FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
    augroup end
]])
