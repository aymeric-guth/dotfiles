local status, obsidian = pcall(require, 'obsidian')
if not status then
  error('obsidian')
  return
end

obsidian.setup({
  dir = os.getenv('OBSIDIAN_VAULT'),
  completion = {
    nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
  },
})
