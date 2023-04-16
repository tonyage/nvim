vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cursorline = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cursorline then
      vim.wo.cursorline = true
      vim.wo.cursorcolumn = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cursorline = vim.wo.cursorline
    local cursorcolumn = vim.wo.cursorcolumn
    if cursorline and cursorcolumn then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cursorline)
      vim.wo.cursorline = false
      vim.wo.cursorcolumn = false
    end
  end
})
