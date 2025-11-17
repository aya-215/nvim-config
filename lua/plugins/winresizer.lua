return {
  {
    "simeji/winresizer",
    event = "VeryLazy",
    keys = {
      { "<C-e>", "<cmd>WinResizerStartResize<cr>", desc = "Start window resize mode" },
    },
    config = function()
      -- ウィンドウリサイズの増減値
      vim.g.winresizer_vert_resize = 2
      vim.g.winresizer_horiz_resize = 2

      -- キーコード設定（オプション）
      -- vim.g.winresizer_start_key = '<C-e>'  -- デフォルトは<C-e>
      -- vim.g.winresizer_keycode_cancel = 113  -- 'q'キーのキーコード

      -- 矢印キーを使用したい場合（コメントアウトして有効化）
      -- vim.g.winresizer_keycode_up = "\<UP>"
      -- vim.g.winresizer_keycode_down = "\<DOWN>"
      -- vim.g.winresizer_keycode_left = "\<LEFT>"
      -- vim.g.winresizer_keycode_right = "\<RIGHT>"

      -- モード切り替えキー（デフォルト）
      -- 'e': モード切替
      -- 'r': リサイズモード
      -- 'm': 移動モード
      -- 'f': フォーカスモード
      -- 'Enter': 確定
      -- 'q': キャンセル
    end,
  },
}