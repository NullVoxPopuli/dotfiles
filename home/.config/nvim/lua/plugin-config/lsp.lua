local cmp = require'cmp'
local lsp = require('lspconfig')
local notify = require('notify')
-- local lsp_status = require('lsp-status')
-- local lsp_spinner = require('lsp_spinner')

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
  -- Not actively using these atm
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

vim.keymap.set("n", "<A-r>", ":IncRename ")

---------------------------
-- Settings and other available servers
--  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
---------------------------
local mySettings = {
  eslint = {
    format = true,
  },
  tailwindcss = {
    tailwindCSS = {
      includeLanguages = {
        markdown = "html",
        handlebars = "html",
        javascript = {
          glimmer = "javascript"
        },
        typescript = {
          glimmer = "javascript"
        }
      }
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
  },
  tsserver = {
    maxTsServerMemory = 8000,
    implicitProjectConfig = {
      experimentalDecorators = true
    },
    -- importModuleSpecifier = "shortest"
  }
}

-- https://github.com/j-hui/fidget.nvim
require"fidget".setup {}

require("mason").setup {
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}
require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = true
}


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
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),

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
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'spell' },
  }, {
    { name = 'buffer' },
  })
})

vim.opt.spelllang = { 'en_us' }

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lsp_status.register_progress()
-- capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)
-- lsp_spinner.setup()
-- lsp_spinner.init_capabilities(capabilities)


for _, serverName in ipairs(servers) do
  local server = lsp[serverName]

  -- TODO: only disable TS when glint is available
  if (server and (server ~= 'tsserver')) then
    server.setup({
      capabilities = capabilities,
      settings = mySettings[serverName],
      on_attach = function(client, bufnr)
        -- lsp_status.on_attach(client)
        -- lsp_spinner.on_attach(client, bufnr)
        -- require "lsp_signature".on_attach({
        --   fix_pos = true,
        -- }, bufnr)

        -- Helpers, Utilities, etc. (lua -> vim apis are verbose)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        local function n(key, line)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', key, '<cmd>lua ' .. line .. '<CR>', { noremap = true, silent = true })
        end
        local function i(key, line)
          vim.api.nvim_buf_set_keymap(bufnr, 'i', key, '<cmd>lua ' .. line .. '<CR>', { noremap = true, silent = true })
        end


        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Global keymaps (no-remap by default, cause... sanity)
        n('gD', 'vim.lsp.buf.declaration()')
        n('gd', 'vim.lsp.buf.definition()')
        n('gi', 'vim.lsp.buf.implementation()')
        n('gt', 'vim.lsp.buf.type_definition()')
        n('gr', 'vim.lsp.buf.references()')
        n('<leader>ff', 'vim.lsp.buf.format({ async = true })')

        n('<C-u>', 'vim.lsp.buf.signature_help()<CR>')
        n('<leader><Space>', 'vim.lsp.buf.hover()')
        n('<leader>e', 'vim.diagnostic.open_float()')
        n('<leader>a', 'vim.lsp.buf.code_action()')
        n('<leader>rn', 'vim.lsp.buf.rename()')

        -- Server-specific things to do
        if client.name == 'eslint' then
          -- This only works for now because most of what I write is js/ts, but this is technically incorrect
          -- n([[<leader>ff :EslintFixAll<CR>]])
          client.server_capabilities.document_formatting = true
        end

        -- if serverName == 'ember' then
          -- Need Language Server support for invoking this as a formatter
          -- local name = vim.api.nvim_buf_get_name(bufnr)
          -- local isHbs = name:sub(-string.len('.hbs')) == '.hbs'

          -- if (isHbs) then
          --   n([[<leader>ff :silent ! $(npm bin ember-template-lint)/ember-template-lint ]] .. name .. [[<CR>]])
          -- end
        -- end
        -- vim.api.nvim_exec([[
        --   augroup lsp_au
        --     autocmd! * <buffer>
        --     autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()
        --   augroup END
        -- ]], false)
      end
    })
  end
end


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
  severity_sort = true,
  float = {
    show_header = false,
    source = true,
    border = 'rounded',
    -- So we can copy-paste errors to chat
    focusable = true,
  },
})

