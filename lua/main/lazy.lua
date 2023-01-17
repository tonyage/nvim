local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lspkind = require("ui.icons")["lspkind"]
local constants = require("main.constants")
local key = require("main.mappings")
local lazy_defaults = {
  defaults = { lazy = true },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin", "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      }, }, },
  debug = false,
}

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  "L3MON4D3/LuaSnip",
  "williamboman/mason.nvim",
  "folke/zen-mode.nvim",
  "rcarriga/nvim-notify",
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      local neotree = require("neo-tree.command")
      local manager = require("neo-tree.sources.manager")
      local function close() neotree.execute({ action = "close" }) end
      local function show()
        neotree.execute({ action = "show" })
        manager.refresh("filesystem")
        manager.refresh("buffers")
        manager.refresh("git_status")
      end
      require("auto-session").setup({
        auto_session_suppress_dirs = { "~/", "~/Downloads", "~/git", "~/Code" },
        pre_save_cmds = { close() },
        post_save_cmds = { show() },
        post_open_cmds = { show() },
        post_restore_cmds = { show() },
        cwd_change_handling = {
          restore_upcoming_session = true,
          pre_cwd_changed_hook = close(),
          post_cwd_changed_hook = show()
        }
      })
      vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    keys = { "|" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      key.map("n", "|", ":Neotree reveal <CR>")
      require("neo-tree").setup(require("main.config.neotree"))
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navic",
    },
    tag = "v0.1.4",
    init = function() require("lsp") end,
  },

  { "tpope/vim-fugitive", event = { "VeryLazy" } },
  { "windwp/nvim-autopairs", event = { "InsertEnter" }, config = true },
  { "numToStr/Comment.nvim", lazy = false, config = true },

  {
    "j-hui/fidget.nvim",
    event = { "BufReadPre" },
    config = {
      text = {
        spinner = "dots_scrolling"
      }
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "VeryLazy" },
    init = function()
      vim.g.indent_blankline_char =  "▏"
    end,
    config = {
      use_treesitter_scope = true,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    cmd = "LspInstall",
    config = {
      ensure_installed = constants.servers,
      automatic_installation = true,
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufEnter" },
    config = require("main.config.gitsigns")
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("main.config.cmp")
    end,
  },

  {
    "SmiteshP/nvim-navic",
    config = function()
      vim.g.navic_silence = true
      require("nvim-navic").setup({
        icons = {
          File          = " ",
          Module        = lspkind["Module"],
          Namespace     = " ",
          Package       = " ",
          Class         = lspkind["Class"],
          Method        = " ",
          Property      = "練",
          Field         = " ",
          Constructor   = " ",
          Enum          = lspkind["Enum"],
          Interface     = lspkind["Interface"],
          Function      = " ",
          Variable      = " ",
          Constant      = " ",
          String        = " ",
          Number        = " ",
          Boolean       = "◩ ",
          Array         = " ",
          Object        = " ",
          Key           = " ",
          Null          = "ﳠ ",
          Struct        = lspkind["Struct"],
          Event         = " ",
          Operator      = " ",
          TypeParameter = " ",
        },
        highlight = true,
        separator = " " .. require("ui.icons").winbar["separator"]["light"]["right"] .. " ",
      })
    end,
  },

  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true
  },

  {
    "smjonas/inc-rename.nvim",
    keys = { "grn" },
    config = function()
      key.map("n", "grn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
      require("inc_rename").setup()
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("ui.themer").highlight("devicons")
      require("nvim-web-devicons").setup({ override = require("ui.icons").devicons })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    config = function()
      require("main.config.treesitter")
    end
  },

  { "nvim-treesitter/nvim-treesitter-context", event = { "BufReadPre" }, config = true },
}, lazy_defaults)

