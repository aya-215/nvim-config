local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- LazyVimとそのプラグインを追加
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- カスタムプラグインをインポート/上書き
    { import = "plugins" },
  },
  defaults = {
    -- デフォルトではLazyVimプラグインのみ遅延読み込み。カスタムプラグインは起動時に読み込まれる
    -- すべてのカスタムプラグインをデフォルトで遅延読み込みにする場合は true に設定
    lazy = true, -- 起動時間最適化: すべてのプラグインをデフォルトで遅延読み込み
    -- バージョン管理対応プラグインの多くは古いリリースを使っており、Neovimが壊れる可能性があるため
    -- 現時点では version=false のままにしておくことを推奨
    version = false, -- 常に最新のgit commitを使用
    -- version = "*", -- semverをサポートするプラグインの最新安定版をインストール
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- プラグイン更新を定期的にチェック
    notify = false, -- 更新時に通知しない
  }, -- プラグイン更新を自動チェック
  performance = {
    rtp = {
      -- 一部のrtpプラグインを無効化
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
