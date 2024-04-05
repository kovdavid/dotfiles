local before = require("before")

vim.keymap.set('n', '<C-h>', before.jump_to_last_edit, {})
vim.keymap.set('n', '<C-l>', before.jump_to_next_edit, {})

before.setup({ history_size = 50 })
