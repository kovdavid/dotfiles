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

    nnoremap <c-z> :action ToggleDistractionFreeMode<CR>
    nnoremap <leader>h :action HideActiveWindow<CR>
    nnoremap <leader>se :action ShowErrorDescription<CR>
    nnoremap <leader>sd :action QuickJavaDoc<CR>
    nnoremap <leader>sa :action ShowIntentionActions<CR>
    nnoremap <leader>to :action ActivateTerminalToolWindow<CR>
    nnoremap <leader>tt :action Terminal.OpenInTerminal<CR>
    nnoremap <C-W>r :action MoveEditorToOppositeTabGroup<CR>
    nnoremap <leader>n :action ShowNavBar<CR>
    nnoremap <leader>cc :action CommentByLineComment<CR>
    vnoremap <leader>cc :action CommentByLineComment<CR>
    nnoremap <leader>cu :action CommentByLineComment<CR>
    vnoremap <leader>cu :action CommentByLineComment<CR>
    nnoremap <leader>p :action ActivateProjectToolWindow<CR>
    nnoremap <leader>gd :action GotoDeclaration<CR>
    nnoremap <leader>gi :action GotoImplementation<CR>
    nnoremap <leader>fu :action FindUsages<CR>
    nnoremap <c-o> :action Back<CR>
    nnoremap <leader>ogh :action Github.Open.In.Browser<CR>
    nnoremap <leader>z :action MaximizeEditorInSplit<CR>
    nnoremap <leader>ff :action ShowReformatFileDialog<CR>
endif

if has("ide")
    noremap <leader>ss :source ~/.ideavimrc<CR>
else
    noremap <leader>se :tabnew $MYVIMRC<CR>
    noremap <leader>ss :source $MYVIMRC<CR>
endif
noremap <leader>sl :execute getline(".")<CR>
