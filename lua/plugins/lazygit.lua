return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
      { "<leader>gG", "<cmd>LazyGitCurrentFile<cr>", desc = "Open LazyGit (Current File)" },
      { "<leader>gc", "<cmd>LazyGitConfig<cr>", desc = "Open LazyGit Config" },
      { "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Filter" },
      { "<leader>gF", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit Filter (Current File)" },
    },
    config = function()
      -- LazyGitの設定
      vim.g.lazygit_floating_window_winblend = 0 -- 透明度 (0-100)
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- ウィンドウのスケール
      vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- ボーダー文字
      vim.g.lazygit_floating_window_use_plenary = 1 -- plenary.nvimを使用
      vim.g.lazygit_use_neovim_remote = 1 -- neovim-remoteを使用

      -- Windowsでの設定
      if vim.fn.has('win32') == 1 then
        -- WindowsでLazyGitがインストールされているか確認
        if vim.fn.executable('lazygit') == 0 then
          vim.notify(
            "LazyGit is not installed. Please install it first:\n" ..
            "scoop install lazygit\n" ..
            "or\n" ..
            "choco install lazygit",
            vim.log.levels.WARN
          )
        end
      end
    end,
  },
}