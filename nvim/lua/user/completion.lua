vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("user_completion_buftype", { clear = true }),
    callback = function(ev)
        if vim.bo[ev.buf].buftype ~= "" then
            vim.b[ev.buf].minicompletion_disable = true
        end
    end,
})

local function pum_or(key, fallback)
    return function()
        return vim.fn.pumvisible() == 1 and key or fallback
    end
end

vim.keymap.set("i", "<Tab>", pum_or("<C-n>", "<Tab>"), { expr = true })
vim.keymap.set("i", "<S-Tab>", pum_or("<C-p>", "<S-Tab>"), { expr = true })
vim.keymap.set("i", "<C-j>", pum_or("<C-n>", "<C-j>"), { expr = true })
vim.keymap.set("i", "<C-k>", pum_or("<C-p>", "<C-k>"), { expr = true })

local function esc(keys)
    return vim.api.nvim_replace_termcodes(keys, true, false, true)
end

local accept, newline = esc("<C-y>"), esc("<CR>")

vim.keymap.set("i", "<CR>", function()
    if vim.fn.complete_info({ "selected" }).selected ~= -1 then
        return accept
    end

    local ok, autopairs = pcall(require, "nvim-autopairs")
    return ok and autopairs.autopairs_cr() or newline
end, { expr = true, replace_keycodes = false, desc = "accept completion or newline" })
