vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    virtual_text = { current_line = false, prefix = "●" },
    -- virtual_lines = { current_line = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
    jump = {
        on_jump = function(diagnostic)
            if diagnostic then
                vim.diagnostic.open_float({ scope = "cursor" })
            end
        end,
    },
})
