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
