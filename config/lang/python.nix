{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.js0ny.python;
  gatePackage = p: if cfg.enable then p else null;
  debugpyPython = "${pkgs.python3.withPackages (ps: [ ps.debugpy ])}/bin/python";
  launch = {
    type = "debugpy";
    request = "launch";
    name = "Launch current file";
    program.__raw = /* lua */ ''
      function()
        return vim.fn.expand("%:p")
      end
    '';
    pythonPath.__raw = /* lua */ ''
      function()
        for _, env in ipairs({ "VIRTUAL_ENV", "CONDA_PREFIX" }) do
          local prefix = vim.env[env]
          if prefix and vim.fn.executable(prefix .. "/bin/python") == 1 then
            return prefix .. "/bin/python"
          end
        end
        local python = vim.fn.exepath("python3")
        return python ~= "" and python or "${debugpyPython}"
      end
    '';
    cwd = "\${workspaceFolder}";
    console = "internalConsole";
  };
in
{
  plugins.lsp.servers = {
    ty = {
      enable = true;
      package = gatePackage pkgs.ty;
    };
    ruff = {
      enable = true;
      package = gatePackage pkgs.ruff;
      settings = lib.mkDefault {
        init_options.settings = {
          lint.ignore = [
            "EXE001" # shebang-not-executable: This will report false negative when envfs enabled
          ];
        };
      };
    };
  };
  plugins.dap = lib.mkIf cfg.enable {
    adapters.executables.debugpy = {
      command = debugpyPython;
      args = [
        "-m"
        "debugpy.adapter"
      ];
    };
    configurations.python = [ launch ];
  };
}
