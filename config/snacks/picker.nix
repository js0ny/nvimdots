{
  plugins.snacks.settings.picker = {
    enabled = true;
    ui_select = true;
    recent = {
      finder = "recent_files";
      format = "file";
      filter = {
        paths = {
          "*.png" = false;
          "*.jpg" = false;
        };
      };
    };
  };
  keymaps = [
    {
      key = "<leader><space>";
      action.__raw =
        # lua
        ''
          function()
            require('snacks').picker.smart()
          end
        '';
      options.desc = "Pick files";
    }
    {
      key = "<leader>/";
      action.__raw =
        # lua
        ''
          function()
            require('snacks').picker.grep()
          end
        '';
      options.desc = "Grep files";
    }
    {
      key = "<leader>R";
      action.__raw =
        # lua
        ''
          function()
            require('snacks').picker.resume()
          end
        '';
      options.desc = "Resume last pick";
    }
  ];
}
