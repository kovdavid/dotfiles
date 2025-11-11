return {
    "sindrets/diffview.nvim",
    opts = {
        view = {
            merge_tool = {
                layout = "diff4_mixed",
                disable_diagnostics = true,
            }
        }
    },
    keys = {
        { "<leader>do", ":DiffviewOpen", desc = "DiffviewOpen", silent = false },
        { "<leader>df", ":DiffviewFileHistory %<CR>", desc = "DiffviewFileHistory", silent = false },
        { "<leader>dc", ":DiffviewClose<CR>", desc = "DiffviewClose" },
        { "<leader>dt", ":DiffviewToggleFiles<CR>", desc = "DiffviewToggleFiles" },
    }
}
