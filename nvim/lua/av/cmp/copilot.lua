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

copilot_cmp.setup({
  method = 'getCompletionsCycling',
})
