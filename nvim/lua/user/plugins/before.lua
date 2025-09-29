return {
    "bloznelis/before.nvim",
    init = function()
        local before = require("before")

        vim.keymap.set('n', '<C-h>', function()
            before.show_edits_in_telescope(require('telescope.themes').get_dropdown())
        end, {})
        vim.keymap.set('n', '<C-l>', before.jump_to_next_edit, {})
    end,
    opts = {
        history_size = 50,
    }
}
