-- Treesitter folds
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.o.foldlevelstart = 99

require('nvim-treesitter.configs').setup({
    -- nvim-treesitter/nvim-treesitter (self config)
    auto_install = true,
    ensure_installed = {
        'c',
        'cpp',
        'dockerfile',
        'lua',
        'rust',
        'go',
        'javascript',
        'typescript',
        'tsx',
        'markdown',
        'markdown_inline',
        'html',
        'css',
        'json',
        'bash',
        -- 'perl',
        'python',
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
    },
    -- nvim-treesitter/nvim-treesitter-refactor
    refactor = {
        highlight_definitions = { enable = true },
        -- highlight_current_scope = { enable = false },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})
