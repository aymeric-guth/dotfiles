local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

treesitter.setup({
  ensure_installed = {
    'c',
    --"lua",
    --"rust",
    'python',
    --"cmake",
    --"cpp",
    --"css",
    'dockerfile',
    --"go",
    --"html",
    --"java",
    --"javascript",
    'json',
    --"json5",
    --"make",
    'markdown',
    --"ninja",
    --"sql",
    'toml',
    'vim',
    'yaml',
  },
  sync_install = false,
  autopairs = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
