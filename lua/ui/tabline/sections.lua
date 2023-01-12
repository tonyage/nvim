local buf_is_valid = require("ui.tabline").buf_is_valid
local themer = require("ui.themer")
themer.highlight("tabline")

vim.cmd("function! TbGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction")
vim.cmd[[
   function! TbKillBuf(bufnr,b,c,d) 
        call luaeval('require("ui.tabline").close_buffer(_A)', a:bufnr)
  endfunction]]
vim.cmd("function! TbNewTab(a,b,c,d) \n tabnew \n endfunction")
vim.cmd("function! TbGotoTab(tabnr,b,c,d) \n execute a:tabnr ..'tabnext' \n endfunction")
vim.cmd("function! TbTabClose(a,b,c,d) \n lua require('ui.tabline').close_all_buffers('closeTab') \n endfunction")
vim.cmd("function! TbCloseAllBufs(a,b,c,d) \n lua require('ui.tabline').close_all_buffers() \n endfunction")
vim.cmd("function! TbToggleTabs(a,b,c,d) \n let g:toggletabs = !g:TbTabsToggled | redrawtabline \n endfunction")

vim.api.nvim_create_user_command("TbPick", function()
  vim.g.pickbuffer = true
  vim.cmd("redrawtabline")
  vim.api.nvim_echo({ { "Enter Num ", "Question" } }, false, {})
  local key = tonumber(vim.fn.nr2char(vim.fn.getchar()))
  local bufid = vim.t.bufs[(key and key or 0) + vim.g.buffirst]
  if key and bufid then
    vim.cmd("b" .. bufid)
    vim.api.nvim_echo({ { "key: " .. key .. " bufid: " .. bufid } }, false, {})
    vim.cmd("redraw")
  end
  vim.g.pickbuffer = false
  vim.cmd("redrawtabline")
end, {})

vim.api.nvim_create_user_command("TbLeft", function()
  require("ui.tabline").move_buf(-1)
end, {})

vim.api.nvim_create_user_command("TbRight", function()
  require("ui.tabline").move_buf(1)
end, {})

local function nvim_tree_width(filetype)
  for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].ft == filetype then
      return vim.api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

local function button_width() -- close, theme toggle btn etc
  local width = 6
  if vim.fn.tabpagenr "$" ~= 1 then
    width = width + ((3 * vim.fn.tabpagenr "$") + 2) + 10
    width = not vim.g.toggletabs and 8 or width
  end
  return width
end

