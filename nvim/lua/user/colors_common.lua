local M = {}

local augroup = vim.api.nvim_create_augroup("user_colors", { clear = true })

-- Applied on every ColorScheme so that :colorscheme and ReloadConfig keep them.
local function apply(overrides)
    vim.api.nvim_set_hl(0, "@org.keyword.todo", { link = "Function" })
    vim.api.nvim_set_hl(0, "@org.keyword.done", { link = "Debug" })
    vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@constant.typescript", { link = "Constant", force = true })

    for group, spec in pairs(overrides) do
        vim.api.nvim_set_hl(0, group, spec)
    end
end

function M.setup(opts)
    local overrides = opts.overrides or {}

    vim.api.nvim_create_autocmd("ColorScheme", {
        group = augroup,
        pattern = "*",
        callback = function()
            apply(overrides)
        end,
    })

    vim.o.background = opts.background
    vim.cmd.colorscheme(opts.colorscheme)
end

return M
