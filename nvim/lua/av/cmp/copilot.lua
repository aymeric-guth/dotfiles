-- For copilot.vim
-- vim.g.copilot_filetypes = {
--   ["*"] = false,
-- }

-- vim.cmd [[
--   imap <silent><script><expr> <C-A> copilot#Accept("\<CR>")
--   let g:copilot_no_tab_map = v:true
-- ]]

local ok, copilot = pcall(require, 'copilot')
if not ok then
  return
end

local ok, copilot_cmp = pcall(require, 'copilot_cmp')
if not ok then
  return
end

copilot_cmp.setup({
  -- method = 'getCompletionsCycling',
  method = 'getPanelCompletions',
  formatters = {
    label = require('copilot_cmp.format').format_label_text,
    insert_text = require('copilot_cmp.format').format_insert_text,
    preview = require('copilot_cmp.format').deindent,
  },
})

copilot.setup({
  panel = {
    enabled = false,
    auto_refresh = false,
  },
  suggestion = {
    enabled = false,
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ['.'] = false,
  },
})
