{
  plugins.neogit = {
    enable = true;
    settings = {
      console_timeout = 0;
      status = {
        mode_text = {
          M = "[M] modified";
          N = "[N] new file";
          A = "[A] added";
          D = "[D] deleted";
          C = "[C] copied";
          U = "[U] updated";
          R = "[R] renamed";
          T = "[T] changed";
          DD = "[DD] unmerged";
          AU = "[AU] unmerged";
          UD = "[UD] unmerged";
          UA = "[UA] unmerged";
          DU = "[DU] unmerged";
          AA = "[AA] unmerged";
          UU = "[UU] unmerged";
          "?" = "";
        };
      };
    };
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
