require('plugin-config.lsp.keymap')
require('plugin-config.lsp.config')
require('plugin-config.lsp.completions')

local utils = require('utils')

-- https://github.com/j-hui/fidget.nvim
require "fidget".setup {}

vim.lsp.config('eslint', {
  root_dir = utils.eslint_root_dir,
  settings = {
    useFlatConfig = true,
  },
  filetypes = {
    "javascript", "typescript",
    "typescript.glimmer", "javascript.glimmer",
    "json",
    "markdown"
  },
  on_new_config = function(new_config, new_root_dir) 
    local info = utils.eslint_config()

      print("eslint on_new_config")
      print(info)
    if not info then
      return
    end

    if not info.is_modern then
      print("Not modern")
      new_config.settings.useFlatConfig = false
    end
  end
})
vim.lsp.enable('eslint');


vim.lsp.config('lua_ls', {
  settings = {
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
  }
});
vim.lsp.enable('lua_ls');

vim.lsp.config('tailwindcss', {
  settings = {
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
  }
});
vim.lsp.enable('tailwindcss');


vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
});

vim.lsp.enable('yamlls')

vim.lsp.enable('ts_query_ls');
vim.lsp.enable('bashls');
vim.lsp.enable('cssls');
vim.lsp.enable('dockerls');
vim.lsp.enable('graphql');
vim.lsp.enable('html');
vim.lsp.enable('marksman'); -- https://github.com/artempyanykh/marksman
vim.lsp.enable('rust_analyzer');
vim.lsp.enable('stylelint_lsp');
vim.lsp.enable('copilot-language-server')


vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities()
})


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
  ensure_installed = {
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
    "eslint",
    "stylelint_lsp"
  },
  automatic_enable = false,
  automatic_installation = false
}
