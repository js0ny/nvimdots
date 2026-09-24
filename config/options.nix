{ pkgs, lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.js0ny = {
    # keep-sorted start block=yes
    configFiles.enable = lib.mkOption {
      description = "Config Files editing support";
      default = true;
    };
    cxx.enable = mkEnableOption "C/C++/Cuda toolchain support";
    image.enable = mkEnableOption "Snacks image support";
    lua.enable = lib.mkOption {
      description = "Lua support";
      default = true;
    };
    nix.enable = lib.mkOption {
      description = "Nix support";
      default = true;
    };
    python.enable = mkEnableOption "Python toolchain support";
    typst.enable = mkEnableOption "Typst toolchain support";
    wayland.enable = lib.mkOption {
      description = "Wayland / Linux Desktop support";
      default = pkgs.stdenv.hostPlatform.isLinux;
    };
    # keep-sorted end
  };
}
