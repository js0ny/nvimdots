{
  plugins.treesitter-context = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        keys = [ "<leader>tc" ];
        cmd = [ "TSContext" ];
      };
    };
    settings = {
      max_lines = 5;
      mode = "topline";
    };
  };
  keymaps = [
    {
      key = "<leader>tc";
      action.__raw = /* lua */ ''
        function()
          require('treesitter-context').toggle()
        end
      '';
      options.desc = "Toggle Treesitter Context";
    }
  ];
}
