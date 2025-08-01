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

  -- Fun
  -- https://github.com/letieu/hacker.nvim

  -- Plugins with too much config to have all in
  -- the same file
  require('plugins.lsp')(use)
  require('plugins.git')(use)
  require('plugins.debugging')(use)
  require('plugins.syntax')(use)
  require('plugins.statusline')(use)
  require('plugins.browsing')(use)
  require('plugins.finding')(use)
  require('plugins.visuals')(use)
  require('plugins.snippets')(use)

  -- NOTE: previously tried plugins
  --   twilight.nvim
  --     - loses highlights on dim
  --   shade.nvim
  --     - buggy, tries to dim buffer that doesn't exist
  --     - previous opacity: 85
  ----------------------

  -- Scripting Utilities
  use 'nvim-lua/plenary.nvim'
  use {
    'rcarriga/nvim-notify',
    config = function()
      vim.keymap.set('n', '<leader>m', '<cmd>lua require("telescope").extensions.notify.notify()<cr>',
        { silent = true, noremap = true })
      -- vim.notify = function(msg, ...)
      --   if msg and string.find(msg, "Neo") and string.find(msg, "tree") then
      --     return
      --   end
      --
      --   require("notify")(msg, ...)
      -- end
    end

  }

  use {
    'vuki656/package-info.nvim',
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require('package-info').setup({
        autostart = false,
        hide_up_to_date = true
      })

      vim.keymap.set(
        'n', '<leader>v', '<cmd>lua require("package-info").toggle()<cr>',
        { silent = true, noremap = true }
      )
    end
  }

  ----------------------
  -- Editor Behavior
  ----------------------
  use 'tpope/vim-surround'

  -- Better buffer resizing
  use {
    "kwkarlwang/bufresize.nvim",
    config = function()
      require("bufresize").setup()
    end
  }

  -- Multi-cursor
  -- Some vim zealots really hate that people want this.
  -- They're wrong.
  -- Multi-cursor is good.
  -- Macros are also good, but not for the same purpose.
  use {
    -- This also effectively disables usage of the arrow key
    -- for normal movement. Should be using better movement anyway
    -- (by word, or hoppin')
    'jake-stewart/multicursor.nvim',
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      local set = vim.keymap.set

      -- Easy way to add and remove cursors using the main cursor.
      set({ "n", "v" }, "<c-q>", mc.toggleCursor)

      -- Delete the main cursor.
      set({ "n", "v" }, "<leader>x", mc.deleteCursor)

      -- bring back cursors if you accidentally clear them
      set("n", "<leader>gv", mc.restoreCursors)

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "v" }, "<up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "v" }, "<down>", function() mc.lineAddCursor(1) end)
      set({ "n", "v" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
      set({ "n", "v" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "v" }, "<leader>d", function() mc.matchAddCursor(1) end, { noremap = true, nowait = true })
      set({ "n", "v" }, "<leader>D", function() mc.matchAddCursor(-1) end)
      set({ "n", "v" }, "<leader>s", function() mc.matchSkipCursor(1) end)
      set({ "n", "v" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

      -- Add all matches in the document
      set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)

      -- Rotate the main cursor.
      set({ "n", "v" }, "<left>", mc.nextCursor)
      set({ "n", "v" }, "<right>", mc.prevCursor)

      set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- Rotate visual selection contents.
      set("v", "<leader>t",
        function() mc.transposeCursors(1) end)
      set("v", "<leader>T",
        function() mc.transposeCursors(-1) end)
    end
  }

  -- Making up for issues in some tree-sitter grammars
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
  use { "OlegGulevskyy/better-ts-errors.nvim",
    config = function()
      require("better-ts-errors").setup({
        keymap = '<leader>e' -- Toggling keymap
      })
    end
  }
  -- temporary
  -- use 'alvan/vim-closetag'

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
  if os.getenv("LOCAL_AI") == "true" then
    use({
      "frankroeder/parrot.nvim",
      requires = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
      config = function()
        require("parrot").setup({
          cmd_prefix = "Parrot",
          providers = {
            -- anthropic = {
            --   api_key = os.getenv "ANTHROPIC_API_KEY",
            -- },
            -- gemini = {
            --   api_key = os.getenv "GEMINI_API_KEY",
            -- },
            -- groq = {
            --   api_key = os.getenv "GROQ_API_KEY",
            -- },
            -- mistral = {
            --   api_key = os.getenv "MISTRAL_API_KEY",
            -- },
            -- pplx = {
            --   api_key = os.getenv "PERPLEXITY_API_KEY",
            -- },
            -- provide an empty list to make provider available (no API key required)
            -- ollama = {},
            -- openai = {
            --   api_key = os.getenv "OPENAI_API_KEY",
            -- },
            github = {
              api_key = os.getenv "GITHUB_TOKEN",
              topic = {
                model = "gpt-4o"
                -- model = "claude-3-7-sonnett"
              }
            },
            -- nvidia = {
            --   api_key = os.getenv "NVIDIA_API_KEY",
            -- },
            -- xai = {
            --   api_key = os.getenv "XAI_API_KEY",
            -- },
          },
          hooks = {
            Ask = function(parrot, params)
              local template = [[
          In light of your existing knowledge base, please generate a response that
          is succinct and directly addresses the question posed. Prioritize accuracy
          and relevance in your answer, drawing upon the most recent information
          available to you. Aim to deliver your response in a concise manner,
          focusing on the essence of the inquiry.
          Question: {{command}}
        ]]
              local model_obj = parrot.get_model("command")
              parrot.logger.info("Asking model: " .. model_obj.name)
              parrot.Prompt(params, parrot.ui.Target.popup, model_obj, "🤖 Ask ~ ", template)
            end,
          }
        })
      end,
    })
  end

  -- This is broken again
  -- Login via :Codeium Auth
  -- use {
  --   "Exafunction/windsurf.nvim",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     -- if os.getenv('PWD'):find('Work') then
  --     --   -- Not yet approved for work
  --     -- else
  --     require("codeium").setup({
  --       enable_cmp_source = false,
  --       -- requires api.host, and I don't know what that is
  --       -- enterprise_mode = true,
  --       virtual_text = {
  --         enabled = true,
  --         idle_delay = 200,
  --       },
  --       map_keys = false,
  --     })
  --
  --     local accept = require('codeium.virtual_text').accept
  --
  --     -- On Dvorak, this is easy
  --     vim.keymap.set("i", "<C-u>", accept, { silent = true, expr = true, script = true, nowait = true })
  --     -- end
  --   end
  -- }



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
