" ******************************************************
" *                                                    *
" *formatFile.vim                                      *
" ******************************************************
" *                                                    *
" *formats all the code                                *
" *                                                    *
" ******************************************************

fu! s:FormatFile()
   let a:cursor_pos = getpos(".")
   normal gg=G
   :call setpos('.', a:cursor_pos)
endfunction

command! FormatFile call s:FormatFile()
