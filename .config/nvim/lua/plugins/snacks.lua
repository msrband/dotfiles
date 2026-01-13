return {
  "folke/snacks.nvim",
  keys = {
    -- 숨김 파일 포함 find_files
    {
      "<leader>fF",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = "Find Files (hidden)",
    },
    -- 숨김 파일 포함 grep
    {
      "<leader>sH",
      function()
        Snacks.picker.grep({ hidden = true })
      end,
      desc = "Grep (hidden)",
    },
  },
}
