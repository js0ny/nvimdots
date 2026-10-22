{ lib, ... }:
let
  inherit (lib.nixvim.utils) listToUnkeyedAttrs;
  localOpts = {
    expandtab = true;
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
  };
  prettier = (
    /*nixfmt:disable*/
    listToUnkeyedAttrs [ "prettierd" "prettier" ]
    // { stop_after_first = true; }
    /*nixfmt:enable*/
  );
in
{
  files = {
    "after/ftplugin/javascript.lua" = { inherit localOpts; };
    "after/ftplugin/typescript.lua" = { inherit localOpts; };
    "after/ftplugin/javascriptreact.lua" = { inherit localOpts; };
    "after/ftplugin/typescriptreact.lua" = { inherit localOpts; };
    "after/ftplugin/svelte.lua" = { inherit localOpts; };
    "after/ftplugin/vue.lua" = { inherit localOpts; };
  };
}
