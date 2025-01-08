local bash_group = vim.api.nvim_create_augroup("bash", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sh" },
    group = bash_group,
    callback = function ()
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>rr", ":!bash %<CR>", opts)
    end,
})

local javascript_group = vim.api.nvim_create_augroup("javascript", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript" },
    group = javascript_group,
    callback = function ()
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>rr", ":!node %<CR>", opts)
    end,
})

local hurl_group = vim.api.nvim_create_augroup("hurl", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "hurl" },
    group = hurl_group,
    callback = function ()
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>rr", ":!hurl %<CR>", opts)
        vim.keymap.set("n", "<leader>rv", ":!hurl --verbose %<CR>", opts)
    end,
})

local all_files_group = vim.api.nvim_create_augroup("all_files", { clear = true })
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

local markdown_group = vim.api.nvim_create_augroup("markdown_group", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
    group = markdown_group,
    pattern = {"todo.md"},
    callback = function (ev)
        local keymap_options = { buffer = ev.buf, silent = true, noremap = true }
        vim.keymap.set("i", "<F5>", "<C-R>=strftime('%F')<CR>", keymap_options)
        vim.keymap.set("i", "<F6>", "<C-R>=strftime('%FT%T')<CR>", keymap_options)
    end
})

local make_group = vim.api.nvim_create_augroup("make_group", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
    group = make_group,
    callback = function()
        vim.bo.expandtab = false
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
    end,
})
