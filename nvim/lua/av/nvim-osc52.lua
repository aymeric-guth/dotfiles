local ok, osc52 = pcall(require, 'osc52')

if not ok then
  return
end

local function copy(lines, _)
  osc52.copy(table.concat(lines, '\n'))
end

local function paste()
  return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
end

vim.g.clipboard = {
  name = 'osc52',
  copy = { ['+'] = copy, ['*'] = copy },
  paste = { ['+'] = paste, ['*'] = paste },
}

-- Now the '+' register will copy to system clipboard using OSC52
vim.keymap.set('n', '<leader>y', osc52.copy_operator, { expr = true })
vim.keymap.set('n', '<leader>yy', '<leader>y_', { remap = true })
vim.keymap.set('x', '<leader>y', osc52.copy_visual)
