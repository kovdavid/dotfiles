return {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
        settings = {
            -- separate_diagnostic_server = false,
            -- tsserver_max_memory = 1536,
        },
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
        jsx_close_tag = {
            enable = true,
            filetypes = {
                "javascriptreact",
                "typescriptreact",
            }
        }
    },
}
