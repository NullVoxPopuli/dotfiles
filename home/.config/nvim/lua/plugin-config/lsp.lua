local servers = {
  --------------
  -- Languages
  "html",
  "jsonls",
  "yamlls",
  "cssls",
  "sumneko_lua",
  "tsserver",
  "bashls",
  -- "elixirls",
  -- "rust_analyzer",
  -- "fsautocomplete",

  --------------
  -- Frameworks
  "ember",
  "glint",

  --------------
  -- Tools
  "graphql",
  "tailwindcss",
  "graphql",
  "dockerls",

  --------------
  -- Linting
  "eslint",
}

---------------------------
-- Settings and other available servers
--  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
---------------------------
local mySettings = {
  tsserver = {
    format = { enable = false },
  },
  eslint = {
    format = { enable = true },
    lintTask = {
      enable = true
    },
    codeAction = {
      showDocumentation = true
    }
  },
  sumneko_lua = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  }
}

require("nvim-lsp-installer").setup {
  ensure_installed = servers,
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
      require('luasnip').lsp_expand(args.body)
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
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp = require('lspconfig')

for _, serverName in ipairs(servers) do
  local server = lsp[serverName]

  if server then
    server.setup({
      capabilities = capabilities,
      settings = mySettings[serverName],
      on_attach = function(client, bufnr)
        -- Helpers, Utilities, etc. (lua -> vim apis are verbose)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        local function n(line) vim.cmd([[nnoremap ]] .. line) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Global keymaps (no-remap by default, cause... sanity)
        n([[gD :lua vim.lsp.buf.declaration()<CR>]])
        n([[gd :lua vim.lsp.buf.definition()<CR>]])
        n([[gi :lua vim.lsp.buf.implementation()<CR>]])
        n([[gt :lua vim.lsp.buf.type_definition()<CR>]])
        n([[gr :lua vim.lsp.buf.references()<CR>]])
        n([[<leader>ff :lua vim.lsp.buf.format({ async = true })<CR>]])

        n([[<leader><Space> :lua vim.lsp.buf.hover()<CR>]])
        n([[<leader>a :lua vim.lsp.buf.code_action()<CR>]])
        n([[<leader>rn :lua vim.lsp.buf.rename()<CR>]])

        -- Server-specific things to do
        if serverName == 'eslint' then
          n([[<leader>ff :EslintFixAll<CR>]])
        end

        -- Show line diagnostics automatically in hover window
        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
          callback = function()
            local opts = {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = 'rounded',
              source = 'always',
              prefix = ' ',
              scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
          end
        })

      end
    })
  end
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '➢', -- Could be '●', '▎', 'x'
    source = 'always'
  }
})

-- Change diagnostic symbols in the sign column (gutter)
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  -- virtual text makes things pretty claustrophobic
  --  would be great to only turn on/off for certain diagnostics providers tho
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

