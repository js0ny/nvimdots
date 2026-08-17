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
          mkPackage = extraModules: import ./package.nix { inherit extraModules inputs pkgs; };
          mkProfile = enabled: {
            js0ny =
              lib.genAttrs
                [
                  "image"
                  "lua"
                  "nix"
                  "typst"
                ]
                (_: {
                  enable = enabled;
                })
              // {
                wayland.enable = enabled && lib.meta.availableOn pkgs.stdenv.hostPlatform pkgs.wl-clipboard;
              };
          };
          package = mkPackage [ ];
          full = mkPackage [ (mkProfile true) ];
          minimal = mkPackage [ (mkProfile false) ];
        in
        {
          checks.default = package.config.build.test;
          packages = rec {
            default = package;
            inherit full minimal;
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
    js0ny-packages.url = "git+ssh://forgejo@git.js0ny.net:2220/infra/miscpkgs.git";
  };
}
