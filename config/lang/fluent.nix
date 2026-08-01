{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.fluent-vim
  ];
  extraConfigLua = /* lua */ ''
    require("sops").setup({})
  '';
}
