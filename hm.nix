{ inputs }:

{
  pkgs,
  config,
  lib,
  ...
}:
let
  withImg = config.programs.kitty.enable || config.programs.ghostty.enable;
in
{
  programs.neovim = {
    enable = true;
    sideloadInitLua = true;
    defaultEditor = true;
    withNodeJs = false;
    withPerl = false;
    withRuby = false;
    withPython3 = false;
    extraPackages =
      with pkgs;
      [
        # lua devenvs (luajit)
        lua5_1
        lua51Packages.luarocks
        lua-language-server
        stylua
        # tree-sitter
        tree-sitter
        # copilot-lua
        nodejs-slim_26
        # snacks.image
        pkg-config
        markdown-oxide
        # cli deps
        ripgrep
        ast-grep
        # cc
        clang
      ]
      ++ (lib.optionals withImg) (
        with pkgs;
        [
          mermaid-cli
          imagemagick
          tectonic
          ghostscript_headless
        ]
      );
    extraLuaPackages =
      ps:
      [
        ps.tree-sitter-cli
      ]
      ++ lib.optionals withImg [
        ps.magick
      ];
  };

  xdg.configFile."nvim".source = ./.;

}
