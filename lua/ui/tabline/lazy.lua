local buf_is_valid = require("ui.tabline").buf_is_valid
local key = require("main.mappings")
return function(opts)
  vim.t.bufs = vim.api.nvim_list_bufs()

  vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
    callback = function(args)
      if vim.t.bufs == nil then
        vim.t.bufs = vim.api.nvim_get_current_buf() == args.buf and {} or { args.buf }
      else
        local bufs = vim.t.bufs

        if
          not vim.tbl_contains(bufs, args.buf)
          and (args.event == "BufEnter" or vim.bo[args.buf].buflisted)
          and (args.event == "BufEnter" or args.buf ~= vim.api.nvim_get_current_buf())
          and buf_is_valid(args.buf)
        then
          table.insert(bufs, args.buf)
          vim.t.bufs = bufs
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufDelete", {
    callback = function(args)
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        local bufs = vim.t[tab].bufs
        if bufs then
          for i, bufnr in ipairs(bufs) do
            if bufnr == args.buf then
              table.remove(bufs, i)
              vim.t[tab].bufs = bufs
              break
            end
          end
        end
      end
    end,
  })

  key.map("n", "<TAB>", function() require("ui.tabline").tabufline_next() end)
  key.map("n", "<S-TAB>", function() require("ui.tabline").tabufline_prev() end)

  if opts.lazyload then
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "TabEnter", "TermOpen" }, {
      pattern = "*",
      group = vim.api.nvim_create_augroup("TabufflineLazyLoad", {}),
      callback = function()
        if #vim.fn.getbufinfo { buflisted = 1 } >= 2 or #vim.api.nvim_list_tabpages() >= 2 then
          vim.opt.showtabline = 2
          vim.opt.tabline = "%!v:lua.require('ui.tabline').setup()"
          vim.api.nvim_del_augroup_by_name("TabufflineLazyLoad")
        end
      end,
    })
  else
    vim.opt.showtabline = 2
    vim.opt.tabline = "%!v:lua.require('ui.tabline').setup()"
  end
end
