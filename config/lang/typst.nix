{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.js0ny.typst.enable {
  plugins.typst-preview = {
    enable = true;
    settings = {
      dependencies_bin = {
        tinymist = lib.mkDefault (lib.getExe pkgs.tinymist);
        websocat = lib.mkDefault (lib.getExe pkgs.websocat);
      };
    };
  };
}
