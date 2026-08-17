{
  description = "Neovim configuration";
  outputs =
    {
      nixpkgs,
      nixvim,
      flake-parts,
      js0ny-packages,
      ...
    }@inputs:
    let
      myLib = import ./lib { lib = nixpkgs.lib; };
      moduleConfiguration = nixvim.lib.evalNixvim {
        modules = [
          ./config
          { nixpkgs.overlays = [ js0ny-packages.overlays.default ]; }
        ];
        extraSpecialArgs = {
          inherit inputs myLib;
        };
      };
      inherit (moduleConfiguration.config.build) homeModule nixosModule;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { pkgs, lib, ... }:
        let
          package = import ./package.nix { inherit inputs pkgs; };
        in
        {
          checks.default = package.config.build.test;
          packages = rec {
            default = package;
            neovide = pkgs.writeShellScriptBin "neovide" ''
              ${lib.getExe pkgs.neovide} --neovim-bin ${lib.getExe default}
            '';
          };
        };
      flake = {
        homeModules = rec {
          default = nixvim;
          nixvim = homeModule;
        };
        nixosModules = {
          default = nixosModule;
          nixvim = nixosModule;
        };
      };
    };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    js0ny-packages.url = "github:js0ny/miscpkgs";
  };
}
