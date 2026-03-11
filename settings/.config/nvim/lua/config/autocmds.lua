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
