vim.api.nvim_create_user_command('Mkdir', function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == '' then
    vim.notify('Mkdir: current buffer has no file name', vim.log.levels.ERROR)
    return
  end

  local directory = vim.fs.dirname(file)
  local ok, result = pcall(vim.fn.mkdir, directory, 'p')

  if not ok or (result == 0 and vim.fn.isdirectory(directory) == 0) then
    vim.notify('Mkdir: failed to create ' .. directory, vim.log.levels.ERROR)
    return
  end

  vim.notify('Created directory: ' .. directory)
end, {
  desc = "Create the current buffer's parent directory",
})
