local datahome = vim.fn.stdpath('data')
local nnoremap = require('mappings').nnoremap

local install_path = datahome .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  Packer_bootstrap = vim.fn.system(
    {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
  )
end

require('packer').startup(function(use)
  -- packer itself
  use 'wbthomason/packer.nvim'

  -- top and bottom bar
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- indentation
  use 'yggdroot/indentline'
  use 'roryokane/detectindent'

  -- vcs
  use 'mhinz/vim-signify'
  use 'tpope/vim-fugitive'

  -- sessions
  use 'xolox/vim-session'
  use 'xolox/vim-misc'

  -- print # of matches in search
  use 'henrik/vim-indexed-search'

  -- better <C-x>
  use 'moll/vim-bbye'

  -- navigation
  use 'preservim/nerdtree'
  use 'junegunn/fzf'
  use 'jremmen/vim-ripgrep'

  -- lsp
  use 'neovim/nvim-lspconfig'

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'

  -- snippets
  use 'sirver/ultisnips'

  -- language specific
  use 'lervag/vimtex'

  -- color scheme
  use 'tomasr/molokai'

  -- highlighting
  use 'nvim-treesitter/nvim-treesitter'

  -- Automatically set up your configuration after cloning packer.nvim
  if Packer_bootstrap then
    require('packer').sync()
  end
end)

-- vim-airline settings
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1
vim.g['airline#extensions#whitespace#checks'] = {}
vim.g.airline_theme = 'molokai'

-- indentline settings
vim.g.indentLine_conceallevel = 1
vim.g.indentLine_fileTypeExclude = {'markdown', 'json'}

-- detectindent settings
local function ignorabledetectindent()
  if vim.fn.index({'markdown', 'rust', 'python', 'html'}, vim.bo.filetype) == -1 then
    vim.cmd('DetectIndent')
  end
end
vim.api.nvim_create_autocmd({'BufReadPost'}, {
  callback = ignorabledetectindent,
})

-- vim-signify settings
vim.g.signify_vcs_list = {'git'}

-- vim-session settings
vim.g.session_autosave = 0
vim.g.session_autoload = 0
vim.g.session_directory = datahome .. '/sessions'

-- vim-bbye settings
nnoremap('<C-x>', ':Bdelete<CR>')

-- nerdtree settings
nnoremap('<leader>t', ':NERDTreeToggle<CR>')
vim.g.NERDTreeMinimalUI = 1 -- disable help text

-- fzf settings
vim.api.nvim_create_user_command('FZ',
  'call fzf#run(fzf#wrap({"source": "rg --files"}))',
  {}
)
vim.api.nvim_create_user_command('FZA',
  'call fzf#run(fzf#wrap({}))',
  {}
)

-- snippets
vim.g.UltiSnipsExpandTrigger = '<C-s>'

-- vimtex settings
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_syntax_conceal_disable = 1
vim.g.vimtex_compiler_latexmk = { build_dir = 'build' }

-- nvim-treesitter settings
require('nvim-treesitter.configs').setup {
  ensure_installed = {"python", "rust", "lua"},
  sync_install = false,

  highlight = {
    enable = true,
  }
}

-- molokai settings
vim.g.molokai_original = 1
vim.g.rehash256 = 1

-- Terminal Color Settings
vim.o.termguicolors = true
vim.o.syntax = 'enable'
vim.o.background = 'dark'
vim.cmd('colorscheme molokai')
