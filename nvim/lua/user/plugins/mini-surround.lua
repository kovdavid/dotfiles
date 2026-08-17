return {
  "nvim-mini/mini.surround",
  event = "VeryLazy",
  config = function()
    require("mini.surround").setup({
      mappings = {
        add = "",
        delete = "ds",
        replace = "cs",

        find = "",
        find_left = "",
        highlight = "",

        suffix_last = "l",
        suffix_next = "n",
      },
    })
  end,
}
