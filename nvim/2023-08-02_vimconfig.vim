" vimrc by Davs

" >>>> plugins.vim
call plug#begin()

Plug 'rhysd/clever-f.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-abolish'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-endwise'
Plug 'junkblocker/git-time-lapse'
Plug 'benekastah/neomake'
Plug 'kovdavid/vim_test_runner', { 'for': 'perl' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Plug 'fatih/vim-go'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'elixir-editors/vim-elixir'
" Plug 'mhinz/vim-mix-format'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ton/vim-alternate'
Plug 'dense-analysis/ale', { 'for': 'python' }
Plug 'morhetz/gruvbox'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" <<<< plugins.vim

" >>>> global_settings.vim
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

if has("ide")
    set ideajoin
endif

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

set colorcolumn=120

set title
set noerrorbells
set showmode

set nocursorbind
set noscrollbind

" Folding
set foldmethod=indent
set foldlevel=20 " open folds by default
" <<<< global_settings.vim

" >>>> global_functions.vim
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

function! ReplaceSelection() range
    let l:line_no = line("'>") - line("'<") + 1
    if l:line_no == 1
        try
            let a_save = @a
            normal! gv"ay
            let l:escaped = escape(@a, '\/')
            let l:escaped = substitute(l:escaped, "\r", '', '')
            let l:escaped = substitute(l:escaped, "\n", '', '')
            call feedkeys(":\<c-u>%s/\\V".l:escaped."//gc\<LEFT>\<LEFT>\<LEFT>", 'n')
        finally
            let @a = a_save
        endtry
    else
        echo "More than 1 line selected!"
    endif
endfunction

function! GrepSelection() range
    let l:line_no = line("'>") - line("'<") + 1
    if l:line_no == 1
        try
            let a_save = @a
            normal! gv"ay
            let l:escaped = escape(@a, '\/')
            let l:escaped = substitute(l:escaped, "\r", '', '')
            let l:escaped = substitute(l:escaped, "\n", '', '')
            call feedkeys(":\<c-u>!grep -r '".l:escaped."' .", 'n')
        finally
            let @a = a_save
        endtry
    else
        echo "More than 1 line selected!"
    endif
endfunction

function! AgSelection() range
    let l:line_no = line("'>") - line("'<") + 1
    if l:line_no == 1
        try
            let a_save = @a
            normal! gv"ay
            let l:escaped = escape(@a, '\/')
            let l:escaped = substitute(l:escaped, "\r", '', '')
            let l:escaped = substitute(l:escaped, "\n", '', '')
            call feedkeys(":\<c-u>Ag ".l:escaped."", 'n')
        finally
            let @a = a_save
        endtry
    else
        echo "More than 1 line selected!"
    endif
endfunction

function! ToggleLineNumbers()
    if &number
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif
endfunction
" <<<< global_functions.vim
" >>>> global_mappings.vim
nnoremap <leader>. :nohl<CR>
nnoremap <leader>> :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>
nnoremap <leader>? :let @/ = expand('<cword>')\|set hlsearch<CR>

" very magic mode for regexes
nnoremap <leader>/ /\v

vnoremap <C-r> :call ReplaceSelection()<CR>
vnoremap <leader>gp :call GrepSelection()<CR>
vnoremap <leader>ag :call AgSelection()<CR>
nnoremap <leader>rw viw"hy:s/<C-r>h//g<left><left>

vnoremap > >gv
vnoremap < <gv

nnoremap > >>
nnoremap < <<
nnoremap <leader>db :windo set scrollbind!<CR>
nnoremap <leader>du :windo diffupdate<CR>
nnoremap <leader>dw :windo set diffopt+=iwhite<CR>

nnoremap <C-G> 2<C-G>

" Basic maps
nnoremap ; :
noremap <leader>w :w<CR>
nnoremap qt <C-W><C-C>
nnoremap qw <C-W><C-W>
nnoremap qW <C-W><C-W>:setlocal winwidth=121<CR>
nnoremap QW <C-W><C-W>:setlocal winwidth=121<CR>
nnoremap qe :tabprev<CR>
nnoremap qr :tabnext<CR>

vnoremap <leader>jf  :!perl -MJSON::PP -E 'my $json = do { local $/; <STDIN> }; print JSON::PP->new()->utf8(1)->canonical(1)->pretty(1)->indent_length(4)->encode(decode_json($json));'<CR>
vnoremap <leader>ujf :!perl -MJSON::XS -E 'my $json = do { local $/; <STDIN> }; print encode_json(decode_json($json))'<CR>
vnoremap <leader>xf :!xmllint --format -<CR>
vnoremap <leader>sf :!sqlformat -r -s -<CR>
vnoremap <leader>pf :!perl -e 'use Data::Dumper; my $lines = do { local $/ = undef; <STDIN> }; print Dumper(eval $lines);'<CR>
vnoremap <c-f> "sy/<C-R>s<CR>

nnoremap <leader>me :let @/=expand("%:t")<CR>:Explore<CR>n:nohl<CR>

" maximize current split
nnoremap qa <C-W>_<C-W><BAR>
" move to next split and maximize it
nnoremap qs <C-W><C-W><C-W>_<C-W><BAR>

"disable ex-mode; run macros instead
nnoremap Q @q
xnoremap Q :normal @q <CR>

"move to matching brace pair
nnoremap <tab> %

" Coc.vim
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

inoremap <c-f> <c-x><c-f>

nnoremap ds<space> F<space>xf<space>x

nnoremap <leader>tw :%s/\s\+$//e<CR>
" Movement maps
" H beginning of line; L end of line
nnoremap H ^
nnoremap L g_

vnoremap H ^
vnoremap L g_

onoremap H ^
onoremap L g_

" j/k move in wrapped lines too
nnoremap j gj
nnoremap k gk

vnoremap j gj
vnoremap k gk

" move to the top/middle/bottom of the screen
nnoremap gt :normal! H<CR>
nnoremap gb :normal! L<CR>
nnoremap gm :normal! M<CR>

" Row/column highlight
noremap <F2> :call ToggleLineNumbers()<CR>
noremap <F3> :set cursorline!<CR>
noremap <F4> :set cursorcolumn!<CR>
noremap <F6> :set list!<CR>
noremap <F7> :GitGutterToggle<CR>

noremap <c-t> :tabnew<CR>

nnoremap <leader>cl :call CloseHiddenBuffers()<CR>

nnoremap <space> za

noremap ZZ <c-w>_ \| <c-w>\|
noremap Zz <c-w>=

if has("ide")
    sethandler <C-W>r a:vim
    set NERDTree

    nnoremap g; :action JumpToLastChange<CR>
    nnoremap <C-W>r :action MoveEditorToOppositeTabGroup<CR>
    nnoremap <c-o> :action Back<CR>
    nnoremap <c-e> :action RecentFiles<CR>
    nnoremap <c-z> :action ToggleDistractionFreeMode<CR>
    nnoremap <leader>, :action GotoClass<CR>
    nnoremap <leader>ar :action ActivateRunToolWindow<CR>
    nnoremap <leader>at :action ActivateTerminalToolWindow<CR>
    nnoremap <leader>cc :action CommentByLineComment<CR>
    nnoremap <leader>cu :action CommentByLineComment<CR>
    nnoremap <leader>ff :action ShowReformatFileDialog<CR>
    nnoremap <leader>fu :action FindUsages<CR>
    nnoremap <leader>gd :action GotoDeclaration<CR>
    nnoremap <leader>gi :action GotoImplementation<CR>
    nnoremap <leader>gt :action GotoTypeDeclaration<CR>
    nnoremap <leader>ge :action GotoNextError<CR>
    nnoremap <leader>ha :action HideActiveWindow<CR>
    nnoremap <leader>ht :action HideAllWindows<CR>
    nnoremap <leader>n :action ShowNavBar<CR>
    nnoremap <leader>ogh :action Github.Open.In.Browser<CR>
    nnoremap <leader>oi :action OptimizeImports<CR>
    nnoremap <leader>p :action ActivateProjectToolWindow<CR>
    nnoremap <leader>rr :action Rerun<CR>
    nnoremap <leader>sa :action ShowIntentionActions<CR>
    nnoremap <leader>sd :action QuickJavaDoc<CR>
    nnoremap <leader>se :action ShowErrorDescription<CR>
    nnoremap <leader>sr :action Refactorings.QuickListPopupAction<CR>
    nnoremap <leader>tt :action Terminal.OpenInTerminal<CR>
    nnoremap <leader>z :action MaximizeEditorInSplit<CR>
    nnoremap <space> :action ExpandCollapseToggleAction<CR>
    vnoremap <leader>cc :action CommentByLineComment<CR>
    vnoremap <leader>cu :action CommentByLineComment<CR>

endif

if has("ide")
    noremap <leader>ss :source ~/.ideavimrc<CR>
else
    noremap <leader>se :tabnew $MYVIMRC<CR>
    noremap <leader>ss :source $MYVIMRC<CR>
endif
noremap <leader>sl :execute getline(".")<CR>
" <<<< global_mappings.vim
" >>>> plugin_settings.vim
" Tabularize
vnoremap <leader>ah :Tabularize /^.\{-}\zs=>/l1l1<CR>
vnoremap <leader>a= :Tabularize /^.\{-}\zs=\(>\)\@!/l1l1<CR>
vnoremap <leader>a, :Tabularize /^.\{-}\zs,/l1l1<CR>
vnoremap <leader>aa :Tabularize /
vnoremap <leader>af :Tabularize /^.\{-}\zs/l1l1<left><left><left><left><left>

nnoremap <leader>ah :Tabularize /^.\{-}\zs=>/l1l1<CR>
nnoremap <leader>a= :Tabularize /^.\{-}\zs=\(>\)\@!/l1l1<CR>
nnoremap <leader>a, :Tabularize /^.\{-}\zs,/l1l1<CR>
nnoremap <leader>aa :Tabularize /
nnoremap <leader>af :Tabularize /^.\{-}\zs/l1l1<left><left><left><left><left>

" CtrlP
if executable('fd')
    let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
    let g:ctrlp_use_caching = 0
    let g:ctrlp_match_window_reversed = 0
endif
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_regexp = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v(\.git|venv|deps|_build)',
            \ 'file': '\v(__init2__\.py|\.pyc)$',
            \ }

