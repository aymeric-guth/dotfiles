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
    'c_sharp',
    'css',
    'dockerfile',
    'go',
    'help',
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
    'yaml',
  },
  sync_install = false,
  autopairs = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = true },
  text_object = { enable = true },
  indent = {
    enable = true,
  },
})

local ok, _ = pcall(require, 'nvim-treesitter/playground')
if not ok then
  return
end
require('nvim-treesitter/playground').setup()
