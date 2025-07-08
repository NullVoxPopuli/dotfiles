-- https://cmp.saghen.dev/configuration/general.html
local home = os.getenv('HOME');
local localEmberSnippets = home .. '/Development/NullVoxPopuli/snippets'

local workSources = { 'lsp', 'path', 'snippets', 'buffer' }
local ossSources = {
  'lsp', 'path', 'snippets', 'buffer',
  -- disabled because windsulf (formally codeium is broken)
  --'codeium'
}

local sources = {}

if os.getenv('PWD'):find('Work') then
  sources = workSources
else
  sources = ossSources
end



require('blink.cmp').setup({
  keymap = {
    -- NOTE: binding this prevents the enter key from
    --       working in insert mode
    -- ['<CR>'] = { 'select_and_accept' },
    -- ['<Tab>'] = { 'select_and_accept' },

    ['<Tab>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      'snippet_forward',
      'fallback'
    },
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
    trigger = { show_in_snippet = false },
    keyword = { range = 'full' },
    documentation = {
      auto_show = true,
      window = { border = 'single' },
    },
    menu = {
      -- Require ctrl+space to open completion suggestions
      -- (we want the default for the editor to not interrupt us)
      auto_show = false,
      border = 'single',
      draw = {
        columns = {
          { "label",     "label_description", gap = 1 },
          { "kind_icon", "kind",              'source_name', gap = 1 }
        },
        components = {
          source_name = { text = function(ctx) return ctx.item.client_name or ctx.item.source_name end },
        },
      }
    },
  },
  sources = {
    default = sources,
    --   providers = {
    --     codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
    --     snippets = {
    --       opts = {
    --         -- supposed to be handled by luasnip
    --         search_paths = { localEmberSnippets },
    --       },
    --     }
    --   }
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
