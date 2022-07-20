local status, cmp = pcall(require, 'cmp')
if not status then
  return
end

local status, luasnip = pcall(require, 'luasnip')
if not status then
  return
end

local compare = require('cmp.config.compare')
local icons = require('av.ui.icons')
local kind_icons = icons.kind

-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
-- vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
-- vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
-- vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
-- vim.api.nvim_set_hl(0, "CmpItemKindLsp", { fg = "#6CC644" })
-- vim.api.nvim_set_hl(0, "CmpItemKindBuffer", { fg = "#CA42F0" })
-- vim.api.nvim_set_hl(0, "CmpItemKindPath", { fg = "#FDE030" })
-- vim.api.nvim_set_hl(0, "CmpItemKindLua", { fg = "#F64D00" })

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
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]

      if entry.source.name == 'cmp_tabnine' then
        vim_item.kind = icons.misc.TabNine
        vim_item.kind_hl_group = 'CmpItemKindTabnine'
      end

      if entry.source.name == 'copilot' then
        vim_item.kind = icons.git.Octoface
        vim_item.kind_hl_group = 'CmpItemKindCopilot'
      end

      if entry.source.name == 'emoji' then
        vim_item.kind = icons.misc.Smiley
        vim_item.kind_hl_group = 'CmpItemKindEmoji'
      end

      if entry.source.name == 'nvim_lsp' then
        vim_item.kind = icons.misc.Robot
        vim_item.kind_hl_group = 'CmpItemKindLsp'
      end

      if entry.source.name == 'buffer' then
        vim_item.kind = icons.misc.Buffer
        vim_item.kind_hl_group = 'CmpItemKindBuffer'
      end

      if entry.source.name == 'path' then
        vim_item.kind = icons.misc.Path
        vim_item.kind_hl_group = 'CmpItemKindPath'
      end

      if entry.source.name == 'nvim_lua' then
        vim_item.kind = icons.misc.Vim
        vim_item.kind_hl_group = 'CmpItemKindLua'
      end

      vim_item.menu = ({
        nvim_lsp = '',
        nvim_lua = '',
        luasnip = '',
        buffer = '',
        path = '',
        emoji = '',
      })[entry.source.name]
      return vim_item
    end,
  },

  sources = cmp.config.sources({
    { name = 'null_ls' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'copilot' },
    { name = 'cmp_tabnine' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    -- { name = 'emoji' },
  }),

  sorting = {
    priority_weight = 2,
    comparators = {
      -- require("copilot_cmp.comparators").prioritize,
      -- require("copilot_cmp.comparators").score,
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
      -- require("copilot_cmp.comparators").prioritize,
      -- require("copilot_cmp.comparators").score,
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
    augroup END
]])
