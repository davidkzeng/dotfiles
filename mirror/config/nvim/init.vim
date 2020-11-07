" Compatible with nvim 0.4+, vim 8+
set number relativenumber
set cursorline

set backspace=indent,eol,start
set visualbell

" Enable mouse support in all modes
set mouse=a

" Tabs and spacing
set tabstop=4 shiftwidth=4 softtabstop=4
set shiftround
set expandtab
set smarttab
set autoindent

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Completion
set wildmenu
set wildignorecase
set wildmode=full

set colorcolumn=120
highlight ColorColumn ctermbg=lightgreen guibg=lightgreen
highlight clear SignColumn

" Permanant gutter column
set signcolumn=yes

if empty($XDG_DATA_HOME)
    let datahome = $HOME . '/.local/share/vim'
else
    let datahome = $XDG_DATA_HOME . '/vim'
endif

" Persistent undo settings
set undofile " Save undo history
set undolevels=1000 " Save a maximum of 1000 undos
set undoreload=10000 " Save undo history when reloading a file
let &undodir=datahome . '/undo/'
if !isdirectory(&undodir)
    call mkdir(&undodir, "p", 0700)
endif

" Prevent attempt to link with terminal clipboard
" Can lower startup time when used through ssh
if exists(&clipboard)
    set clipboard=exclude:.*
endif

" Lower updatetime for better responsiveness for certain plugins
set updatetime=1000

" Remappings
nnoremap D "_dd

" vim-bbye remappings
nnoremap <C-x> :Bdelete<CR>

" Clear search highlights
nnoremap <C-n> :noh<CR>

nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>

nnoremap <C-Up>   <C-u>
nnoremap <C-Down> <C-d>

nnoremap <Leader>l :set invlist<cr>
vnoremap p pgvy

function! TrimWhitespace()
    %s/\s*$//
endfunction
command! TrimWhiteSpace call TrimWhitespace()

function! OpenVimConfig()
    :e $MYVIMRC
endfunction
command! OpenVimConfig call OpenVimConfig()

call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'tomasr/molokai'

    Plug 'yggdroot/indentline'

    Plug 'mhinz/vim-signify'

    Plug 'roryokane/detectindent'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'henrik/vim-indexed-search'

    Plug 'xolox/vim-session'
    Plug 'xolox/vim-misc'

    Plug 'moll/vim-bbye'

    Plug 'junegunn/fzf'

    " Depends on npm module instant-markdown-d: https://github.com/suan/vim-instant-markdown
    Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

    Plug 'rust-lang/rust.vim'
call plug#end()

function! SetFileIndent(length)
    setlocal tabstop=a:length shiftwidth=a:length softtabstop=a:length
endfunction

" Override default indentation
augroup FileIndent
    autocmd!
    autocmd Filetype markdown,html setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" markdown requires two space tabs
" rust, python have standardized style with four space tabs
function! IgnorableDetectIndent()
    if index(['markdown', 'rust', 'python', 'html'], &filetype) != -1
        return
    endif
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

let g:airline_theme = 'molokai'

" vim-signify settings
let g:signify_vcs_list = [ 'hg', 'git' ]

" vim-session settings
let g:session_autosave = 0
let g:session_autoload = 0

" indentline settings
let g:indentLine_conceallevel = 0

" CoC settings

" CoC shortcuts
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
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

" vim-instant-markdown settings
let g:instant_markdown_mathjax = 1
let g:instant_markdown_slow = 1 " Only update on save/idle
let g:instant_markdown_autostart = 0 " :InstantMarkdownPreview to manually trigger

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
