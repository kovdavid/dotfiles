return {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'L3MON4D3/LuaSnip'},
    },
    config = function()
        local lsp = require('lsp-zero').preset({})

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({buffer = bufnr})
        end)

        require("lspconfig").eslint.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = function(client)
                if client.resolved_capabilities then
                    client.resolved_capabilities.document_formatting = false
                end
            end,
            settings = {
                experimental = {
                    useFlatConfig = false
                }
            }
        })

        require("lspconfig").clangd.setup({})

        lsp.setup()
    end
}