local function add_file_info(name, bufnr)
  local present, devicons = pcall(require, "nvim-web-devicons")
  if present then
    local icon, icon_hl = devicons.get_icon(name, string.match(name, "%a+$"))
    local padding = (24 - #name - 5) / 2

    if not icon then
      icon, icon_hl = devicons.get_icon("default_icon")
    end

    icon = (
      vim.api.nvim_get_current_buf() == bufnr and themer.new_hl_groups("TbLine", icon_hl, "TbLineBufOn") .. " " .. icon
      or themer.new_hl_groups("TbLine", icon_hl, "TbLineBufOff") .. " " .. icon
    )

    for _, value in ipairs(vim.t.bufs) do
      if buf_is_valid(value) then
        if name == vim.fn.fnamemodify(vim.api.nvim_buf_get_name(value), ":t") and value ~= bufnr then
          local other = {}
          for match in (vim.api.nvim_buf_get_name(value) .. "/"):gmatch("(.-)" .. "/") do
            table.insert(other, match)
          end
          local current = {}
          for match in (vim.api.nvim_buf_get_name(bufnr) .. "/"):gmatch("(.-)" .. "/") do
            table.insert(current, match)
          end
          name = current[#current]
          for i = #current - 1, 1, -1 do
            local value_current = current[i]
            local other_current = other[i]
            if value_current ~= other_current then
              name = value_current .. "/../" .. name
              break
            end
          end
          break
        end
      end
    end
    name = (#name > 18 and string.sub(name, 1, 16) .. "..") or name
    name = (vim.api.nvim_get_current_buf() == bufnr and "%#TbLineBufOn# " .. name) or ("%#TbLineBufOff# " .. name)
    return icon .. string.rep(" ", padding) .. name .. string.rep(" ", padding)
  end
end

local function style_buffer_tab(nr)
  local close_btn = "%" .. nr .. "@TbKillBuf@ %X"
  local name = (#vim.api.nvim_buf_get_name(nr) ~= 0) and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(nr), ":t") or " No Name "
  name = "%" .. nr .. "@TbGoToBuf@" .. add_file_info(name, nr) .. "%X"

  if nr == vim.api.nvim_get_current_buf() then
    close_btn = (vim.bo[0].modified and "%" .. nr .. "@TbKillBuf@%#TbLineBufOnModified# ")
      or ("%#TbLineBufOnClose#" .. close_btn)
    name = "%#TbLineBufOn#" .. name .. close_btn
  else
    close_btn = (vim.bo[nr].modified and "%" .. nr .. "@TbKillBuf@%#TbBufLineBufOffModified# ")
      or ("%#TbLineBufOffClose#" .. close_btn)
    name = "%#TbLineBufOff#" .. name .. close_btn
  end
  return name
end

local M = {}

function M.offset_tree()
  return "%#NeoTreeNormal#" .. string.rep(" ", nvim_tree_width("neo-tree") - 1) -- .. "%#NeoTreeWinSeparator#"  -- .. "▕"
end

function M.cover_nvim_tree()
  return "%NvimTreeNormal#" .. (vim.g.nvimtree_side == "left" and "" or string.rep(" ", nvim_tree_width("neo-tree")))
end

function M.bufferlist()
  local buffers = {}
  local available_space = vim.o.columns - nvim_tree_width("neo-tree") - button_width()
  local current_buf = vim.api.nvim_get_current_buf()
  local has_current = false
  if vim.g.pickbuffer then
    for index, value in ipairs(vim.g.visiblebuffers) do
      print("index: " .. tostring(index))
      local name = value:gsub("", "(" .. index .. ")")
      table.insert(buffers, name)
    end
    return table.concat(buffers) .. "%#TbLineFill#" .. "%="
  end

  vim.g.buffirst = 0
  for _, bufnr in ipairs(vim.t.bufs) do
    if buf_is_valid(bufnr) then
      if ((#buffers + 1) * 21) > available_space then
        if has_current then break end
        vim.g.buffirst = vim.g.buffirst + 1
        table.remove(buffers, 1)
      end
      has_current = (bufnr == current_buf and true) or has_current
      table.insert(buffers, style_buffer_tab(bufnr))
    end
  end
  vim.g.visiblebuffers = buffers
  return table.concat(buffers) .. "%#TbLineFill#" .. "%="
end

vim.g.toggletabs = 0

function M.tablist()
  local result, number_of_tabs = "", vim.fn.tabpagenr "$"

  if number_of_tabs > 1 then
    for i = 1, number_of_tabs, 1 do
      local tab_hl = ((i == vim.fn.tabpagenr()) and "%#TbLineTabOn# ") or "%#TbLineTabOff# "
      result = result .. ("%" .. i .. "@TbGotoTab@" .. tab_hl .. i .. " ")
      result = (i == vim.fn.tabpagenr() and result .. "%#TbLineTabCloseBtn#" .. "%@TbTabClose@ %X") or result
    end
    local new_tab_button = "%#TbLineTabNewBtn#" .. "%@TbNewTab@ %X"
    local tabs_toggle_button = "%@TbToggleTabs@ %#TbTabTitle# TABS %X"
    return vim.g.toggletabs == 1 and tabs_toggle_button:gsub("()", { [36] = " " })
      or new_tab_button .. tabs_toggle_button .. result
  end
end

function M.buttons()
  local close_all = "%@TbCloseAllBufs@%#TbLineCloseAllBufsBtn#" .. "  " .. "%X"
  local buttons = close_all
  return buttons
end

return M

