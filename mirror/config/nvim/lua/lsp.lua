nnoremap = require('mappings').nnoremap

nnoremap('[g', vim.diagnostic.goto_prev)
nnoremap(']g', vim.diagnostic.goto_next)
nnoremap('<leader>gd', vim.diagnostic.setqflist)

local lspconfig = require('lspconfig')
local function on_attach(_, bufnr)
  nnoremap('gd', vim.lsp.buf.definition)
  nnoremap('gy', vim.lsp.buf.type_definition)
  nnoremap('gi', vim.lsp.buf.implementation)
  nnoremap('gr', vim.lsp.buf.references)
  nnoremap('<leader>gr', vim.lsp.buf.rename)
  nnoremap('<leader>gf', vim.lsp.buf.code_action)
end

local servers = {
  pylsp = {
    cmd = {'pylsp', '-vv', '--log-file', '/tmp/lsp_python.log'},
    settings = {
      pylsp = {
        configurationSources = {'flake8'},
        plugins = {
          pyflakes = { enabled = true },
          pycodestyle = { enabled = true },
        },
      }
    }
  },
  rust_analyzer = {
    cmd = {'rust-analyzer'},
  }
}

for server,config in pairs(servers) do
  config.on_attach = on_attach
  lspconfig[server].setup(config)
end
