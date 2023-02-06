local M = {}

M.not_focusable = {
  border = "rounded",
  focusable = false,
  relative = "win",
  anchor = "SW",
  row = 0,
  col = 0,
}

M.hover = {
  border = "rounded",
  focusable = false,
  relative = "cursor",
  anchor = "SW",
  row = 0,
  col = 0,
}

M.hl_rounded_borders = function(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

M.hl_square_borders = function(hl_name)
  return {
    { "⎡", hl_name },
    { "─", hl_name },
    { "⎤", hl_name },
    { "│", hl_name },
    { "⎦", hl_name },
    { "─", hl_name },
    { "⎣", hl_name },
    { "│", hl_name },
  }
end

M.rounded_borders = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

M.square_borders = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }

return M

