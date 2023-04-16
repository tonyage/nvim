return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return {
        defaults = {
          results_height = 15,
          winblend = 20,
          width = 0.8,
          results_title = false,
          prompt_title = false,
          prompt_prefix = "   ",
          sorting_strategy = "ascending",
          previewer = false,
          dynamic_preview_title = true,
          show_line = false,
          layout_config = {
            horizontal = {
              width = 0.5,
              prompt_position = "top",
            },
            preview_cutoff = 120,
          },
          borderchars = {
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
        },
      }
    end,
  },
}
