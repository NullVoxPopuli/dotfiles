local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  print("Installing packer close and reopen Neovim...")
end


require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require 'nvim-treesitter.configs'.setup {
        sync_install = true,
        ignore_install = {},
        auto_install = true,
        modules = {},
        ensure_installed = {
          "javascript", "typescript",
          "glimmer", "glimmer_javascript", "glimmer_typescript",
          "jsdoc",
          "diff",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        },
      }

      -- vim.treesitter.language.register('gjs', 'javascript.glimmer')
      -- vim.treesitter.language.register('gjs', 'typescript.glimmer')
    end
  }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

vim.api.nvim_command [[set termguicolors]]
vim.api.nvim_command [[syntax on]]
