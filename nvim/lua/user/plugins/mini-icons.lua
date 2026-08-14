return {
  "nvim-mini/mini.icons",
  lazy = false,
  priority = 900,
  config = function()
    require("mini.icons").setup()
    MiniIcons.tweak_lsp_kind("replace")
  end,
}
