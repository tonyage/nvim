local separators = require("ui.icons").statusline_separators[vim.g.statusline_style]

local left_sep = separators["left"]
local right_sep = separators["right"]

local modes = {
  ["n"]   = { "NORMAL",              "NormalMode"    },
  ["niI"] = { "NORMAL i",            "NormalMode"    },
  ["niR"] = { "NORMAL r",            "NormalMode"    },
  ["niV"] = { "NORMAL v",            "NormalMode"    },
  ["no"]  = { "N-PENDING",           "NormalMode"    },
  ["i"]   = { "INSERT",              "InsertMode"    },
  ["ic"]  = { "INSERT (completion)", "InsertMode"    },
  ["ix"]  = { "INSERT completion",   "InsertMode"    },
  ["t"]   = { "TERMINAL",            "TerminalMode"  },
  ["nt"]  = { "NTERMINAL",           "NTerminalMode" },
  ["v"]   = { "VISUAL",              "VisualMode"    },
  ["V"]   = { "V-LINE",              "VisualMode"    },
  ["Vs"]  = { "V-LINE (Ctrl O)",     "VisualMode"    },
  [""]  = { "V-BLOCK",             "VisualMode"    },
  ["R"]   = { "REPLACE",             "ReplaceMode"   },
  ["Rv"]  = { "V-REPLACE",           "ReplaceMode"   },
  ["s"]   = { "SELECT",              "SelectMode"    },
  ["S"]   = { "S-LINE",              "SelectMode"    },
  [""]  = { "S-BLOCK",             "SelectMode"    },
  ["c"]   = { "COMMAND",             "CommandMode"   },
  ["cv"]  = { "COMMAND",             "CommandMode"   },
  ["ce"]  = { "COMMAND",             "CommandMode"   },
  ["r"]   = { "PROMPT",              "ConfirmMode"   },
  ["rm"]  = { "MORE",                "ConfirmMode"   },
  ["r?"]  = { "CONFIRM",             "ConfirmMode"   },
  ["!"]   = { "SHELL",               "TerminalMode"  },
}

local M = {}

function M.mode()
  local m = vim.api.nvim_get_mode().mode
  local current_mode = "%#" .. modes[m][2] .. "#" .. "  " .. modes[m][1]
  local separator = "%#" .. modes[m][2] .. "Sep" .. "#" .. right_sep
  return current_mode .. separator .. "%#buffer#" .. right_sep
end

function M.git()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ""
  end

  local git_status = vim.b.gitsigns_status_dict
  local branch = "%#git_branch#".. "  " .. git_status.head
  local added = (git_status.added and git_status.added ~= 0) and ("%#git_added#" .. "  " .. git_status.added) or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and ("%#git_changed#" .. "  " .. git_status.changed) or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and ("%#git_removed#" .. "  " .. git_status.removed) or ""
  local sep = " " .. "%#git_sep#" .. right_sep
  return branch .. added .. changed .. removed .. sep
end

function M.progress()
  if not rawget(vim, "lsp") then
    return ""
  end

  local lsp = vim.lsp.util.get_progress_messages()[1]

  if vim.o.columns < 120 or not lsp then
    return ""
  end

  local updates = ""
  if require("lazy.status").has_updates() then
    updates = require("lazy.status").updates()
  end

  local msg = lsp.message or ""
  local percentage = lsp.percentage or 0
  local title = lsp.title or ""
  local spinners = { "", "" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
  return ("%#lsp_progress#" .. content .. updates) or ""
end

function M.diagnostics()
  if not rawget(vim, "lsp") then
    return ""
  end

  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

  local e = (errors and errors > 0) and ("%#lsp_error#" .. " " .. errors .. " ") or ""
  local w = (warnings and warnings > 0) and ("%#lsp_warning#" .. "  " .. warnings .. " ") or ""
  local h = (hints and hints > 0) and ("%#lsp_hints#" .. "ﯧ " .. hints .. " ") or ""
  local i = (info and info > 0) and ("%#lsp_info#" .. " " .. info .. " ") or ""

  return e .. w .. h .. i
end

function M.cwd()
  local dir_icon = "%#cwd_icon#" .. " "
  local dir_name = "%#cwd_text#" .. " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " "
  return (vim.o.columns > 85 and ("%#cwd_sep#" .. left_sep .. dir_icon .. dir_name)) or ""
end

function M.lsp_status()
  local sep = "%#lsp_sep#" .. left_sep
  local icon = "%#lsp_icon#" .. "  "
  local text = "%#lsp_text#" .. " "
  if rawget(vim, "lsp") then
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      if client.attached_buffers[vim.api.nvim_get_current_buf()] then
        return (vim.o.columns > 100 and sep .. icon .. text .. client.name .. " ")
      end
    end
  end
end

local function readonly()
  if vim.bo.filetype == "help" then
    return false
  end
  return vim.bo.readonly
end

function M.file_info()
  local icon = "%#pos_sep#" .. left_sep .. "%#pos_icon#" .. " "
  local encode = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.enc

  local current_line = vim.fn.line "."
  local total_line = vim.fn.line "$"
  local text = math.modf((current_line / total_line) * 100) .. tostring "%%"

  text = (current_line == 1 and "Top") or text
  text = (current_line == total_line and "Bot") or text
  local result = "%#pos_text#" .. " " ..  encode:upper() .. " │ " .. text .. " "

  if readonly() then
    result = "%#pos_text#" .. " readonly" .. " │ "  .. encode:upper() .. " │ " .. text .. " "
  end

  return icon .. result
end

return M

