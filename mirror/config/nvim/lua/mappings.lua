local function merge(a, b)
    local c = {}
    for k, v in pairs(a) do c[k] = v end
    for k, v in pairs(b) do c[k] = v end
    return c
end

local mappings = {}

function mappings.map(mode, shortcut, command, config)
  vim.keymap.set(mode, shortcut, command, config)
end

function mappings.nnoremap(shortcut, command, extra_config)
  extra_config = extra_config or {}
  mappings.map('n', shortcut, command, merge({ noremap = true }, extra_config))
end

function mappings.nbufnoremap(shortcut, command, bufnr)
  mappings.nnoremap(shortcut, command, { buffer = bufnr })
end

function mappings.vnoremap(shortcut, command, extra_config)
  extra_config = extra_config or {}
  mappings.map('v', shortcut, command, merge({ noremap = true }, extra_config))
end

local nnoremap = mappings.nnoremap
local vnoremap = mappings.vnoremap

-- avoid overwriting buffer
nnoremap('D', '"_dd')
nnoremap('x', '"_x')
vnoremap('p', 'pgvy')

-- fast navigation
nnoremap('H', '^')
nnoremap('J', 'gg')
nnoremap('K', 'G')
nnoremap('L', '$')

-- quickfix
nnoremap(']q', ':cnext<CR>')
nnoremap('[q', ':cprev<CR>')
nnoremap('<leader>qq', ':cclose<CR>')

-- loc list
nnoremap(']l', ':lnext<CR>')
nnoremap('[l', ':lprev<CR>')
nnoremap('<leader>ql;', ':lclose<CR>')

-- buffer
nnoremap(']b', ':bn<CR>')
nnoremap('[b', ':bp<CR>')

nnoremap('<leader>c', ':noh<CR>')
nnoremap('<leader>i', ':set invlist<CR>')

return mappings
