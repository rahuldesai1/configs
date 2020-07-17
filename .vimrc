set nocompatible              " be iMproved, required
filetype off                  " required

if has('python3')
endif

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ycm-core/YouCompleteMe'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-fugitive'

call plug#end()

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>
let g:lsp_virtual_text_enabled = 0
let g:lsp_highlights_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_hint = {'text': 'H'}

" go-pls
autocmd FileType go nmap gb  <Plug>(go-build)
autocmd FileType go nmap gr  <Plug>(go-run)
let g:go_version_warning = 0
let g:go_fmt_command = "goimports"

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Nerd Tree config
let NERDTreeQuitOnOpen = 1
nmap <silent> <C-f> :NERDTreeToggle<CR>

let g:rainbow_active = 1
set laststatus=2

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
nnoremap :Q :q<CR>

nnoremap bb <C-O>
