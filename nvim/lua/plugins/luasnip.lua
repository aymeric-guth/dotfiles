return {
  'L3MON4D3/LuaSnip',
  -- follow latest release.
  version = '2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',
  config = function()
    local ls = require('luasnip')
    local types = require('luasnip.util.types')
    ls.config.set_config({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '<-', 'Error' } },
          },
        },
      },
    })
    vim.keymap.set({ 'i', 's' }, '<C-k>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true, desc = 'goto next' })
    vim.keymap.set({ 'i', 's' }, '<C-j>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true, desc = 'jumps backward' })
    vim.keymap.set({ 'i' }, '<C-l>', function()
      if ls.choice_active() then
        ls.choice_active(-1)
      end
    end, { silent = true, desc = 'cycle between choice nodes' })
    vim.keymap.set(
      { 'n' },
      '<leader><leader>s',
      '<cmd>source ' .. os.getenv('DOTFILES') .. '/nvim/after/plugin/luasnip.lua' .. '<CR>',
      { silent = true, desc = 'reloads snippets' }
    )
  end,
}
