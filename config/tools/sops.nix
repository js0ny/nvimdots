{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.js0ny.vimPlugins.sops-nvim
  ];
  extraConfigLua = /* lua */ ''
    require("sops").setup({})
  '';
}
