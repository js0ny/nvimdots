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
  ];
}
