" vimrc by Davs

" >>>> plugins.vim
call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-rooter'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-abolish'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-endwise'
Plug 'junkblocker/git-time-lapse'
Plug 'benekastah/neomake'
Plug 'kovdavid/vim_test_runner', { 'for': 'perl' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ton/vim-alternate'
Plug 'dense-analysis/ale', { 'for': 'python' }
Plug 'morhetz/gruvbox'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" <<<< plugins.vim

" >>>> global_settings.vim

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

set nocursorbind
set noscrollbind

" Folding
" <<<< global_settings.vim

" >>>> global_mappings.vim
" very magic mode for regexes

nnoremap <leader>rw viw"hy:s/<C-r>h//g<left><left>

vnoremap <leader>jf  :!perl -MJSON::PP -E 'my $json = do { local $/; <STDIN> }; print JSON::PP->new()->utf8(1)->canonical(1)->pretty(1)->indent_length(4)->encode(decode_json($json));'<CR>
vnoremap <leader>ujf :!perl -MJSON::XS -E 'my $json = do { local $/; <STDIN> }; print encode_json(decode_json($json))'<CR>
vnoremap <leader>xf :!xmllint --format -<CR>
vnoremap <leader>sf :!sqlformat -r -s -<CR>
vnoremap <leader>pf :!perl -e 'use Data::Dumper; my $lines = do { local $/ = undef; <STDIN> }; print Dumper(eval $lines);'<CR>
vnoremap <c-f> "sy/<C-R>s<CR>

nnoremap <leader>me :let @/=expand("%:t")<CR>:Explore<CR>n:nohl<CR>

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

nnoremap <leader>tw :%s/\s\+$//e<CR>

" move to the top/middle/bottom of the screen
nnoremap gt :normal! H<CR>
nnoremap gb :normal! L<CR>
nnoremap gm :normal! M<CR>

noremap ZZ <c-w>_ \| <c-w>\|
noremap Zz <c-w>=
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
if has("ide")
    nnoremap <leader>, :action GotoFile<CR>
else
    nnoremap <leader>, :CtrlP<CR>
endif

" Clever-f
let g:clever_f_across_no_line = 0

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
" }}}
