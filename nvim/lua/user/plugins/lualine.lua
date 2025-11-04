return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        { "ellisonleao/gruvbox.nvim", config = true },
    },
    opts = {
        options = {
            theme = "gruvbox",
        },
        inactive_sections = {
            lualine_x = {
                { function() return vim.api.nvim_get_current_buf() end, icon = '#', },
            },
        }
    }
}
