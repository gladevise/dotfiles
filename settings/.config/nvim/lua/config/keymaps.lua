local map = vim.keymap.set

-- jjでインサートモードから抜ける
map("i", "jj", "<Esc>", { desc = "Escape insert mode" })

-- 視覚行での移動（折り返し行対応）
map({ "n", "v" }, "j", "gj", { desc = "Move down (visual line)" })
map({ "n", "v" }, "k", "gk", { desc = "Move up (visual line)" })

-- 行頭/行末移動（H/L）
-- 注: LazyVimデフォルトの<S-h>/<S-l>（バッファ切替）を上書きする
-- バッファ切替は[b/]bで代替可能
map({ "n", "v", "o" }, "H", "^", { desc = "Go to line start" })
map({ "n", "v", "o" }, "L", "$", { desc = "Go to line end" })
