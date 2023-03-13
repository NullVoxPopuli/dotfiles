-- options that need to be set after some plugin initialization
vim.api.nvim_command [[set termguicolors]]

require('plugin-config.lsp')
require('plugin-config.visuals')
require('plugin-config.treesitter')
require('plugin-config.debugging')

-- Fancy notification from nvim-notify
vim.notify = require('notify')
vim.notify.setup { level = 'error' }

-- require('nvim-autopairs').setup{}
require'lightspeed'.setup {}

vim.api.nvim_create_user_command('IntegratedTerm', function()
  vim.cmd(':term')
  local winid = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(winid, 'winhl', 'Normal:TermBackGround')
  vim.api.nvim_set_hl(0, 'TermBackGround', { background = '#000000' })
end, {})
