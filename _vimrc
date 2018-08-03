" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if has("win32")
    " important source includes
    source $VIMRUNTIME/mswin.vim

    " unmap mswin mappings
    " windows uses ~/vimfiles but I like ~/.vim better
    set rtp+=~/.vim

    unmap <C-Z>
    " opened an unneeded search dialog
    unmap <C-F>
    iunmap <C-F>
    cunmap <C-F>
    " opened an unneeded replace dialog
    unmap <C-H>
    iunmap <C-H>
    cunmap <C-H>
endif

if has("vms")
   set nobackup		" do not keep a backup file, use versions instead
else
   set backup		" keep a backup file
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
   set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
   syntax on
   set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

   " Enable file type detection.
   " Use the default filetype settings, so that mail gets 'tw' set to 72,
   " 'cindent' is on in C files, etc.
   " Also load indent files, to automatically do language-dependent indenting.
   filetype plugin indent on

   " Put these in an autocmd group, so that we can delete them easily.
   augroup vimrcEx
      au!

      " For all text files set 'textwidth' to 78 characters.
      autocmd FileType text setlocal textwidth=100

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      " Also don't do it when the mark is in the first line, that is the default
      " position when opening a file.
      autocmd BufReadPost *
               \ if line("'\"") > 1 && line("'\"") <= line("$") |
               \   exe "normal! g`\"" |
               \ endif

   augroup END

endif " has("autocmd")


" My new _vimrc
""""""""""""""""


" alternatively, pass a path where vim-plug should install plugins
call plug#begin('~/.vim/bundle')

" plugin on GitHub repo
Plug 'junegunn/vim-plug'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Quramy/tsuquyomi'
Plug 'othree/html5.vim'
Plug 'leafgarland/typescript-vim'
Plug 'alvan/vim-closetag'
Plug 'dzeban/vim-log-syntax'
Plug 'skywind3000/asyncrun.vim'
Plug 'LukasKraushofer/todo.txt-vim'

" All of your Plugins must be added before the following line
call plug#end()

" configurations
"""""""""""""""""
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time; also in vim-sensible
set showcmd		" display incomplete commands
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set encoding=utf-8 " also in vim-sensible
set scrolloff=2
set autoindent " also in vim-sensible
" set showmode
set hidden
set wildmenu " also in vim-sensible
set wildmode=list:full
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
set visualbell " stops vim beeping on errors
set cursorline
set ttyfast
set backspace=indent,eol,start " allow backspacing over everything in insert mode " also in vim-sensible
set laststatus=2 " also in vim-sensible
"set undofile
"set relativenumber
set number
set ignorecase
set smartcase
set incsearch " also in vim-sensible
set showmatch
set hlsearch
set wrap linebreak 
set list listchars=tab:>-,trail:˛,nbsp:·
" :hi SpecialKey guifg=lightgrey
set showbreak=>>
set colorcolumn=0
set textwidth=89
set formatoptions=qrn1j
set omnifunc=syntaxcomplete#Complete

set switchbuf=usetab

set backupdir-=.
set backupdir^=$TEMP

set directory-=.

" gui settings
set guioptions=acgR
set guifont=Anonymous_Pro:h11:cANSI
" set guifont=Source_Code_pro:h10:cANSI:qDRAFT
set columns=120
set lines=45
color desert

function MyDiff()
   let opt = '-a --binary '
   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
   let arg1 = v:fname_in
   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
   let arg2 = v:fname_new
   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
   let arg3 = v:fname_out
   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
   let eq = ''
   if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
         let cmd = '""' . $VIMRUNTIME . '\diff"'
         let eq = '"'
      else
         let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
   else
      let cmd = $VIMRUNTIME . '\diff'
   endif
   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
set diffexpr=MyDiff()

" plugin configurations
""""""""""""""""""""""""
" vim-closetag.vim
let g:closetag_filenames = "*.html, *.xhtml, *.xml"

" netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_preview = 1
let g:netrw_winsize = 25

" CtrlP
let g:ctrlp_custom_ignore = {
         \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|target)',
         \ 'file': '\v\.(exe|so|dll)$'
         \ }

" Nerd Commenter
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCustomDelimiters = {
   \ 'typescript': { 'left': '// ' },
   \ 'javascript': { 'left': '// ' }
\ }

" autocmd FileType javascript JsPreTmpl html
" autocmd FileType typescript syn clear foldBraces

" tsuquyomi
if has("balloon_eval")
   set ballooneval
   autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()
endif
let g:tsuquyomi_shortest_import_path=1
let g:tsuquyomi_single_quote_import=1

" key mappings
"""""""""""""""
" change mapleader to "ö"
let mapleader="ö"
let maplocalleader="ö"

":clear last highlighted search
nnoremap <esc> :noh<return><esc>

" Don't use Ex mode, use Q for formatting
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" navigate in quickfix
nnoremap <F11> :cprev<return>
nnoremap <F12> :cnext<return>

" Easy Expand of the Active File Directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Formatting all the lines
noremap <S-C-L> :silent FormatFile<return>

" gVim key mappings
nnoremap <C-Tab> <C-^>

" CtrlP key mappings
nmap <F3> :CtrlP .<CR>

" NERDTree Mappings
nnoremap <F4> :NERDTree<CR>
nnoremap <F5> :NERDTreeFind<CR>

" tsuquyomi shortcuts
nnoremap <Leader>d :TsuDefinition<return>
nnoremap <Leader>b :TsuGoBack<return>
nnoremap <Leader>r :TsuReferences<return>
nnoremap <Leader>q :TsuQuickFix<return>

