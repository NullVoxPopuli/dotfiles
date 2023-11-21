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
  use 'nvim-treesitter/playground' -- debugging / reporting bugs
  use {
    'nvim-treesitter/nvim-treesitter',
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
          "ejs",
          -- Web Framework Languages
          "glimmer", "svelte",
          -- Web Transport Languages
          "graphql",
          -- Documentation Languages
          "markdown", "markdown_inline",
          -- "help", -- missing?
          -- "comment", -- slow?
          "jsdoc",
          -- Configuration Languages
          "toml", "jsonc",
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
        playground = {
          enable = false,
          disable = {},
          updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }

      require('ts_context_commentstring').setup({})
      vim.g.skip_ts_context_commentstring_module = true
    end
  }

  -- Useful for large functions or in unfamiliar code
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Comments in embedded languages via treesitter
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- TreeSitter-aware spell checking
  -- not enabled for now, because there is yet to be a solidy LSP integration with spell
  -- use {
  --   'lewis6991/spellsitter.nvim',
  --   config = function()
  --     require('spellsitter').setup()
  --   end
  -- }
end
