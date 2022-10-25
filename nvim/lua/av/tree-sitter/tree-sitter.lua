local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
  return
end

treesitter.setup({
  ensure_installed = {
    'bash',
    'c',
    'cmake',
    'cpp',
    'css',
    'dockerfile',
    'go',
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
