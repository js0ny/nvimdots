{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.js0ny.configFiles;
  inherit (lib.nixvim.utils) listToUnkeyedAttrs;
  prettier = (
    /*nixfmt:disable*/
    listToUnkeyedAttrs [ "prettierd" "prettier" ]
    // { stop_after_first = true; }
    /*nixfmt:enable*/
  );
  localOpts = {
    expandtab = true;
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
  };
  gatePackage = p: if cfg.enable then p else null;
in
{
  plugins = {
    conform-nvim.settings.formatters_by_ft = {
      json = [ "jq" ];
      jsonc = prettier;
    };
    lsp.servers.jsonls = {
      enable = true;
      package = gatePackage pkgs.vscode-langservers-extracted;
    };
    schemastore = {
      enable = true;
      json.enable = true;
    };
  };
  files = {
    "after/ftplugin/json.lua" = { inherit localOpts; };
    "after/ftplugin/jsonc.lua" = { inherit localOpts; };
  };
}
