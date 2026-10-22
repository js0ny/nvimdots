_: {
  globals.clipboard.__raw = /* lua */ ''
    (function()
      local term_program = vim.env.TERM_PROGRAM
      local term = vim.env.TERM
      if term_program == "kitty" or term_program == "ghostty"
        or term == "xterm-kitty" or term == "xterm-ghostty" then
        return "osc52"
      end
      return nil
    end)()
  '';
  globalOpts = {
    clipboard = "unnamedplus";
  };
}
