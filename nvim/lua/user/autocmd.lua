local bash_group = vim.api.nvim_create_augroup("bash", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sh" },
    group = bash_group,
    callback = function ()
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>rr", ":!bash %<CR>", opts)
    end,
})

local all_files_group = vim.api.nvim_create_augroup("all_files", { clear = true})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = all_files_group,
    callback = function ()
        vim.cmd("%s/\\s\\+$//e")
    end
})
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
    group = all_files_group,
    callback = function ()
        vim.cmd("setlocal winwidth=1")
        vim.cmd("setlocal number")
        vim.cmd("setlocal relativenumber")
        if vim.api.nvim_win_get_option(0, "diff") then
            vim.cmd("setlocal wrap")
        end
    end
})
vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost", "BufLeave" }, {
    group = all_files_group,
    callback = function ()
        vim.cmd("setlocal norelativenumber")
        vim.cmd("setlocal number")
    end
})
