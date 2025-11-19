# 💤 Neovim設定ファイル

LazyVimをベースにしたカスタムNeovim設定です。

## ✨ 特徴

- [LazyVim](https://github.com/LazyVim/LazyVim)ベース
- 40種類以上のカスタムプラグイン設定
- Windows環境最適化
- Claude Code統合
- 日本語IME対応 (win-ime-con)

## 📦 インストール方法

### Windows

```powershell
# 既存の設定をバックアップ
mv ~\AppData\Local\nvim ~\AppData\Local\nvim.bak

# このリポジトリをクローン
git clone https://github.com/aya-215/nvim-config.git ~\AppData\Local\nvim

# Neovimを起動（プラグインが自動インストールされます）
nvim
```

### Linux/macOS

```bash
# 既存の設定をバックアップ
mv ~/.config/nvim ~/.config/nvim.bak

# このリポジトリをクローン
git clone https://github.com/aya-215/nvim-config.git ~/.config/nvim

# Neovimを起動（プラグインが自動インストールされます）
nvim
```

## 🔄 プラグイン管理

プラグインは[lazy.nvim](https://github.com/folke/lazy.nvim)で管理されています。

- プラグインのバージョンは`lazy-lock.json`で固定
- 初回起動時に自動インストール
- プラグイン更新: `:Lazy update`
- ロックされたバージョンに同期: `:Lazy restore`

## 📂 ディレクトリ構成

```
nvim/
├── init.lua                 # エントリーポイント
├── lazy-lock.json          # プラグインバージョン固定ファイル
├── lua/
│   ├── config/            # 基本設定
│   │   ├── lazy.lua       # Lazy.nvimセットアップ
│   │   ├── options.lua    # Neovimオプション
│   │   └── keymaps.lua    # キーマップ
│   └── plugins/           # プラグイン設定（40以上のファイル）
├── tools/                 # ユーティリティスクリプト
│   ├── measure-startup.ps1   # 起動速度計測
│   └── show-history.ps1      # 履歴表示
└── .gitignore
```

## 🚀 使い方

インストール後、lazy.nvimが自動的に以下を実行します:
1. lazy.nvim本体のインストール
2. `lazy-lock.json`に基づいて全プラグインをダウンロード
3. 環境のセットアップ

初回起動は1〜2分かかります。お待ちください。

## 📝 注意事項

- プラグインは`~\AppData\Local\nvim-data`（Windows）または`~/.local/share/nvim`（Linux/macOS）にインストールされます
- このリポジトリは設定ファイルのみを管理し、プラグイン本体は含みません
- 複数のマシンで同じプラグインバージョンを使用するため、`lazy-lock.json`を含めています

## ⏱️ 起動速度の計測と履歴管理

このリポジトリには、Neovimの起動速度を自動計測・履歴管理する仕組みが組み込まれています。

### 自動計測

コミット時に自動的に起動速度が計測されます（Git post-commit hookで実行）。

計測結果は `startup-history.json` に保存されます（このファイルは `.gitignore` に含まれています）。

### 手動計測

いつでも手動で計測可能です：

```powershell
# 10回計測（デフォルト）
pwsh tools/measure-startup.ps1

# 計測回数を指定
pwsh tools/measure-startup.ps1 -Iterations 20
```

### 履歴の確認

```powershell
# 最新20件を表示（デフォルト）
pwsh tools/show-history.ps1

# 最新10件をグラフ付きで表示
pwsh tools/show-history.ps1 -Last 10 -Graph
```

**出力例:**
```
Neovim起動速度の履歴（最新10件）
================================================================================
[2025-11-19 14:47] 6b21f78   45.81ms fix: improve history array handling
[2025-11-19 14:49] 77dc4ce   57.36ms test: startup time measurement on commit
================================================================================

統計（最新10件）:
  平均: 51.59ms
  最速: 45.81ms (commit: 6b21f78)
  最遅: 57.36ms (commit: 77dc4ce)
```

### 必要な依存関係

- [vim-startuptime](https://github.com/rhysd/vim-startuptime): Rust製の起動速度計測ツール

```bash
cargo install vim-startuptime
```

## 📚 ドキュメント

- [LazyVim ドキュメント](https://lazyvim.github.io)
- [lazy.nvim ドキュメント](https://github.com/folke/lazy.nvim)
- [vim-startuptime](https://github.com/rhysd/vim-startuptime)
