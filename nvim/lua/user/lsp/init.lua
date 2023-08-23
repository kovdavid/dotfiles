local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings to learn the available actions

    if client.name == "lua_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end

    lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
