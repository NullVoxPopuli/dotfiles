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

require 'nvim-treesitter'.setup {
  -- only needed because we launch with --clean
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require 'nvim-treesitter'.install {
  "javascript", "typescript",
  "glimmer", "glimmer_javascript", "glimmer_typescript",
}

-- Some of this is in ember.nvim
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascript', 'typescript',
    "javascript.glimmer", "typescript.glimmer",
  },
  callback = function()
    vim.treesitter.start()

    -- Folding
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'

    -- indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.treesitter.language.register('glimmer_javascript', 'gjs')
vim.treesitter.language.register('glimmer_typescript', 'gts')
vim.treesitter.language.register('glimmer', 'hbs')
