return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = "VeryLazy",
    opts = {
        -- Windows環境でのビルド設定
        prefer_git = false,

        -- 基本言語のパーサーを自動インストール
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
          "python",
          "javascript",
          "typescript",
          "html",
          "css",
          "json",
          "yaml",
          "bash",
          "regex",
          "java",
        },
        
        -- パーサーを自動でインストール（使用頻度低+LSP再起動あるため有効化）
        auto_install = true,
        
        -- シンタックスハイライト設定
        highlight = {
          enable = true,
          -- 大きなファイルでは無効化（パフォーマンス向上）
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          -- JSPファイルで追加のVimの正規表現ハイライト使用
          additional_vim_regex_highlighting = { "jsp" },
        },
        
        -- インデント設定
        indent = {
          enable = true,
          -- 問題のある言語では無効化
          disable = { "python" },
        },
        
        -- 段階的選択
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-backspace>",
          },
        },
        
        -- テキストオブジェクト（nvim-treesitter-textobjectsプラグイン使用）
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
    },
  },
}