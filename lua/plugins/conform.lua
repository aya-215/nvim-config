return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- ファイル保存前に遅延読み込み
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },

      -- Web
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },

      -- Markdown
      markdown = { "prettier" },

      -- Python (isort → black の順で実行)
      python = { "isort", "black" },

      -- Lua
      lua = { "stylua" },

      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },
    },

    -- デフォルトフォーマットオプション
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = "fallback", -- LSPフォーマッターをフォールバックとして使用
    },

    -- フォーマッターごとの詳細設定
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" }, -- インデント2、case文のインデント有効
      },
      prettier = {
        prepend_args = { "--tab-width", "2", "--single-quote", "false" },
      },
    },
  },
}
