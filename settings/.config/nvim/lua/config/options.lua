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
