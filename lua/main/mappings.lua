local M = {}

M.map = function(mode, lhs, rhs, opts)
  opts = opts or { noremap = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.buffer_map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_deep_extend("force", { noremap = true }, opts or {})
  vim.api.nvim_buf_set_keymap(opts.buffer, mode, lhs, rhs, opts)
end

M.default = function()
  M.map("v", ">", ">gv")
  M.map("v", "<", "<gv")
  M.map("v", "J", ":m '>+1<CR>gv=gv'")
  M.map("v", "K", ":m '<-2<CR>gv=gv'")

  M.map("x", "<leader>p", [["_dP]])
  M.map("n", "Q", "<nop>")
end

return M

