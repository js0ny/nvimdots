{
  plugins.multicursors = {
    enable = true;
    lazyLoad.settings = {
      event = [ "InsertEnter" ];
    };
    settings = {
      DEBUG_MODE = true;
      create_commands = false;
      hint_config = {
        position = "top";
        type = "cmdline";
      };
      normal_keys = {
        "," = {
          method = {
            __raw = "require('multicursors.normal_mode').clear_others";
          };
          opts = {
            desc = "Clear others";
          };
        };
      };
    };
  };
}
