return {
  {
    "Nvchad/nvim-colorizer.lua",
    opts = { filetypes = { "lua", "css", "nix", "javascript" } },
  },
  {
    "bennypowers/splitjoin.nvim",
    lazy = true,
    keys = {
      {
        "gj",
        function()
          require("splitjoin").join()
        end,
        desc = "Join the object under the cursor",
      },
      {
        "g,",
        function()
          require("splitjoin").split()
        end,
        desc = "Split the object under the cursor",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    opts = {
      show_end_of_line = true,
      show_first_indent_level = false,
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "as",
        delete = "ds",
        replace = "cs",
        highlight = "hs",
      },
    },
  },
}
