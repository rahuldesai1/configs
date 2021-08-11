set nocompatible              " be iMproved, required
filetype off                  " required

if has('python3')
endif

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

" Navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'

" Dev Keybindings
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Smooth Scrolling
Plug 'psliwka/vim-smoothie'

" Git
Plug 'tpope/vim-fugitive'
Plug 'itchyny/vim-gitbranch'

Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Linting
Plug 'dense-analysis/ale'

" Completion
Plug 'neoclide/coc.nvim', {'for': ['javascript', 'go', 'json',  'yaml', 'python', 'vim', 'java'], 'branch': 'release'}

" Python
Plug 'sillybun/vim-repl'

call plug#end()

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let b:ale_linters = {'javascript': ['eslint']}
let g:ale_disable_lsp = 1

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

" go-pls
autocmd FileType go nmap gb  <Plug>(go-build)
let g:go_version_warning = 0
let g:go_fmt_command = "goimports"

" Fugitive remaps
nmap gs :G<CR>
nmap gc :Gcommit<CR>
nmap gl :Glog<CR>

" Regex searches
nnoremap <C-g> :Rg!

" Nerd Tree config
let NERDTreeQuitOnOpen = 1
nmap <silent> <C-f> :NERDTreeToggle<CR>

" LightLine
let g:rainbow_active = 1
set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" FZF
nmap <silent> <C-p> :FZF<CR>

" Code Folding
set foldmethod=indent   
set foldnestmax=5
set foldlevel=1
set nofoldenable

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" REPL
nnoremap <C-C>r :REPLToggle<CR>

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

" easy save and exit
nnoremap ;w :w<CR>
nnoremap ;wq :wq<CR>
nnoremap ;q :q<CR>
nnoremap :Q :q<CR>

" Copy to clipboard
noremap <C-C>y "*y

" Buffer shortcuts
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>

" CS 164
" Jflex syntax highlighting
augroup filetype
 au BufRead,BufNewFile *.flex,*.jflex    set filetype=jflex
augroup END
au Syntax jflex    so ~/.vim/syntax/jflex.vim
" CUP syntax highlight
autocmd BufNewFile,BufRead *.cup setf cup
