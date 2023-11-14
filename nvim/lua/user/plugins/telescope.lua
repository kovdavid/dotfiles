-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<C-s>"] = "select_horizontal"
            },
            n = {
                ["<C-s>"] = "select_horizontal"
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
        }
    }
}
-- To get fzf loaded and working with telescope, you need to call load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local opts = { noremap = true, silent = true }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', function() builtin.find_files({ hidden = false }) end, opts)
vim.keymap.set('n', '<leader>m', function() builtin.find_files({ cwd = vim.fn.expand("%:p:h") }) end, opts)
vim.keymap.set('n', '<leader>.', function() builtin.buffers({ cwd_only = true, ignore_current_buffer = true, sort_lastused = true }) end, opts)
vim.keymap.set('n', '<leader>tr', function() builtin.resume() end, opts)


-- require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })
