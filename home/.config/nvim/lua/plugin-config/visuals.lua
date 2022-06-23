-- https://github.com/lukas-reineke/indent-blankline.nvim
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#252537 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#202230 gui=nocombine]]

require("indent_blankline").setup {
  char = "",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = false,
}

-- local theta = require("alpha.themes.theta")
-- local layout = theta.config.layout

-- require'alpha'.setup(theta)

-- local config = {
--   layout = {
--     layout[0],
--     layout[1],
--     layout[2],
--     layout[3],
--     layout[4]
--   },
--   opts = theta.config.opts
-- }

-- require'alpha'.setup(config)
