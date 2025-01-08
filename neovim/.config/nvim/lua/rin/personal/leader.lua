local M = {}

M.setup = function(args)
  vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
  vim.g.mapleader = " "
  vim.cmd("map \\ <space>")
end

if not pcall(debug.getlocal, 4, 1) then
  M.setup()
end

return M
