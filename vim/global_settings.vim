if !has('nvim')
    set nocp
    set encoding=utf-8
endif
" set history=999  " history size
" set ttyfast
" set hidden       " hide buffers instead of closing them
" set backspace=indent,eol,start " allow backspace in insert mode
" set errorformat=%f:%l:%m
" set nobackup
set lazyredraw   " don't redraw when executing macros (good performance option)
set noswapfile
set scrolloff=3  " when moving vertically set 3 lines to the cursor
set backspace=indent,eol,start

" set mousehide
set mouse=niv
set number
set relativenumber

set splitbelow
set splitright
set nojoinspaces
set clipboard=unnamedplus,unnamed " add two more registers to clipboard
set iskeyword-=:

set switchbuf=useopen,usetab,newtab
set complete-=i

" Word wrap not in the middle of the word
set formatoptions=l
set linebreak

" fast exiting insert mode; the removes the 1sec delay when not in GUI
" set timeout timeoutlen=1000 ttimeoutlen=1000
" if !has('gui_running')
    " set ttimeoutlen=10
    " augroup FastEscape
        " autocmd!
        " au InsertEnter * set timeoutlen=0
        " au InsertLeave * set timeoutlen=1000
    " augroup END
" endif
set updatetime=300

if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

if isdirectory($VIM_UNDODIR)
    set undodir=$VIM_UNDODIR
    set undofile
endif

if isdirectory($VIM_SWAPDIR)
    set directory=$VIM_SWAPDIR//
    set swapfile
endif

" let g:sh_noisk=1
" set cmdheight=1 "command line size
" set wildmenu    "cmdline completition

set showcmd
set noruler

let mapleader = ","
let maplocalleader = "\\"

" Horizontal split fill chars
set fillchars+=stlnc:-
set fillchars+=stl:-
set fillchars+=vert:\|

" Search
set showmatch
set hlsearch
set incsearch
set ignorecase

" Indents
set autoindent
set copyindent

" Tabs
set shiftwidth=4  " number of spaces for indenting
set tabstop=4     " number of spaces for tabs
set softtabstop=4 " number of spaces for tabs while editing
set shiftround
set modelines=1
set expandtab

set list
set listchars=tab:▸\ ,trail:·

" Statusline
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
" set statusline +=%{fugitive#statusline()} "git branch"
set statusline +=%4*\ %<%-.80f%*        "relative path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

" Gui
set guifont=DejaVu\ Sans\ Mono\ 11
set guioptions=
set guioptions+=a  "autoselect
set guioptions+=e  "tabs
set guioptions+=g  "grey menu items
set guioptions+=i  "vim icon
set guioptions+=t  "tearoff menu items
set guitablabel=%t "show only filename in tabs

set t_Co=256
set colorcolumn=80
if filereadable("/tmp/.Xresources_solarized")
    set background=light
    colorscheme solarized
    highlight CursorLine cterm=NONE ctermbg=253
    highlight ColorColumn guibg=#333333 ctermbg=253
else
    colorscheme zenburn
    highlight CursorLine cterm=NONE ctermbg=239
    highlight ColorColumn guibg=#333333 ctermbg=8
endif

if has('gui_running')
    highlight VertSplit guifg=fg guibg=bg
else
    highlight VertSplit ctermfg=bg ctermbg=fg
endif

highlight Search cterm=underline

set title
set noerrorbells
set showmode

" Diff
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

set nocursorbind
set noscrollbind

" Folding
set foldmethod=indent
set foldlevel=20 " open folds by default
