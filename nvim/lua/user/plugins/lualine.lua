return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    { "ellisonleao/gruvbox.nvim", config = true },
  },
  opts = {
    options = {
      theme = "zenburned",
    },
    sections = {
      lualine_c = { "filename", vim.ui.progress_status },
    },
    inactive_sections = {
      lualine_x = {
        {
          function()
            return vim.api.nvim_get_current_buf()
          end,
          icon = "#",
        },
      },
    },
  },
}
