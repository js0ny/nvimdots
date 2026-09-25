{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.js0ny.vimPlugins.code-runner-nvim
  ];
  extraConfigLua = /* lua */ ''
      require("code_runner").setup({
      mode = "float",
      filetype = {
        python = "python3 -u",
        javascript = "node",
      },
    })
  '';
}
