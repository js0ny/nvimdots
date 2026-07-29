{
  inputs,
  pkgs,
}:
let
  pkgs' = pkgs.extend inputs.js0ny-packages.overlays.default;
  myLib = import ./lib { lib = pkgs'.lib; };
  configuration = inputs.nixvim.lib.evalNixvim {
    modules = [
      ./config
      { nixpkgs.pkgs = pkgs'; }
    ];
    extraSpecialArgs = {
      inherit inputs myLib;
    };
  };
in
configuration.config.build.package
