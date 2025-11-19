return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "flake8",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        border = "rounded",
        width = 0.8,
        height = 0.8,
        keymaps = {
          toggle_package_expand = "<CR>",
          install_package = "i",
          update_package = "u",
          check_package_version = "c",
          update_all_packages = "U",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
          toggle_package_install_log = "<CR>",
          toggle_help = "g?",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 2, -- メモリ最適化: 4→2に削減
      registries = {
        "github:mason-org/mason-registry",
      },
      providers = {
        "mason.providers.registry-api",
        "mason.providers.client",
      },
      github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
      },
      pip = {
        upgrade_pip = false,
        install_args = {},
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      -- 起動時間最適化: refresh を遅延実行
      vim.defer_fn(function()
        mr.refresh(function()
          for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end)
      end, 3000) -- 3秒後に実行
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "ts_ls",
        "eslint",
        "pyright",
        -- "rust_analyzer", -- メモリ最適化: Rust未使用のため削除
        "bashls",
        -- "dockerls", -- メモリ最適化: Docker編集頻度低いため削除
        -- "docker_compose_language_service", -- メモリ最適化: Docker編集頻度低いため削除
        "marksman",
        "jdtls", -- Java使用中のため保持
      },
      automatic_installation = false,
    },
    config = function(_, opts)
      local mlsp = require("mason-lspconfig")
      mlsp.setup(opts)
      
      if vim.fn.has("nvim-0.11") == 1 then
        mlsp.setup({
          automatic_enable = true,
        })
      else
        mlsp.setup_handlers({
          function(server_name)
            local has_lspconfig, lspconfig = pcall(require, "lspconfig")
            if has_lspconfig then
              lspconfig[server_name].setup({})
            end
          end,
        })
      end
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    -- event = "VeryLazy", -- 起動時間最適化: eventを削除してcmdのみで遅延読み込み
    opts = {
      ensure_installed = {
        "prettier",
        "prettierd",
        "stylua",
        "isort",
        "black",
        "pylint",
        "eslint_d",
        "shellcheck",
        "shfmt",
        "hadolint",
        "markdownlint",
        "yamllint",
        "jsonlint",
        "fixjson",
      },
      auto_update = false,
      run_on_start = false,
      start_delay = 5000,
      debounce_hours = 5,
    },
  },
}
