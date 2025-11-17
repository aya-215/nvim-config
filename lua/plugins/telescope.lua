return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          hidden = true,
          respect_gitignore = false,
          file_ignore_patterns = {
            "node_modules/.*",
            "build/.*",
            "%.git/.*",
            "%.env$",
            "%.env%..*"
          }
        }
      })
      -- キーマップを強制的に設定
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
    end,
  },
}
