local function map(mode, shortcut, command, config)
    vim.keymap.set(mode, shortcut, command, config)
end

local function nnoremap(shortcut, command)
    map('n', shortcut, command, { noremap = true })
end

local function vnoremap(shortcut, command)
    map('v', shortcut, command, { noremap = true })
end

-- avoid overwriting buffer
nnoremap('D', '"_dd')
nnoremap('x', '"_x')
vnoremap('p', 'pgvy')

nnoremap(']q', ':cn<CR>')
nnoremap('[q', ':cp<CR>')
nnoremap('<Leader>q', ':ccl<CR>')

-- Buffer
nnoremap(']b', ':bn<CR>')
nnoremap('[b', ':bp<CR>')

nnoremap('<Leader>i', ':set invlist<cr>')

local mod = {}
mod.map = map
mod.nnoremap = nnoremap
mod.vnoremap = vnoremap

return mod
