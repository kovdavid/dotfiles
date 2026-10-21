return {
    root_dir = require("user.lsp_root"),
    settings = {
      configPath = vim.fn.expand(vim.env.NVIM_OXLINT_CONFIG),
    }
}
