# Neovim起動速度の履歴を表示
# 使い方: pwsh tools/show-history.ps1 [-Last 10] [-Graph]

param(
    [int]$Last = 20,  # 最新N件を表示
    [switch]$Graph    # グラフ表示
)

# エンコーディング設定（日本語文字化け対策）
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$historyFile = "$PSScriptRoot\..\startup-history.json"

if (-not (Test-Path $historyFile)) {
    Write-Host "履歴ファイルが見つかりません: $historyFile" -ForegroundColor Red
    exit 1
}

$history = Get-Content $historyFile -Raw -Encoding UTF8 | ConvertFrom-Json

if ($history.Count -eq 0) {
    Write-Host "履歴が空です" -ForegroundColor Yellow
    exit 0
}

# 最新N件を取得
$recent = $history | Select-Object -Last $Last

Write-Host "`nNeovim起動速度の履歴（最新${Last}件）" -ForegroundColor Cyan
Write-Host ("=" * 80)

foreach ($entry in $recent) {
    $date = [DateTime]::Parse($entry.timestamp).ToString("yyyy-MM-dd HH:mm")
    $hash = $entry.commit_hash
    $msg = $entry.commit_message
    if ($msg.Length -gt 50) {
        $msg = $msg.Substring(0, 47) + "..."
    }

    $color = "White"
    if ($entry.avg_ms -lt 100) {
        $color = "Green"
    } elseif ($entry.avg_ms -lt 200) {
        $color = "Yellow"
    } else {
        $color = "Red"
    }

    Write-Host ("[{0}] {1}" -f $date, $hash) -NoNewline -ForegroundColor Gray
    Write-Host (" {0,7:F2}ms " -f $entry.avg_ms) -NoNewline -ForegroundColor $color
    Write-Host $msg -ForegroundColor White
}

Write-Host ("=" * 80)

# 統計情報
$avgAll = ($recent.avg_ms | Measure-Object -Average).Average
$minEntry = $recent | Sort-Object avg_ms | Select-Object -First 1
$maxEntry = $recent | Sort-Object avg_ms | Select-Object -Last 1

Write-Host "`n統計（最新${Last}件）:" -ForegroundColor Yellow
Write-Host ("  平均: {0:F2}ms" -f $avgAll)
Write-Host ("  最速: {0:F2}ms (commit: {1})" -f $minEntry.avg_ms, $minEntry.commit_hash)
Write-Host ("  最遅: {0:F2}ms (commit: {1})" -f $maxEntry.avg_ms, $maxEntry.commit_hash)

# グラフ表示
if ($Graph) {
    Write-Host "`nグラフ（起動速度の推移）:" -ForegroundColor Yellow

    $maxMs = ($recent.avg_ms | Measure-Object -Maximum).Maximum
    $scale = 60 / $maxMs  # 最大60文字幅

    foreach ($entry in $recent) {
        $barLength = [Math]::Floor($entry.avg_ms * $scale)
        $bar = "█" * $barLength

        $color = "White"
        if ($entry.avg_ms -lt 100) {
            $color = "Green"
        } elseif ($entry.avg_ms -lt 200) {
            $color = "Yellow"
        } else {
            $color = "Red"
        }

        Write-Host ("{0,7:F2}ms " -f $entry.avg_ms) -NoNewline -ForegroundColor Gray
        Write-Host $bar -ForegroundColor $color
    }
}

Write-Host ""
