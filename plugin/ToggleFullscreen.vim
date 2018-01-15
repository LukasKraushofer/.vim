fu! s:ToggleFullscreen()
   if !exists('s:is_fullscreen') || s:is_fullscreen == 0
      let s:is_fullscreen=1
      set lines=1000
      set columns=1000
   elseif s:is_fullscreen == 1
      let s:is_fullscreen=0
      set lines=45 
      set columns=120
  endif
endfunction

command! ToggleFullscreen call s:ToggleFullscreen()

" fast toggle fullscreen
nnoremap <silent> <Leader>f :ToggleFullscreen<CR>

