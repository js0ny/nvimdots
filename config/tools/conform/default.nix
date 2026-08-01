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
        event = [ "BufWritePre" ];
        cmd = [
          "ConformInfo"
          "Format"
          "FormatToggle"
        ];
        before.__raw = /* lua */ ''
          function()
            ${builtins.readFile ./format.lua}
          end
        '';
      };
    };
    settings = {
      formatters_by_ft = {
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        nu = [ "nufmt" ];
        python = [
          "ruff"
          "black"
        ];
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
      format_on_save.__raw = /* lua */ ''
        function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end
      '';
    };
  };
  globalOpts = {
    formatexpr = /* vim */ "v:lua.require'conform'.formatexpr()";
  };
}
