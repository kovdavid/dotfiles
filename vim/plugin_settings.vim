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

nnoremap <leader>, :CtrlP<CR>

" Clever-f
let g:clever_f_across_no_line = 0

" Rooter
let g:rooter_patterns = [ '.vimproject', '.git/' ]
let g:rooter_manual_only = 0
let g:rooter_change_directory_for_non_project_files = 1

" snippets
let g:snips_author = "David Kovacs [DavsX]"
let g:snips_email = "kovdavid@gmail.com"
let g:snips_github = "http://github.com/DavsX"

" NERDTree
function! NERDTreeFindToggle()
    if &filetype=='nerdtree'
        execute 'NERDTreeClose'
    else
        if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
            execute 'NERDTreeClose'
        else
            execute 'NERDTreeFind'
        endif
    endif
endfunction
nnoremap <F5> :call NERDTreeFindToggle()<CR>

let NERDTreeIgnore = ['\.pyc$']
let NERDTreeChDirMode=0

" Fugitive
nnoremap gst :Gstatus<CR>5j
nnoremap gd :Gvdiff<CR>
nnoremap gci :let @f=expand("%:t:r")<CR>:Gwrite <BAR> Gcommit<CR>O<C-R>f:<space>
nnoremap gca :Gwrite <BAR> Gcommit --amend<CR>ggA

" NERDCommenter
let g:NERDCustomDelimiters = {
            \ 'elixir': { 'left': '#' },
            \ 'haskell': { 'left': '--' },
            \ 'arduino': { 'left': '//' }
            \}
let g:NERDRemoveExtraSpaces = 1
let g:NERDSpaceDelims = 1

" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" vim-go
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" LanguageClient
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio']
    \ }

let g:coc_disable_startup_warning = 1

let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-prettier']
