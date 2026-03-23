return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'L3MON4D3/LuaSnip'},
    },
    config = function()
        -- vim.lsp.enable("eslint")
        vim.lsp.enable("vtsls")
        -- vim.lsp.enable("tsgo")
        vim.lsp.enable("clangd")

        vim.keymap.del("n", "grn")
        vim.keymap.del("n", "gra")
        vim.keymap.del("n", "grr")
        vim.keymap.del("n", "gri")
        vim.keymap.del("n", "grt")
    end
}
