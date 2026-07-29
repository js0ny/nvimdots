{
  keymaps = [
    {
      key = "<Tab>";
      mode = [ "n" ];
      action = "%";
      options.desc = "Match pairs";
    }
    {
      key = "<C-c>";
      mode = [ "v" ];
      action = ''"+y'';
      options.desc = "Copy selection to system clipboard";
    }
  ];
}
