{
  plugins.lazydev = {
    enable = true;
    lazyLoad.settings = {
      ft = [ "lua" ];
    };
    settings = {
      enabled = /* lua */ ''
        function()
          return vim.g.lazydev_enabled = nil and true or vim.g.lazydev_enabled
        end
      '';
      library = [
        {
          path = "\${3rd}/luv/library";
          words = [ "vim%.uv" ];
        }
      ];
    };
  };
}
