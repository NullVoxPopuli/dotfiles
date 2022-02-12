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

  -- Syntax Highlighting
  use 'nvim-treesitter/playground' -- debugging / reporting bugs
  use {
    'nvim-treesitter/nvim-treesitter',
    -- 'NullVoxPopuli/nvim-treesitter',
    -- branch = 'support-template-tag-glimmer-embedded',
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
