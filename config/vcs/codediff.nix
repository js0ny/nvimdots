{
  plugins.codediff = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        cmd = ["CodeDiff"];
      };
    };
    settings = {
      highlights = {
        line_insert = "DiffAdd";
        line_delete = "DiffDelete";
      };
      explorer.position = "left";
      keymaps = {
        view = {
          toggle_stage = "s";
        };
      };
    };
  };
}
