local local_vimrc = vim.fn.getcwd() .. '/.nvimrc'
if vim.loop.fs_stat(local_vimrc) then
  vim.cmd('source' .. local_vimrc)
end

local layer = os.getenv('AV_NVIM_LAYER')

if layer == 'base' or layer == nil then
  require('base')
elseif layer == 'core' or layer == 'ide' then
  require(layer)
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
  require('lazy').setup({
    require(layer .. '.plugins'),
  }, {})
else
  error('Invalid layer: ' .. layer)
end
