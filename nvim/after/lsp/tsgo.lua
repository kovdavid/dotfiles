return {
    root_dir = function(bufnr, on_dir)
        local project_root = vim.fs.root(bufnr, { ".vimproject", ".git" }) or vim.fn.getcwd()
        on_dir(project_root)
    end,
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, { buffer = bufnr })
    end,
}
