return {
  {
    "jvgrootveld/telescope-zoxide",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Z (Zoxide Directory Jump)" },
    },
    config = function()
      require("telescope").load_extension("zoxide")

      -- Zoxideの設定
      require("telescope._extensions.zoxide.config").setup({
        prompt_title = "[ Zoxide - Directory Jump ]",
        mappings = {
          default = {
            action = function(selection)
              vim.cmd.cd(selection.path)
            end,
            after_action = function(selection)
              print("Changed directory to: " .. selection.path)
            end
          },
        },
      })

      -- :cdコマンドでzoxideに自動追加する
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          local cwd = vim.fn.getcwd()
          vim.fn.system("zoxide add " .. vim.fn.shellescape(cwd))
        end,
      })
    end,
  },
}
