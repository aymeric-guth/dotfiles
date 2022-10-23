local status, tabnine = pcall(require, 'cmp_tabnine.config')
if not status then
  return
end

tabnine:setup({
  env = {
    XDG_CACHE_HOME = '',
    XDG_CONFIG_HOME = '',
    XDG_DATA_HOME = '',
    HOME = vim.fn.stdpath('data'),
  },
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = '..',
  ignored_file_types = { -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true
  },
})
