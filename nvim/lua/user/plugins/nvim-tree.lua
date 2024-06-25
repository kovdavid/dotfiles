return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        actions = {
            open_file = {
                quit_on_open = true,
                resize_window = true,
            }
        },
        view = {
            adaptive_size = true,
        }
    }
}
