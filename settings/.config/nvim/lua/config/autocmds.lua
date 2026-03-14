-- tmux.conf保存時に自動リロード
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = ".tmux.conf",
  command = "silent !tmux source-file ~/.tmux.conf && tmux refresh-client",
  desc = "Auto-reload tmux.conf on save",
})

-- コメント自動挿入を無効化
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable auto comment insertion",
})

-- hidden file（ドットファイル）を通常ファイルと同じ色で表示（git-ignoredとの区別のため）
-- ColorScheme autocmd + 即時適用（autocmds.luaはVeryLazyで読み込まれるため、
-- 起動時のColorSchemeイベントには間に合わない）
local grp = vim.api.nvim_create_augroup("SnacksExplorerHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = grp,
  callback = function()
    vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "SnacksPickerFile" })
  end,
  desc = "Override snacks.explorer hidden file highlight",
})
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "SnacksPickerFile" })
