# nvimdots

This flake exposes the configuration as both a package and Nixvim modules.

## Branches

- [lazy.nvim setup](https://github.com/js0ny/nvimdots/tree/lazy)

```nix
# flake.nix
{
  inputs = {
    nvimdots.url = "github:js0ny/nvimdots/nixvim";
  };
}
```

## Install with packages

```nix
{
  # or home.packages
  environment.systemPackages = [  inputs.nvimdots.packages.${pkgs.stdenv.hostPlatform.system}.default   ];
}
```

## NixOS Module

```nix
{
  imports = [ inputs.nvimdots.nixosModules.default ];

  programs.nixvim = {
    enable = true;

    # Existing preset values need an explicit module-system override.
    globalOpts.number = lib.mkForce false;
  };
}
```

## Home Manager Module

```nix
{
  imports = [ inputs.nvimdots.homeModules.default ];

  programs.nixvim = {
    enable = true;
    globalOpts.number = lib.mkForce false;
  };
}
```
