return {
  "nvim-mini/mini.trailspace",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("mini.trailspace").setup()

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("user_trailspace", { clear = true }),
      callback = function()
        MiniTrailspace.trim()
      end,
    })
  end,
}
