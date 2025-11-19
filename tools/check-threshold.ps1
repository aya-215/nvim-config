# Neovim起動速度の閾値チェック
# 使い方: pwsh tools/check-threshold.ps1 [-Threshold 100] [-Baseline 10]

param(
    [double]$Threshold = 100,     # 警告を出す閾値（ミリ秒）
    [double]$Baseline = 10,       # ベースライン計算に使う直近N回
    [string]$HistoryFile = "$PSScriptRoot\..\startup-history.json"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $HistoryFile)) {
    Write-Host "履歴ファイルが見つかりません。初回計測です。" -ForegroundColor Yellow
    exit 0
}

# 履歴を読み込み
$history = Get-Content $HistoryFile -Raw | ConvertFrom-Json
if ($history -is [Array]) {
    $allHistory = @($history)
} else {
    $allHistory = @($history)
}

if ($allHistory.Count -lt 2) {
    Write-Host "履歴が不足しています。比較用のデータがありません。" -ForegroundColor Yellow
    exit 0
}

# 最新の計測結果
$latest = $allHistory[-1]
$latestAvg = $latest.avg_ms

# ベースライン（直近N回の平均、最新を除く）
$baselineCount = [Math]::Min($Baseline, $allHistory.Count - 1)
$baselineData = $allHistory[-($baselineCount + 1)..-2]  # 最新を除く直近N回
$baselineAvg = ($baselineData.avg_ms | Measure-Object -Average).Average

# 増加率を計算
$increase = $latestAvg - $baselineAvg
$increasePercent = ($increase / $baselineAvg) * 100

Write-Host "`n起動速度チェック結果:" -ForegroundColor Cyan
Write-Host "=" * 50
Write-Host ("最新:       {0,7:F2}ms" -f $latestAvg)
Write-Host ("ベースライン: {0,7:F2}ms（直近{1}回の平均）" -f $baselineAvg, $baselineCount)
Write-Host ("差分:       {0,7:F2}ms ({1:+0.0;-0.0}%)" -f $increase, $increasePercent)
Write-Host ("閾値:       {0,7:F2}ms" -f $Threshold)
Write-Host "=" * 50

# 閾値チェック
if ($latestAvg -gt $Threshold) {
    Write-Host "`n⚠️  警告: 起動速度が閾値を超えています！" -ForegroundColor Red
    Write-Host "   現在: ${latestAvg}ms > 閾値: ${Threshold}ms" -ForegroundColor Red

    Write-Host "`n原因調査のヒント:" -ForegroundColor Yellow
    Write-Host "  1. vim-startuptime -vimpath nvim で詳細を確認"
    Write-Host "  2. 最近追加したプラグインを確認"
    Write-Host "  3. init.luaやconfig/*.luaの変更を確認"
    Write-Host "  4. pwsh tools/show-history.ps1 -Last 20 -Graph で推移を確認"

    exit 1
}

# ベースラインとの比較
if ($increase -gt 10 -and $increasePercent -gt 20) {
    Write-Host "`n⚠️  注意: ベースラインから大幅に遅くなっています！" -ForegroundColor Yellow
    Write-Host "   増加: ${increase}ms (+${increasePercent}%)" -ForegroundColor Yellow

    # 最近のコミットを表示
    if ($latest.commit_hash -and $latest.commit_message) {
        Write-Host "`n最新コミット:" -ForegroundColor Cyan
        Write-Host "  [$($latest.commit_hash)] $($latest.commit_message)"
    }

    Write-Host "`n原因調査のヒント:" -ForegroundColor Yellow
    Write-Host "  1. git diff HEAD~1 でこのコミットの変更を確認"
    Write-Host "  2. vim-startuptime -vimpath nvim で詳細を確認"
    Write-Host "  3. 最近のプラグイン変更を確認: git log --oneline -10"

    exit 0
}

Write-Host "`n✓ 起動速度は正常範囲内です。" -ForegroundColor Green

exit 0
