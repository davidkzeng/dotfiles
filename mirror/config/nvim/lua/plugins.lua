local datahome = vim.fn.stdpath('data')
local nnoremap = require('mappings').nnoremap

local install_path = datahome .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  Packer_bootstrap = vim.fn.system(
    { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  )
end

require('packer').startup(function(use)
  -- packer itself
  use 'wbthomason/packer.nvim'

  -- bottom bar
  use 'beauwilliams/statusline.lua'

  -- indentation
  use 'yggdroot/indentline'
  use 'roryokane/detectindent'

  -- vcs
  use 'mhinz/vim-signify'
  use 'tpope/vim-fugitive'

  -- better buffer closing
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

  -- tabnine
  use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }

  -- Automatically set up your configuration after cloning packer.nvim
  if Packer_bootstrap then
    require('packer').sync()
  end
end)

-- indentline settings
vim.g.indentLine_conceallevel = 1
vim.g.indentLine_fileTypeExclude = { 'markdown', 'json' }

-- detectindent settings
local function ignorable_detect_indent()
  if vim.fn.index({ 'markdown', 'rust', 'python', 'html' }, vim.bo.filetype) == -1 then
    vim.cmd('DetectIndent')
  end
end
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  callback = ignorable_detect_indent,
})

-- vim-signify settings
vim.g.signify_vcs_list = { 'git' }

-- vim-bbye settings
nnoremap('<leader>qb', ':Bdelete<CR>')

-- nvim-tree settings
-- Need to install NerdFonts for WSL
nnoremap('<leader>t', ':NvimTreeToggle<CR>')
require('nvim-tree').setup {}

-- fzf settings

local function get_bufs_loaded()
  local bufs_loaded = {}
  local idx = 1
  for _, buf_hndl in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf_hndl) then
      local buf_name = vim.api.nvim_buf_get_name(buf_hndl)

      if buf_name ~= '' then
        bufs_loaded[idx] = buf_name
        idx = idx + 1
      end
    end
  end

  return bufs_loaded
end

local function rg_files()
  vim.fn['fzf#run'](vim.fn['fzf#wrap']({ source = 'rg --files', sink = 'e' }))
end

local function rg_buffers()
  vim.fn['fzf#run'](vim.fn['fzf#wrap']({ source = get_bufs_loaded(), sink = 'e' }))
end

vim.api.nvim_create_user_command('FZ',
  rg_files,
  {}
)
vim.api.nvim_create_user_command('FZB',
  rg_buffers,
  {}
)

nnoremap('<leader>ff', ':FZ<CR>')
nnoremap('<leader>fb', ':FZB<CR>')

vim.g.fzf_colors = {
  prompt = { 'fg', 'Conditional' },
}
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6, relative = true, yoffset = 1.0 } }

-- snippets
vim.g.UltiSnipsExpandTrigger = '<C-s>'

-- vimtex settings
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_syntax_conceal_disable = 1
vim.g.vimtex_compiler_latexmk = { build_dir = 'build' }

-- nvim-treesitter settings
require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "rust", "lua" },
  sync_install = false,

  highlight = {
    enable = true,
  }
}

-- tabnine settings
require('tabnine').setup({
  disable_auto_comment = true,
  accept_keymap = "<C-]>",
  dismiss_keymap = "<C-a>",
  debounce_ms = 800000,
  suggestion_color = { gui = "#808080", cterm = 244 },
  exclude_filetypes = { "TelescopePrompt", "NvimTree" },
  log_file_path = "/tmp/tabnine.log", -- absolute path to Tabnine log file
})

-- molokai settings
vim.g.molokai_original = 1
vim.g.rehash256 = 1

-- Terminal Color Settings
vim.o.termguicolors = true
vim.o.syntax = 'enable'
vim.o.background = 'dark'
vim.cmd('colorscheme molokai')
