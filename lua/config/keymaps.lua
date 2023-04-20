local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lsh, mode = mode })] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<leader>i4", "<cmd>setlocal shiftwidth=4 tabstop=4<CR>", { desc = "Set indent to 4 on demand" })
