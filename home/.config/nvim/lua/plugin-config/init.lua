-- options that need to be set after some plugin initialization
vim.api.nvim_command [[set termguicolors]]

require('plugin-config.lsp')

-- setting default level appears broken?
-- See: https://github.com/rcarriga/nvim-notify/issues/77#issuecomment-1127091726
-- vim.notify = require('notify')
-- vim.notify.setup { level = 'error' }


