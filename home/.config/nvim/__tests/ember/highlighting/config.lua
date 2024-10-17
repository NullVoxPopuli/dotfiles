-- This example dosen't use a package manager.
-- Exact details for how to get plugins will depend on your package manager, 
--   if you're using one.

vim.api.nvim_command [[set termguicolors]]
vim.api.nvim_command [[syntax on]]

local now = vim.fn.system({ 'date', '+%s' })
-- MacOS is really annoying about this.
-- Default $USER doesn't have permissions to create folders in /tmp
local tmp_folder = os.getenv("TMPDIR") .. os.tmpname() .. '/nvim-test-' .. now

-- remove the trailing new line
tmp_folder = vim.fn.trim(tmp_folder)

vim.api.nvim_command("!mkdir -p " .. tmp_folder)

vim.print("Plugins will be stored in :: '" .. tmp_folder .. "'")
vim.opt.rtp:append(tmp_folder)

function install(repo, name)
  vim.print("Installing " .. name)
  vim.api.nvim_command("!git clone " .. repo .. " " .. tmp_folder .. '/')
end

install('https://github.com/nvim-treesitter/nvim-treesitter.git', 'nvim-treesitter')

vim.api.nvim_create_autocmd('BufRead', {
  pattern = { "*.gjs", "*.gts" },

  callback = function()
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

    local ts_install = require("nvim-treesitter.install")
    local ts_update = ts_install.update({ with_sync = true })

    ts_install.prefer_git = true

    ts_update()
  end
})

