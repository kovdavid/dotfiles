function! NewPerlModule()
    0r ~/.vim/skeleton/perl.package
    let l:path = expand('%:p')
    let l:path = substitute(l:path, '^.*/\(lib\|t\)/', '', '')
    let l:path = substitute(l:path, '.pm$', '', '')
    let l:module_name = substitute(l:path, '/', '::', 'g')
    execute "normal! ggwi".l:module_name
endfunction

function! NewGoFile()
    0r ~/.vim/skeleton/go.script
    let l:module = expand('%:h:t')
    execute "normal! ggwi".l:module
endfunction

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

    execute "NERDTree | NERDTreeToggle"
endfunction

function! DeleteFile()
    let l:path = expand('%:p')
    let l:confirm = input('Delete '.l:path.'? [YES]: ')
    if l:confirm ==# 'YES'
        call delete(l:path) | bdelete!
    endif
endfunction

function! CommitPerlFiles()
    let l:path = expand("%")
    let l:git_rev = system("git rev-parse --abbrev-ref HEAD 2>/dev/null")

    if l:path =~# '\v^(bin|lib|t)\/.+(pl|pm|t)?$'
        let l:path = substitute(l:path, '\v(bin|lib|t)/', '', '')
        let l:path = substitute(l:path, '\/', '::', 'g')

        execute "normal! :Gwrite \<BAR> Gcommit\<CR>A".l:path." - "
    else
        execute "normal! :let @f=expand('%:t:r')\<CR>:Gwrite \<BAR> Gcommit\<CR>O\<C-R>f - \<space>"
    endif

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

function! ToggleLineNumbers()
    if &number
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif
endfunction

function! PerlOpenModule(type)
    " t s v
    let l:line = line(".")
    let l:col = col(".")
    let l:file = expand("%:p")

    let l:cmd = "/home/davs/bin/perl_find_module.pl " . l:file . " " . l:line . " " . l:col . " " . a:type
    let l:result = system(l:cmd)
    let l:result = substitute(l:result, '\n\+$', '', '')
    if strlen(l:result) > 10
        let l:tokens = split(l:result, "\t")
        if a:type == 1
            execute "tabnew " . l:tokens[0]
        elseif a:type == 2
            execute "split " . l:tokens[0]
        elseif a:type == 3
            execute "vsplit " . l:tokens[0]
        else
            execute "e " . l:tokens[0]
        endif
        execute l:tokens[1]
    endif
endfunction
