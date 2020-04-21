set number relativenumber
set nu rnu
set cursorline
 
set backspace=indent,eol,start
set visualbell
 
set mouse=a
 
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab
set autoindent

set hlsearch
set incsearch
set ignorecase
set smartcase

set wildmenu
set wildignorecase
set wildmode=full

" set foldmethod=indent

set colorcolumn=120
highlight ColorColumn ctermbg=lightgreen guibg=lightgreen
highlight clear SignColumn

" Permanant gutter column
set signcolumn=yes
 
" Persistent undo settings
set undofile " Save undo history
set undodir=$HOME/.vim/backup/undo// " Store undo history in a central directory
set undodir+=. " Alternatively, store undo history in the same directory as the file
set undolevels=1000 " Save a maximum of 1000 undos
set undoreload=10000 " Save undo history when reloading a file
silent !mkdir $HOME/.vim/backup/undo > /dev/null 2>&1

set noundofile
" set clipboard=exclude:.*

" Lower updatetime for better responsiveness for certain plugins
set updatetime=1000

" Remappings
nnoremap D "_dd

nnoremap <C-z> <C-^>
nnoremap <C-x> :Bdelete<CR>
 
nnoremap <C-Up> <C-u>
nnoremap <C-Down> <C-d>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
 
nnoremap <C-n> :noh<CR>
 
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>
 
" Quickfix mappings
nnoremap ]q :cn<CR>
nnoremap [q :cp<CR>
nnoremap <Leader>q :ccl<CR>

nnoremap <Leader>l :set invlist<cr>
vnoremap p pgvy

call plug#begin('~/.vim/plugged')
 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
 
Plug 'tomasr/molokai'
 
Plug 'yggdroot/indentline'
 
Plug 'mhinz/vim-signify'
 
Plug 'roryokane/detectindent'
 
Plug 'rust-lang/rust.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
 
Plug 'henrik/vim-indexed-search'

Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

Plug 'moll/vim-bbye'

Plug 'junegunn/fzf'
call plug#end()

function! IgnorableDetectIndent()
   " Return early for files you wish to ignore 
   DetectIndent
endfunction
 
augroup DetectIndent
    autocmd!
    autocmd BufReadPost * call IgnorableDetectIndent()
augroup END

" vim-airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#checks = []

" vim-signify settings
let g:signify_vcs_list = [ 'hg', 'git' ]

" vim-session settings
let g:session_autosave = 0
let g:session_autoload = 0
 
" coc settings

" CoC shortcuts
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>gd <Plug>(coc-diagnostic-info)
nmap <silent> <Leader>gr <Plug>(coc-rename)
nmap <silent> <Leader>gf :CocFix<CR>

" CoC Tab Completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" CoC show documentation
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" molokai settings
let g:molokai_original = 1
let g:rehash256 = 1

" Terminal Color Settings
if &term =~# '256color' && ( &term =~# '^screen'  || &term =~# '^tmux' )
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
set background=dark
colorscheme molokai
