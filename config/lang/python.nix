{ pkgs, config, ... }:
let
  cfg = config.js0ny.python;
  gatePackage = p: if cfg.enable then p else null;
in
{
  plugins = {
    lsp.servers = {
      basedpyright = {
        enable = true;
        package = gatePackage pkgs.basedpyright;
      };
      ruff = {
        enable = true;
        package = gatePackage pkgs.ruff;
      };
    };
  };
}
