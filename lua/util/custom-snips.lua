local M = {}

local function log_error(msg)
  vim.notify("[custom-snips] " .. msg, vim.log.levels.WARN)
end

local function is_empty(str)
  return str == nil or str == ""
end

---@class GetScnipOptions
---@field base_dir string
---@field include_filetypes? string[]
---@field exclude_pattern? string

---@class Snip
---@field path string
---@field name string

---@alias CustomSnips table<filetype, Snip[]>

---Gets all snippet files
---@param opts GetScnipOptions
---@return CustomSnips
function M.get_snip_files(opts)
  opts = vim.tbl_deep_extend("force", {
    base_dir = "",
    include_filetypes = nil,
    exclude_pattern = nil,
  }, opts or {})

  if is_empty(opts.base_dir) then
    log_error("base_dir can not be empty")
    return {}
  end

  -- by default skip hidden and backup files
  local exclude_regex = vim.regex(opts.exclude_pattern or [[^\.\|\~$]])

  local function path_join(dir, entry)
    if string.match(dir, "/$") == nil then
      dir = dir .. "/"
    end
    return dir .. entry
  end

  local valid_filetypes = {}
  for _, x in ipairs(opts.include_filetypes or {}) do
    valid_filetypes[x] = true
  end

  local function should_include_filetype(filetype)
    return opts.include_filetypes == nil or valid_filetypes[filetype] == true
  end

  local function must_exclude_dir(dir)
    if not exclude_regex:match_str(dir) then
      return 1
    else
      return 0
    end
  end

  local snips = {}
  -- TODO: return an iterator to files instead of loading everything into memory
  local function get_files_recursive(path)
    if vim.fn.isdirectory(path) == 0 then
      local filetype = vim.filetype.match({ filename = path })
      if filetype == nil then
        log_error("Could not determine filetype of " .. path)
      elseif should_include_filetype(filetype) then
        snips[filetype] = snips[filetype] or {}
        table.insert(snips[filetype], {
          path = path,
          name = vim.fn.fnamemodify(path, ":t:r")
          -- name = vim.fn.fnamemodify(path, ":p:r"):sub(vim.fn.fnamemodify(opts.base_dir, ":p"):len() + 1):gsub("/", "_"),
        })
      end
    else
      for _, entry in pairs(vim.fn.readdir(path, must_exclude_dir)) do
        get_files_recursive(path_join(path, entry))
      end
    end
  end

  get_files_recursive(vim.fn.fnamemodify(opts.base_dir, ":p"))
  return snips
end

local function read_file_lines(path)
  local file = assert(io.open(path, "r"))
  local content = file:read("a")
  file:close()

  local lines = {}
  for line in content:gmatch("([^\n]*)\n?") do
    table.insert(lines, line)
  end
  return lines
end

---Add snips to luasnip
---@param snips CustomSnips
function M.add_to_luasnip(snips)
  local ls = require("luasnip")
  for filetype, filepaths in pairs(snips) do
    local ext_snips = {}
    for _, snip in ipairs(filepaths) do
      table.insert(ext_snips, ls.snippet(snip.name, ls.text_node(read_file_lines(snip.path))))
    end

    ls.add_snippets(nil, { [filetype] = ext_snips })
  end
end

---Gets snippet files and adds to luasnips
---@param opts GetScnipOptions
function M.get_and_add_snips(opts)
  M.add_to_luasnip(M.get_snip_files(opts))
end

return M
