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

-- avoid overwriting buffer
mappings.nnoremap('D', '"_dd')
mappings.nnoremap('x', '"_x')
mappings.vnoremap('p', 'pgvy')

mappings.nnoremap(']q', ':cn<CR>')
mappings.nnoremap('[q', ':cp<CR>')
mappings.nnoremap('<leader>q', ':ccl<CR>')

-- Buffer
mappings.nnoremap(']b', ':bn<CR>')
mappings.nnoremap('[b', ':bp<CR>')

mappings.nnoremap('<C-n>', ':noh<CR>')
mappings.nnoremap('<leader>i', ':set invlist<cr>')

return mappings
