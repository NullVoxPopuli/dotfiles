local function read_file(filePath)
  local file = io.open(filePath, "r")

  if not file then
    return nil
  end

  local contents = file:read("*all")

  file:close()

  return contents
end

-- Returns the contents of the nearest file matching lookFor
local function find_nearest(lookFor)
  local rootDir = vim.fs.root(0, { lookFor })

  if not rootDir then
    return nil
  end

  local filePath = rootDir .. lookFor
  local contents = read_file(filePath)

  if not contents then
    return nil
  end

  return contents
end

local function eslint_config()
  local modern = vim.fs.root(0,{ 'eslint.config.js', 'eslint.config.mjs', 'eslint.config.cjs' })

  if modern then
    return {
      is_modern = true,
      root_dir = modern
    }
  end

  local legacy = vim.fs.root(0, { '.eslintrc.cjs', '.eslintrc.js' })

  if legacy then
    return {
      is_modern = false,
      root_dir = legacy
    }
  end

  return nil
end


local function eslint_root_dir(filename, onDir)
  local info = eslint_config()

  if not info then
    return nil
  end

  local root_dir = info.root_dir

  local manifest = read_file(root_dir .. '/package.json')
  if (not manifest) then return nil end

  local hasESlint = string.find(manifest, '"eslint"')
  if not hasESlint then return nil end

  return onDir(root_dir)
end

return {
  read_file = read_file,
  find_nearest = find_nearest,
  eslint_root_dir = eslint_root_dir,
  eslint_config = eslint_config,
}
