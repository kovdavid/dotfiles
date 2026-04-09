return {
  -- Required plugins
  "nvim-lua/plenary.nvim",
  "kkharji/sqlite.lua",

  -- Colorschemes
  "phha/zenburn.nvim",

  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({})
    end,
  },

  -- {
  --     "sainnhe/gruvbox-material",
  --     lazy = false,
  --     priority = 1000,
  --     config = function()
  --         vim.g.gruvbox_material_background = 'soft'
  --     end
  -- },
  -- "rebelot/kanagawa.nvim",
}