if has("ide")
    nnoremap <leader>, :action GotoFile<CR>
else
    nnoremap <leader>, :CtrlP<CR>
endif

" Clever-f
let g:clever_f_across_no_line = 0

" Rooter
let g:rooter_patterns = [ '.vimproject', '.git/' ]
let g:rooter_manual_only = 0
let g:rooter_change_directory_for_non_project_files = 1

" snippets
let g:snips_author = "Dávid Kovács"
let g:snips_email = "kovdavid@gmail.com"
let g:snips_github = "http://github.com/kovdavid"

" NERDCommenter
let g:NERDRemoveExtraSpaces = 1
let g:NERDSpaceDelims = 1

" delimitMate
let g:delimitMate_expand_cr = 0
let g:delimitMate_expand_space = 1
let g:delimitMate_quotes = "\" '"

let g:coc_disable_startup_warning = 1

" JavaScript - 'coc-tsserver', 'coc-eslint', 'coc-prettier',
" Python - 'coc-pyright
let g:coc_global_extensions = [
    \ 'coc-jedi',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-prettier',
    \ 'coc-rust-analyzer',
    \ ]

let g:AlternateExtensionMappings = [{'.cpp' : '.h', '.h' : '.ino', '.ino' : '.cpp'}, {'.c': '.h', '.h': '.c'}]
" <<<< plugin_settings.vim
" >>>> colors.vim
set background=dark
colorscheme zenburn
highlight CursorLine cterm=NONE ctermbg=239
highlight ColorColumn guibg=#333333 ctermbg=238

