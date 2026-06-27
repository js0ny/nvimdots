{
  description = "Public flake for my personal NixOS and Home Manager configurations";

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      flake.homeModules.default = import ./hm.nix { inherit inputs; };

      perSystem =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        let
          extraPackages = with pkgs; [
            lua5_1
            lua51Packages.luarocks
            lua-language-server
            stylua
            tree-sitter
            nodejs-slim_26
            pkg-config
            markdown-oxide
            ripgrep
            ast-grep
            clang
          ];
        in
        {
          packages.default = pkgs.symlinkJoin {
            name = "nvimdots";
            paths = [ pkgs.neovim ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              mkdir -p $out/share/nvimdots
              cp -r ${./.}/. $out/share/nvimdots/

              wrapProgram $out/bin/nvim \
                --set NVIMDOTS_READONLY_CONFIG 1 \
                --set NVIM_APPNAME nvimdots \
                --set XDG_CONFIG_HOME $out/share \
                --run 'export XDG_DATA_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}"' \
                --run 'export XDG_STATE_HOME="''${XDG_STATE_HOME:-$HOME/.local/state}"' \
                --run 'export XDG_CACHE_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}"' \
                --prefix PATH : ${lib.makeBinPath extraPackages}
            '';
          };

          apps.default = {
            type = "app";
            program = "${config.packages.default}/bin/nvim";
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              lua5_1
              selene
              stylua
              lua-language-server
            ];
          };
        };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
