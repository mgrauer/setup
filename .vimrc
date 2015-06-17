set nocompatible
filetype off
   

set hlsearch
set incsearch

let mapleader = "\<Space>"
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>t :tabe<CR>




" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
   let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
   if l:tabstop > 0
       let &l:sts = l:tabstop
       let &l:ts = l:tabstop
       let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction

function! SummarizeTabs()
    try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon ' shiftwidth='.&l:sw
        echon ' softtabstop='.&l:sts
        if &l:et
            echon ' expandtab'
        else
            echon ' noexpandtab'
        endif
    finally
        echohl None
    endtry
endfunction

" tabs turn into spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" use F2 (fn + f2) to toggle paste/nopaste, preserves spacing for copy/paste
" from system clipboard
noremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode


set background=dark
syntax on
colorscheme wombat256mod


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" requidarkgreen!
Plugin 'gmarik/vundle'

Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " requidarkgreen
filetype plugin indent on    " requidarkgreen


augroup vimrc_autocmds
  autocmd!
"  " highlight characters past column 80
  autocmd FileType * highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType * match Excess /\%80v.*/
  autocmd FileType * highlight ExtraWhite ctermbg=DarkGreen guibg=DarkGreen
  autocmd FileType * match ExtraWhite /\s\+$/
  autocmd FileType * set nowrap
augroup END

set ru
highlight LineNr ctermfg=Black ctermbg=DarkGrey
set number



function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" strip trailing whitespace
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" what does this do exactly? preserve indentation?
nmap _= :call Preserve("normal gg=G")<CR>
" map strip trailing whitespace to F5
autocmd BufWritePre *.py,*.js call Preserve("%s/\\s\\+$//e")
nnoremap <silent> <F5> :call  Preserve("%s/\\s\\+$//e")<CR>


" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
