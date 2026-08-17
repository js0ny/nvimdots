# nvimdots

This flake exposes the configuration as both a package and Nixvim modules.


## Branches

- [lazy.nvim setup](https://github.com/js0ny/nvimdots/tree/lazy)

## Usage

### Run without installation

```bash
# run in terminal
nix run github:js0ny/nvimdots/nixvim
nix run github:js0ny/nvimdots/nixvim#minimal # closure ~685 MB, with 300MB of Treesitter
nix run github:js0ny/nvimdots/nixvim#full
nix run github:js0ny/nvimdots/nixvim#neovide # run with neovide, based on the default profile
```

### Install to system

```nix
# flake.nix
{
  inputs = {
    nvimdots.url = "github:js0ny/nvimdots/nixvim";
  };
}
```

#### Install with packages

```nix
{
  # or home.packages
  environment.systemPackages = [  inputs.nvimdots.packages.${pkgs.stdenv.hostPlatform.system}.default   ];
}
```

#### NixOS Module

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

#### Home Manager Module

```nix
{
  imports = [ inputs.nvimdots.homeModules.default ];

  programs.nixvim = {
    enable = true;
    globalOpts.number = lib.mkForce false;
  };
}
```
