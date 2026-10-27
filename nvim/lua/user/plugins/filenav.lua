return {
  "wojciech-kulik/filenav.nvim",
  config = function()
    require("filenav").setup({
      prev_file_key = "<C-^>",
      max_history = 100,
      remove_duplicates = false,
    })
  end,
}
