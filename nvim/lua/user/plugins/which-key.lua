local wk = require("which-key")
wk.setup({
    plugins = {
        marks = true,
        registers = true,
        presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
        }
    },
})

vim.cmd("unmap gc")
vim.cmd("unmap gcc")

wk.register({
    ["d"] = {
        name = "diff",
        ["w"] = { ":windo set diffopt+=iwhiteall<CR>", "diff +iwhite" },
        ["u"] = { ":windo diffupdate<CR>", "diff update" },
        ["b"] = { ":windo set scrollbind!<CR>", "diff scrollbind!" },
        ["o"] = { ":DiffviewOpen", "DiffviewOpen", silent=false },
        ["f"] = { ":DiffviewFileHistory %<CR>", "DiffviewFileHistory", silent=false },
        ["c"] = { ":DiffviewClose<CR>", "DiffviewClose" },
    },
    ["h"] = {
        name = "hunk",
        ["n"] = { function() require("gitsigns").next_hunk() end, "next hunk" },
        ["p"] = { function() require("gitsigns").prev_hunk() end, "prev hunk" },
        ["w"] = { function() require("gitsigns").preview_hunk() end, "preview hunk" },
        ["s"] = { function() require("gitsigns").stage_hunk() end, "stage hunk" },
        ["r"] = { function() require("gitsigns").reset_hunk() end, "reset hunk" },
        ["b"] = { function() require("gitsigns").blame_line({ full = true }) end, "blame line" },
        ["d"] = { function() require("gitsigns").diffthis() end, "diff" },
        ["t"] = {
            name = "toggle",
            ["b"] = { function() require("gitsigns").toggle_current_line_blame() end, "toggle blame current line" },
            ["d"] = { function() require("gitsigns").toggle_deleted() end, "toggle deleted" },
        },
    },
    ["l"] = {
        name = "LSP",
        ["r"] = { vim.lsp.buf.rename, "rename" }
    },
    ["t"] = {
        name = "Telescope",
        ["r"] = { function() require('telescope.builtin').resume() end, "Telescope resume" },
        ["b"] = { function() require('telescope').extensions.before.before() end, "Telescope before" } ,
        ["f"] = { function() require('telescope.builtin').buffers({ cwd_only = true, ignore_current_buffer = true, sort_lastused = true }) end, "Telescope buffers" },
        ["d"] = { function() require('telescope.builtin').find_files({ cwd = vim.fn.expand("%:p:h") }) end, "Telescope directory" },
        ["g"] = {
            name = "Grep",
            ["l"] = { function() require('telescope.builtin').live_grep() end, "Live grep" },
            ["w"] = { function() require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') }) end, "Live grep word" },
            ["f"] = { function() require('telescope.builtin').live_grep({ default_text = '\\b' .. vim.fn.expand('<cword>') .. '\\b' }) end, "Live grep full word" },
        },
    },
    [" "] = { ":NvimTreeFindFile<CR>", "NvimTree" },
    ["f"] = { function() require("conform").format({ async = true }) end, "Format with conform" },
    ["<leader>"] = { function() require('telescope').extensions.smart_open.smart_open({ cwd_only = true, filename_first = false }) end, "telescope project" },
    -- ["<leader>"] = { function() require('telescope.builtin').find_files({ hidden = false }) end, "telescope project" },
}, { prefix = "<leader>", mode = "n" })

wk.register({
    ["t"] = {
        name = "Telescope",
        ["g"] = {
            name = "Grep",
            ["w"] = { function() require('telescope.builtin').live_grep({ default_text = require('user.utils').get_telescope_grep_selection({ full_word = false }) }) end, "Live grep word" },
            ["f"] = { function() require('telescope.builtin').live_grep({ default_text = require('user.utils').get_telescope_grep_selection({ full_word = true }) }) end, "Live grep full word" },
        },
    },
    ["j"] = {
        name = "json",
        ["c"] = { ":!jq --compact-output<CR>", "jq compact" },
        ["f"] = { ":!jq --indent 4<CR>", "jq format" },
        ["g"] = { ":!gron<CR>", "gron format" },
    },
}, { prefix = "<leader>", mode = "v" })

local normalAndVisualModes = {"n", "v"}
for _, mode in ipairs(normalAndVisualModes) do
    wk.register({
        ["j"] = {
            name = "json",
            ["c"] = { ":%!jq --compact-output<CR>", "jq compact" },
            ["f"] = { ":%!jq --indent 4<CR>", "jq format" },
            ["g"] = { ":%!gron<CR>", "gron format" },
            ["u"] = { ":%!gron -u<CR>", "gron unformat" },
        },
    }, { prefix = "<leader>", mode = mode })
end

wk.register({
    ["g"] = {
        ["d"] = { vim.lsp.buf.definition, "LSP definition" },
        ["D"] = { vim.lsp.buf.declaration, "LSP declaration" },
        -- ["c"] = { function() require('telescope.builtin').lsp_incoming_calls() end, "LSP incoming calls" },
        ["r"] = { function() require('telescope.builtin').lsp_references() end, "LSP references" },
        ["i"] = { vim.lsp.buf.implementation, "LSP implementation" },
        ["l"] = { vim.diagnostic.open_float, "LSP diagnostic" },
        ["o"] = { vim.lsp.buf.type_definition, "Type definition" },
        ["s"] = { vim.lsp.buf.signature_help, "Signature help" },
    },
})
