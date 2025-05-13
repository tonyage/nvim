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
            highlight = "CursorLine",
            text = "",
          },
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        separator_style = "thin",
        indicator = {
          style = "none",
        },
        style_preset = require("bufferline").style_preset.minimal,
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
              color = fg("String"),
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
    requires = {
      "3rd/image.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
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
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
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
      presets = { command_palette = true },
    },
  },
  {
    "stevearc/aerial.nvim",
    event = "LazyFile",
    opts = function()
      local icons = vim.deepcopy(LazyVim.config.icons.kinds)

      -- HACK: fix lua's weird choice for `Package` for control
      -- structures like if/else/for/etc.
      icons.lua = { Package = icons.Control }

      ---@type table<string, string[]>|false
      local filter_kind = false
      if LazyVim.config.kind_filter then
        filter_kind = assert(vim.deepcopy(LazyVim.config.kind_filter))
        filter_kind._ = filter_kind.default
        filter_kind.default = nil
      end

      local opts = {
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,
        layout = {
          resize_to_content = true,
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },
        icons = icons,
        filter_kind = filter_kind,
      -- stylua: ignore
      guides = {
        mid_item   = "├╴",
        last_item  = "└╴",
        nested_top = "│ ",
        whitespace = "  ",
      },
      }
      return opts
    end,
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
  },
}
