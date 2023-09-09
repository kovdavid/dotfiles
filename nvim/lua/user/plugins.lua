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

        ----------------------
        -- Required plugins --
        ----------------------

        use('nvim-lua/plenary.nvim')

        --------
        -- UI --
        --------
        use("phha/zenburn.nvim")
        use("ellisonleao/gruvbox.nvim")
        -- use("rebelot/kanagawa.nvim")
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
        use({ 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' })
        use({
            'abecodes/tabout.nvim',
            config = function()
                require('user.plugins.tabout')
            end,
            wants = {'nvim-treesitter'},
            after = {'nvim-cmp'},
        })

        ----------------
        -- Navigation --
        ----------------

        use({
            'rhysd/clever-f.vim',
            config = function()
                require("user.plugins.clever-f")
            end
        })

        use({
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({})
            end
        })

        use({ "kylechui/nvim-surround", config = function() require("nvim-surround").setup({}) end })

        use({
            "ahmedkhalf/project.nvim",
            config = function()
                require("project_nvim").setup({
                    detection_methods = { "pattern" },
                    patterns = { ".git", ".vimproject" },
                })
            end
        })

        use({ "nvim-telescope/telescope.nvim", config = function() require("user.plugins.telescope") end })
        use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

        ----------------
        -- Formatting --
        ----------------

        use({
            "Vonr/align.nvim",
            config = function() require("user.plugins.align") end,
        })

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
                {'L3MON4D3/LuaSnip'},
            }
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
