MYVIMRC = os.getenv('MYVIMRC')

local datahome = vim.fn.stdpath('data')

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

vim.o.backspace = 'indent,eol,start'

-- silence bells
vim.o.visualbell = false
vim.o.t_vb = ''

vim.o.mouse = 'a'

-- indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.autoindent = true

local function settwospaceindent()
  vim.bo.tabstop = 2
  vim.bo.shiftwidth = 2
  vim.bo.softtabstop = 2
end
vim.api.nvim_create_autocmd({'BufEnter'}, {
  pattern = {'*.html', '*.lua'},
  callback = settwospaceindent,
})

-- search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- cmd line completion
vim.o.wildmenu = true
vim.o.wildignorecase = true
vim.o.wildmode = 'full'

vim.o.colorcolumn = '120'
vim.o.signcolumn = 'yes' -- permanent gutter column

vim.o.undodir = datahome .. '/undo/'
vim.o.directory = datahome .. '/swap/'
vim.o.backupdir = datahome .. '/backup/'

local function ensure_directory(dir)
  if not vim.fn.isdirectory(dir) then
    vim.fn.mkdir(dir, 'p', '0700')
  end
end
ensure_directory(vim.o.undodir)
ensure_directory(vim.o.directory)
ensure_directory(vim.o.backupdir)

vim.o.undofile = true
vim.o.undolevels = 1000
vim.o.undoreload = 10000

-- Prevent attempt to link with terminal clipboard
-- Can lower startup time when used through ssh
vim.o.clipboard = ""

-- Lower updatetime for better responsiveness for certain plugins
vim.o.updatetime = 1000

vim.api.nvim_create_user_command(
  'TrimWhitespace',
---@diagnostic disable-next-line: unused-local
  function(input)
    local view = vim.fn.winsaveview()
    vim.cmd('keeppatterns %s/\\s\\+$//e')
    vim.fn.winrestview(view)
  end,
  {}
)
vim.api.nvim_create_user_command(
  'OpenVimConfig',
  ':e ' .. MYVIMRC,
  {}
)
