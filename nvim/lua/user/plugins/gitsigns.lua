require("gitsigns").setup({
    on_attach = function(bufnr)

        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- map('n', '<leader>hs', gs.stage_hunk)
        -- map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
        -- map('n', '<leader>hd', gs.diffthis)
        -- map('n', '<leader>tb', gs.toggle_current_line_blame)
        -- map('n', '<leader>td', gs.toggle_deleted)

    end
})
