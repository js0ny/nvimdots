let
  sysFlake = /* nix */ ''(builtins.getFlake "github:js0ny/nixcfgs")'';
in
{
  plugins.lsp.servers = {
    nixd = {
      enable = true;
      settings = {
        nixpkgs.expr = "import <nixpkgs> { }";
        formatting.command = [ "nixfmt" ];
        options = rec {
          nixos.expr = /* nix */ "${sysFlake}.nixosConfigurations.crystal.options";
          nix-darwin.expr = /* nix */ "${sysFlake}.darwinConfigurations.zen.options";
          home-manager.expr = /* nix */ "${nixos.expr}.home-manager.users.type.getSubOptions []";
          flake-parts.expr = /* nix */ "${sysFlake}.debug.options";
          nixvim.expr = /* nix */ "${sysFlake}.inputs.nixvim.nixvimConfigurations.aarch64-linux.default.options";
        };
      };
    };
  };
}
