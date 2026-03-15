-- lua/plugins/diff-compare.lua
return {
  {
    "snacks.nvim",
    -- init は snacks.setup() より前に実行されるが、
    -- コマンド実行時点では snacks は初期化済みなので問題なし
    init = function()
      vim.api.nvim_create_user_command("CompareSelected", function()
        local pickers = Snacks.picker.get({ source = "explorer" })
        if #pickers == 0 then
          vim.notify("Explorer is not open.", vim.log.levels.WARN)
          return
        end
        local picker = pickers[#pickers] -- 最新の explorer

        local selected = picker:selected()
        -- ディレクトリを除外
        local files = {}
        for _, item in ipairs(selected) do
          if item.file and not item.dir then
            table.insert(files, item.file)
          end
        end

        if #files ~= 2 then
          vim.notify(
            "Select exactly 2 files with <Tab> in explorer. (current: " .. #files .. ")",
            vim.log.levels.WARN
          )
          return
        end

        local file_a, file_b = files[1], files[2]

        if not vim.uv.fs_stat(file_a) then
          vim.notify("File no longer exists: " .. file_a, vim.log.levels.ERROR)
          return
        end
        if not vim.uv.fs_stat(file_b) then
          vim.notify("File no longer exists: " .. file_b, vim.log.levels.ERROR)
          return
        end

        picker.list:set_selected() -- 選択をクリア
        picker:close()
        vim.schedule(function()
          local ok, err = pcall(function()
            vim.cmd("tabedit " .. vim.fn.fnameescape(file_a))
            vim.cmd("vert diffsplit " .. vim.fn.fnameescape(file_b))
          end)
          if not ok then
            vim.notify("Failed to open diff: " .. tostring(err), vim.log.levels.ERROR)
          end
        end)
      end, { desc = "Compare 2 selected files in explorer" })
    end,
  },
}
