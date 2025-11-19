# Neovim起動速度計測スクリプト
# vim-startuptimeを使用して計測
# 使い方: pwsh tools/measure-startup.ps1

param(
    [int]$Iterations = 100,  # 計測回数（デフォルト100回）
    [string]$OutputFile = "$PSScriptRoot\..\startup-history.json"
)

$ErrorActionPreference = "Stop"

# vim-startuptimeがインストールされているか確認
if (-not (Get-Command vim-startuptime -ErrorAction SilentlyContinue)) {
    Write-Error "vim-startuptimeがインストールされていません。`ncargo install vim-startuptime でインストールしてください。"
    exit 1
}

Write-Host "Neovim起動速度を計測中 (vim-startuptime, $Iterations 回)..." -ForegroundColor Cyan

# vim-startuptimeを実行
$output = vim-startuptime -vimpath nvim -count $Iterations 2>&1 | Out-String

# 出力から統計情報を抽出
if ($output -match 'Total Average:\s+(\d+\.\d+)\s+msec') {
    $avg = [double]$matches[1]
} else {
    Write-Error "計測結果の解析に失敗しました"
    exit 1
}

if ($output -match 'Total Max:\s+(\d+\.\d+)\s+msec') {
    $max = [double]$matches[1]
} else {
    $max = $avg
}

if ($output -match 'Total Min:\s+(\d+\.\d+)\s+msec') {
    $min = [double]$matches[1]
} else {
    $min = $avg
}

# 中央値は (min + max) / 2 で近似
$median = ($min + $max) / 2

Write-Host "`n結果:" -ForegroundColor Yellow
Write-Host "  平均: ${avg}ms"
Write-Host "  中央値: ${median}ms (近似)"
Write-Host "  最小: ${min}ms"
Write-Host "  最大: ${max}ms"

# Git情報取得
$gitHash = git rev-parse --short HEAD 2>$null
$gitMessage = git log -1 --pretty=%s 2>$null
$gitDate = git log -1 --pretty=%ci 2>$null

# 結果をJSON形式で保存
$result = @{
    timestamp = Get-Date -Format "o"
    commit_hash = $gitHash
    commit_message = $gitMessage
    commit_date = $gitDate
    avg_ms = [Math]::Round($avg, 2)
    median_ms = [Math]::Round($median, 2)
    min_ms = [Math]::Round($min, 2)
    max_ms = [Math]::Round($max, 2)
    iterations = $Iterations
}

# 既存履歴に追記
$history = @()
if (Test-Path $OutputFile) {
    $existing = Get-Content $OutputFile -Raw | ConvertFrom-Json
    # 単一オブジェクトの場合は配列に変換
    if ($existing -is [Array]) {
        $history = @($existing)
    } else {
        $history = @($existing)
    }
}
$history += $result

# 保存（配列として保存）
if ($history.Count -eq 1) {
    # 単一要素でも配列形式で保存
    "[$($history | ConvertTo-Json -Depth 10)]" | Set-Content $OutputFile -Encoding UTF8
} else {
    $history | ConvertTo-Json -Depth 10 | Set-Content $OutputFile -Encoding UTF8
}

Write-Host "`n履歴に保存しました: $OutputFile" -ForegroundColor Green

return $result
