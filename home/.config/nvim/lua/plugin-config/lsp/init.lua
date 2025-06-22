local lsp = require('lspconfig')

require('plugin-config.lsp.keymap')
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

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities()
})

-- TS, Glint, etc
require('plugin-config.lsp.typescript')


for _, serverName in ipairs(servers) do
  local server = lsp[serverName]

  if (server) then
    if (serverName == 'eslint') then
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
        end,
      })
      vim.lsp.enable(serverName)
    else
      server.setup({
        capabilities = capabilities,
        settings = mySettings[serverName],
      })
      vim.lsp.enable(serverName)
    end
  end
end
