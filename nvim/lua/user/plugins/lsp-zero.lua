return {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v4.x',
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
        require('mason').setup({})
        require('mason-lspconfig').setup({})

        local lsp_zero = require('lsp-zero')

        local lsp_attach = function(client, bufnr)
            lsp_zero.default_keymaps({buffer = bufnr})
        end

        lsp_zero.extend_lspconfig({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            lsp_attach = lsp_attach,
            float_border = 'rounded',
            sign_text = true,
        })

        require("lspconfig").eslint.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = function(client)
                if client.resolved_capabilities then
                    client.resolved_capabilities.document_formatting = true
                end
            end,
            settings = {
                experimental = {
                    useFlatConfig = false
                }
            }
        })

        require("lspconfig").clangd.setup({})
    end
}
