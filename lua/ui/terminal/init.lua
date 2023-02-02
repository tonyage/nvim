local util = require("ui.terminal.util")
local terminal = {}
local terminals = {}

local function get_last(list)
  if list then
    return not vim.tbl_isempty(list) and list[#list] or nil
  end
  return terminals[#terminals] or nil
end

local function get_type(type, list)
  list = list or terminals.list
  return vim.tbl_filter(function(t)
    return t.type == type
  end, list)
end

local function get_still_open()
  if not terminals.list then
    return {}
  end
  return #terminals.list > 0 and vim.tbl_filter(function(t)
    return t.open == true
  end, terminals.list) or {}
end

local function get_last_still_open()
  return get_last(get_still_open())
end

local function get_type_last(type)
  return get_last(get_type(type))
end

local function get_term(key, value)
  return vim.tbl_filter(function(t)
    return t[key] == value
  end, terminals.list)[1]
end

local function create_term_window(type)
  local existing = terminals.list and #get_type(type, get_still_open()) > 0
  util.execute_type_cmd(type, terminals, existing)
  vim.wo.relativenumber = false
  vim.wo.number = false
  return vim.api.nvim_get_current_win()
end

local function ensure_and_send(cmd, type)
  terminals = util.verify(terminals)
  local function select_term()
    if not type then
      return get_last_still_open() or terminal.new "horizontal"
    else
      return get_type_last(type) or terminal.new(type)
    end
  end
  local term = select_term()
  vim.api.nvim_chan_send(term.job_id, cmd .. "\n")
end

local function call_and_restore(fn, opts)
  local current_win = vim.api.nvim_get_current_win()
  local mode = vim.api.nvim_get_mode().mode == "i" and "startinsert" or "stopinsert"

  fn(unpack(opts))
  vim.api.nvim_set_current_win(current_win)

  vim.cmd(mode)
end

local function set_behavior(behavior)
  if behavior.autoclose_on_quit.enabled then
    local function force_exit()
      require("ui.terminal").close_all_terms()
      vim.api.nvim_command "qa"
    end
    vim.api.nvim_create_autocmd({ "WinClosed" }, {
      callback = vim.schedule_wrap(function()
        local open_terms = require("ui.terminal").list_active_terms("win")

        local non_terms = vim.tbl_filter(function(win)
          return not vim.tbl_contains(open_terms, win)
        end, vim.api.nvim_list_wins())

        if not vim.tbl_isempty(non_terms) then
          return
        end

        if not behavior.autoclose_on_quit.confirm then
          return force_exit()
        end

        vim.ui.input({ prompt = "Close all terms and quit? (Y/N): " }, function(input)
          if not input or not string.lower(input) == "y" then
            return
          end
          force_exit()
        end)
      end),
    })
  end

  if behavior.close_on_exit then
    vim.api.nvim_create_autocmd({ "TermClose" }, {
      callback = function()
        vim.schedule_wrap(vim.api.nvim_input "<CR>")
      end,
    })
  end

  if behavior.auto_insert then
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      callback = function()
        vim.cmd("startinsert")
      end,
      pattern = "term://*",
    })

    vim.api.nvim_create_autocmd({ "BufLeave" }, {
      callback = function()
        vim.cmd("stopinsert")
      end,
      pattern = "term://*",
    })
  end
end

function terminal.send(cmd, type)
  if not cmd then
    return
  end
  call_and_restore(ensure_and_send, { cmd, type })
end

function terminal.hide_term(term)
  terminals.list[term.id].open = false
  vim.api.nvim_win_close(term.win, false)
end

function terminal.show_term(term)
  term.win = create_term_window(term.type)
  vim.api.nvim_win_set_buf(term.win, term.buf)
  terminals.list[term.id].open = true
  vim.cmd("startinsert")
end

function terminal.get_and_show(key, value)
  local term = get_term(key, value)
  terminal.show_term(term)
end

function terminal.get_and_hide(key, value)
  local term = get_term(key, value)
  terminal.hide_term(term)
end

function terminal.hide(type)
  local term = type and get_type_last(type) or get_last()
  terminal.hide_term(term)
end

function terminal.show(type)
  terminals = util.verify(terminals)
  local term = type and get_type_last(type) or terminals.last
  terminal.show_term(term)
end

function terminal.new(type, shell_override)
  local win = create_term_window(type)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "filetype", "terminal")
  vim.api.nvim_buf_set_option(buf, "buflisted", false)
  vim.api.nvim_win_set_buf(win, buf)

  local job_id = vim.fn.termopen(terminals.shell or shell_override or vim.o.shell)
  local id = #terminals.list + 1
  local term = { id = id, win = win, buf = buf, open = true, type = type, job_id = job_id }
  terminals.list[id] = term
  vim.cmd("startinsert")
  return term
end


function terminal.toggle(type)
  terminals = util.verify(terminals)
  local term = get_type_last(type)

  if not term then
    term = terminal.new(type)
  elseif term.open then
    terminal.hide_term(term)
  else
    terminal.show_term(term)
  end
end

function terminal.toggle_all_terms()
  terminals = util.verify(terminals)

  for _, term in ipairs(terminals.list) do
    if term.open then
      terminal.hide_term(term)
    else
      terminal.show_term(term)
    end
  end
end

function terminal.close_all_terms()
  for _, buf in ipairs(terminal.list_active_terms "buf") do
    vim.cmd("bd! " .. tostring(buf))
  end
end

function terminal.list_active_terms(property)
  local terms = get_still_open()
  if property then
    return vim.tbl_map(function(t)
      return t[property]
    end, terms)
  end
  return terms
end

function terminal.list_terms()
  return terminals.list
end

function terminal.setup(config)
  config = config or require("ui.terminal.config")
  set_behavior(config.behavior)
  terminals = config.terminals
end

return terminal

