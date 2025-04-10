-- https://cmp.saghen.dev/configuration/general.html
require('blink.cmp').setup({
  keymap = {
    -- NOTE: binding this prevents the enter key from
    --       working in insert mode
    -- ['<CR>'] = { 'select_and_accept' },
    ['<Tab>'] = { 'select_and_accept' },
    -- NOTE: you *can* just use k/j, but then you can't type those
    --       letters once the completion menu opens
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<A-k>'] = { 'scroll_documentation_up' },
    ['<A-j>'] = { 'scroll_documentation_down' },
    -- Defaults:
    -- ['<C-space>'] = { function(cmp) cmp.show() end },
  },

  -- fancy?
  completion = {
    keyword = { range = 'full' },
    documentation = {
      auto_show = true,
      window = { border = 'single' },
    },
    ghost_text = { enabled = true },
    menu = {
      -- Require ctrl+space to open completion suggestions
      -- (we want the default for the editor to not interrupt us)
      auto_show = false,
      border = 'single',
      draw = {
        columns = {
          { "label",     "label_description", gap = 1 },
          { "kind_icon", "kind",              gap = 1 }
        },
      }
    },
  },
  snippets = {
    -- Shorthand doesn't work yet
    -- preset = 'luasnip' ,
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
    active = function(filter)
      if filter and filter.direction then
        return require("luasnip").jumpable(filter.direction)
      end
      return require("luasnip").in_snippet()
    end,
    jump = function(direction)
      require("luasnip").jump(direction)
    end,
  },

  -- Experimental
  -- https://cmp.saghen.dev/configuration/signature.html
  signature = { enabled = true, window = { border = 'single' } },
})