" light
" set background=light
" colorscheme gruvbox
" highlight TabLineSel ctermfg=229 ctermbg=66
" <<<< colors.cim

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

" Fix Coc autocomplete popup not highlighted
highlight! link CocFloating CocHintFloat

" Filetype {{{
" EveryFile {{{
augroup all_file_type
    autocmd!

    autocmd WinEnter,FocusGained,BufEnter * setlocal relativenumber | setlocal number
    autocmd WinLeave,FocusLost,BufLeave * setlocal norelativenumber | setlocal number
    autocmd BufWritePre * %s/\s\+$//e

    autocmd BufEnter * silent execute ":Rooter"

    " Turn off syntax syncing for large files
    autocmd BufEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    autocmd WinEnter,FocusGained,BufEnter * if &diff | setlocal winwidth=1 | setlocal wrap | setlocal nocursorbind | endif
    autocmd WinEnter,FocusGained,BufEnter * if !&diff | setlocal winwidth=1 | endif

    autocmd Syntax * highlight SpecialKey ctermfg=240 gui=bold guifg=#5b605e
    autocmd Syntax * highlight NonText ctermfg=240 gui=bold guifg=#5b605e

    autocmd BufEnter * let &titlestring = $USER."@".hostname().":".expand("%:p")

    autocmd BufRead,BufNewFile *.xml.sample  setfiletype xml
    autocmd BufRead,BufNewFile *.sls setfiletype yaml
