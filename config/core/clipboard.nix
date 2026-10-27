_: {
  globals.clipboard.__raw = /* lua */ ''
    (function()
      local term_program = vim.env.TERM_PROGRAM
      local term = vim.env.TERM
      local use_osc52_paste = term_program == "kitty" or term_program == "ghostty"
        or term == "xterm-kitty" or term == "xterm-ghostty"
      local osc52 = require("vim.ui.clipboard.osc52")
      local clipboard = { name = "OSC 52 with paste fallback", copy = {}, paste = {} }

      for _, register in ipairs({ "+", "*" }) do
        local cached = { { "" }, "v" }
        local copy = osc52.copy(register)
        local paste = osc52.paste(register)
        clipboard.copy[register] = function(lines, regtype)
          cached = { vim.deepcopy(lines), regtype }
          copy(lines, regtype)
        end
        clipboard.paste[register] = function()
          if use_osc52_paste then
            return paste()
          end
          return vim.deepcopy(cached)
        end
      end

      vim.api.nvim_create_user_command("OSC52PasteToggle", function()
        use_osc52_paste = not use_osc52_paste
        vim.notify("OSC 52 paste " .. (use_osc52_paste and "enabled" or "disabled (using cached registers)"))
      end, { desc = "Toggle OSC 52 paste" })

      return clipboard
    end)()
  '';
  globalOpts = {
    clipboard = "unnamedplus";
  };
}
