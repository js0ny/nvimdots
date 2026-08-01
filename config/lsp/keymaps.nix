{
  keymaps = [
    {
      key = "<C-CR>";
      action.__raw = /* lua */ "vim.lsp.buf.definition";
      options.desc = "Goto Definition";
    }
    {
      key = "gi";
      action.__raw = /* lua */ "vim.lsp.buf.implementation";
      options.desc = "Goto Implementation";
    }
    {
      key = "ga";
      action.__raw = /* lua */ "vim.lsp.buf.code_action";
      options.desc = "Code Action";
    }
    {
      key = "K";
      action.__raw = /* lua */ "vim.lsp.buf.hover";
      options.desc = "Show hover";
    }
    {
      key = "cd";
      mode = [ "n" ];
      action.__raw = /* lua */ "vim.lsp.buf.rename";
      options.desc = "Rename symbols under cursor";
    }
  ];
  extraConfigLuaPre = /* lua */ ''
    local function wincmd_smart_split(func, reverse)
      local width = vim.api.nvim_win_get_width(0)
      if width > 80 and not reverse then
        vim.api.nvim_command('vsp')
      else
        vim.api.nvim_command('sp')
      end
      func()
    end
  '';
}
