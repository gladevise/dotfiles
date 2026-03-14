local opt = vim.opt
opt.updatetime = 100
opt.fileformat = "unix"
opt.inccommand = "split" -- 置換プレビューをsplitで表示

-- SSH時のOSC 52クリップボード設定
if os.getenv("SSH_TTY") then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- 未使用プロバイダーを無効化
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- mise経由のプロバイダーパスを設定（shim経由だとpyenv shimと誤検出されるため実パスを使用）
local node_host = vim.fn.system("mise which neovim-node-host"):gsub("\n", "")
if vim.v.shell_error == 0 and node_host ~= "" then
  vim.g.node_host_prog = node_host
end

local python3_host = vim.fn.system("mise which pynvim-python"):gsub("\n", "")
if vim.v.shell_error == 0 and python3_host ~= "" then
  vim.g.python3_host_prog = python3_host
end
