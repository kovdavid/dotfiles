return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        -- Treesitter folds
        -- vim.o.foldmethod = 'expr'
        -- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
        -- vim.o.foldlevelstart = 99

        require('nvim-treesitter.configs').setup({
            -- nvim-treesitter/nvim-treesitter (self config)
            -- auto_install = true,
            auto_install = false,
            ensure_installed = {
                'bash',
                'css',
                'dockerfile',
                'html',
                'javascript',
                'json',
                'lua',
                'markdown',
                'markdown_inline',
                'tsx',
                'typescript',
            },
            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            -- windwp/nvim-ts-autotag
            autotag = {
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
                filetypes = {
                    "html",
                    "ejs",
                    "mason",
                    "javascript",
                    "typescript",
                    "javascriptreact",
                    "typescriptreact",
                },
            },
            -- nvim-treesitter/nvim-treesitter-refactor
            refactor = {
                highlight_definitions = { enable = true },
                -- highlight_current_scope = { enable = false },
            },
        })
    end
}
