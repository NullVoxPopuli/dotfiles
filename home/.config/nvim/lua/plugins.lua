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
return require('packer').startup(function()
  -- NOTE: previously tried plugins
  --   twilight.nvim
  --     - loses highlights on dim
  --   shade.nvim
  --     - buggy, tries to dim buffer that doesn't exist
  --     - previous opacity: 85

  -- colorize various color-like tokens in code
  use 'norcalli/nvim-colorizer.lua'

  -- Scripting Utilities
  use 'nvim-lua/plenary.nvim'

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

  -- Syntax Highlighting
  use 'nvim-treesitter/playground' -- debugging / reporting bugs
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
          "commonlisp"
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
          persist_queries = false -- Whether the query persists across vim sessions
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = {"BufWrite", "CursorHold"},
        },
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
    config = function()
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback

      require'nvim-tree'.setup {
        hijack_netrw = false,
        view = {
          width = 40,
          mappings = {
            list = {
              { key = "<Tab>", cb = tree_cb("preview") }
            }
          }
        }

      }
    end
  }

end)
