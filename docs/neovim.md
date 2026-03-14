# Neovim (LazyVim) セットアップガイド

## 前提条件

| ツール | バージョン | インストール方法 |
|---|---|---|
| Neovim | >= 0.10 | mise (`mise install`) |
| Nerd Font | FiraCode Nerd Font | `scripts/install_apt.sh` |
| ripgrep | latest | mise (cargo:ripgrep) |
| fzf | latest | mise |
| yazi | latest | mise |
| lazygit | latest | mise |

## インストール

### 全環境一括セットアップ

```bash
./install.sh
```

Nerd Font、シンボリックリンク作成、mise経由のツールインストールを含む。

### 個別セットアップ

```bash
mise install            # neovim, lazygit等をインストール
./scripts/link.sh       # シンボリックリンクを作成
nvim                    # 初回起動でlazy.nvimが自動ブートストラップ
```

## 旧環境からの移行

vim-plug + init.vim環境からの移行:

```bash
./scripts/migration/migrate_to_lazyvim.sh
```

このスクリプトは以下を実行する:
- 旧init.vimシンボリックリンクの削除
- vim-plugの残骸を削除
- 旧AppImage Neovimの削除（mise管理に移行）
- 旧neovim python providerの削除

## キーバインド一覧

### ファイル操作

| キー | 機能 |
|---|---|
| `<leader>e` | ファイルエクスプローラ (snacks.explorer) |
| `<leader>-` | yazi ファイルマネージャ |
| `<leader>fs` | ファイル保存 |

### 検索

| キー | 機能 |
|---|---|
| `<leader>ff` | ファイル検索 (fzf-lua) |
| `<leader>sg` | grep検索 (fzf-lua) |
| `<leader>sr` | 検索と置換 (grug-far) |

### Git

| キー | 機能 |
|---|---|
| `]h` / `[h` | hunk移動 (gitsigns) |
| `<leader>gg` | lazygit |

### LSP

| キー | 機能 |
|---|---|
| `gd` | 定義へジャンプ |
| `K` | ホバー情報 |
| `<leader>ca` | コードアクション |

### Window / バッファ

| キー | 機能 |
|---|---|
| `<leader>w` + サブキー | Window操作 |
| `[b` / `]b` | バッファ切替 |

### カスタムキーバインド

| キー | 機能 |
|---|---|
| `jj` | ESC (インサートモード) |
| `H` / `L` | 行頭 / 行末移動 |
| `j` / `k` | 視覚行での移動 (折り返し対応) |

## SSH利用

Neovim 0.10+のOSC 52クリップボードが自動的に有効になる。SSH接続時にターミナルのクリップボードと連携する。

## sudo編集

### シェルから

```bash
sudoedit /etc/hosts     # EDITOR=nvimで開く（全プラグイン有効）
```

### nvim内から

```vim
:SudaWrite              " sudo権限で保存（vim-suda）
:SudaRead /etc/hosts    " sudo権限で読み込み
```

## カスタマイズ

`lua/plugins/` ディレクトリにLuaファイルを追加することでプラグインを追加・設定変更できる。

例: `lua/plugins/example.lua`
```lua
return {
  { "author/plugin-name", opts = {} },
}
```

詳細は [LazyVim公式ドキュメント](https://www.lazyvim.org/) を参照。
