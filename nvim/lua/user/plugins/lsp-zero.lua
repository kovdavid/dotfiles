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

        lsp_zero.extend_lspconfig({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            lsp_attach = function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end,
            float_border = 'rounded',
            sign_text = true,
        })

        vim.lsp.config("eslint", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            -- on_attach = function(client)
            --     if client.resolved_capabilities then
            --         client.resolved_capabilities.document_formatting = true
            --     end
            -- end,
            root_markers = {
                ".vimproject",
                ".git",
            },
            -- root_dir = function(fname)
            --     return vim.lsp.util.root_pattern(".vimproject")(fname)
            --         or vim.lsp.util.root_pattern(".git")(fname)
            -- end,
            settings = {
                experimental = {
                    useFlatConfig = os.getenv("ESLINT_FLAT_CONFIG") == 'true'
                }
            }
        })

        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--query-driver=/usr/bin/arm-none-eabi-g++"
            }
        })

        -- require("lspconfig").gopls.setup({})
        -- require("lspconfig").rust_analyzer.setup({})
        -- require("lspconfig").pyright.setup({})

        vim.lsp.enable("eslint")
        vim.lsp.enable("clangd")

        vim.keymap.del("n", "grn")
        vim.keymap.del("n", "gra")
        vim.keymap.del("n", "grr")
        vim.keymap.del("n", "gri")
        vim.keymap.del("n", "grt")
    end
}
