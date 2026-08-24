{ myLib, ... }: {
  imports = myLib.scanPaths ./.;
  plugins.snacks = {
    enable = true;
    settings = {
      input.enabled = true;
      indent.enabled = true;
      terminal.enabled = true;
    };
  };
  keymaps = [
    {
      key = "<leader>gB";
      action.__raw = /* lua */ ''
        function() require("snacks").git.blame_line() end
      '';
      options.desc = "Blame line";
    }
    {
      key = "<leader>fR";
      action.__raw = /* lua */ ''
        function() require("snacks").rename.rename_file() end
      '';
      options.desc = "Rename file";
    }
  ];
  extraConfigLua = builtins.readFile ./commands.lua;
}
