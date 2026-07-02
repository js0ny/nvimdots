{
  plugins.treesitter-textobjects = {
    enable = true;
    settings = {
      enable = true;
      lookahead = true;
      move.set_jumps = true;
      select = {
        lookahead = true;
        include_surrounding_whitespace = true;
      };
    };
  };
}
