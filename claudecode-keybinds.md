# claudecode.nvim キーバインド 完全ガイド

## 🤖 基本操作

| キー | 機能 | 詳細説明 |
|------|------|----------|
| `<leader>ac` | **Claude起動/終了** | Claude Codeターミナルの表示・非表示を切り替え |
| `<leader>af` | **Claudeにフォーカス** | スマートフォーカス：非表示なら表示、表示済みならフォーカス移動 |

## 🔄 セッション管理

| キー | 機能 | 詳細説明 |
|------|------|----------|
| `<leader>ar` | **セッション再開** | 前回の対話セッションを復元して継続 |
| `<leader>aC` | **対話継続** | 現在のセッションで新しい対話を開始 |

## 🎯 モデル選択

| キー | 機能 | 詳細説明 |
|------|------|----------|
| `<leader>am` | **モデル選択** | Claude Opus、Sonnet、Haikuから使用するモデルを選択 |

## 📝 コンテキスト追加

| キー | 機能 | 詳細説明 |
|------|------|----------|
| `<leader>ab` | **現在のファイル追加** | 編集中のバッファをClaudeのコンテキストに追加 |
| `<leader>as` | **選択範囲送信** | ビジュアルモードで選択したテキストをClaudeに送信 |
| `<leader>as` | **ファイル追加** | ファイルマネージャー（nvim-tree/netrw）でファイルをコンテキストに追加 |

## ✅ Diff操作

| キー | 機能 | 詳細説明 |
|------|------|----------|
| `<leader>aa` | **変更を承認** | Claudeが提案した変更を受け入れてファイルに適用 |
| `<leader>ad` | **変更を拒否** | Claudeが提案した変更を却下してdiffを閉じる |

## 🖱️ ターミナル内ショートカット

| キー | 機能 | 詳細説明 |
|------|------|----------|
| `Shift+Enter` | **改行入力** | ターミナル内でメッセージを送信せずに改行 |
| `Ctrl+\` | **ターミナル脱出** | ターミナルモードから通常モードに戻る |

## 📁 ファイルマネージャー統合

| 対象 | キー | 機能 |
|------|------|------|
| **nvim-tree** | `<leader>as` | カーソル下のファイルをClaudeに追加 |
| **netrw** | `<leader>as` | カーソル下のファイルをClaudeに追加 |

## 💡 使用例シナリオ

### 基本的なワークフロー
1. **`<leader>ac`** → Claudeを起動
2. **`<leader>ab`** → 現在のファイルを追加
3. **ビジュアル選択 + `<leader>as`** → 特定部分を送信
4. **`<leader>aa`** → 提案された変更を承認
5. **`<leader>af`** → Claudeターミナルに戻る

### モデル切り替えワークフロー
1. **`<leader>am`** → モデル選択画面を開く
2. **用途に応じてモデル選択**:
   - **Opus**: 複雑な推論・創作
   - **Sonnet**: バランス型・一般的なコーディング
   - **Haiku**: 高速・簡単なタスク

### ファイル管理ワークフロー
1. **`:e`** でnetrwを開く、または **`<leader>e`** でnvim-treeを開く
2. **ファイルを選択**
3. **`<leader>as`** → そのファイルをClaudeのコンテキストに追加

## 🎯 覚え方のコツ

- **`<leader>a`**: **A**I/Claude関連の統一プレフィックス
- **`c`**: **C**laude toggle
- **`f`**: **F**ocus
- **`r`**: **R**esume
- **`C`**: **C**ontinue（大文字で区別）
- **`m`**: **M**odel select
- **`b`**: **B**uffer add
- **`s`**: **S**end
- **`a`**: **A**ccept
- **`d`**: **D**eny

## ⚙️ 設定詳細

### 現在の設定
```lua
-- ~/.config/nvim/init.lua
{
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    git_repo_cwd = true,           -- Gitリポジトリルートで起動
    focus_after_send = true,       -- 送信後Claudeにフォーカス
    terminal = {
      split_side = "right",        -- 右分割で表示
      split_width_percentage = 0.35, -- 35%の幅
    },
    diff_opts = {
      open_in_current_tab = false, -- 新しいタブでdiff表示
    },
  },
}
```

### 特徴
- **右分割**: 35%幅でClaude表示
- **Git対応**: プロジェクトルートで自動起動
- **新タブDiff**: 変更提案を独立タブで表示
- **netrw統合**: 標準ファイラーサポート

## 📖 関連ドキュメント

- [claudecode.nvim GitHub](https://github.com/coder/claudecode.nvim)
- [Claude Code公式ドキュメント](https://docs.anthropic.com/en/docs/claude-code)
- [lazy.nvim](https://github.com/folke/lazy.nvim)

---

**更新日**: 2024年9月30日
**バージョン**: claudecode.nvim v0.3.0