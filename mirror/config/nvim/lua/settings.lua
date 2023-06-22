vim.g.mapleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

-- silence bells
vim.o.visualbell = false
vim.o.t_vb = ''

-- indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
vim.o.expandtab = true

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
vim.o.ignorecase = true
vim.o.smartcase = true

-- cmd line completion
vim.o.wildignorecase = true
vim.o.wildmode = 'full'

vim.o.colorcolumn = '120'
vim.o.signcolumn = 'yes' -- permanent gutter column

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
  function(_)
    local view = vim.fn.winsaveview()
    vim.cmd('keeppatterns %s/\\s\\+$//e')
    vim.fn.winrestview(view)
  end,
  {}
)

MYVIMRC = os.getenv('MYVIMRC')
vim.api.nvim_create_user_command(
  'OpenVimConfig',
  ':e ' .. MYVIMRC,
  {}
)
vim.api.nvim_create_user_command(
  'Source',
  ':source ' .. MYVIMRC,
  {}
)
