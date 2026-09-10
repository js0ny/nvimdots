{ pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.js0ny = {
    image.enable = mkEnableOption "Snacks image support";
    typst.enable = mkEnableOption "Typst toolchain support";
    python.enable = mkEnableOption "Python toolchain support";
    wayland.enable = lib.mkOption {
      description = "Wayland / Linux Desktop support";
      default = pkgs.stdenv.hostPlatform.isLinux;
    };
    nix.enable = lib.mkOption {
      description = "Nix support";
      default = true;
    };
    configFiles.enable = lib.mkOption {
      description = "Config Files editing support";
      default = true;
    };
    lua.enable = lib.mkOption {
      description = "Lua support";
      default = true;
    };
  };
}
