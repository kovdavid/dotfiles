local null_ls = require("null-ls")

local sources = {
    -- null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.code_actions.shellcheck,
    -- null_ls.builtins.code_actions.gitsigns,
    -- null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.prettier.with({
        filetypes = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
        },
        only_local = "node_modules/.bin",
        condition = function(utils)
            return utils.root_has_file({ ".editorconfig" })
        end,
        debug = false,
    }),
    -- null_ls.builtins.formatting.eslint.with({
    --     format = { enable = false }
    -- })
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    sources = sources,
    debug = false,
    root_dir = require("null-ls.utils").root_pattern(".vimproject"),
    on_attach = function(client, bufnr)

        if client.supports_method("textDocument/formatting") then
            vim.notify("Setting up formatting with " .. client.name, vim.log.levels.INFO)

            require("which-key").register({
                ["f"] = {
                    function()
                        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), timeout_ms = 5000 })
                    end,
                    "[lsp] format"
                },
            }, { prefix = "<leader>", mode = "n", buffer = bufnr })

            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

            if os.getenv("ENABLE_AUTOFORMAT") then
                -- vim.api.nvim_create_autocmd("BufWritePre", {
                --     group = augroup,
                --     buffer = bufnr,
                --     callback = function()
                --         vim.lsp.buf.format({ bufnr = bufnr })
                --     end,
                --     desc = "[lsp] format on save"
                -- })
            end
        end

        -- if client.supports_method("textDocument/rangeFormatting") then
        --     vim.keymap.set("x", "<Leader>f", function()
        --         vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        --     end, { buffer = bufnr, desc = "[lsp] format" })
        -- end

        -- if client.supports_method("textDocument/formatting") then
        --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --         group = augroup,
        --         buffer = bufnr,
        --         callback = function()
        --             vim.lsp.buf.format({
        --                 bufnr = bufnr,
        --                 filter = function(c) return c.name == "null-ls" end,
        --             })
        --         end,
        --     })
        -- end
    end,
})
