----------------------
-- Syntax Highlighting
----------------------
return function(use)
  -- Better Folding
  use {
    "kevinhwang91/nvim-ufo",
    event = { "BufRead" },
    wants = { "promise-async" },
    requires = "kevinhwang91/promise-async",
    config = function()
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter' }
        end
      })

      vim.opt.foldcolumn = "0"
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      vim.keymap.set('n', 'z<space>', require('ufo').peekFoldedLinesUnderCursor)
    end
  }
  use {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('pretty-fold').setup()
    end
  }

  -- autoclose and autorename tags
  use {
    'windwp/nvim-ts-autotag',
  }

  -- for developing highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    -- '~/Development/OpenSource/nvim-treesitter',
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require 'nvim-treesitter.configs'.setup {
        autotag = {
          enable = true,
          filetypes = {
            "html",
            "javascript", "typescript",
            "typescript.glimmer", "javascript.glimmer",
            "javascriptreact", "typescriptreact",
            "markdown",
            "glimmer", "handlebars", "hbs", "svelte", "vue"
          }
        },
        ensure_installed = {
          -- Web Languages
          "javascript", "typescript",
          "html", "css", "regex",
          -- Web Framework Languages
          "glimmer", "glimmer_javascript", "glimmer_typescript",
          "svelte",
          -- Web Transport Languages
          "graphql",
          -- Documentation Languages
          "markdown", "markdown_inline",
          -- "help", -- missing?
          -- "comment", -- slow?
          "jsdoc",
          -- Configuration Languages
          "toml", "jsonc", "yaml",
          "dockerfile",
          "lua", "vim",
          -- Scripting Languages
          "commonlisp",
          "bash",
          "jq",
          -- Systems Languages
          "c", "cmake",
          "rust",
          "go",
          -- Specifically for the treesitter AST
          "query",
          -- Utility Syntaxes
          "diff",
          "jq",
          "git_rebase", "gitcommit", "gitignore"
        },
        ignore_install = {
          "json" -- jsonc is better
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        },
      }

      require('ts_context_commentstring').setup({})
      vim.g.skip_ts_context_commentstring_module = true

      vim.treesitter.language.register('html', 'html.edge')
    end
  }

  -- Useful for large functions or in unfamiliar code
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Comments in embedded languages via treesitter
  use { 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end
  }
end
