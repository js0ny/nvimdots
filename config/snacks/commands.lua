vim.api.nvim_create_user_command('Rename', function(args)
  Snacks.rename.rename_file()
end, {
  desc = 'Rename current buffer',
})
vim.api.nvim_create_user_command('GitBrowse', function(args)
  Snacks.gitbrowse.open()
end, {
  desc = 'Open remote with browser',
})
vim.api.nvim_create_user_command('GotoGitRoot', function(args)
  vim.fn.chdir(Snacks.git.get_root())
end, {
  desc = 'Change to Git Root Directory',
})
vim.api.nvim_create_user_command('TermNew', function(args)
  Snacks.terminal.open()
end, {
  desc = 'Create a new terminal',
})
vim.api.nvim_create_user_command('TermToggle', function(args)
  Snacks.terminal.toggle()
end, {
  desc = 'Create a new terminal',
})
