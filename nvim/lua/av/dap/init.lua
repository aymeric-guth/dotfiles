local status, mason = pcall(require, 'mason')
if not status then
  return
end

local status, dap = pcall(require, 'dap')
if not status then
  return
end

mason.setup()
dap.adapters.bashdb = {
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
  name = 'bashdb',
}
dap.configurations.sh = {
  {
    type = 'bashdb',
    request = 'launch',
    name = 'Launch file',
    showDebugOutput = true,
    pathBashdb = vim.fn.stdpath('data')
      .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
    pathBashdbLib = vim.fn.stdpath('data')
      .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
    trace = true,
    file = '${file}',
    program = '${file}',
    cwd = '${workspaceFolder}',
    pathCat = 'cat',
    pathBash = '/bin/bash',
    pathMkfifo = 'mkfifo',
    pathPkill = 'pkill',
    args = {},
    env = {},
    terminalKind = 'integrated',
  },
}
