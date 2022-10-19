local status, osc52 = pcall(require, 'osc52')

if not status then
  return
end

osc52.setup({
  max_length = 0, -- Maximum length of selection (0 for no limit)
  silent = false, -- Disable message on successful copy
  trim = false, -- Trim text before copy
})

local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
end

vim.g.clipboard = {
  name = 'osc52',
  copy = { ['+'] = copy, ['*'] = copy },
  paste = { ['+'] = paste, ['*'] = paste },
}

--[[
-- OSC52
--]]
-- Now the '+' register will copy to system clipboard using OSC52
vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, { expr = true })
vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
vim.keymap.set('x', '<leader>c', require('osc52').copy_visual)
vim.keymap.set('n', '<leader>c', '"+y')
vim.keymap.set('n', '<leader>cc', '"+yy')
