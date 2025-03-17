return {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    lazy = true,
    ft = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    opts = {
        settings = {
            -- separate_diagnostic_server = false,
            -- tsserver_max_memory = 1536,
        },
        -- tsserver_file_preferences = {
            -- importModuleSpecifierPreference = "non-relative"
        -- },
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

            if filetype == "DiffviewFiles" or filetype == "DiffviewFileHistory" then
                return false
            end
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
