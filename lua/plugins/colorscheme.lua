return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "catppuccin",
    lazy = false, -- カラースキームは起動時に必要
    priority = 1000, -- 他のプラグインより先に読み込む
    opts = {
      transparent_background = true,
    },
  },
}