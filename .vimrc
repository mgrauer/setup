" follow recipe from
" http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/

set nocompatible
filetype off

set hlsearch
" prefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab

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

Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Powerline setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'ntpeters/vim-better-whitespace'
autocmd FileType php,py autocmd BufWritePre <buffer> StripWhitespace
Bundle 'scrooloose/nerdtree'
map <S-t> :NERDTreeToggle<CR>
" tells nerdtree to come up in split window with focus
let NERDTreeHijackNetrw=1

" required Vundle install of Solarized
" and
" mv bundle/Solarized/colors/solarized.vim colors/
set background=dark
colorscheme solarized

" The bundles you install will be listed here
filetype plugin indent on


augroup vimrc_autocmds
  autocmd!
  " highlight characters past column 120
  autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType python match Excess /\%120v.*/
  autocmd FileType python set nowrap
augroup END
