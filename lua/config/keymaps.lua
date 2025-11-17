-- キーマップはVeryLazyイベントで自動的に読み込まれます
-- デフォルトのキーマップ: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- 追加のキーマップをここに記述します


-- ファイルエクスプローラー
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "ファイルエクスプローラーの表示切替" })

-- ===================================================
-- Alt+hjkl: ウィンドウ移動（全モードで動作）
-- Neovim公式ドキュメント推奨の方法
-- ===================================================

-- Normalモード（グローバル）
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "左のウィンドウへ移動" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "下のウィンドウへ移動" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "上のウィンドウへ移動" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "右のウィンドウへ移動" })

-- Insertモード（グローバル）
vim.keymap.set("i", "<A-h>", "<C-\\><C-n><C-w>h", { desc = "左のウィンドウへ移動" })
vim.keymap.set("i", "<A-j>", "<C-\\><C-n><C-w>j", { desc = "下のウィンドウへ移動" })
vim.keymap.set("i", "<A-k>", "<C-\\><C-n><C-w>k", { desc = "上のウィンドウへ移動" })
vim.keymap.set("i", "<A-l>", "<C-\\><C-n><C-w>l", { desc = "右のウィンドウへ移動" })

-- ターミナルモード拡張
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    -- バッファ名が正しく設定されるまで待機
    vim.defer_fn(function()
      local bufname = vim.api.nvim_buf_get_name(0)
      local is_claude = string.find(bufname:lower(), "claude") ~= nil or
                        string.find(bufname:lower(), "snacks") ~= nil
      local is_lazygit = string.find(bufname:lower(), "lazygit") ~= nil

      -- ESCキーの動作: Claude Code/LazyGitではESCをそのまま渡す、その他のターミナルではNormalモードへ
      if is_claude or is_lazygit then
        vim.keymap.set("t", "<Esc>", "<Esc>", {
          buffer = 0,
          desc = "ESCをそのまま渡す（Claude Code/LazyGit用）"
        })
		-- Ctrl+eでNormalモードへ
		vim.keymap.set("t", "<C-e>", "<C-\\><C-n>", {
			buffer = 0,
			desc = "Normalモードに移行"
		})

      else
        vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {
          buffer = 0,
          desc = "ターミナルモードを終了"
        })
      end
    end, 50)

    -- ターミナルモードでのウィンドウ移動
    vim.keymap.set("t", "<A-h>", "<C-\\><C-n><C-w>h", { buffer = 0, desc = "左のウィンドウへ移動" })
    vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>j", { buffer = 0, desc = "下のウィンドウへ移動" })
    vim.keymap.set("t", "<A-k>", "<C-\\><C-n><C-w>k", { buffer = 0, desc = "上のウィンドウへ移動" })
    vim.keymap.set("t", "<A-l>", "<C-\\><C-n><C-w>l", { buffer = 0, desc = "右のウィンドウへ移動" })

    -- 追加のウィンドウ操作（ターミナルモードのみ）
    vim.keymap.set("t", "<A-w>", "<C-\\><C-n><C-w>w", { buffer = 0, desc = "ウィンドウを順番に切り替え" })
    vim.keymap.set("t", "<A-v>", "<C-\\><C-n><C-w>v", { buffer = 0, desc = "縦に分割" })
    vim.keymap.set("t", "<A-s>", "<C-\\><C-n><C-w>s", { buffer = 0, desc = "横に分割" })
    vim.keymap.set("t", "<A-q>", "<C-\\><C-n><C-w>q", { buffer = 0, desc = "ウィンドウを閉じる" })

    -- Ctrl+Jでターミナルに改行を送信
    vim.keymap.set("t", "<C-j>", function()
      local lf_key = vim.api.nvim_replace_termcodes("<C-v><C-j>", true, false, true)
      vim.api.nvim_feedkeys(lf_key, "n", false)
    end, {
      buffer = 0,
      desc = "ターミナルに改行を送信"
    })
  end,
  desc = "ターミナルモードのキーバインド設定"
})
