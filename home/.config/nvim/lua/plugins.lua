-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end


-- :PackerCompile
-- :PackerClean
-- :PackerInstall
-- :PackerUpdate
-- :PackerSync
return require('packer').startup(function(use)
  -- NOTE: previously tried plugins
  --   twilight.nvim
  --     - loses highlights on dim
  --   shade.nvim
  --     - buggy, tries to dim buffer that doesn't exist
  --     - previous opacity: 85
  ----------------------


  -- Scripting Utilities
  use 'nvim-lua/plenary.nvim'

  ----------------------
  -- Syntax / Theme
  ----------------------
  use 'joshdick/onedark.vim'
  use 'sainnhe/edge'

  ----------------------
  -- Editor Behavior
  ----------------------
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'ntpeters/vim-better-whitespace'
  use 'editorconfig/editorconfig-vim'
  use { 'junegunn/fzf', run = './install --bin', }
  use {
    'ibhagwan/fzf-lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  ----------------------
  -- Information
  ----------------------
  use 'airblade/vim-gitgutter'
  -- colorize various color-like tokens in code
  use 'norcalli/nvim-colorizer.lua'
  use { 'neoclide/coc.nvim', branch = 'release' }

  --  ¯\_( ツ )_/¯
  -- kinda broken -- overriding tab breaks everything
  -- issues are disabled on the repo, no support
  -- use { 'github/copilot.vim' }


  -- statusline
  use {
    'NullVoxPopuli/lualine.nvim',
    branch = 'fix-estimated-with-calculation',
    config = function ()
      require('lualine').setup{
        options = {
          theme = 'dracula',
          -- theme = 'nightfly'
          -- these settings make the status line minimal
          -- component_separators = "",
          -- section_separators = "",
        },
        extensions = { 'fzf', 'nvim-tree' },

        sections = {
          lualine_a = { {'mode', upper = true} },
          -- lualine_b = { {'branch', icon = ''} },
          lualine_b = { {'diff'} },
          lualine_c = { {'filename', file_status = false, path = 1 } },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location'  },
        },
        inactive_sections = {
          lualine_a = {  },
          -- lualine_b = {  },
          lualine_b = { {'branch', icon = ''} },
          lualine_c = { {'filename', file_status = true, path = 1 } },
          lualine_x = {  },
          lualine_y = {  },
          lualine_z = {  }
        },
      }

    end
  }

  ----------------------
  -- Syntax Highlighting
  ----------------------
  -- Tree-sitter markdown seems buggy and unmaintained
  use 'plasticboy/vim-markdown'
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
  -- use 'nvim-treesitter/playground' -- debugging / reporting bugs
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          -- "markdown", -- buggy
          "javascript", "typescript", "glimmer", "tsx",
          "html", "jsdoc", "regex", "bash",
          "toml", "html", "jsonc",
          "css", "lua",
          "commonlisp",
          "c"
        },
        ignore_install = {
          "json" -- jsonc is better
        },
        highlight = {
          enable = true,
        },
        playground = {
          enable = false,
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


  -- Project-wide Search, Find&Replace, with Regex!
  use {
    'windwp/nvim-spectre',
    config = function()
      require('spectre').setup({

      })
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    setup = function()
      vim.g.nvim_tree_window_picker_chars = 'aoeuidhtnsgcrld;qjkxbmwv'
      vim.g.nvim_tree_highlight_opened_files = 0 -- breaks icon color
      vim.g.nvim_tree_indent_markers = 1
      vim.g.nvim_tree_add_trailing = 1
    end,
    config = function()
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback

      -- https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt#L505
      require'nvim-tree'.setup {
        open_on_setup = false,
        open_on_tab = false,

        update_to_buf_dir = {
          enable = false,
          auto_open = false
        },

        filters = {
          custom = { '.git', 'node_modules', '.cache', 'dist', 'tmp', 'declarations' }
        },

        diagnostics = {
          -- lsp info
          enable = true,
        },

        view = {
          width = 40,
          auto_resize = true,
          mappings = {
            list = {
              { key = "<Tab>", cb = tree_cb("preview") }
            }
          }
        }

      }
    end
  }



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
