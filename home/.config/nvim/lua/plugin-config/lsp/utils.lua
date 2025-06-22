local lsp = require('lspconfig')

local function readFile(filePath)
  local file = io.open(filePath, "r")

  if not file then
    return nil
  end

  local contents = file:read("*all")

  file:close()

  return contents;
end

local function read_nearest_ts_config(fromFile)
  local rootDir = vim.fs.root(0, { 'tsconfig.json' })

  if not rootDir then
    return nil
  end

  local tsConfig = rootDir .. "/tsconfig.json"
  local contents = readFile(tsConfig)
  local manifest = readFile(rootDir .. "/package.json")

  if not contents then
    return nil
  end

  if not manifest then
    return nil
  end


  -- BUG:
  --   this does not follow "extends" or global tsconfigs if a "one tsconfig.json"
  --   is used.
  local isGlint = string.find(contents, '"glint"')
  -- NOTE: hyphens don't work here
  local hasGlintPlugin = string.find(manifest, "@glint/tsserver")

  return {
    isGlint = not not isGlint,
    isGlintPlugin = not not hasGlintPlugin,
    rootDir = rootDir,
  };
end

-- See:
-- :help lspconfig
-- search for ROOT DIRECTORY DETECTION
local function is_glint_project(filename, bufnr)
  local result = read_nearest_ts_config(filename)

  if not result then
    return nil
  end

  if (not result.isGlintPlugin) then
    return nil
  end

  if (not result.isGlint) then
    return nil
  end

  return result.rootDir
end

local function is_ts_project(filename, onDir)
  local result = read_nearest_ts_config(filename)

  print(result)

  if not result then
    return nil
  end

  if (result.isGlintPlugin) then
    return onDir(result.rootDir)
  end

  if (result.isGlint) then
    return nil
  end

  return onDir(result.rootDir)
end

return {
  is_glint_project = is_glint_project,
  is_ts_project = is_ts_project,
}
