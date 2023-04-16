local icons = require("lazyvim.config").icons
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "",
            highlight = "CursorLine",
          },
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local fg = function(name)
        return function()
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end
      return {
        options = {
          disabled_filetypes = { "alpha" },
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { "mode", icon = { "" } },
          },
          lualine_b = {
            { "branch", draw_empty = true, icon = { "" } },
            {
              "diff",
              symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed },
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = { modified = icons.git.modified, readonly = "", unnamed = "" },
            },
          },
          lualine_x = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            "filetype",
            {
              "fileformat",
              separator = "",
              symbols = { unix = "", dos = "", mac = "" },
            },
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = fg("Statement"),
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                require("noice").api.status.mode.has()
              end,
              color = fg("Constant"),
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = fg("Special"),
            },
          },
          lualine_z = {
            { "location", padding = { left = 1, right = 1 } },
          },
        },
      }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          always_show = {
            ".github/",
            ".envrc",
            ".env",
            ".editorconfig",
            ".gitignore",
          },
        },
      },
      default_component_configs = {
        container = {
          right_padding = 1,
        },
      },
      source_selector = {
        winbar = true,
        tabs_layout = "equal",
        show_separator_on_edge = false,
      },
      popup_border_style = "single",
      open_files_do_not_replace_types = { "terminal", "trouble", "qf", "ugaterm" },
      separator = { right = "▏" },
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {
      { "<leader>o", "<cmd>SymbolsOutline", desc = "Open Symbols Outline menu" },
    },
    opts = { position = "right" },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      local right = "⟩"
      return {
        highlight = true,
        icons = require("lazyvim.config").icons,
        separator = " " .. right .. " ",
      }
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      views = {
        cmdline_popup = {
          border = { style = "single", padding = { 1, 1 } },
          filter_options = {},
          position = { row = 5, col = "50%" },
          size = { width = 60, height = "auto" },
          win_options = { winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" } },
        },
        popupmenu = {
          relative = "editor",
          border = { style = "none", padding = { 1, 1 } },
          position = { row = 9, col = "50%" },
          size = { width = 60, height = 10 },
          win_options = { winhighlight = { Normal = "Pmenu", FloatBorder = "DiagnosticInfo" } },
        },
        mini = {
          win_options = { winhighlight = { Normal = "Normal" } },
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      {
        fps = 100,
        on_open = function(win)
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, {
              border = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            })
          end
        end,
      },
    },
  },
}
