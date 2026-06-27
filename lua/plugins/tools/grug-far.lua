local utils = require('core.utils')

local function get_search_prefill()
  local search = utils.join(utils.get_visual_selection_text())
  if search ~= '' then
    return search
  end

  if vim.fn.mode() ~= 'n' or vim.v.hlsearch == 0 then
    return ''
  end

  search = vim.fn.getreg('/')
  if vim.startswith(search, [[\V]]) then
    search = search:sub(3)
  end

  return search:gsub([[\<]], ''):gsub([[\>]], ''):gsub([[\/]], '/')
end

local function open()
  local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
  require('grug-far').open({
    transient = true,
    prefills = {
      search = get_search_prefill(),
      filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
    },
  })
end

return {
  'MagicDuck/grug-far.nvim',
  ---@type grug.far.OptionsOverride
  opts = {
    headerMaxWidth = 80,
    windowCreationCommand = 'rightbelow 40 vsplit',
  },
  cmd = { 'GrugFar', 'GrugFarWithin' },
  keys = {
    {
      '<leader>fF',
      open,
      mode = { 'n', 'v' },
      desc = 'Search and Replace',
    },
    {
      '<C-S-f>',
      open,
      mode = { 'n', 'v', 'i' },
      desc = 'Search and Replace',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('my-grug-far-custom-keybinds', { clear = true }),
      pattern = { 'grug-far' },
      callback = function(args)
        local bufnr = args.buf

        local function close()
          local win = vim.fn.bufwinid(bufnr)
          if win ~= -1 then
            vim.api.nvim_win_close(win, true)
          else
            vim.api.nvim_buf_delete(bufnr, { force = true })
          end
        end

        vim.keymap.set({ 'n', 'i' }, '<C-S-f>', close, {
          buffer = bufnr,
        })
        vim.keymap.set({ 'n' }, '<leader>fF', close, {
          buffer = bufnr,
        })
      end,
    })
  end,
}
