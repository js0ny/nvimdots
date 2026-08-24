{ lib, ... }:
let
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
in
{
  plugins = {
    conform-nvim.settings.formatters_by_ft = {
      json = [ "jq" ];
      jsonc = prettier;
    };

    lsp.servers.jsonls.enable = lib.mkDefault false;
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
