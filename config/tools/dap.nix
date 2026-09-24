{
  plugins.dap = {
    enable = true;
  };
  plugins.dap-ui.enable = true;
  extraConfigLua = /* lua */ ''
    local dap = require("dap")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      require("dapui").close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      require("dapui").close()
    end
  '';
  keymaps = [
    {
      key = "<leader>db";
      action.__raw = /* lua */ ''require("dap").toggle_breakpoint'';
      options.desc = "Toggle breakpoint";
    }
    {
      key = "<leader>dc";
      action.__raw = /* lua */ ''require("dap").continue'';
      options.desc = "Start / continue debugging";
    }
    {
      key = "<leader>dn";
      action.__raw = /* lua */ ''require("dap").step_over'';
      options.desc = "Step over";
    }
    {
      key = "<leader>di";
      action.__raw = /* lua */ ''require("dap").step_into'';
      options.desc = "Step into";
    }
    {
      key = "<leader>do";
      action.__raw = /* lua */ ''require("dap").step_out'';
      options.desc = "Step out";
    }
    {
      key = "<leader>dt";
      action.__raw = /* lua */ ''require("dap").terminate'';
      options.desc = "Terminate debugging";
    }
    {
      key = "<leader>du";
      action.__raw = /* lua */ ''require("dapui").toggle'';
      options.desc = "Toggle debug UI";
    }
  ];
}
