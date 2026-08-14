return {
  "nvim-mini/mini.completion",
  lazy = false,
  dependencies = { "nvim-mini/mini.icons" },
  config = function()
    require("mini.completion").setup({
      delay = { completion = 50, info = 100, signature = 50 },
      mappings = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
    })
  end,
}
