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
