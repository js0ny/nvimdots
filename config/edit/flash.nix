{ pkgs, ... }:
{
  plugins.flash = {
    enable = true;
  };
  extraPlugins = [
    pkgs.js0ny.vimPlugins.flash-any-nvim
  ];
  extraConfigLua = /* lua */ ''
    require("flash-any").setup({
      sources = {
        { name = "pinyin", scheme = "natural" },
        "nerdfont",
        "unicode",
      },
    })
  '';
  keymaps = [
    {
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      action.__raw = /* lua */ ''function() require("flash-any").jump() end'';
    }
    {
      key = "S";
      mode = [
        "n"
        "x"
        "o"
      ];
      action.__raw = /* lua */ ''function() require("flash").treesitter() end'';
    }
  ];
}
