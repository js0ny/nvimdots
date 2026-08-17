{ pkgs, ... }: {
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
}
