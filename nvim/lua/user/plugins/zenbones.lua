return {
    "zenbones-theme/zenbones.nvim",
    dependencies = {
        "rktjmp/lush.nvim"
    },
    config = function()
        vim.g.zenbones = {
            darkness = "warm"
        }
    end
}
