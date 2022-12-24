local M = {}

function M.buf_is_valid(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted 
end

function M.bufilter()
  local bufs = vim.t.bufs or nil
  if not bufs then return {} end
  for i = #bufs, 1, -1 do
    if not M.buf_is_valid(bufs[i]) then
      table.remove(bufs, i)
    end
  end
  return bufs
end

function M.tabufline_next()
  local bufs = M.bufilter() or {}
  for i, v in ipairs(bufs) do
    if vim.api.nvim_get_current_buf() == v then
      vim.cmd(i == #bufs and "b" .. bufs[1] or "b" .. bufs[i + 1])
      break
    end
  end
end

function M.tabufline_prev()
  local bufs = M.bufilter() or {}
  for i, v in ipairs(bufs) do
    if vim.api.nvim_get_current_buf() == v then
      vim.cmd(i == 1 and "b" .. bufs[#bufs] or "b" .. bufs[i - 1])
      break
    end
  end
end

function M.close_buffer(bufnr)
  if vim.bo.buftype == "terminal" then
    vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
  else
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    require("ui.tabline").tabufline_prev()
    vim.cmd("confirm bd" .. bufnr)
  end
end

function M.close_all_buffers(action)
  local bufs = vim.t.bufs
  if action == "closeTab" then
    vim.cmd("tabclose")
  end
  for _, buf in ipairs(bufs) do
    M.close_buffer(buf)
  end
  if action ~= "closeTab" then
    vim.cmd("enew")
  end
end

function M.move_buf(n)
  local bufs = vim.t.bufs
  for i, bufnr in ipairs(bufs) do
    if bufnr == vim.api.nvim_get_current_buf() then
      if n < 0 and i == 1 or n > 0 and i == #bufs then
        bufs[1], bufs[#bufs] = bufs[#bufs], bufs[1]
      else
        bufs[i], bufs[i + n] = bufs[i + n], bufs[i]
      end
      break
    end
  end
  vim.t.bufs = bufs
  vim.cmd("redrawtabline")
end

function M.setup()
  local sections = require("ui.tabline.sections")
  local result = sections.bufferlist() .. (sections.tablist() or "") .. sections.buttons()
  result = sections.offset_tree() .. sections.bufferlist() .. (sections.tablist() or "") .. sections.buttons()
  return result
end

return M

