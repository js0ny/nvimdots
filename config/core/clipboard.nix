{ pkgs, ... }:
{
  clipboard.providers = {
    pbcopy.enable = pkgs.stdenv.isDarwin;
    wl-copy.enable = pkgs.stdenv.isLinux;
  };
  globalOpts = {
    clipboard = "unnamedplus";
  };
}
