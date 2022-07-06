----------------------
-- Syntax Highlighting
----------------------
return function(use)

  use {
    'Quramy/vim-js-pretty-template',
    setup = function()
      -- Nested syntax highlighting (normally provided by tree-sitter)
      -- needed for js/ts named template literals in markdown.
      vim.g.vim_markdown_fenced_languages = {
        'js=javascript', 'ts=typescript', 'hbs=handlebars', 'bash=sh', 'cjs=javascript', 'mjs=javascript'
      }
    end
  }

  -- for developing highlights
  use 'nvim-treesitter/playground' -- debugging / reporting bugs
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require'nvim-treesitter.configs'.setup {
        context_commentstring = {
          enable = true,
        },
        ensure_installed = {
          "javascript", "typescript",
          "html", "css", "jsdoc", "regex",
          "markdown",
          "glimmer", "tsx", "svelte",
          "toml", "html", "jsonc", "dockerfile",
          "graphql",
          "lua", "vim",
          "commonlisp",
          "bash", "comment",
          "c", "cmake",
          -- Specifically for the treesitter AST
          "query"
        },
        ignore_install = {
          "json" -- jsonc is better
        },
        highlight = {
          enable = true,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
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
