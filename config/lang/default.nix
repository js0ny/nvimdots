{ myLib, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = myLib.scanPaths ./.;
  plugins.schemastore = {
    enable = true;
    yaml.enable = mkDefault false;
    json.enable = mkDefault false;
  };
}
