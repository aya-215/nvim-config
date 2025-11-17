return {
  "vim-scripts/vim-auto-save",
  event = { "InsertLeave", "TextChanged" },
  config = function()
    -- 自動保存を有効化（デフォルトは無効）
    vim.g.auto_save = 1

    -- インサートモード中の自動保存を無効化（編集中に保存されない）
    vim.g.auto_save_in_insert_mode = 0

    -- サイレントモード（保存通知を表示しない）
    vim.g.auto_save_silent = 1

    -- updatetime（200ms）の変更を防ぐ（他のプラグインとの競合防止）
    vim.g.auto_save_no_updatetime = 1

    -- 保存後のフック（必要に応じて設定）
    -- vim.g.auto_save_postsave_hook = 'TagsGenerate'
  end,
  keys = {
    { "<leader>ts", "<cmd>AutoSaveToggle<cr>", desc = "Toggle Auto Save" },
  },
}
