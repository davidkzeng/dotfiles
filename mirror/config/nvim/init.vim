" vim 8.0+, nvim 0.4+

" Respect XDG_DATA_HOME environment variable
if has('nvim')
    let datahome = stdpath('data')
    let cachehome = stdpath('cache')
else
    let datahome = $XDG_DATA_HOME . '/vim'
    let cachehome = $XDG_CACHE_HOME . '/vim'
endif

set nocompatible

set number relativenumber
set cursorline

set backspace=indent,eol,start

" disable bell
set visualbell
set t_vb=

" enable mouse support in all modes
set mouse=a

" tabs and spacing
set tabstop=4 shiftwidth=4 softtabstop=4
set shiftround
set expandtab
set smarttab
set autoindent
augroup FileIndent
    autocmd!
    autocmd Filetype html setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" search
set hlsearch
set incsearch
set ignorecase
set smartcase

" cmd line completion
set wildmenu
set wildignorecase
set wildmode=full

set colorcolumn=120
highlight ColorColumn ctermbg=lightgreen guibg=lightgreen
highlight clear SignColumn

" permanant gutter column
set signcolumn=yes

" undo save backup
let &undodir=datahome . '/undo/'
let &directory=datahome . '/swap/'
let &backupdir=datahome . '/backup/'

if !isdirectory(&undodir)
    call mkdir(&undodir, "p", 0700)
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p", 0700)
endif
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p", 0700)
endif

" persistent undo
set undofile " Save undo history
set undolevels=1000 " Save a maximum of 1000 undos
set undoreload=10000 " Save undo history when reloading a file

" Prevent attempt to link with terminal clipboard
" Can lower startup time when used through ssh
if exists(&clipboard)
    set clipboard=exclude:.*
endif

" Lower updatetime for better responsiveness for certain plugins
set updatetime=1000

" Remappings
" delete without saving to buffer
nnoremap D "_dd

" Clear search highlights
nnoremap <C-n> :noh<CR>

nnoremap <Leader>i :set invlist<cr>
" reselects and copies pasted text
vnoremap p pgvy

" Quickfix
nnoremap ]q :cn<CR>
nnoremap [q :cp<CR>
nnoremap <Leader>q :ccl<CR>

" Buffer
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>

function! TrimWhitespace()
    %s/\s*$//
endfunction
command! TrimWhiteSpace call TrimWhitespace()

function! OpenVimConfig()
    :e $MYVIMRC
endfunction
command! OpenVimConfig call OpenVimConfig()

" VimPlug
if has('nvim')
    let vimplugfile=datahome . '/site/autoload/plug.vim'
else
    let vimplugfile='~/.vim/autoload/plug.vim'
endif

if empty(glob(vimplugfile))
  silent execute '!curl -fLo ' . vimplugfile . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(datahome . '/plugged')
    " top and bottom bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " indentation
    Plug 'yggdroot/indentline'
    Plug 'roryokane/detectindent'

    " vcs
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'

    " sessions
    Plug 'xolox/vim-session'
    Plug 'xolox/vim-misc'

    " print # of matches in search
    Plug 'henrik/vim-indexed-search'

    " better <C-x>
    Plug 'moll/vim-bbye'

    " navigation
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf'
    Plug 'jremmen/vim-ripgrep'

    " lsp
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " snippets
    Plug 'sirver/ultisnips'

    " language specific
    Plug 'rust-lang/rust.vim'
    Plug 'lervag/vimtex'

    " color scheme
    Plug 'tomasr/molokai'
call plug#end()

" Plugin Settings

" vim-airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#checks = []

" vim-airline-themes settings
let g:airline_theme = 'molokai'

" indentline settings
let g:indentLine_conceallevel = 1
let g:indentLine_fileTypeExclude = ['markdown', 'json']

" detectindent settings
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

" vim-signify settings
let g:signify_vcs_list = [ 'hg', 'git' ]

" vim-session settings
let g:session_autosave = 0
let g:session_autoload = 0
let g:session_directory = datahome . '/sessions'

" vim-bbye settings
nnoremap <C-x> :Bdelete<CR>

" nerdtree settings
nnoremap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeMinimalUI = 1 " Disable help text

" fzf settings
if executable('rg')
    command! FZ call fzf#run(fzf#wrap({'source': 'rg --files'}))
    command! FZA call fzf#run(fzf#wrap({}))
endif

" coc.nvim settings

" shortcuts
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>gd <Plug>(coc-diagnostic-info)
nmap <silent> <Leader>gr <Plug>(coc-rename)
nmap <silent> <Leader>gf :CocFix<CR>

" tab completion
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

" show documentation
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" snippets
let g:UltiSnipsExpandTrigger="<Leader>s"

" vimtex settings
let g:vimtex_view_method = 'zathura'
let g:vimtex_syntax_conceal_disable = 1

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
