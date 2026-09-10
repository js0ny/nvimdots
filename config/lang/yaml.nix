{ pkgs, config, ... }:
let
  cfg = config.js0ny.configFiles;
  gatePackage = p: if cfg.enable then p else null;
in
{
  plugins = {
    lsp.servers.yamlls = {
      enable = true;
      package = gatePackage pkgs.yaml-language-server;
    };
    schemastore = {
      enable = true;
      yaml.enable = true;
    };
  };
}
