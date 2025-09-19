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

                if filetype == "DiffviewFiles" or filetype == "DiffviewFileHistory" then
                    return false
                end
            end,
            root_dir = function(...)
                return require("lspconfig.util").root_pattern(".vimproject", ".git")(...)
            end,
            settings = {
                experimental = {
                    useFlatConfig = os.getenv("ESLINT_FLAT_CONFIG") == 'true'
                }
            }
        })

        require("lspconfig").clangd.setup({
            cmd = {
                "clangd",
                "--query-driver=/usr/bin/arm-none-eabi-g++"
            }
        })
        require("lspconfig").gopls.setup({})
        require("lspconfig").rust_analyzer.setup({})
        -- require("lspconfig").pyright.setup({})

        vim.keymap.del("n", "grn")
        vim.keymap.del("n", "gra")
        vim.keymap.del("n", "grr")
        vim.keymap.del("n", "gri")
        vim.keymap.del("n", "grt")
    end
}
