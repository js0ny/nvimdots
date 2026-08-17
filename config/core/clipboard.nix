{ pkgs, config, ... }:
{
  clipboard.providers = {
    pbcopy.enable = pkgs.stdenv.hostPlatform.isDarwin;
    wl-copy.enable = config.js0ny.wayland.enable;
  };
  globalOpts = {
    clipboard = "unnamedplus";
  };
}
