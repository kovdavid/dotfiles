return {
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
    root_dir = function(bufnr, on_dir)
        local project_root = vim.fs.root(bufnr, { ".vimproject", ".git" }) or vim.fn.getcwd()
        on_dir(project_root)
    end,
    settings = {
        experimental = {
            useFlatConfig = os.getenv("ESLINT_FLAT_CONFIG") == 'true'
        }
    }
}
