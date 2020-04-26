set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'preservim/nerdtree'
Plugin 'frazrepo/vim-rainbow'
Plugin 'jiangmiao/auto-pairs'
Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'universal-ctags/ctags'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Nerd Tree config
let NERDTreeQuitOnOpen = 1
nmap <silent> <C-f> :NERDTreeToggle<CR>

let g:rainbow_active = 1
set laststatus=2

set updatetime=200

" OTHER CONFIG

syntax on

colorscheme molokai

set shiftwidth=2
set expandtab
set tabstop=2
set number
set tags=tags

set autoindent
set smartindent

imap jj <ESC>

nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv

" Remap commonly used keys
nnoremap <Down> :m .+1<CR>
nnoremap <Up> :m .-2<CR>
inoremap <Down> <Esc>:m .+1<CR>
inoremap <Up> <Esc>:m .-2<CR>
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap <Up> :m '<-2<CR>gv=gv

nnoremap ;w :w<CR>
nnoremap ;wq :wq<CR>
nnoremap ;q :q<CR>
