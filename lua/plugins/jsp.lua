-- JSP (JavaServer Pages) サポート
-- シンタックスハイライトとファイルタイプ検出

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- JSPファイルタイプを登録
      vim.filetype.add({
        extension = {
          jsp = "jsp",
          jspf = "jsp",
          tag = "jsp",
        },
      })
    end,
  },
}
