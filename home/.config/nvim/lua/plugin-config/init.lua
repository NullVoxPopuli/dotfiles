-- options that need to be set after some plugin initialization
vim.api.nvim_command [[set termguicolors]]

require('plugin-config.lsp')
require('plugin-config.visuals')
require('plugin-config.treesitter')

-- Fancy notification from nvim-notify
vim.notify = require('notify')
vim.notify.setup { level = 'error' }

require('nvim-autopairs').setup{}
require'lightspeed'.setup {}

