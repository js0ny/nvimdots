{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.js0ny.cxx;
  gatePackage = p: if cfg.enable then p else null;
  codelldb = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
  launch = {
    type = "codelldb";
    request = "launch";
    name = "Launch executable";
    program.__raw = /* lua */ ''
      function()
        return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
      end
    '';
    cwd = "\${workspaceFolder}";
  };
  localOpts = {
    expandtab = true;
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
  };
in
{
  plugins.lsp.servers = {
    clangd = {
      enable = true;
      package = gatePackage pkgs.clang-tools;
      extraOptions.cmd.__raw = /* lua */ ''
        function(dispatchers, config)
          -- The fallback style is fixed when clangd starts and shared by buffers using this client.
          local cmd = {
            "clangd",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style={BasedOnStyle: LLVM, IndentWidth: " .. vim.fn.shiftwidth() .. "}",
          }
          return vim.lsp.rpc.start(cmd, dispatchers, { cwd = config.cmd_cwd, env = config.cmd_env })
        end
      '';
      filetypes = [
        "c"
        "cpp"
        "cuda"
      ];
      rootMarkers = [
        ".clangd"
        ".clang-format"
        "compile_commands.json"
        "compile_flags.txt"
      ];
    };
  };
  plugins.dap = lib.mkIf cfg.enable {
    adapters.servers.codelldb = {
      port = "\${port}";
      executable = {
        command = codelldb;
        args = [
          "--port"
          "\${port}"
        ];
      };
    };
    configurations = {
      c = [ launch ];
      cpp = [ launch ];
      rust = [ launch ];
    };
  };

  files = {
    "after/ftplugin/c.lua" = { inherit localOpts; };
    "after/ftplugin/cpp.lua" = { inherit localOpts; };
  };
}
