require("ui.themer").highlight("neotree")
return {
  filesystem = {
    visible = true,
    hijack_netrw_behavior = "open_default",
    always_show = {
      ".github/",
      ".envrc",
      ".env",
      ".editorconfig"
    },
  },
  default_component_configs = {
    container = {
      right_padding = 1
    }
  },
  source_selector = {
    winbar = true,
    tabs_layout = "equal",
    show_separator_on_edge = false,
  },
}