augroup END
" }}}
" golang {{{
augroup filetype_golang
    autocmd!
    autocmd FileType go setlocal shiftwidth=4
    autocmd FileType go setlocal tabstop=4
    autocmd FileType go setlocal softtabstop=4

    autocmd BufRead,BufNewFile *.go if line('$') == 1 && getline('.') == '' | call NewGoFile() | endif
    autocmd BufWritePost *.go Neomake

    autocmd FileType go nnoremap <buffer> <leader>dd o<ESC>ifmt.Printf("%+v\n", )<LEFT>
    autocmd FileType go nnoremap <buffer> <leader>de o<ESC>ifmt.Printf("%+v\n")<CR>os.Exit(1)<ESC>:GoImports<CR>k$i,

    autocmd FileType go let g:go_fmt_command = "goimports"
    autocmd FileType go let g:go_def_mode = "gopls"
    autocmd FileType go let g:go_info_mode = "gopls"
    autocmd FileType go let g:go_fmt_autosave = 1
    autocmd FileType go let g:go_fmt_fail_silently = 1

    autocmd FileType go let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
    autocmd FileType go let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
    autocmd FileType go let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
    autocmd FileType go let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
    autocmd FileType go let g:neomake_go_enabled_makers = [ 'go' ]

    autocmd FileType go noremap <buffer> <leader>rr :!go run %<CR>
    autocmd FileType go noremap <buffer> <leader>i :GoInfo<CR>
    autocmd FileType go noremap <buffer> <leader>d :GoDef<CR>
    autocmd FileType go noremap <buffer> <leader>b :GoBuild -i<CR>
    autocmd FileType go noremap <buffer> <leader>ts :GoInstall<CR>
    autocmd FileType go noremap <buffer> <leader>gi :GoImports<CR>
    autocmd FileType go noremap <buffer> <leader>tf :GoTestFunc<CR>
    autocmd FileType go noremap <buffer> <leader>ta :GoTest<CR>
    autocmd FileType go noremap <buffer> <leader>aa :GoAlternate<CR>

    autocmd FileType go noremap <buffer> <leader>ger oif err != nil {<CR>return err<CR>}
    autocmd FileType go noremap <buffer> <leader>gel oif err != nil {<CR>log.Fatal(err)<CR>}
    autocmd FileType go noremap <buffer> <leader>get oif err != nil {<CR>t.Fatal(err)<CR>}
    autocmd FileType go noremap <buffer> <leader>gep oif err != nil {<CR>panic("")<CR>}<ESC>k$<LEFT><LEFT>i
