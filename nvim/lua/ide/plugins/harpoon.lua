return {
  'ThePrimeagen/harpoon',
  config = function()
    require('harpoon').setup({})
    local opts = { silent = true, noremap = true }

    vim.keymap.set('n', '<leader>a', function()
      require('harpoon.mark').add_file()
    end, opts)
    vim.keymap.set('n', '<C-e>', function()
      require('harpoon.ui').toggle_quick_menu()
    end)
    vim.keymap.set('n', '<C-j>', function()
      require('harpoon.ui').nav_file(1)
    end)
    vim.keymap.set('n', '<C-k>', function()
      require('harpoon.ui').nav_file(2)
    end)
    vim.keymap.set('n', '<C-h>', function()
      require('harpoon.ui').nav_file(3)
    end)
    vim.keymap.set('n', '<C-f>', function()
      require('harpoon.ui').nav_file(4)
    end)
    vim.keymap.set('n', '<C-s>', function()
      require('harpoon.ui').nav_file(5)
    end)
  end,
}
