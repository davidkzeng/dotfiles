local m = require('mappings')

-- nvim-cmp settings
local has_words_before = function()
---@diagnostic disable-next-line: deprecated
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  completion = {
    autocomplete = false,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end
      }
    },
  }, {
  }),
}


m.nnoremap('[g', vim.diagnostic.goto_prev)
m.nnoremap(']g', vim.diagnostic.goto_next)
m.nnoremap('<leader>gd', vim.diagnostic.setqflist)

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { update_in_insert = false })

local lspconfig = require('lspconfig')
local function on_attach(_, bufnr)
  m.nbufnoremap('gd', vim.lsp.buf.definition, bufnr)
  m.nbufnoremap('gy', vim.lsp.buf.type_definition, bufnr)
  m.nbufnoremap('gi', vim.lsp.buf.implementation, bufnr)
  m.nbufnoremap('gr', vim.lsp.buf.references, bufnr)
  m.nbufnoremap('gh', vim.lsp.buf.hover, bufnr)
  m.nbufnoremap('<leader>gr', vim.lsp.buf.rename, bufnr)
  m.nbufnoremap('<leader>gf', vim.lsp.buf.code_action, bufnr)
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
    settings = {
      ["rust-analyzer"] = {
        procMacro = {
          enable = true
        }
      }
    }
  },
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'}
        }
      }
    }
  }
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for server,config in pairs(servers) do
  config.on_attach = on_attach
  config.capabilities = capabilities
  lspconfig[server].setup(config)
end
