{ pkgs, config, ... }:
{
  clipboard.providers = {
    pbcopy.enable = pkgs.stdenv.isDarwin;
    wl-copy.enable = config.js0ny.wayland.enable;
  };
  globalOpts = {
    clipboard = "unnamedplus";
  };
}
