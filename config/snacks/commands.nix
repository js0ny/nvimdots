{
  extraConfigLua = ''
    vim.api.nvim_create_user_command('Rename', function(args)
      Snacks.rename.rename_file()
    end, {
      desc = 'Rename current buffer',
    })
    vim.api.nvim_create_user_command('GitBrowse', function(args)
      Snacks.gitbrowse.open()
    end, {
      desc = 'Rename current buffer',
    })
    vim.api.nvim_create_user_command('GotoGitRoot', function(args)
      vim.fn.chdir(Snacks.git.get_root())
    end, {
      desc = 'Change to Git Root Directory',
    })
  '';
}
