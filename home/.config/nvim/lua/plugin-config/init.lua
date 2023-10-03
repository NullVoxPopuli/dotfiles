-- options that need to be set after some plugin initialization
vim.api.nvim_command [[set termguicolors]]

require('plugin-config.lsp')
require('plugin-config.visuals')
require('plugin-config.treesitter')
require('plugin-config.debugging')

-- Fancy notification from nvim-notify
-- vim.notify = require('notify')
-- vim.notify.setup { level = 'error' }

-- require('nvim-autopairs').setup{}

vim.api.nvim_create_user_command('IntegratedTerm', function()
  vim.cmd(':term')
  local winid = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(winid, 'winhl', 'Normal:TermBackGround')
  vim.api.nvim_set_hl(0, 'TermBackGround', { background = '#000000' })
end, {})


function MyFoldtext()
  local text = vim.treesitter.foldtext()

  local n_lines = vim.v.foldend - vim.v.foldstart
  local text_lines = " lines"

  if n_lines == 1 then
    text_lines = " line"
  end

  table.insert(text, { " - " .. n_lines .. text_lines, { "Folded" }})

  return text
end

vim.opt.foldmethod="expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- vim.opt.foldtext = "v:lua.MyFoldtext()"
