local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set
local fn = vim.fn
local opt = vim.opt

-- Remap ',' as leader key
-- keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

local function highlight_word(args)
    print("calling function")

    local highlight = fn.expand('<cword>')
    if args.exact_match then
        highlight = "\\<" .. highlight .. "\\>"
    end

    fn.setreg("/", highlight)
    opt.hlsearch = true
end

keymap("n", "<leader>/", ":nohlsearch<CR>", opts)
keymap("n", "<leader>>", function() highlight_word({ exact_match = true }) end, opts)
keymap("n", "<leader>?", function() highlight_word({ exact_match = false }) end, opts)

if not table.unpack then
    table.unpack = unpack
end

local function get_visual_single_line()
    local _, start_line, start_col = table.unpack(vim.fn.getpos('v'))
    local _, end_line, end_col = table.unpack(vim.fn.getpos('.'))

    if start_line ~= end_line then
        return nil
    end

    local from = start_col
    local to = end_col

    if start_col > end_col then
        from = end_col
        to = start_col
    end

    local selection = vim.api.nvim_buf_get_text(0, start_line - 1, from - 1, end_line - 1, to, {})[1]

    selection = string.gsub(selection, "/", "\\/")
    selection = string.gsub(selection, "\r", "")
    selection = string.gsub(selection, "\n", "")

    return selection
end

local function replace_selection()
    local selection = get_visual_single_line()

    if selection == nil then
        print("More than 1 line selected!")
        return
    end

    local command = vim.api.nvim_replace_termcodes(":<C-u>%s/\\V", false, false, true)
    command = command .. selection
    command = command .. vim.api.nvim_replace_termcodes("//gc<LEFT><LEFT><LEFT>", false, false, true)

    fn.feedkeys(command, 'n')
end

keymap("v", "<C-r>", function() replace_selection() end, opts)

local function grep_selection(opts)
    local selection = get_visual_single_line()

    if selection == nil then
        print("More than 1 line selected!")
        return
    end

    if opts.full_word then
        selection = '\\b' .. selection .. '\\b'
    end

    require('telescope.builtin').live_grep({ default_text = selection })
end

keymap("v", "<leader>gw", function() grep_selection({ full_word = false }) end, opts)
keymap("v", "<leader>gwf", function() grep_selection({ full_word = true }) end, opts)
keymap("n", "<leader>lg", function() require('telescope.builtin').live_grep() end, opts)

keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
keymap("n", ">", ">>", opts)
keymap("n", "<", "<<", opts)

keymap("n", "<C-G>", "2<C-G>", opts) -- print the full path of the file. See ':help CTRL-G'

keymap("n", ";", ":", { noremap = true })

keymap("n", "<leader>w", ":w<CR>", opts)                        -- write file

keymap("n", "qw", "<C-W><C-W>", opts)                           -- go to next split
keymap("n", "qW", "<C-W><C-W>:setlocal winwidth=121<CR>", opts) -- go to next split and make it at 121 wide
keymap("n", "QW", "<C-W><C-W>:setlocal winwidth=121<CR>", opts)
keymap("n", "qe", ":tabprev<CR>", opts)
keymap("n", "qr", ":tabnext<CR>", opts)
keymap("n", "<c-t>", ":tabnew<CR>", opts)

-- split navigation
keymap("n", "<C-H>", "<C-W><C-H>", opts)
keymap("n", "<C-J>", "<C-W><C-J>", opts)
keymap("n", "<C-K>", "<C-W><C-K>", opts)
keymap("n", "<C-L>", "<C-W><C-L>", opts)

keymap("i", "<c-f>", "<c-x><c-f>", opts)              -- autocomplete files

keymap("n", "qa", "<C-W>_<C-W><BAR>", opts)           -- maximize current split
keymap("n", "qs", "<C-W><C-W><C-W>_<C-W><BAR>", opts) -- move to next split and maximize it
keymap("n", "qd", "<C-W>=", opts) -- move to next split and maximize it

-- Movement maps
keymap({ "n", "v", "o" }, "H", "^", opts) -- beginning of line
keymap({ "n", "v", "o" }, "L", "g_", opts) -- end of line

keymap({ "n", "v" }, "j", "gj", opts)    -- move in wrapped lines
keymap({ "n", "v" }, "k", "gk", opts)

keymap("n", "Q", "<NOP>", opts)                                                    -- disable Ex mode
keymap("x", "Q", ":normal @q <CR>", opts)                                          -- execute '@q' macro

-- keymap("n", "<F2>", function()
--     -- Toggle line numbers
--     if opt.number:get() then
--         vim.opt["number"] = false
--         vim.opt["relativenumber"] = false
--     else
--         vim.opt["number"] = true
--         vim.opt["relativenumber"] = true
--     end
-- end, opts)
-- keymap("n", "<F3>", ":set cursorline!<CR>", opts)
-- keymap("n", "<F4>", ":set cursorcolumn!<CR>", opts)
-- keymap("n", "<F6>", ":set list!<CR>", opts)

vim.api.nvim_exec([[
function! CloseHiddenBuffers()
    let visible_buffers = {}

    for tab in range(1, tabpagenr('$'))
        for buffer in tabpagebuflist(tab)
            let visible_buffers[buffer] = 1
        endfor
    endfor

    for buffer in range(1, bufnr('$'))
        if bufloaded(buffer) && !has_key(visible_buffers, buffer)
            execute 'bd ' . buffer
        endif
    endfor
endfunction
]], false)

keymap("n", "<leader>cl", ":call CloseHiddenBuffers()<CR>", opts)

keymap("n", "<TAB>", "%", opts)
keymap("n", "<space>", "za", opts)
keymap("n", "<leader>tw", "<cmd>:%s/\\s\\+$//e<CR>", opts)

keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)

-- keymap("n", "<leader>me", ":let @/=expand('%:t')<CR>:Explore<CR>n:nohl<CR>", opts) -- open :Explore with cursor on the current file
keymap("n", "<leader> ", ":NvimTreeFindFile<CR>", opts)

keymap("i", "<c-l>", "<c-x><c-l>", opts)

keymap("n", "<leader>jf", ":%!jq --indent 4<CR>", opts)
keymap("n", "<leader>jg", ":%!gron<CR>", opts)

keymap("n", "<leader>db", ":windo set scrollbind!<CR>", opts)
keymap("n", "<leader>du", ":windo diffupdate<CR>", opts)
-- keymap("n", "<leader>dw", ":windo set diffopt+=iwhite<CR>", opts)
keymap("n", "<leader>dw", ":windo set diffopt+=iwhiteall<CR>", opts)
