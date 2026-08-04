{ lib, ... }: {
  plugins = {
    conform-nvim.settings.formatters_by_ft.json = [ "jq" ];

    lsp.servers.jsonls.enable = lib.mkDefault false;
  };

  files."after/ftplugin/json.lua" = {
    localOpts = {
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
    };
  };
}
