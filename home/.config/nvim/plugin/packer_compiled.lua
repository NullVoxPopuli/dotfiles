-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/psego/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/psego/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/psego/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/psego/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/psego/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\4\0\0\6\0\26\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0004\4\3\0005\5\b\0>\5\1\4=\4\n\0034\4\3\0005\5\v\0>\5\1\4=\4\f\0034\4\3\0005\5\r\0>\5\1\4=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0004\4\0\0=\4\n\0034\4\3\0005\5\23\0>\5\1\4=\4\f\0034\4\3\0005\5\24\0>\5\1\4=\4\14\0034\4\0\0=\4\16\0034\4\0\0=\4\18\0034\4\0\0=\4\20\3=\3\25\2B\0\2\1K\0\1\0\22inactive_sections\1\2\2\0\rfilename\16file_status\2\tpath\3\1\1\2\1\0\vbranch\ticon\bî‚ \1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\2\0\0\rfiletype\14lualine_c\1\2\2\0\rfilename\16file_status\1\tpath\3\1\14lualine_b\1\2\0\0\tdiff\14lualine_a\1\0\0\1\2\1\0\tmode\nupper\2\15extensions\1\3\0\0\bfzf\14nvim-tree\foptions\1\0\0\1\0\1\ntheme\fdracula\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/psego/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/psego/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n«\3\0\0\5\0\17\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0004\4\0\0=\4\v\3=\3\f\0025\3\r\0005\4\14\0=\4\15\3=\3\16\2B\0\2\1K\0\1\0\17query_linter\16lint_events\1\3\0\0\rBufWrite\15CursorHold\1\0\2\21use_virtual_text\2\venable\2\15playground\fdisable\1\0\3\20persist_queries\1\venable\1\15updatetime\3\25\14highlight\1\0\1\venable\2\19ignore_install\1\2\0\0\tjson\21ensure_installed\1\0\0\1\15\0\0\15javascript\15typescript\fglimmer\btsx\thtml\njsdoc\nregex\tbash\ttoml\thtml\njsonc\bcss\blua\15commonlisp\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/psego/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  playground = {
    loaded = true,
    path = "/home/psego/.local/share/nvim/site/pack/packer/start/playground"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n«\3\0\0\5\0\17\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0004\4\0\0=\4\v\3=\3\f\0025\3\r\0005\4\14\0=\4\15\3=\3\16\2B\0\2\1K\0\1\0\17query_linter\16lint_events\1\3\0\0\rBufWrite\15CursorHold\1\0\2\21use_virtual_text\2\venable\2\15playground\fdisable\1\0\3\20persist_queries\1\venable\1\15updatetime\3\25\14highlight\1\0\1\venable\2\19ignore_install\1\2\0\0\tjson\21ensure_installed\1\0\0\1\15\0\0\15javascript\15typescript\fglimmer\btsx\thtml\njsdoc\nregex\tbash\ttoml\thtml\njsonc\bcss\blua\15commonlisp\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n\4\0\0\6\0\26\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0004\4\3\0005\5\b\0>\5\1\4=\4\n\0034\4\3\0005\5\v\0>\5\1\4=\4\f\0034\4\3\0005\5\r\0>\5\1\4=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0004\4\0\0=\4\n\0034\4\3\0005\5\23\0>\5\1\4=\4\f\0034\4\3\0005\5\24\0>\5\1\4=\4\14\0034\4\0\0=\4\16\0034\4\0\0=\4\18\0034\4\0\0=\4\20\3=\3\25\2B\0\2\1K\0\1\0\22inactive_sections\1\2\2\0\rfilename\16file_status\2\tpath\3\1\1\2\1\0\vbranch\ticon\bî‚ \1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\2\0\0\rfiletype\14lualine_c\1\2\2\0\rfilename\16file_status\1\tpath\3\1\14lualine_b\1\2\0\0\tdiff\14lualine_a\1\0\0\1\2\1\0\tmode\nupper\2\15extensions\1\3\0\0\bfzf\14nvim-tree\foptions\1\0\0\1\0\1\ntheme\fdracula\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
