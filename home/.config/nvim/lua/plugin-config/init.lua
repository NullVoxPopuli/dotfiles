-- options that need to be set after some plugin initialization
vim.api.nvim_command [[set termguicolors]]

require('plugin-config.lsp')
require('plugin-config.visuals')
require('plugin-config.debugging')

-- Fancy notification from nvim-notify
-- vim.notify = require('notify')
-- vim.notify.setup { level = 'error' }

vim.api.nvim_create_user_command('IntegratedTerm', function()
  vim.cmd(':term')
  local winid = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(winid, 'winhl', 'Normal:TermBackGround')
  vim.api.nvim_set_hl(0, 'TermBackGround', { background = '#000000' })
end, {})

local colors = {
  fg = '#ffffff',
  bg = '#5D3FD3',
  bold = true
}
require 'window-picker'.setup({
  hint = 'statusline-winbar',
  selection_chars = "AOEUHTNSIDKBPGXYFPCRLMJWVZQ",
  highlights = {
    statusline = {
      unfocused = colors
    }
  }
})


vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldenable = true
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