augroup END
" }}}
" Perl {{{
augroup filetype_perl
    autocmd!
    autocmd BufRead,BufNewFile *.pm  setfiletype perl
    autocmd BufRead,BufNewFile *.pl  setfiletype perl
    autocmd BufRead,BufNewFile *.t   setfiletype perl

    autocmd BufNewFile *.pl 0r ~/.vim/skeleton/perl.script
    autocmd BufNewFile *.t 0r ~/.vim/skeleton/perl.test

    autocmd BufRead,BufNewFile *.pm if line('$') == 1 && getline('.') == '' | call NewPerlModule() | endif

    autocmd BufRead,BufNewFile *.pm  setlocal filetype=perl
    autocmd BufRead,BufNewFile *.pl  setlocal filetype=perl
    autocmd BufRead,BufNewFile *.t   setlocal filetype=perl

    autocmd FileType perl setlocal iskeyword-=:

    autocmd FileType perl setlocal nowrap

    autocmd FileType perl syn region perlSubFold start="^\z(\s*\)\<subtest\>.*[^};]$" end="^\z1};\s*$" transparent fold keepend
    autocmd FileType perl syn region perlSubFold start="^\z(\s*\)\<txn_subtest\>.*[^};]$" end="^\z1};\s*$" transparent fold keepend
    autocmd FileType perl hi Statement ctermfg=14

    autocmd FileType perl nnoremap <buffer> <leader>dd <ESC>ause v5.10;<CR>use Data::Dumper;<CR>local $Data::Dumper::Sortkeys = 1;<CR>local $Data::Dumper::Terse = 0;<CR>local $Data::Dumper::Indent = 2;<CR>local $Data::Dumper::Maxdepth = 2;<CR>say STDERR Dumper();<CR>exit;<UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
    autocmd FileType perl nnoremap <buffer> <leader>dt <ESC>ause v5.10;<CR>use Data::Dumper;<CR>local $Data::Dumper::Terse = 1;<CR>local $Data::Dumper::Indent = 0;<CR>local $Data::Dumper::Sortkeys = 1;<CR>local $Data::Dumper::Maxdepth = 2;<CR>say STDERR Dumper();<LEFT><LEFT>
    autocmd FileType perl nnoremap <buffer> <leader>so <ESC>vapk:sort<CR>

    " (?<!\$|@|%|{)
    autocmd FileType perl nnoremap <buffer> <leader>gu  :let @/=expand("<cword>")<CR>:!grep -rP  '<C-R>=expand("<cword>")<CR>' bin/ lib/ t/<CR>
    autocmd FileType perl nnoremap <buffer> <leader>glu :let @/=expand("<cword>")<CR>:!grep -rlP '<C-R>=expand("<cword>")<CR>' bin/ lib/ t/<CR>
    autocmd FileType perl nnoremap <buffer> <leader>gd  :let @/=expand("<cword>")<CR>:!grep -rP  'sub <C-R>=expand("<cword>")<CR>' bin/ lib/ t/<CR>
    autocmd FileType perl nnoremap <buffer> <leader>gld :let @/=expand("<cword>")<CR>:!grep -rlP 'sub <C-R>=expand("<cword>")<CR>' bin/ lib/ t/<CR>
    autocmd FileType perl nnoremap <buffer> <leader>ga  :let @/=expand("<cword>")<CR>:!grep -rP  '<C-R>=expand("<cword>")<CR>' bin/ lib/ t/<CR>
    autocmd FileType perl nnoremap <buffer> <leader>gla :let @/=expand("<cword>")<CR>:!grep -rlP '<C-R>=expand("<cword>")<CR>' bin/ lib/ t/<CR>
    autocmd FileType perl nnoremap <buffer> <leader>gsc :let @/=expand("<cword>")<CR>:!grep -rP  '<C-R>=expand("<cword>")<CR>\(' bin/ lib/ t/<CR>

    autocmd FileType perl nnoremap <buffer> <leader>rr :!perl -Ilib %<CR>

    vnoremap <leader>pt :!perltidy<CR>
    nnoremap <leader>pt :%!perltidy<CR>

    autocmd FileType perl let g:test_runner_single_command = "perl"
    autocmd FileType perl let g:test_runner_multiple_command = "prove"
    autocmd FileType perl let g:test_runner_test_dir = "t"
    autocmd FileType perl let g:test_runner_test_ext = "t"
    autocmd FileType perl let g:test_runner_code_ext = "pm"

    if len($PERL_TEST_FILE_COMMAND) > 0
        autocmd FileType perl let g:perl_test_file_command = $PERL_TEST_FILE_COMMAND
    endif
    if len($TEST_RUNNER_SINGLE_COMMAND) > 0
        autocmd FileType perl let g:test_runner_single_command = $TEST_RUNNER_SINGLE_COMMAND
    endif
    if len($TEST_RUNNER_MULTI_COMMAND) > 0
        autocmd FileType perl let g:test_runner_multiple_command = $TEST_RUNNER_MULTI_COMMAND
    endif

    autocmd FileType perl nnoremap <buffer> <leader>ts  :!perl -Ilib -c %<CR>
    autocmd FileType perl nnoremap <buffer> <leader>tf  :RunSingleTest<CR>
    autocmd FileType perl nnoremap <buffer> <leader>ta  :RunAllTests<CR>
    autocmd FileType perl nnoremap <buffer> <leader>td  :RunTestsInDir<CR>
    autocmd FileType perl nnoremap <buffer> <leader>tc  :CreateTestFile<CR>
    autocmd FileType perl nnoremap <buffer> <leader>to  :OpenTestDir<CR>
    autocmd FileType perl nnoremap <buffer> <leader>mt  :call PerlOpenModule(1)<CR>
    autocmd FileType perl nnoremap <buffer> <leader>ms  :call PerlOpenModule(2)<CR>
    autocmd FileType perl nnoremap <buffer> <leader>mv  :call PerlOpenModule(3)<CR>
    autocmd FileType perl nnoremap <buffer> <leader>mm  :call PerlOpenModule(4)<CR>
    autocmd FileType perl nnoremap <buffer> <leader>mp  :call PerlOpenModule(5)<CR>

    autocmd FileType perl nnoremap <buffer> <silent> <F1> m`:%!perltidy<CR>g``
    autocmd FileType perl vnoremap <buffer> <silent> <F1> :%!perltidy<CR>


    autocmd FileType perl nnoremap gci :call CommitPerlFiles()<CR>

    autocmd FileType perl nnoremap <buffer> <leader>ps 0f$lviw"hyouse v5.10; say "<C-r>h: $<C-r>h";<ESC>
    autocmd FileType perl nnoremap <buffer> <leader>pd 0f$lviw"hyouse v5.10; use Data::Dumper; local $Data::Dumper::Sortkeys = 1; local $Data::Dumper::Maxdepth = 2;<CR>say "<C-r>h: ".Dumper($<C-r>h);<ESC>
augroup END
" }}}
" vim {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
    autocmd FileType vim setlocal expandtab

    autocmd FileType vim noremap <buffer> <leader>ss  :w<CR>:source %<CR>:e <CR>
    autocmd FileType vim noremap <buffer> <leader>rr  :source %<CR>
augroup END
" }}}
" CursorLine {{{
augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
" }}}
" TypeScript {{{
augroup TypeScript
    autocmd!

    autocmd FileType typescript,typescriptreact setlocal shiftwidth=2
    autocmd FileType typescript,typescriptreact setlocal tabstop=2

    autocmd FileType typescript,typescriptreact setlocal formatprg=prettier\ --parser\ typescript

    autocmd FileType typescript,typescriptreact nnoremap <buffer> <leader>dd <ESC>aconsole.log("\n\n========DAVS");<cr>console.log()<LEFT>
    autocmd FileType typescript,typescriptreact nnoremap <buffer> <leader>df <ESC>aif(typeof window === 'undefined') {<CR>import('fs').then((fs) => {<CR>fs.writeFileSync(`/clean_daily/${XyXyXy}.json`, JSON.stringify(XyXyXy))<CR>// process.exit(1)<CR><BS><BS><BS>})<CR>}<UP><UP><UP><ESC>/XyXyXy<CR>cw

    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END
" }}}
" sh {{{
augroup sh
    autocmd!
    autocmd FileType sh nnoremap <buffer> <leader>rr :!bash %<CR>
augroup END
" }}}
" yaml {{{
augroup yaml
    autocmd!
    autocmd FileType yaml setlocal expandtab
    autocmd FileType yaml setlocal autoindent
    autocmd FileType yaml setlocal tabstop=2
    autocmd FileType yaml setlocal shiftwidth=2
augroup END
" }}}
" jinja {{{
augroup jinja
    autocmd!
    autocmd FileType jinja setlocal expandtab
    autocmd FileType jinja setlocal autoindent
    autocmd FileType jinja setlocal tabstop=2
    autocmd FileType jinja setlocal shiftwidth=2
augroup END
" }}}
" python {{{
augroup python
    autocmd!

    autocmd FileType python setlocal expandtab
    autocmd FileType python setlocal autoindent

    autocmd FileType python nnoremap <buffer> <leader>rr :!env python %<CR>
augroup END
" }}}
" JavaScript {{{
" TypeScript {{{
augroup TypeScript
    autocmd!

    autocmd FileType javascript nnoremap <buffer> <leader>rr :!node %<CR>
augroup END
" }}}
" }}}
