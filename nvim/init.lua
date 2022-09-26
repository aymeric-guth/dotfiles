local local_vimrc = vim.fn.getcwd() .. '/.nvimrc'
if vim.loop.fs_stat(local_vimrc) then
  vim.cmd('source ' .. local_vimrc)
end

require('av.set')
require('av.keymaps')
require('av.packer')

if os.getenv('NEOVIM_FULL') then
  require('av.cmp')
  require('av.lsp')
end

require('av.telescope')
require('av.tree-sitter')
-- require('av.gitsigns')
require('av.harpoon')
-- require('av.obsidian')
require('av.ui')
