{
  lib,
  pkgs,
  config,
  ...
}:
let
  sysFlake = /* nix */ ''(builtins.getFlake "github:js0ny/nixcfgs")'';
  cfg = config.js0ny.nix;
  gatePackage = p: if cfg.enable then p else null;
in
{
  plugins = {
    conform-nvim.settings = {
      formatters_by_ft.nix = [
        "nixfmt"
        "keep-sorted"
      ];
      formatters.nixfmt.args = [ "-" ];
    };
    lsp.servers = {
      nixd = {
        enable = true;
        package = gatePackage pkgs.nixd;
        settings = {
          nixpkgs.expr = /* nix */ "import ${sysFlake}.inputs.nixpkgs { overlays = ${sysFlake}.outputs.allOverlays; }";
          formatting.command = [ "nixfmt" ];
          options = rec {
            nixos.expr = /* nix */ "${sysFlake}.nixosConfigurations.crystal.options";
            # nix-darwin.expr = /* nix */ "${sysFlake}.darwinConfigurations.zen.options";
            home-manager.expr = /* nix */ "${nixos.expr}.home-manager.users.type.getSubOptions []";
            flake-parts.expr = /* nix */ "${sysFlake}.debug.options";
            nixvim.expr = /* nix */ ''(builtins.getFlake "github:js0ny/nvimdots/nixvim").inputs.nixvim.nixvimConfigurations.aarch64-linux.default.options'';
          };
        };
      };
      nil_ls = {
        enable = true;
        package = gatePackage pkgs.nil;
        onAttach.function = /* lua */ ''
          if client.name == 'nil_ls' then
            client.server_capabilities.definitionProvider = false -- use nixd
            client.server_capabilities.renameProvider = false -- use nixd
          end
        '';
      };

    };
  };

  files."after/ftplugin/nix.lua" = {
    localOpts = {
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
    };
  };
  extraPackages = lib.optionals (cfg.enable) [ pkgs.nixfmt ];
}
