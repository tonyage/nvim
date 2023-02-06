require("ui.themer").highlight("telescope")
local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local key = require("main.mappings")
local windows = require("ui.windows")
local extensions_list = { "fzf", "themes", "terms" }

local config = {
  defaults = {
    prompt_prefix = "  ",
    results_title = false,
    dynamic_preview_title = true,
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        width = 0.5,
        preview_width = 0.5,
        prompt_position = "top"
      },
      preview_cutoff = 120,
    },
    border = {},
    mappings = {
      n = {
        ["<Esc>"] = actions.close,
      },
    },
    file_ignore_patterns = { "^node_modules/", "^__pycache__/" },
    path_display = {
      "smart",
      shorten = { len = 1, exclude = { 1, -1 }},
    },
  },
  pickers = {
    find_files = {
      -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
    },
  },
}

telescope.setup(config)
pcall(function()
  for _, extension in pairs(extensions_list) do
    telescope.load_extension(extension)
  end
end)

key.map("n", "<leader>sf", function()
  builtin.find_files({ all = true })
end)
key.map("n", "<leader>sgf", builtin.git_files)
key.map("n", "<leader>scm", builtin.git_commits)
key.map("n", "<leader>gs", builtin.git_status)
key.map("n", "<leader>sof", builtin.oldfiles)
key.map("n", "<leader>rg", function()
  builtin.grep_string({ search = vim.fn.input(" ")})
end)
