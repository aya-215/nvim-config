return {
  {
    "levouh/tint.nvim",
	lazy = true,
	event ="WinNew",
    config = function()
      require("tint").setup({
        tint = -45,
        saturation = 0.6,
        tint_background_colors = true,
        highlight_ignore_patterns = { "WinSeparator", "Status.*" },
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")

          return filetype == "dashboard"
            or filetype == "help"
            or filetype == "qf"
        end,
      })
    end,
  },
}
