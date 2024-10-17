vim.api.nvim_command [[set termguicolors]]
vim.api.nvim_command [[syntax on]]


local tmp_folder = vim.api.nvim_command(':system mktemp')
vim.api.nvim_echo({"Cloning plugins to " .. tmp_folder}, false, {})


vim.api.nvim_command('!git clone https://github.com/nvim-treesitter/nvim-treesitter.git')

-- Add plugins to runtime path so that require can find them
vim.opt.rtp:append(tmp_folder .. "/nvim-treesitter")

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

local ts_update = require('nvim-treesitter.install').update({ with_sync = true })

ts_update()
