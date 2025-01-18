--[=[
- Download `js-debug-dap-${version}.tar.gz` from https://github.com/microsoft/vscode-js-debug/releases
- Extract it somewhere `tar xvzf js-debug-dap-${version}.tar.gz`
- Point args to `src/dapDebugServer.js`
--]=]

local ok = require("rin.utils.check_requires").check({
  "dap",
})
if not ok then
  return
end

local dap = require("dap")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { os.getenv("HOME") .. "/.DAP/js-debug/src/dapDebugServer.js", "${port}" },
  }
}

local exts = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  -- using pwa-chrome
  "vue",
  "svelte",
}

for _, ext in ipairs(exts) do
  dap.configurations[ext] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node)",
      cwd = "${workspaceFolder}",
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node with deno)",
      runtimeExecutable = "deno",
      runtimeArgs = {
        "run",
        "--inspect-wait",
        "--allow-all"
      },
      program = "${file}",
      cwd = "${workspaceFolder}",
      attachSimplePort = 9229,
    },
  }
end
