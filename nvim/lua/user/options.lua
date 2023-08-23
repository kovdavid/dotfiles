local options = {
    backup = false,                          -- creates a backup file
    clipboard = "unnamedplus,unnamed",       -- allows neovim to access the system clipboard
    cmdheight = 1,                           -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                  -- the encoding written to a file
    hlsearch = true,                         -- highlight all matches on previous search pattern
    incsearch = true,
    showmatch = true,
    ignorecase = true,                       -- ignore case in search patterns
    mouse = "a",                             -- allow the mouse to be used in neovim
    pumheight = 10,                          -- pop up menu height
    showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,                         -- always show tabs
    smartcase = true,                        -- smart case
    smartindent = true,                      -- make indenting smarter again
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of current window
    swapfile = false,                        -- creates a swapfile
    joinspaces = false,
    termguicolors = true,                    -- set term gui colors (most terminals support this)
    timeoutlen = 1000,                        -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = false,                        -- enable persistent undo
    updatetime = 300,                        -- faster completion (4000ms default)
    writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true,                        -- convert tabs to spaces
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation
    tabstop = 4,                             -- insert 2 spaces for a tab
    softtabstop = 4,
    shiftround = true,
    cursorline = true,                       -- highlight the current line
    number = true,                           -- set numbered lines
    relativenumber = true,                   -- set relative numbered lines
    numberwidth = 4,                         -- set number column width to 2 {default 4}
    showcmd = true,

    signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
    wrap = true,                             -- display lines as one long line
    linebreak = true,                        -- companion to wrap, don't split words
    scrolloff = 3,                           -- minimal number of screen lines to keep above and below the cursor
    sidescrolloff = 3,                       -- minimal number of screen columns either side of cursor if wrap is `false`
    guifont = "monospace:h17",               -- the font used in graphical neovim applications
    whichwrap = "bs<>[]hl",                  -- which "horizontal" keys are allowed to travel to prev/next line

    list = true,
    listchars="tab:▸ ,trail:·",

    colorcolumn = "120",
    title = true,
    errorbells = false,

    cursorbind = false,
    scrollbind = false,

    fillchars = { vert = '│', stlnc = '—'},

    foldmethod = "indent",
    foldlevel = 20,
}

local undodir = os.getenv("VIM_UNDODIR")
if vim.fn.isdirectory(undodir) then
    options["undodir"] = undodir
    options["undofile"] = true
end

local swapdir = os.getenv("VIM_SWAPDIR")
if vim.fn.isdirectory(swapdir) then
    options["directory"] = swapdir .. "//"
    options["swapfile"] = true
end

if vim.fn.has("ide") == 1 then
    options["ideajoin"] = true
end

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.opt.shortmess:append("c")                           -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append("-")                           -- hyphenated words recognized by searches
vim.opt.iskeyword:remove(":")
vim.opt.formatoptions:remove({ "c", "r", "o" })         -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")   -- separate vim plugins from neovim in case vim still in use
