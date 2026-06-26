local M = {}

local default_opts = { noremap = true, silent = true }
local default_mode = { 'n' }

function M.set_keymaps(maps)
  for _, map in ipairs(maps) do
    local opts = vim.tbl_extend('force', default_opts, map.opts or {})
    local mode = map.mode or default_mode
    vim.keymap.set(mode, map.keys, map.cmd, opts)
  end
end

function M.set_buf_keymaps(maps)
  if not maps then
    return
  end
  for _, map in ipairs(maps) do
    local opts = vim.tbl_extend('force', map.opt or {}, { buffer = true })
    vim.keymap.set(map.mode, map.keys, map.cmd, opts)
  end
end

function M.exepath(name)
  local path = vim.fn.exepath(name)
  return path ~= '' and path or nil
end
---
--- Return the visually selected text as an array with an entry for each line
---
--- @return string[]|nil lines The selected text as an array of lines.
function M.get_visual_selection_text()
  local _, srow, scol = unpack(vim.fn.getpos('v'))
  local _, erow, ecol = unpack(vim.fn.getpos('.'))

  -- visual line mode
  if vim.fn.mode() == 'V' then
    if srow > erow then
      return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
    else
      return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
    end
  end

  -- regular visual mode
  if vim.fn.mode() == 'v' then
    if srow < erow or (srow == erow and scol <= ecol) then
      return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
    else
      return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
    end
  end

  -- visual block mode
  if vim.fn.mode() == '\22' then
    local lines = {}
    if srow > erow then
      srow, erow = erow, srow
    end
    if scol > ecol then
      scol, ecol = ecol, scol
    end
    for i = srow, erow do
      table.insert(
        lines,
        vim.api.nvim_buf_get_text(
          0,
          i - 1,
          math.min(scol - 1, ecol),
          i - 1,
          math.max(scol - 1, ecol),
          {}
        )[1]
      )
    end
    return lines
  end
end

---
--- Join an array of strings into a single string. Returns "" if the array is nil.
---
--- @param arr string[]|nil
--- @return string
function M.join(arr)
  return arr and table.concat(arr, "") or ""
end

return M
