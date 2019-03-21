" easyescapeplus.vim        Pull out your Escape key!
" Author:               Yu Hou
" Version:              0.2
" ---------------------------------------------------------------------
" Special Thanks to (Yichao Zhou) the author of easyescape.vim


if &cp || exists("g:loaded_easyescape")
    finish
endif
let g:loaded_easyescape = 1
let s:haspy3 = has("python3")

if !exists("g:easyescape_string")
    let g:easyescape_string = "kj"
endif

if !exists("g:easyescape_timeout")
    if s:haspy3
        let g:easyescape_timeout = 100
    else
        let g:easyescape_timeout = 2000
    endif
endif

if !s:haspy3 && g:easyescape_timeout < 2000
    let g:easyescape_timeout = 2000
endif

function! s:EasyescapeSetTimer()
    if s:haspy3
        py3 easyescape_time = default_timer()
    endif
    let s:localtime = localtime()
endfunction

function! s:EasyescapeReadTimer()
    if s:haspy3
        py3 vim.command("let pyresult = %g" % (1000 * (default_timer() - easyescape_time)))
        return pyresult
    endif
    return 1000 * (localtime() - s:localtime)
endfunction


let s:started = 0
function! <SID>EasyescapeMapStart(char)
    let s:started = 1
    call s:EasyescapeSetTimer()
    return a:char
endfunction

function! <SID>EasyescapeMapEnd(char)
    if s:started == 0
        return a:char
    endif
    let s:started = 0

    if s:EasyescapeReadTimer() > g:easyescape_timeout
        call s:EasyescapeSetTimer()
        return a:char
    endif

    let l:line_check_empty = getline(".")
    if l:line_check_empty == "k"
        return s:escape_sequence
    endif

    let l:trimed  = substitute(l:line_check_empty, '^\s*\(.\{-}\)\s*$', '\1', '')
    if l:trimed == "k"
        return "\<BS>" . "\<c-w>" . "\<ESC>"
    else
        return s:escape_sequence
    endif
endfunction

let s:easyescape_start_key = g:easyescape_string[0]
let s:easyescape_end_key = g:easyescape_string[1]
let s:escape_sequence = "\<BS>" . "\<ESC>"
exec "inoremap <expr>" . s:easyescape_start_key . " <SID>EasyescapeMapStart(\"" . s:easyescape_start_key . "\")"
exec "inoremap <expr>" . s:easyescape_end_key . " <SID>EasyescapeMapEnd(\"" . s:easyescape_end_key . "\")"

if s:haspy3
    py3 from timeit import default_timer
    py3 import vim
    call s:EasyescapeSetTimer()
else
    let s:localtime = localtime()
endif

