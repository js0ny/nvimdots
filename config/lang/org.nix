{
  plugins.orgmode = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        ft = [ "org" ];
      };
    };
  };
  plugins.blink-cmp.settings.sources = {
    per_filetype.org = [ "orgmode" ];
    providers.orgmode = {
      name = "Orgmode";
      module = "orgmode.org.autocompletion.blink";
      fallbacks = [ "buffer" ];
    };
  };
}
