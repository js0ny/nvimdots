{ myLib, ... }: {
  imports = myLib.scanPaths ./.;
  plugins.lsp = {
    enable = true;
    servers.emmet_ls = {
      enable = true;
    };
  };
}
