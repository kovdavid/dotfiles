return {
    root_dir = require("user.lsp_root"),
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, { buf = bufnr })
    end,
}
