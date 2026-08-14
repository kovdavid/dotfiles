require("user.colors_common").setup({
  background = "dark",
  -- colorscheme = "kanagawa",
  -- colorscheme = "gruvbox-material",
  -- colorscheme = "zenburned",
  -- colorscheme = "tokyonight-moon",
  colorscheme = "zenburn",
  overrides = {
    CursorLine = { bg = "#4f4f4f" },
    CurSearch = { overline = true },
    DiffDelete = { link = "Tag" },
  },
})
