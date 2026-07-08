return {
  "sindrets/diffview.nvim",
  opts = {
    view = {
      merge_tool = {
        layout = "diff4_mixed",
        disable_diagnostics = true,
      },
    },
    file_panel = {
      -- listing_style = function()
      --   local listing_style = vim.api.nvim_win_get_width(0) < 150 and "list" or "tree"
      --   return { listing_style = listing_style }
      -- end,
      listing_style = "tree",
      win_config = function()
        local width = vim.api.nvim_win_get_width(0) < 150 and 25 or 35
        return {
          width = width,
        }
      end,
    },
  },
  keys = {
    { "<leader>do", ":DiffviewOpen", desc = "DiffviewOpen", silent = false },
    { "<leader>df", ":DiffviewFileHistory %<CR>", desc = "DiffviewFileHistory", silent = false },
    { "<leader>dc", ":DiffviewClose<CR>", desc = "DiffviewClose" },
    {
      "<leader>dt",
      function()
        require("diffview.actions").toggle_files()
        local windows = vim.api.nvim_tabpage_list_wins(0)

        for _, win in ipairs(windows) do
          vim.wo[win].number = false
          vim.wo[win].relativenumber = false
          vim.wo[win].signcolumn = "no"
          vim.wo[win].foldcolumn = "0"
        end
      end,
      desc = "DiffviewToggleFiles",
    },
  },
}
