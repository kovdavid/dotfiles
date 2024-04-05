local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrapped = ensure_packer()

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerSync',
})

return require('packer').startup({
    function (use)
        ---------------------
        -- Package Manager --
        ---------------------

        use('wbthomason/packer.nvim')

        -- ----------------------
        -- -- Required plugins --
        -- ----------------------

        use('nvim-lua/plenary.nvim')

        -- --------
        -- -- UI --
        -- --------

        use("phha/zenburn.nvim")
        use("ellisonleao/gruvbox.nvim")
        use("rebelot/kanagawa.nvim")
        use({"nvim-lualine/lualine.nvim", config = function() require("user.plugins.lualine") end})

        -----------------------------------
        -- Treesitter: Better Highlights --
        -----------------------------------

        use({
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                require('user.plugins.treesitter')
            end
        })

        use({ 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' })
        use({ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' })
        use({ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' })

        ----------------
        -- Navigation --
        ----------------

         use({ 'rhysd/clever-f.vim', config = function() require('user.plugins.clever-f') end })
         use({ 'stevearc/oil.nvim', config = function() require('oil').setup() end })
         use({ 'kylechui/nvim-surround', config = function() require('nvim-surround').setup({}) end })
         use({ 'sindrets/diffview.nvim' })
         use({ 'notjedi/nvim-rooter.lua', config = function() require('user.plugins.nvim-rooter') end })
         use({ 'nvim-telescope/telescope.nvim', config = function() require('user.plugins.telescope') end })
         use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
         use({ 'lewis6991/gitsigns.nvim', config = function() require('user.plugins.gitsigns') end, })
         use({ 'folke/which-key.nvim', config = function() require('user.plugins.which-key') end, })
         use({ 'bloznelis/before.nvim', config = function() require('user.plugins.before') end, })

         use({
             'windwp/nvim-autopairs',
             config = function()
                 require('nvim-autopairs').setup({})
             end
         })


         use({
             'nvim-tree/nvim-tree.lua',
             requires = { 'nvim-tree/nvim-web-devicons' },
             config = function()
                 require('user.plugins.nvim-tree')
             end
         })

        ----------------
        -- Formatting --
        ----------------

        use({
            "numToStr/Comment.nvim",
            config = function () require("user.plugins.comment") end
        })

        -----------------
        -- Completions --
        -----------------

        use({
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            requires = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'L3MON4D3/LuaSnip'},
            }
        })

         use({
             "jose-elias-alvarez/null-ls.nvim",
             config = function() require("user.plugins.null-ls") end,
             requires = { "nvim-lua/plenary.nvim" },
         })

         use({
             "LunarVim/bigfile.nvim",
             config = function() require("bigfile").setup() end,
         })

        if packer_bootstrapped then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
    },
})
