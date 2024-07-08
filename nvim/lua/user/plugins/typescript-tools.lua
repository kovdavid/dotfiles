return {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
        settings = {
            separate_diagnostic_server = false,
            tsserver_max_memory = 600,
        }
    },
}
