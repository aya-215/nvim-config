return {
  "pepo-le/win-ime-con.nvim",
  -- Windows環境でのみ有効化
  enabled = function()
    return vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
  end,
  -- モード切り替え時に遅延読み込み
  event = { "InsertEnter", "InsertLeave" },
  priority = 100,
  config = function()
    -- IME制御の動作設定
    -- 1 (デフォルト): Insert モード時に前の IME 状態を復元
    -- 0: Insert モード時に常に IME を OFF にする
    vim.g.win_ime_con_mode = 1
  end,
}