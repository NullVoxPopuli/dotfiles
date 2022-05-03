require("nvim-lsp-installer").setup {
  ensure_installed = {
    "glint",
    "html", "json", "yamlls", "cssls",
    "tailwindcss",
    "eslint", "graphql", "tsserver",
    "sumneko_lua",
    -- "elixirls", "rust_analyzer", "fsautocomplete",
    "bashls", "dockerls",
  },
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

local cmp = require'cmp'

-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#menu-type
-- for later ^
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    -- Scroll up in docs
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    -- Scroll down in docs
    ['<C-j>'] = cmp.mapping.scroll_docs(4),

    -- Same as the escape key
    ['<C-e>'] = cmp.mapping.abort(),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- Selects next item in completion menu
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
      end
    end,
    -- Selects previous item in completion menu
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local lsp = require('lspconfig')

lsp['tsserver'].setup {
  capabilities = capabilities,
  on_attach = on_attach
}



vim.cmd([[nnoremap gd :lua vim.lsp.buf.definition()<CR>]])
vim.cmd([[nnoremap <leader><Space> :lua vim.lsp.buf.hover()<CR>]])
vim.cmd([[nnoremap <leader>aw :lua vim.lsp.buf.code_action()<CR>]])
vim.cmd([[nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>]])

