return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" }, -- ファイル操作時に遅延読み込み
  opts = {
    -- Linterを実行するイベント
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },

    linters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },

      -- Python
      python = { "pylint" },

      -- Markdown
      markdown = { "markdownlint" },

      -- YAML
      yaml = { "yamllint" },

      -- JSON
      json = { "jsonlint" },

      -- Shell
      sh = { "shellcheck" },
      bash = { "shellcheck" },

      -- Docker
      dockerfile = { "hadolint" },
    },

    -- Linterの詳細設定
    linters = {
      -- shellcheckの設定例
      shellcheck = {
        args = {
          "--format=json",
          "-", -- stdin から読み取り
        },
      },
      -- markdownlintの設定例
      markdownlint = {
        args = {
          "--disable",
          "MD013", -- 行の長さ制限を無効化
          "--",
        },
      },
    },
  },
}
