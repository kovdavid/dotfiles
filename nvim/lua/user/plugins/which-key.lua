return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 200

        vim.cmd("unmap gc")
        vim.cmd("unmap gcc")
    end,
    opts = {
        -- plugins = {
        --     marks = true,
        --     registers = true,
        --     presets = {
        --         operators = true,
        --         -- motions = true,
        --         -- text_objects = true,
        --         -- windows = true,
        --         -- nav = true,
        --         -- z = true,
        --         -- g = true,
        --     }.
        -- },
    },
    keys = {
        { "<leader>dw", ":windo set diffopt+=iwhiteall<CR>", desc = "diff +iwhite" },
        { "<leader>du", ":windo diffupdate<CR>", desc = "diff update" },
        { "<leader>db", ":windo set scrollbind!<CR>", desc = "diff scrollbind!" },
        { "<leader>do", ":DiffviewOpen", desc = "DiffviewOpen", silent = false },
        { "<leader>df", ":DiffviewFileHistory %<CR>", desc = "DiffviewFileHistory", silent=false },
        { "<leader>dc", ":DiffviewClose<CR>", desc = "DiffviewClose" },

        { "<leader>hn", function() require("gitsigns").next_hunk() end, desc = "next hunk" },
        { "<leader>hp", function() require("gitsigns").prev_hunk() end, desc = "prev hunk" },
        { "<leader>hw", function() require("gitsigns").preview_hunk() end, desc = "preview hunk" },
        { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "stage hunk" },
        { "<leader>hS", function() require("gitsigns").stage_buffer() end, desc = "stage buffer" },
        { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "reset hunk" },
        { "<leader>hR", function() require("gitsigns").reset_buffer() end, desc = "reset buffer" },
        { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "blame line" },
        { "<leader>hd", function() require("gitsigns").diffthis() end, desc = "diff" },
        { "<leader>htb", function() require("gitsigns").toggle_current_line_blame() end, desc = "toggle blame current line" },
        { "<leader>htd", function() require("gitsigns").toggle_deleted() end, desc = "toggle deleted" },

        { "<leader>lr", vim.lsp.buf.rename, desc = "rename" },
        { "<leader>la", ":TSToolsAddMissingImports<CR>", desc = "TSTools AddMissingImports" },
        { "<leader>lo", ":TSToolsOrganizeImports<CR>", desc = "TSTools OrganizeImports" },
        { "<leader>lf", ":TSToolsRenameFile<CR>", desc = "TSTools RenameFile" },

        { "<leader>tr", function() require('telescope.builtin').resume() end, desc = "Telescope resume" },
        { "<leader>tb", function() require('telescope').extensions.before.before() end, desc = "Telescope before" } ,
        { "<leader>tf", function() require('telescope.builtin').buffers({ cwd_only = true, ignore_current_buffer = true, sort_lastused = true }) end, desc = "Telescope buffers" },
        { "<leader>td", function() require('telescope.builtin').find_files({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Telescope directory" },
        { "<leader>tgl", function() require('telescope.builtin').live_grep() end, desc = "Live grep" },
        { "<leader>tgw", function() require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') }) end, desc = "Live grep word" },
        { "<leader>tgf", function() require('telescope.builtin').live_grep({ default_text = '\\b' .. vim.fn.expand('<cword>') .. '\\b' }) end, desc = "Live grep full word" },

        { "<leader> ", ":NvimTreeFindFile<CR>", desc = "NvimTree" },
        {
            "<leader>f",
            function()
                if os.getenv("FORMATTER") == "lsp" then
                    vim.lsp.buf.format()
                else
                    require("conform").format({ async = true })
                end
            end,
            desc = "Format"
        },
        { "<leader><leader>", function() require('telescope').extensions.smart_open.smart_open({ cwd_only = true, filename_first = false }) end, desc = "telescope project" },
        -- { "<leader><leader>", function() require('telescope.builtin').find_files({ hidden = false }) end, desc = "telescope project" },

        {
            "<leader>tgw",
            function()
                require('telescope.builtin').live_grep({ default_text = require('user.utils').get_telescope_grep_selection({ full_word = false }) })
            end,
            mode = { 'v' },
            desc = "Live grep word"
        },
        {
            "<leader>tg",
            function()
                require('telescope.builtin').live_grep({ default_text = require('user.utils').get_telescope_grep_selection({ full_word = true }) })
            end,
            mode = { 'v' },
            desc = "Live grep full word",
        },
        { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "stage hunk", mode = { 'v' } },
        { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "reset hunk", mode = { 'v' } },

        { "gd", vim.lsp.buf.definition, desc = "LSP definition" },
        { "gD", vim.lsp.buf.declaration, desc = "LSP declaration" },
        { "gr", function() require('telescope.builtin').lsp_references() end, desc = "LSP references" },
        { "gi", vim.lsp.buf.implementation, desc = "LSP implementation" },
        { "gl", vim.diagnostic.open_float, desc = "LSP diagnostic" },
        { "go", vim.lsp.buf.type_definition, desc = "Type definition" },
        { "gs", vim.lsp.buf.signature_help, desc = "Signature help" },

        { "<leader>jc", ":%!jq --compact-output<CR>", desc = "jq compact", mode = { 'v', 'n', } },
        { "<leader>jf", ":%!jq --indent 4<CR>", desc = "jq format", mode = { 'v', 'n', } },
        { "<leader>js", ":%!jq --sort-keys --indent 4<CR>", desc = "jq format", mode = { 'v', 'n', } },
        { "<leader>jg", ":%!gron<CR>", desc = "gron format", mode = { 'v', 'n', } },
        { "<leader>ju", ":%!gron -u<CR>", desc = "gron unformat", mode = { 'v', 'n', } },
    },
}
