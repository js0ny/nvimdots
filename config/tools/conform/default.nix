_: {
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
        nu = [ "nufmt" ];
        python = [
          "ruff"
          "black"
        ];
        json = [ "jq" ];
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
      default_format_opts = {
        lsp_format = "fallback";
      };
    };
  };
  globalOpts = {
    formatexpr = /* vim */ "v:lua.require'conform'.formatexpr()";
  };
}
