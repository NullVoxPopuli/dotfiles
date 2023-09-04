-- https://github.com/lukas-reineke/indent-blankline.nvim
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#252537 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#202230 gui=nocombine]]

-- local highlight = {
--     "RainbowViolet",
-- }
-- vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
-- require("ibl").setup {
--   char = "",
--   char_highlight_list = {
--     "IndentBlanklineIndent1",
--     "IndentBlanklineIndent2",
--   },
--   space_char_highlight_list = {
--     "IndentBlanklineIndent1",
--     "IndentBlanklineIndent2",
--   },
--   show_trailing_blankline_indent = false,
-- }

-- local highlight = {
--     "CursorColumn",
--     "Whitespace",
-- }
-- require("ibl").setup {
--     indent = { highlight = highlight, char = "" },
--     whitespace = {
--         highlight = highlight,
--         remove_blankline_trail = false,
--     },
--     scope = { enabled = false },
-- }


local highlight = {
    "RainbowViolet",
}
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { 
  scope = { highlight = highlight }, 
}

