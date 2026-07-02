{
  imports = [
    ./nixd.nix
    ./nil.nix
    ./keymaps.nix
  ];
  plugins.lsp = {
    enable = true;
    servers = {
      lua_ls.enable = true;
    };
  };
}
