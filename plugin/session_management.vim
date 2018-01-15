" ******************************************************
" *                                                    *
" *f_session_management.vim                            *
" ******************************************************
" *                                                    *
" *creates a session file when leaving VIM on VimLeave *
" *and restores the created session file on VimEnter   *
" *                                                    *
" ******************************************************

" variables
let s:session_folder=$HOME. '\vimfiles\sessions\last_session.vim'
let s:reading=0

" functions
fu! SaveSess()
    if s:reading
       execute "silent ! del " . s:session_folder . ".reading"
       let s:reading = 0
       execute 'mksession! ' . s:session_folder
    endif
endfunction

fu! RestoreSess()
    if( argc() == 0)
        if filereadable(s:session_folder . '.reading') 
           echo "other instance is already reading the session"

        elseif filereadable(s:session_folder) 
            execute "silent ! copy /b NUL " . s:session_folder . ".reading"
            let s:reading = 1
            execute 'so ' . s:session_folder
            if bufexists(1)
                for l in range(1, bufnr('$'))
                    if bufwinnr(l) == -1
                        exec 'sbuffer ' . l
                    endif
                endfor
            endif
        else
            echo "No session loaded."
        endif
    endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * call RestoreSess()
