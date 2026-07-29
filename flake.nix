{
  description = "Neovim configuration";
  outputs =
    {
      nixvim,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { pkgs, ... }:
        let
          package = import ./package.nix { inherit inputs pkgs; };
        in
        {
          checks.default = package.config.build.test;
          packages.default = package;
        };
    };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    js0ny-packages.url = "github:js0ny/miscpkgs";
  };
}
