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
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    }
  }
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
  use 'quangnguyen30192/cmp-nvim-ultisnips'

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

-- nvim-tree settings
-- Need to install NerdFonts for WSL
nnoremap('<leader>t', ':NvimTreeToggle<CR>')
require('nvim-tree').setup {}

-- fzf settings
vim.api.nvim_create_user_command('FZ',
  'call fzf#run(fzf#wrap({"source": "rg --files"}))',
  {}
)
nnoremap(',f', ':FZ<CR>')

vim.g.fzf_colors = {
  fg = {'fg', 'Normal'},
  bg = {'bg', 'Normal'},
  hl = {'fg', 'Comment'},
  info = {'fg', 'PreProc'},
  border = {'fg', 'Ignore'},
  prompt = {'fg', 'Conditional'},
  pointer = {'fg', 'Exception'},
  marker = {'fg', 'Keyword'},
  spinner = {'fg', 'Label'},
  header = {'fg', 'Comment'}
}

-- snippets
vim.g.UltiSnipsExpandTrigger = '<C-s>'

-- vimtex settings
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_syntax_conceal_disable = 1
vim.g.vimtex_compiler_latexmk = { build_dir = 'build' }

-- nvim-treesitter settings
-- I had to run some hackery: patchelf python.so --add-rpath /lib/x86_64-linux-gnu/
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
