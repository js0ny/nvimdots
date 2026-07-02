{
  plugins.treesj = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        keys = [ "gJ" ];
      };
    };
    settings = {
      use_default_keymaps = false;
    };
  };
  keymaps = [
    {
      key = "gJ";
      action.__raw = /* lua */ ''
        function()
          require('treesj').join()
        end
      '';
      options.desc = "Join lines";
    }
  ];
}
