local status, nvim_tree = pcall(require, 'nvim-tree')
if not status then
  return
end

local status, nvim_tree_config = pcall(require, 'nvim-tree.config')
if not status then
  return
end
local tree_cb = nvim_tree_config.nvim_tree_callback

local status, icons = pcall(require, 'av.ui.icons')
if not status then
  return
end

local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = 60
local height = 20

nvim_tree.setup({
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = true,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = true,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = 'name',
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,

  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    -- height = 30,
    hide_root_folder = false,
    side = 'left',
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
    mappings = {
      custom_only = false,
      list = {
        { key = { 'l', '<CR>', 'o' }, cb = tree_cb('edit') },
        { key = 'h', cb = tree_cb('close_node') },
        { key = 'v', cb = tree_cb('vsplit') },
      },
    },
    float = {
      enable = true,
      open_win_config = {
        relative = 'editor',
        border = 'rounded',
        width = width,
        height = height,
        row = (gheight - height) * 0.4,
        col = (gwidth - width) * 0.5,
      },
    },
  },

  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = 'none',
    root_folder_modifier = ':~',
    indent_markers = {
      enable = false,
      icons = {
        corner = '└ ',
        edge = '│ ',
        item = '│ ',
        none = '  ',
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = 'before',
      padding = ' ',
      symlink_arrow = ' ➛ ',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = '',
        symlink = '',
        --				bookmark = "",
        folder = {
          arrow_closed = '',
          arrow_open = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
    special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
    symlink_destination = false,
  },

  hijack_directories = {
    enable = true,
    auto_open = true,
  },

  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },

  ignore_ft_on_setup = {},
  system_open = {
    cmd = '',
    args = {},
  },

  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Information,
      warning = icons.diagnostics.Warning,
      error = icons.diagnostics.Error,
    },
  },

  filters = {
    dotfiles = false,
    custom = { '^.git$' },
    exclude = {},
  },
  -- filesystem_watchers = {
  --   enable = false,
  --   interval = 100,
  --   debounce_delay = 50,
  -- },

  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    timeout = 400,
  },

  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = true,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    open_file = {
      quit_on_open = true,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        exclude = {
          filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },

  trash = {
    cmd = 'gio trash',
    require_confirm = true,
  },

  live_filter = {
    prefix = '[FILTER]: ',
    always_show_folders = true,
  },

  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
})
