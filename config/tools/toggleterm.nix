{
  plugins.toggleterm.enable = true;
  keymaps = [
    {
      key = "<leader>!";
      action = "<cmd>ToggleTerm direction=float<CR>";
      options.desc = "Toggle Terminal";
    }
    {
      key = "<leader>tf";
      action = "<cmd>ToggleTerm direction=float<CR>";
      options.desc = "Toggle Terminal";
    }
    {
      key = "<leader>tt";
      action = "<cmd>ToggleTerm<CR>";
      options.desc = "Spawn a Terminal";
    }
  ];
}
