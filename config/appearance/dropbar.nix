{
  plugins.dropbar = {
    enable = true;
    lazyLoad = {
      enable = false;
      settings = {
        keys = [
          "<leader>@"
          "[;"
          "];"
        ];
      };
    };
  };
  keymaps = [
    {
      key = "<Leader>@";
      action.__raw = /* lua */ ''
        function()
          require("dropbar.api").pick()
        end
      '';
      options.desc = "Pick symbols in winbar";
    }
    {
      key = "[;";
      action.__raw = /* lua */ ''
        function()
          require("dropbar.api").goto_context_start()
        end
      '';
      options.desc = "Go to start of current context";
    }
    {
      key = "];";
      action.__raw = /* lua */ ''
        function()
          require("dropbar.api").select_next_context()
        end
      '';
      options.desc = "Select next context";
    }
  ];
}
