-- system32のripgrepを優先 (起動時間最適化: vim.scheduleで遅延実行)
vim.schedule(function()
  vim.env.PATH = "C:\\Windows\\System32;" .. (vim.env.PATH or "")
end)

-- プロジェクト固有の.nvimrcを自動読み込み
vim.opt.exrc = true
vim.opt.secure = true

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")