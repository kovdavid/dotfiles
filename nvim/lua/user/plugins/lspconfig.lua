return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("*", { capabilities = require("mini.completion").get_lsp_capabilities() })

    -- vim.lsp.enable("eslint")
    -- vim.lsp.enable("vtsls")
    vim.lsp.enable("tsc")
    vim.lsp.enable("clangd")

    for _, lhs in ipairs({ "grn", "gra", "grr", "gri", "grt", "grx" }) do
      pcall(vim.keymap.del, "n", lhs)
    end
    pcall(vim.keymap.del, "x", "gra")
  end,
}
