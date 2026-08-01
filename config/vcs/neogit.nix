{
  plugins.neogit = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        cmd = "Neogit";
      };
    };
  };
  plugins = {
    codediff.enable = true;
  };
  keymaps = [
    {
      key = "<leader>gg";
      action = "<cmd>Neogit<CR>";
      options.desc = "Neogit";
    }
    {
      key = "<C-S-g>";
      action = "<cmd>Neogit<CR>";
      options.desc = "Neogit";
    }
  ];
}
