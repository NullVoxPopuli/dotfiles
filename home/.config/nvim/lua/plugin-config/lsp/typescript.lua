local utils = require('plugin-config.lsp.utils')

local filetypes = {
  'typescript',
  'javascript',
  'typescript.glimmer',
  'javascript.glimmer',
  'typescript.tsx',
  'javascript.jsx',
  'html.handlebars',
  'handlebars',
}


-- https://neovim.io/doc/user/lsp.html
vim.lsp.config('ts_ls', {
  -- This allows us to switch types of TSServers based on the open file.
  -- We don't always need the @glint/tsserver-plugin -- for example, in backend projects.
  root_dir = utils.is_ts_project,
  settings = {
    hostInfo = "neovim native TS LS",
    maxTsServerMemory = 8000,
    -- implicitProjectConfig = {
    --   experimentalDecorators = true
    -- },
    disableAutomaticTypingAcquisition = true,
    importModuleSpecifierPreference = "relative",
    importModuleSpecifierEnding = "minimal",
  },
  init_options = {
    -- tsserver = { logVerbosity = 'verbose', trace = "verbose" },
    preferences = {
      disableAutomaticTypingAcquisition = true,
      importModuleSpecifierPreference = "relative",
      importModuleSpecifierEnding = "minimal",
    },
    plugins = {
      -- All plugins need to be defined here,
      -- even if we have to change the location later
      {
        name = "@glint/tsserver-plugin",
        location = "/your/path/to/@glint/tsserver-plugin",
        languages = filetypes
      },
    },
  },
  filetypes = filetypes,
  on_new_config = function(new_config, new_root_dir)
    local info = utils.read_nearest_ts_config(new_root_dir)
    local glintPlugin = new_root_dir .. "node_modules/@glint/tsserver-plugin"

    if new_config.init_options then
      if (info.isGlintPlugin) then
        new_config.init_options.plugins = {
          {
            name = "@glint/tsserver-plugin",
            location = glintPlugin,
            languages = filetypes,
            enableForWorkspaceTypeScriptVersions = true,
            configNamespace = "typescript"
          }
        }
      end
    end
  end,
})


vim.lsp.config('glint', {
  root_dir = utils.is_glint_project,
})

vim.lsp.enable('ts_ls')
vim.lsp.enable('glint')
