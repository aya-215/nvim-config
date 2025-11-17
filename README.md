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

## 📚 ドキュメント

- [LazyVim ドキュメント](https://lazyvim.github.io)
- [lazy.nvim ドキュメント](https://github.com/folke/lazy.nvim)
