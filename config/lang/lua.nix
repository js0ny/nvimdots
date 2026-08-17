{ pkgs, config, ... }:
let
  cfg = config.js0ny.lua;
  gatePackage = p: if cfg.enable then p else null;
in
{
  plugins.lsp = {
    servers = {
      lua_ls = {
        enable = true;
        package = gatePackage pkgs.lua-language-server;
      };
      stylua = {
        enable = true;
        package = gatePackage pkgs.stylua;
      };
    };
  };
  plugins.lazydev = {
    enable = true;
    settings = {
      enabled.__raw = /* lua */ ''
        function()
            return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
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
