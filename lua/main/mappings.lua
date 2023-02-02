local M = {}

local terminal = require("ui.terminal")
local ft_cmds = {
  python = "python3 " .. vim.fn.expand("%"), shell = "bash " .. vim.fn.expand("%")
}

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
  M.map("n", "q", "<nop>")

  M.map( { "n", "t" }, "<F5>", function()
   terminal.toggle("horizontal")
  end )
  M.map( { "n", "t" }, "<C-\\>", function()
    terminal.toggle("float")
  end )
  M.map("n", "<leader>b", function()
    terminal.send(ft_cmds[vim.bo.filetype])
  end)
end

return M
