local lsp = require('lspconfig')
local keymap = require('plugin-config.lsp.keymap')
local utils = require('plugin-config.lsp.utils')

require('plugin-config.lsp.config')
require('plugin-config.lsp.completions')

local servers = {
  --------------
  -- Languages
  --
  -- NOTE:
  --   jsonls doesn't support jsonc (it just does JSON.parse and reports errors)
  --------------
  "html",
  "yamlls",
  "cssls",
  "lua_ls",
  "ts_ls",    -- formally tsserver
  "bashls",
  "marksman", -- https://github.com/artempyanykh/marksman
  "rust_analyzer",
  -- Not actively using these atm
  -- "elixirls",
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
  -- Linting / Formatting
  -- null_ls not needed for these
  "eslint"
}


---------------------------
-- Settings and other available servers
--  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
---------------------------
local mySettings = {
  yamlls = {
    yaml = {
      keyOrdering = false
    }
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
        -- https://github.com/neovim/nvim-lspconfig/issues/1700#issuecomment-1033127328
        -- I don't care about proper projects.
        -- I don't actually work in Lua outside of neovim configs
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  },
  ts_ls = {
    hostInfo = "neovim native LS",
    maxTsServerMemory = 8000,
    -- implicitProjectConfig = {
    --   experimentalDecorators = true
    -- },

    disableAutomaticTypingAcquisition = true,
    importModuleSpecifierPreference = "relative",
    importModuleSpecifierEnding = "minimal",
  },
  eslint = {
    useFlatConfig = true
  }
}

-- https://github.com/j-hui/fidget.nvim
require "fidget".setup {}

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


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())

local conditional_features = function(client, bufnr)
  -- if client.server_capabilities.inlayHintProvider then
  --     vim.lsp.buf.inlay_hint(bufnr, true)
  -- end
end

local function get_typescript_server_path(root_dir)
  local project_root = vim.fs.dirname(vim.fs.find('node_modules', { path = root_dir, upward = true })[1])
  return project_root and (project_root .. '/node_modules/typescript/lib') or ''
end

for _, serverName in ipairs(servers) do
  -- lsp = require('lspconfig')
  local server = lsp[serverName]

  if (server) then
    if (serverName == 'ts_ls') then
      local filetypes = {
        'typescript',
        'javascript',
        'typescript.glimmer',
        'javascript.glimmer',
        'typescript.tsx',
        'javascript.jsx',
        'html.handlebars',
        'handlebars',
      }
      server.setup({
        -- filetypes MUST include our custom filetypes for all variants of TS that we might want to use
        -- else the server won't boot and on_new_config won't get called, so we can't conditionally
        -- configure the init_options based on our project
        filetypes = filetypes,
        root_dir = utils.is_ts_project,
        capabilities = capabilities,
        -- This allows us to switch types of TSServers based on the open file.
        -- We don't always need the @glint/tsserver-plugin -- for example, in backend projects.
        on_new_config = function(new_config, new_root_dir)
          local info = utils.read_nearest_ts_config(new_root_dir)
          local glintPlugin = new_root_dir .. "node_modules/@glint/tsserver-plugin"

          if new_config.init_options then
            new_config.init_options.tsdk = get_typescript_server_path(new_root_dir)
            new_config.init_options.requestForwardingCommand = "forwardingTsRequest"


            if (info.isGlintPlugin) then
              new_config.init_options.plugins = {
                {
                  name = "@glint/tsserver-plugin",
                  location = glintPlugin,
                  languages = filetypes,
                  enableForWorkspaceTypeScriptVersions = true,
                  configNamespace = "typescript"
                }
              }
              print(glintPlugin)
            end
          end
        end,
        init_options = {
          tsserver = { logVerbosity = 'verbose', trace = "verbose" },
          preferences = {
            disableAutomaticTypingAcquisition = true,
            importModuleSpecifierPreference = "relative",
            importModuleSpecifierEnding = "minimal",
          },
          plugins = {}
        },
        settings = mySettings[serverName],
        on_attach = function(client, bufnr)
          keymap(bufnr)
          conditional_features(client, bufnr)
        end
      })
    elseif (serverName == 'glint') then
      server.setup({
        root_dir = utils.is_glint_project,
        capabilities = capabilities,
        settings = mySettings[serverName],
        on_attach = function(client, bufnr)
          keymap(bufnr)
          conditional_features(client, bufnr)
        end
      })
    elseif (serverName == 'eslint') then
      server.setup({
        filetypes = {
          "javascript", "typescript",
          "typescript.glimmer", "javascript.glimmer",
          "json",
          "markdown"
        },
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
          conditional_features(client, bufnr)
        end,
      })
    else
      server.setup({
        capabilities = capabilities,
        settings = mySettings[serverName],
        on_attach = function(client, bufnr)
          keymap(bufnr)
          conditional_features(client, bufnr)
        end
      })
    end
  end
end
