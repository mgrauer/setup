" follow recipe from
" http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/

set nocompatible
filetype off

" prefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab



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

Bundle 'scrooloose/nerdtree'
map <S-t> :NERDTreeToggle<CR>



" The bundles you install will be listed here
filetype plugin indent on


augroup vimrc_autocmds
  autocmd!
  " highlight characters past column 120
  autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType python match Excess /\%120v.*/
  autocmd FileType python set nowrap
augroup END
