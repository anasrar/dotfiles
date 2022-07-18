--[=[
install vscode chrome debug
```
git clone https://github.com/Microsoft/vscode-chrome-debug ~/.DAP/vscode-chrome-debug
cd ~/.DAP/vscode-chrome-debug
npm install
npm run build
```
run chrome with argument `--remote-debugging-port=9222`
```
chrome --remote-debugging-port=9222
```

install vscode node debug2
```
git clone https://github.com/microsoft/vscode-node-debug2.git ~/.DAP/vscode-node-debug2
cd ~/.DAP/vscode-node-debug2
npm install
NODE_OPTIONS=--no-experimental-fetch npm run build
```
and run any node using flag `--inspect` or `--inspect-brk`, you can also debug deno using the same flag

debugging ts project using ts-node
install ts-node on local project or global
```
npm i -D ts-node
```
you can start debug with this commnad and attach or just launch
```
node -r ts-node/register --inspect <ts file>
```

install vscode js debug
```
git clone https://github.com/microsoft/vscode-js-debug ~/.DAP/vscode-js-debug --depth=1
cd ~/.DAP/vscode-js-debug
npm install --legacy-peer-deps
npm run compile
```

--]=]

local dap = require('dap')

dap.adapters.chrome = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.DAP/vscode-chrome-debug/out/src/chromeDebug.js' },
}

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.DAP/vscode-node-debug2/out/src/nodeDebug.js' },
}

require('dap-vscode-js').setup({
  node_path = 'node',
  debugger_path = os.getenv('HOME') .. '/.DAP/vscode-js-debug',
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

local exts = {'javascript','typescript','javascriptreact','typescriptreact'}

for i, ext in ipairs(exts) do
  dap.configurations[ext] = {
    {
      type = 'node2',
      request = 'launch',
      name = 'Launch Program (Node2)',
      cwd = vim.fn.getcwd(),
      args = { '${file}' },
      sourceMaps = true,
      protocol = 'inspector',
    },
    {
      type = 'node2',
      request = 'launch',
      name = 'Launch Program (Node2 with ts-node)',
      cwd = vim.fn.getcwd(),
      runtimeArgs = { '-r', 'ts-node/register' },
      runtimeExecutable = 'node',
      args = { '--inspect', '${file}' },
      sourceMaps = true,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
    },
    {
      type = 'node2',
      request = 'launch',
      name = 'Launch Program (Node2 with deno)',
      cwd = vim.fn.getcwd(),
      runtimeArgs = { 'run', '--inspect-brk', '--allow-all', '${file}' },
      runtimeExecutable = 'deno',
      port = 9229,
    },
    {
      type = 'node2',
      request = 'launch',
      name = 'Launch Test Program (Node2 with jest)',
      cwd = vim.fn.getcwd(),
      runtimeArgs = { '--inspect-brk', '${workspaceFolder}/node_modules/.bin/jest' },
      runtimeExecutable = 'node',
      args = { '${file}', '--runInBand', '--coverage', 'false'},
      sourceMaps = true,
      port = 9229,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
    },
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch Test Program (pwa-node with vitest)',
      cwd = vim.fn.getcwd(),
      program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
      args = { 'run', '${file}' },
      autoAttachChildProcesses = true,
      smartStep = true,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
    },
    {
      type = 'node2',
      request = 'launch',
      name = 'Launch Test Program (Node2 with deno)',
      cwd = vim.fn.getcwd(),
      runtimeArgs = { 'test', '--inspect-brk', '--allow-all', '${file}' },
      runtimeExecutable = 'deno',
      port = 9229,
    },
    {
      type = 'chrome',
      request = 'attach',
      name = 'Attach Program (Chrome)',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      port = 9222,
      webRoot = '${workspaceFolder}',
    },
    {
      type = 'node2',
      request = 'attach',
      name = 'Attach Program (Node2)',
      processId = require('dap.utils').pick_process,
    },
    {
      type = 'node2',
      request = 'attach',
      name = 'Attach Program (Node2 with ts-node)',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      port = 9229,
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach Program (pwa-node)',
      cwd = vim.fn.getcwd(),
      processId = require('dap.utils').pick_process,
      skipFiles = { '<node_internals>/**' },
    },
  }
end
