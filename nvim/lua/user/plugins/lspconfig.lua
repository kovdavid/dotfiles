return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "L3MON4D3/LuaSnip" },
  },
  config = function()
    -- vim.lsp.enable("eslint")
    vim.lsp.enable("vtsls")
    -- vim.lsp.enable("tsc")
    vim.lsp.enable("clangd")

    for _, lhs in ipairs({ "grn", "gra", "grr", "gri", "grt", "grx" }) do
      pcall(vim.keymap.del, "n", lhs)
    end
    pcall(vim.keymap.del, "x", "gra")
  end,
}
