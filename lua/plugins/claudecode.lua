return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      -- Git リポジトリルートを作業ディレクトリに設定
      git_repo_cwd = false,

      -- 送信後にClaudeターミナルにフォーカス
      focus_after_send = true,

     -- ターミナル設定（右分割）
      terminal = {
        split_side = "right",
        split_width_percentage = 0.35,
        provider = "snacks",
        auto_close = true,
      },

      -- Diff設定（新しいタブで表示）
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = true, -- 現在のタブで開く
        keep_terminal_focus = false,  -- Diff受け入れ後にClaudeにフォーカス
      },
    },
    keys = {
      -- AI/Claude Code グループ
      { "<leader>a", nil, desc = "🤖 AI/Claude Code" },

      -- 基本操作
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },

      -- セッション管理
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },

      -- モデル選択
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },

      -- コンテキスト追加
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },

      -- Diff管理
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
