-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 基本表示設定
vim.opt.number = true
vim.opt.relativenumber = true

-- 検索設定
vim.opt.ignorecase = true   -- 検索時に大文字・小文字を区別しない
vim.opt.smartcase = true    -- 検索文字列に大文字が含まれている場合は区別する
vim.opt.hlsearch = true     -- 検索結果をハイライト表示
vim.opt.wrapscan = true     -- 検索時、ファイルの末尾まで行ったら先頭に戻る

-- LSP パフォーマンス改善設定
vim.opt.updatetime = 300  -- LSP応答性改善
vim.opt.maxmempattern = 2000  -- メモリ使用量制限

-- タブ設定：タブ文字4個分の幅
vim.opt.tabstop = 4        -- タブ文字の幅
vim.opt.shiftwidth = 4     -- インデント幅
vim.opt.expandtab = false  -- タブ文字を使用
vim.opt.softtabstop = 0    -- タブ文字を使用

-- 自動フォーマッター無効化
vim.g.autoformat = false

-- ターミナル設定：PowerShell Coreをデフォルトシェルに設定
vim.opt.shell = "pwsh"
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""
