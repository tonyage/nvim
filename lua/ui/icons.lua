local M = {}

M.lspkind = {
  Namespace = "",
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "ﰠ ",
  Variable = " ",
  Class = "ﴯ ",
  Interface = " ",
  Module = " ",
  Property = "ﰠ ",
  Unit = "塞 ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = "פּ ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Table = "",
  Object = " ",
  Tag = "",
  Array = "[]",
  Boolean = " ",
  Number = " ",
  Null = "ﳠ",
  String = " ",
  Calendar = "",
  Watch = " ",
  Package = "",
  Copilot = " ",
}

M.lsp = {
  error = {
    name = "Error",
    icon = "",
  },

  info = {
    name = "Info",
    icon = "",
  },

  hint = {
    name = "Hint",
    icon = "", },

  warn = {
    name = "Warn",
    icon = ""
  },
}

M.statusline_separators = {
  default = {
    left = "",
    right = " ",
  },

  round = {
    left = "",
    right = "",
  },

  block = {
    left = "█",
    right = "█",
  },

  arrow = {
    left = "",
    right = "",
  },
}

M.winbar = {
  separator = {
    light = {
      left = "⟨",
      right = "⟩"
    },
    medium = {
      left = "❬",
      right = "❭",
    },
  },
}

M.devicons = {
  default_icon = {
    icon = "",
    name = "Default",
  },

  c = {
    icon = "",
    name = "c",
  },

  css = {
    icon = "",
    name = "css",
  },

  deb = {
    icon = "",
    name = "deb",
  },

  Dockerfile = {
    icon = "",
    name = "Dockerfile",
  },

  html = {
    icon = "",
    name = "html",
  },

  jpeg = {
    icon = "",
    name = "jpeg",
  },

  jpg = {
    icon = "",
    name = "jpg",
  },

  js = {
    icon = "",
    name = "js",
  },

  kt = {
    icon = "󱈙",
    name = "kt",
  },

  lock = {
    icon = "",
    name = "lock",
  },

  lua = {
    icon = "",
    name = "lua",
  },

  mp3 = {
    icon = "",
    name = "mp3",
  },

  mp4 = {
    icon = "",
    name = "mp4",
  },

  out = {
    icon = "",
    name = "out",
  },

  png = {
    icon = "",
    name = "png",
  },

  py = {
    icon = "",
    name = "py",
  },

  ["robots.txt"] = {
    icon = "ﮧ",
    name = "robots",
  },

  toml = {
    icon = "",
    name = "toml",
  },

  ts = {
    icon = "ﯤ",
    name = "ts",
  },

  ttf = {
    icon = "",
    name = "TrueTypeFont",
  },

  rb = {
    icon = "",
    name = "rb",
  },

  rpm = {
    icon = "",
    name = "rpm",
  },

  vue = {
    icon = "﵂",
    name = "vue",
  },

  woff = {
    icon = "",
    name = "WebOpenFontFormat",
  },

  woff2 = {
    icon = "",
    name = "WebOpenFontFormat2",
  },

  xz = {
    icon = "",
    name = "xz",
  },

  zip = {
    icon = "",
    name = "zip",
  },
}

return M

