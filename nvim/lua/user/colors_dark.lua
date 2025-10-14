vim.cmd("hi clear")

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    local p = require("zenburn.palette")

    vim.api.nvim_set_hl(0, "@org.keyword.todo", p.Function)
    vim.api.nvim_set_hl(0, "@org.keyword.done", p.Debug)
  end
})

vim.cmd("set background=dark")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme gruvbox-material")
vim.cmd("colorscheme vim")
vim.cmd("colorscheme zenburn")
-- vim.cmd("colorscheme tokyonight-moon")
vim.cmd("highlight CursorLine guibg=#4f4f4f guifg=NONE")
