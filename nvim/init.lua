local local_vimrc = vim.fn.getcwd() .. '/.nvimrc'
if vim.loop.fs_stat(local_vimrc) then
  vim.cmd('source' .. local_vimrc)
end

require 'av.set'
require 'av.remap'
require 'av.lazy'
require 'av.telescope'
require 'av.nvim-tree'
require 'av.treesitter'
