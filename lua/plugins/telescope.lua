return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return {
        defaults = {
          winblend = 20,
          results_title = false,
          prompt_title = false,
          preview_title = false,
          picker_title = false,
          prompt_prefix = "   ",
          sorting_strategy = "ascending",
          previewer = false,
          dynamic_preview_title = true,
          show_line = false,
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              width = 0.5,
              height = 0.5,
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
