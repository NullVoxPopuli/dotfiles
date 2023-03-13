local cmp = require'cmp'
local lsp = require('lspconfig')
local notify = require('notify')
local lspkind = require('lspkind')

local servers = {
  --------------
  -- Languages
  "html",
  -- "jsonls",
  -- "yamlls",
  "cssls",
  -- "lua_ls",
  "tsserver",
  "bashls",
  "marksman", -- https://github.com/artempyanykh/marksman
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
  lua_ls = {
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
  automatic_installation = false
}




-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#menu-type
-- for later ^
cmp.setup({
  -- Disable completion in comments
  -- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#disabling-completion-in-certain-contexts-such-as-comments
  enabled = function()
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment") 
        and not context.in_syntax_group("Comment")
    end
  end,
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
  experimental = {
    ghost_text = true
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Scroll up in docs -- only works when scrollbar is visible
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    -- Scroll down in docs -- only works when scrollbar is visible
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
    { name = 'path' },
  }, {
    { name = 'copilot'},
    { name = 'nvim_lua' },
    { name = 'spell' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    -- format = lspkind.cmp_format({
    --   symbol_map = { Copilot = "" }
    -- })
},
})

vim.opt.spelllang = { 'en_us' }

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp')
  .default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function keymap(bufnr)
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

  n('<leader>u', 'vim.lsp.buf.signature_help()<CR>')
  n('<leader><Space>', 'vim.lsp.buf.hover()')
  n('<leader>e', 'vim.diagnostic.open_float()')
  n('<leader>a', 'vim.lsp.buf.code_action()')
  n('<leader>rn', 'vim.lsp.buf.rename()')
end

local function readFile(filePath)
  local file = io.open(filePath, "r")
  local contents = file:read("*all")

  file:close()

  return contents;
end

local function read_nearest_ts_config(fromFile) 
  local rootDir = lsp.util.root_pattern('tsconfig.json')(fromFile);

  if not rootDir then 
    return nil 
  end

  local tsConfig = rootDir .. "/tsconfig.json"
  local contents = readFile(tsConfig)
  local isGlint = string.find(contents, '"glint"')

  return { 
    isGlint = not not isGlint,
    rootDir = rootDir,
  };
end

-- See:
-- :help lspconfig 
-- search for ROOT DIRECTORY DETECTION
local function is_glint_project(filename, bufnr) 
  local result = read_nearest_ts_config(filename)
  
  if not result then 
    return nil
  end

  if (not result.isGlint) then 
    return nil
  end

  return result.rootDir 
end

local function is_ts_project(filename, bufnr) 
  local result = read_nearest_ts_config(filename)

  if not result then 
    return nil
  end 

  if (result.isGlint) then 
    return nil
  end

  return result.rootDir
end

for _, serverName in ipairs(servers) do
  local server = lsp[serverName]

  if (server) then
    if (serverName == 'tsserver') then 
      server.setup({
        single_file_support = false,
        root_dir = is_ts_project,
        capabilities = capabilities,
        settings = mySettings[serverName],
        on_attach = function(client, bufnr)
          keymap(bufnr)
        end
      })
    elseif (serverName == 'glint') then 
      server.setup({
        root_dir = is_glint_project,
        capabilities = capabilities,
        settings = mySettings[serverName],
        on_attach = function(client, bufnr)
          keymap(bufnr)
        end
      })
    else
      server.setup({
        capabilities = capabilities,
        settings = mySettings[serverName],
        on_attach = function(client, bufnr)
          keymap(bufnr)
        end
      })
    end
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

