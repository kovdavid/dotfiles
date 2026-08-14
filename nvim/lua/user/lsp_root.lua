return function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, { ".vimproject", ".git" }) or vim.fn.getcwd())
end
