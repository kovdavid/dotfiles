return {
    cmd = { "vtsls", "--stdio", "--max-old-space-size=4096" },
    root_dir = require("user.lsp_root"),
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, { buf = bufnr })
    end,
    settings = {
        typescript = {
            updateImportsOnFileMove = "always",
            preferences = {
                importModuleSpecifier = "non-relative"
            }
        },
        javascript = {
            updateImportsOnFileMove = "always",
            preferences = {
                importModuleSpecifier = "non-relative"
            }
        },
        vtsls = {
            enableMoveToFileCodeAction = true,
        },
    }
}
