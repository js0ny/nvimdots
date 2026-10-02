{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.js0ny.markdown;
  gatePackage = p: if cfg.enable then p else null;
in
{
  imports = [
    ./render-markdown.nix
  ];
  extraPlugins = [ pkgs.js0ny.vimPlugins.typst-infect-nvim ];
  extraConfigLua = ''
    require('typst-infect').setup({
      org = {
        enabled = true,
        variants = {
          inline = true,
          display = true,
          latex_env = false,
          equation_block = false,
          src_blocks = {
            "typst",
            "typst_math",
            "math",
          },
        }
      }
    })
  '';
  plugins = {
    conform-nvim.settings.formatters_by_ft.markdown = [ "mdformat" ];

    lsp.servers.markdown_oxide = {
      enable = true;
      package = lib.mkDefault (gatePackage pkgs.markdown-oxide);
    };
  };

}
