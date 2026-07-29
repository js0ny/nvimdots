{
  nixvim,
  pkgs,
}:
let
  myLib = import ./lib { lib = pkgs.lib; };
  configuration = nixvim.lib.evalNixvim {
    modules = [
      ./config
      { nixpkgs.pkgs = pkgs; }
    ];
    extraSpecialArgs = {
      inherit myLib;
    };
  };
in
configuration.config.build.package
