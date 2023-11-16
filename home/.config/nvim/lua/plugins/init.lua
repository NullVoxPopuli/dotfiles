local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  print("Installing packer close and reopen Neovim...")
end


-- :PackerCompile
-- :PackerClean
-- :PackerInstall
-- :PackerUpdate
-- :PackerSync
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- *aggressive* caching
  use 'lewis6991/impatient.nvim'

  -- Fun
  -- https://github.com/letieu/hacker.nvim

  -- Plugins with too much config to have all in
  -- the same file
  require('plugins.lsp')(use)
  require('plugins.debugging')(use)
  require('plugins.linting')(use)
  require('plugins.syntax')(use)
  require('plugins.statusline')(use)
  require('plugins.browsing')(use)
  require('plugins.finding')(use)
  require('plugins.visuals')(use)

  -- NOTE: previously tried plugins
  --   twilight.nvim
  --     - loses highlights on dim
  --   shade.nvim
  --     - buggy, tries to dim buffer that doesn't exist
  --     - previous opacity: 85
  ----------------------

  -- Scripting Utilities
  use 'nvim-lua/plenary.nvim'
  use 'rcarriga/nvim-notify'
  use { 'vuki656/package-info.nvim', config = function()
    vim.api.nvim_set_keymap(
      'n', '<leader>v', '<cmd>lua require("package-info").show()<cr>',
      { silent = true, noremap = true }
    )
  end }

  ----------------------
  -- Editor Behavior
  ----------------------
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  -- lazygit Slow? investigate
  -- use 'kdheepak/lazygit.nvim'
  use 'editorconfig/editorconfig-vim'
  use { "sindrets/diffview.nvim", config = function()
    local actions = require("diffview.actions")

    require('diffview').setup({
      keymaps = {
        view = {
          -- override NeoTree shortcuts
          { "n", "<leader>\\", actions.focus_files, { desc = "Bring focus to the file panel" } },
          { "n", "<leader>/",  actions.focus_files, { desc = "Bring focus to the file panel" } },
        },
        diff1 = {
          -- Mappings in single window diff layouts
          { "n", "?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
        },
        diff2 = {
          -- Mappings in 2-way diff layouts
          { "n", "?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
        },
      }
    })
  end }
  use { 'FabijanZulj/blame.nvim', config = function()
    require('blame').setup({ virtual_style = "right_asign" })
  end }
  use {
    'vidocqh/auto-indent.nvim',
    config = function()
      require("auto-indent").setup({
        -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
        lightmode = true,
        -- Use vim.bo.indentexpr by default, see 'Custom Indent Evaluate Method'
        indentexpr = function(lnum)
          return require("nvim-treesitter.indent").get_indent(lnum)
        end,
        -- Disable plugin for specific filetypes, e.g. ignore_filetype = { 'javascript' }
        ignore_filetype = {},
      })
    end
  }
  -- * for search forward
  -- # for search backwards
  use 'backdround/improved-search.nvim'
  use { 'dnlhc/glance.nvim', config = function()
    require('glance').setup({
      detached = true,
      border = {
        enable = true,
        top_char = "─",
        bottom_char = "─"
      }
    })
    -- vim.keymap.set('n', 'gd', '<CMD>Glance declaration<CR>')
    -- vim.keymap.set('n', 'gD', '<CMD>Glance definition<CR>')
    vim.keymap.set('n', 'gi', '<CMD>Glance implementations<CR>')
    vim.keymap.set('n', 'gt', '<CMD>Glance type_definitions<CR>')
    vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>')
  end }

  -- temporary
  use 'alvan/vim-closetag'

  -- This generally isn't needed when using lots of
  -- copilot suggestions. Copilot will include the matched pair.
  -- SEE: https://github.com/zbirenbaum/copilot-cmp/issues/31
  use { 'windwp/nvim-autopairs', config = function()
    local npairs = require('nvim-autopairs')
    npairs.setup({
      check_ts = true,
    })
    local Rule = require('nvim-autopairs.rule')
    local cond = require('nvim-autopairs.conds')
    local ts_cond = require('nvim-autopairs.ts-conds')

    -- glimmer autopairs
    -- TODO: replace with lua-snip so these are more ergonomic
    --       https://github.com/alexlafroscia/tree-sitter-glimmer/issues/60
    npairs.add_rules({
      Rule('{{#if.*}}', '{{/if}}', 'handlebars'):use_regex(true):end_wise(cond.is_end_line()),
      Rule('{{#unless.*}}', '{{/unless}}', 'handlebars'):use_regex(true):end_wise(cond.is_end_line()),
      Rule('{{#each-in.*}}', '{{/each-in}}', 'handlebars'):use_regex(true):end_wise(cond.is_end_line()),
      Rule('{{#each.*}}', '{{/each}}', 'handlebars'):use_regex(true):end_wise(cond.is_end_line()),
      Rule('{{#let.*}}', '{{/let}}', 'handlebars'):use_regex(true):end_wise(cond.is_end_line()),
      Rule('{{#in-element.*}}', '{{/in-element}}', 'handlebars'):use_regex(true):end_wise(cond.is_end_line()),
      Rule('{{#link-to.*}}', '{{/link-to}}', 'handlebars'):use_regex(true):end_wise(cond.is_end_line()),
      Rule('|', '|', 'handlebars'):with_move(cond.done()):with_pair(ts_cond.is_ts_node({ 'block_params',
        'block_statement_start' })),
      -- ensure nice behaviour when pressing CR inside an html tag
      Rule('>[%w%s]*$', '^%s*</', 'handlebars'):only_cr():use_regex(true)
    })
  end }

  -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn["mkdp#util#install"]() end,
  }
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {}
    end,
    wants = { 'nvim-treesitter' }
  }

  -- Measure typing speed
  use {
    "jcdickinson/wpm.nvim",
    config = function()
      require("wpm").setup({
      })
    end
  }

  --  ¯\_( ツ )_/¯
  if os.getenv("COPILOT") == "true" then
    -- Login via :Codeium Auth
    use {
      "jcdickinson/codeium.nvim",
      -- Using a fixed version here until
      -- https://github.com/jcdickinson/codeium.nvim/issues/70
      -- is resolved
      commit = "b1ff0d6c993e3d87a4362d2ccd6c660f7444599f",
      requires = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
      },
      config = function()
        require("codeium").setup({
        })
      end
    }
  end



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
