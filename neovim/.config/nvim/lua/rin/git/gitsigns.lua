local M = {}

M.plugin = {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  config = function()
    M.setup()
  end,
}

M.setup = function()
  local ok = require("rin.utils.check_requires").check({
    "gitsigns",
  })
  if not ok then
    return
  end

  local gitsigns = require("gitsigns")

  gitsigns.setup({
    signs                        = {
      add                        = { text = "▍" },
      change                     = { text = "▍" },
      delete                     = { text = "▍" },
      topdelete                  = { text = "▍" },
      changedelete               = { text = "▍" },
      untracked                  = { text = "▍" },
    },
    signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
      interval = 1000,
      follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
      virt_text = true,
      virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil, -- Use default
    max_file_length              = 40000,
    preview_config               = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1
    },
    on_attach                    = function(bufnr)
      local gs = package.loaded.gitsigns

      local buf_keymap = require("rin.utils.keymap").buf_keymap

      buf_keymap(bufnr, "n", "<leader>g]", ":Gitsigns next_hunk<CR>")
      buf_keymap(bufnr, "n", "<leader>g[", ":Gitsigns prev_hunk<CR>")
      buf_keymap(bufnr, "n", "<leader>gd", gs.diffthis)
      buf_keymap(bufnr, "n", "<leader>gp", gs.preview_hunk)
      buf_keymap(bufnr, "n", "<leader>gb", function() gs.blame_line({ full = true }) end)
      buf_keymap(bufnr, "n", "<leader>gtb", gs.toggle_current_line_blame)
      buf_keymap(bufnr, "n", "<leader>gtd", gs.toggle_deleted)
    end
  })
end

if not pcall(debug.getlocal, 4, 1) then
  M.setup()
end

return M
