require('plugin-config.lsp.keymap')
require('plugin-config.lsp.config')
require('plugin-config.lsp.completions')


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
  automatic_installation = false
}

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities()
})

-- TS, Glint, etc
require('plugin-config.lsp.typescript')


vim.lsp.enable('copilot-language-server')


vim.lsp.config('eslint', {
  settings = {
    useFlatConfig = true,
  },
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

vim.lsp.enable('bashls');
vim.lsp.enable('cssls');
vim.lsp.enable('dockerls');
vim.lsp.enable('graphql');
vim.lsp.enable('html');
vim.lsp.enable('marksman'); -- https://github.com/artempyanykh/marksman
vim.lsp.enable('rust_analyzer');
vim.lsp.enable('stylelint_lsp');
