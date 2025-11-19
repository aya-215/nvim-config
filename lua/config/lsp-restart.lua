-- LSP 定期再起動でメモリリークを防止
-- 30分ごとにすべてのLSPクライアントを再起動

local M = {}

-- LSP再起動関数
function M.restart_lsp()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    return
  end

  local restarted = {}
  for _, client in ipairs(clients) do
    table.insert(restarted, client.name)
  end

  if #restarted > 0 then
    vim.notify(
      "Auto-restarting LSP servers: " .. table.concat(restarted, ", "),
      vim.log.levels.INFO
    )
    vim.cmd("LspRestart")
  end
end

-- 初回起動時に30分後の再起動をスケジュール
vim.defer_fn(function()
  M.restart_lsp()

  -- その後は30分ごとに繰り返し実行
  vim.fn.timer_start(
    1800000, -- 30分 = 1800000ms
    function()
      M.restart_lsp()
    end,
    { ['repeat'] = -1 } -- 無限リピート
  )
end, 1800000) -- 初回は起動から30分後

-- 手動でLSP再起動するコマンドを追加
vim.api.nvim_create_user_command('LspRestartAll', function()
  M.restart_lsp()
end, { desc = 'Restart all LSP clients' })

return M
