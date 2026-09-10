return {
  cmd = { "vtsls", "--stdio", "--max-old-space-size=8192" },
  root_dir = require("user.lsp_root"),
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, { buf = bufnr })
  end,
  settings = {
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      tsserver = {
        maxTsServerMemory = 8192,
      },
      preferences = {
        importModuleSpecifier = "non-relative",
      },
      inlayHints = { enabled = false },
    },
    javascript = {
      updateImportsOnFileMove = "always",
      preferences = {
        importModuleSpecifier = "non-relative",
      },
    },
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 15,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    init_options = {
      preferences = {
        disableSuggestions = false,
      },
    },
  },
  init_options = {
    preferences = {
      disableSuggestions = false,
    },
  },
}
