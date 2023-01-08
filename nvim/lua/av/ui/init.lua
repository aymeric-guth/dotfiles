require('av.ui.colorscheme')
require('av.ui.trouble')
require('av.ui.bufferline')
require('av.ui.nvim-tree')
require('av.ui.lualine')
require('av.ui.colorizer')

if os.getenv('NEOVIM_FULL') ~= nil then
  require('av.ui.illuminate')
end
