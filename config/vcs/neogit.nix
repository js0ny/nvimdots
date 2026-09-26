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
  autoCmd = [
    {
      event = "User";
      pattern = "NeogitStatusRefreshed";
      callback.__raw = ''
        function()
          require("neo-tree.sources.manager").refresh("filesystem")
        end
      '';
    }
  ];
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
