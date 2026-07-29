{ pkgs, ... }:
let
  sops = pkgs.callPackage ../../packages/sops.nix { };
in
{
  extraPlugins = [
    sops
  ];
  extraConfigLua = /* lua */ ''
    require("sops").setup({})
  '';
}
