{
  plugins.snacks.settings.terminal.enabled = true;
  keymaps = [
    {
      key = "<leader>!";
      action.__raw = ''
        function() Snacks.terminal() end
      '';
      options.desc = "Toggle Terminal";
    }
    {
      key = "<leader>tf";
      action.__raw = ''
        function() Snacks.terminal({cmd = "zsh"}) end
      '';
      options.desc = "Toggle Terminal (float)";
    }
  ];
}
