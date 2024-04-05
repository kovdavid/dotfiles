require("user.utils")
require("user.globals")
require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.autocmd")
require("user.cmp")
require("user.lsp")

require("gruvbox").setup()
require("user.colors")

vim.keymap.set("n", "<leader>ss", ReloadConfig, { noremap = true, silent = false })
vim.keymap.set("n", "<leader>se", ":tabnew ~/.config/nvim/init.lua<CR>", { noremap = true, silent = false })
