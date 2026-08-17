{ myLib, ... }: {
  imports = myLib.scanPaths ./.;
  plugins.lsp = {
    enable = true;
  };
}
