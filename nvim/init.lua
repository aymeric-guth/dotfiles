local local_vimrc = vim.fn.getcwd() .. '/.nvimrc'
if vim.loop.fs_stat(local_vimrc) then
  vim.cmd('source ' .. local_vimrc)
end

-- local ok, plenary = pcall(require, 'plenary.filetype')
-- if ok then
--   require('plenary.filetype').add_file('sh')
-- end

require('av.packer')
require('av.set')
require('av.autocmd')
require('av.keymaps')

if os.getenv('NEOVIM_FULL') ~= nil then
  require('av.mason')
  require('av.cmp')
  if os.getenv('WORKSPACE') ~= nil then
    require('av.lsp')
    require('av.dap')
  end
  -- require('fidget').setup()
end

require('av.telescope')
require('av.treesitter')
-- vim.opt.verbose = 20
-- vim.opt.verbose = 0
-- vim.opt.verbosefile = nil
require('av.harpoon')
require('av.ui')
require('av.nvim-osc52')
