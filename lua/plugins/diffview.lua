return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>gm", "<cmd>DiffviewOpen main<cr>", desc = "Diff with main" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (Current)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (All)" },
    },
    config = function()
      require("diffview").setup({
        diff_binaries = false, -- バイナリファイルの差分を表示しない
        enhanced_diff_hl = true, -- 拡張された差分ハイライト
        use_icons = true, -- アイコンを使用
        show_help_hints = true, -- ヘルプヒントを表示
        watch_index = true, -- git indexの変更を監視

        -- ファイルパネルの設定
        file_panel = {
          listing_style = "tree", -- "list" or "tree"
          tree_options = {
            flatten_dirs = true, -- 単一ファイルのディレクトリを平坦化
            folder_statuses = "only_folded", -- フォルダのステータス表示
          },
          win_config = {
            position = "left",
            width = 35,
          },
        },

        -- ファイル履歴パネルの設定
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
          },
        },

        -- キーマッピング
        keymaps = {
          disable_defaults = false, -- デフォルトキーマップを無効化しない
          view = {
            { "n", "<tab>", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle file panel" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
            { "n", "<leader>ci", function() require('diffview.actions').open_commit_log() end, { desc = "Show commit info" } },
          },
          file_panel = {
            { "n", "j", "<cmd>lua require('diffview.actions').next_entry()<cr>", { desc = "Next entry" } },
            { "n", "k", "<cmd>lua require('diffview.actions').prev_entry()<cr>", { desc = "Previous entry" } },
            { "n", "<cr>", "<cmd>lua require('diffview.actions').select_entry()<cr>", { desc = "Select entry" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
            { "n", "<tab>", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle file panel" } },
            { "n", "<leader>ci", function() require('diffview.actions').open_commit_log() end, { desc = "Show commit info" } },
          },
          file_history_panel = {
            { "n", "j", "<cmd>lua require('diffview.actions').next_entry()<cr>", { desc = "Next entry" } },
            { "n", "k", "<cmd>lua require('diffview.actions').prev_entry()<cr>", { desc = "Previous entry" } },
            { "n", "<cr>", "<cmd>lua require('diffview.actions').select_entry()<cr>", { desc = "Select entry" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
          },
        },
      })
    end,
  },
}
