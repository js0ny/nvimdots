{ myLib, ... }: {
  imports = myLib.scanPaths ./.;
  plugins.lsp = {
    enable = true;
    servers = {
      lua_ls.enable = true;
    };
  };
}
