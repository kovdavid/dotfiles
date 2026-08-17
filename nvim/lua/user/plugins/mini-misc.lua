return {
  "nvim-mini/mini.misc",
  lazy = false,
  config = function()
    local misc = require("mini.misc")

    misc.setup()
    misc.setup_auto_root({ ".vimproject", ".git" })
    misc.setup_restore_cursor()
  end,
}
