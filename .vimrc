" follow recipe from
" http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/

set nocompatible
filetype off

set hlsearch
set incsearch





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


" use silver searcher for grep
if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>


" toggle showing end of line chars and tabs with \l in normal mode
nmap <leader>l :set list!<CR>

" for ctrl p
" needs to be installed externally
set runtimepath^=~/.vim/bundle/ctrlp.vim

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Plugin 'scrooloose/nerdcommenter'

"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Powerline setup
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
"set laststatus=2

Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
"Bundle 'ntpeters/vim-better-whitespace'
Bundle 'scrooloose/nerdtree'
map <S-t> :NERDTreeToggle<CR>
" tells nerdtree to come up in split window with focus
"let NERDTreeHijackNetrw=1

" required Vundle install of Solarized
" and
" mv bundle/Solarized/colors/solarized.vim colors/
"set t_Co=256
set background=dark
syntax on
colorscheme wombat

" The bundles you install will be listed here
filetype plugin indent on


augroup vimrc_autocmds
  autocmd!
"  " highlight characters past column 80
  autocmd FileType * highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType * match Excess /\%80v.*/
  autocmd FileType * set nowrap
"  autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
"  autocmd FileType python match Excess /\%120v.*/
"  autocmd FileType python set nowrap
augroup END
"
"autocmd FileType js,java,php,py autocmd BufWritePre <buffer> StripWhitespace

set ru
highlight LineNr ctermfg=Black ctermbg=DarkGrey
set number


"function! <SID>StripTrailingWhitespaces()
"    " Preparation: save last search, and cursor position.
"    let _s=@/
"    let l = line(".")
"    let c = col(".")
"    " Do the business:
"    %s/\s\+$//e
"    " Clean up: restore previous search history, and cursor position
"    let @/=_s
"    call cursor(l, c)
"endfunction
""autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

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

" highlight trailing space by adding to Todo group
match Todo /\s\+$/





