return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    -- セッションを保存するディレクトリ
    dir = vim.fn.stdpath("state") .. "/sessions/",
    -- 自動的に保存するオプション
    options = { "buffers", "curdir", "tabpages", "winsize" },
  },
  keys = {
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore Session",
    },
    {
      "<leader>qS",
      function()
        require("persistence").select()
      end,
      desc = "Select Session",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore Last Session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't Save Current Session",
    },
  },
}
