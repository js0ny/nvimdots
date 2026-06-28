{ lib, ... }:
let
  inherit (lib.nixvim.utils) listToUnkeyedAttrs;
in
{
  plugins.conform-nvim = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        cmd = [ "ConformInfo" ];
      };
    };
    settings = {
      formatters_by_ft = {
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        nu = [ "nufmt" ];
        python = [ "ruff" ];
        javascript = (
          listToUnkeyedAttrs [
            "prettierd"
            "prettier"
          ]
          // {
            stop_after_first = true;
          }
        );
      };
      default_format_opts = {
        lsp_format = "fallback";
      };
      formatters = {
        shfmt = {
          prepend_args = [
            "-i"
            "2"
          ];
        };
      };
    };
  };
  extraConfigLuaPost = /* lua */ ''
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  '';
}
