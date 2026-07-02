if vim.g.loaded_sops_nvim == 1 then
  return
end
vim.g.loaded_sops_nvim = 1

local DATA_KEY = '["data"]'
local buffers = {}

local function notify_error(message)
  vim.notify(message, vim.log.levels.ERROR)
end

local function system(cmd, input)
  local output = vim.fn.system(cmd, input)
  if vim.v.shell_error ~= 0 then
    return nil, output
  end

  return output, nil
end

local function write_sops_file()
  local bufnr = vim.api.nvim_get_current_buf()
  local state = buffers[bufnr]
  if state == nil then
    notify_error('Current buffer is not a SOPS file buffer')
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local value = vim.json.encode(table.concat(lines, '\n') .. '\n')
  local _, err = system({ 'sops', 'set', '--value-stdin', state.source, DATA_KEY }, value)
  if err ~= nil then
    notify_error(err)
    return
  end

  vim.bo[bufnr].modified = false
  vim.notify('SOPS wrote .data: ' .. state.source)
end

vim.api.nvim_create_user_command('SopsEditFile', function(opts)
  local src = vim.fn.fnamemodify(opts.args, ':p')
  if vim.uv.fs_stat(src) == nil then
    notify_error('File does not exist: ' .. src)
    return
  end

  local data, err = system({ 'sops', '-d', '--extract', DATA_KEY, src })
  if err ~= nil then
    notify_error(err)
    return
  end

  local tmp = vim.fn.tempname()
  vim.fn.writefile(vim.split(data, '\n', { plain = true }), tmp)
  vim.cmd('edit ' .. vim.fn.fnameescape(tmp))

  local bufnr = vim.api.nvim_get_current_buf()
  vim.bo.buftype = ''
  vim.bo.swapfile = false
  vim.bo.undofile = false
  if vim.bo.filetype == '' then
    vim.bo.filetype = vim.filetype.match({ filename = vim.fn.fnamemodify(src, ':r') }) or ''
  end

  vim.b.sops_source = src
  vim.b.sops_tmp = tmp
  buffers[bufnr] = { source = src, tmp = tmp }

  vim.api.nvim_buf_create_user_command(bufnr, 'SopsWrite', write_sops_file, {})

  vim.api.nvim_create_autocmd('BufWipeout', {
    buffer = bufnr,
    once = true,
    callback = function()
      local state = buffers[bufnr]
      buffers[bufnr] = nil
      if state ~= nil then
        pcall(vim.uv.fs_unlink, state.tmp)
      end
    end,
  })

  vim.keymap.set('n', '<localleader>w', write_sops_file, {
    buffer = true,
    desc = 'Encrypt and write SOPS data file',
  })
end, {
  nargs = 1,
  complete = 'file',
})

return {
  'trixnz/sops.nvim',
  lazy = false,
}
