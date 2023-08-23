set lazyredraw
set switchbuf=useopen,usetab,newtab

" Horizontal split fill chars
set fillchars+=stlnc:-
set fillchars+=stl:-
set fillchars+=vert:\|


" Word wrap not in the middle of the word
set formatoptions=l

if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Indents
set autoindent
set copyindent

nnoremap <leader>/ /\v

set showmode


nnoremap <leader>db :windo set scrollbind!<CR>
nnoremap <leader>du :windo diffupdate<CR>
nnoremap <leader>dw :windo set diffopt+=iwhite<CR>

nnoremap qt <C-W><C-C>


nnoremap ds<space> F<space>xf<space>x

"move to matching brace pair
nnoremap <tab> %


set t_Co=256
if has('gui_running')
    highlight VertSplit guifg=fg guibg=bg
else
    highlight VertSplit ctermfg=bg ctermbg=fg
endif

highlight Search cterm=underline

" Diff
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
