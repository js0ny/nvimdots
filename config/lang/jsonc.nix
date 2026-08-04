{ lib, ... }:
let
  inherit (lib.nixvim.utils) listToUnkeyedAttrs;
  prettier = (
    /*nixfmt:disable*/
    listToUnkeyedAttrs [ "prettierd" "prettier" ]
    // { stop_after_first = true; }
    /*nixfmt:enable*/
  );
in
{
  plugins = {
    conform-nvim.settings.formatters_by_ft.jsonc = prettier;

    lsp.servers.jsonls.enable = lib.mkDefault false;
  };

  files."after/ftplugin/jsonc.lua" = {
    localOpts = {
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
    };
  };
}
