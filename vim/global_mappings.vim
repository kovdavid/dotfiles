nnoremap <leader>. :nohl<CR>
nnoremap <leader>> :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>
nnoremap <leader>? :let @/ = expand('<cword>')\|set hlsearch<CR>

" very magic mode for regexes
nnoremap <leader>/ /\v

vnoremap <C-r> :call ReplaceSelection()<CR>
nnoremap <leader>rw viw"hy:s/<C-r>h//g<left><left>

vnoremap > >gv
vnoremap < <gv

nnoremap > >>
nnoremap < <<
nnoremap <leader>db :windo set scrollbind!<CR>
nnoremap <leader>du :windo diffupdate<CR>
nnoremap <leader>dw :windo set diffopt+=iwhite<CR>

" Basic maps
nnoremap ; :
noremap <leader>w :w<CR>
nnoremap qt <C-W><C-C>
nnoremap qw <C-W><C-W>
nnoremap qe :tabprev<CR>
nnoremap qr :tabnext<CR>

vnoremap <leader>jf :!perl -MJSON::XS -e 'my $json = do { local $/; <STDIN> }; print JSON::XS->new()->canonical(1)->pretty(1)->encode(decode_json($json));'<CR>
vnoremap <leader>ujf :!perl -MJSON::XS -e 'my $json = do { local $/; <STDIN> }; print encode_json(decode_json($json))'<CR>
vnoremap <leader>xf :!xmllint --format -<CR>
vnoremap <leader>sf :!sqlformat -r -s -<CR>
vnoremap <leader>pf :!perl -e 'use Data::Dumper; my $lines = do { local $/ = undef; <STDIN> }; print Dumper(eval $lines);'<CR>
vnoremap <c-f> "sy/<C-R>s<CR>

" maximize current split
nnoremap qa <C-W>_<C-W><BAR>
" move to next split and maximize it
nnoremap qs <C-W><C-W><C-W>_<C-W><BAR>

"disable ex-mode; run macros instead
nnoremap Q @q
xnoremap Q :normal @q <CR>

"move to matching brace pair
nnoremap <tab> %

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
