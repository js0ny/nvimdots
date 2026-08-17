let
  ft = [
    "markdown"
    "Avante"
  ];
in
{
  plugins.render-markdown = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        event = [ "BufRead" ];
        inherit ft;
      };
    };
    settings = {
      file_types = ft;
      render_modes = [
        "n"
        "c"
        "t"
      ];
      latex = {
        enabled = false;
        converter = "latex2text";
        highlight = "RenderMarkdownMath";
        top_pad = 0;
        bottom_pad = 0;
      };
      link.custom = {
        python = {
          pattern = "%.py";
          icon = " ";
        };
        lua = {
          pattern = "%.lua";
          icon = " ";
        };
        markdown = {
          pattern = "%.md";
          icon = " ";
        };
        nix = {
          pattern = "%.nix";
          icon = "󱄅 ";
        };
        rust = {
          pattern = "%.rust";
          icon = " ";
        };
      };
      bullet.icons = [
        "󰮯 "
        "● "
        "○ "
        "◆ "
        "◇ "
      ];
      code = {
        position = "right";
        width = "block";
        right_pad = 10;
      };
    };

  };
}
