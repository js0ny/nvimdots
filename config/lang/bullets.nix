let
  ft = [
    "markdown"
    "gitcommit"
  ];
in
{
  plugins.bullets = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        inherit ft;
      };
    };
  };
  globals.bullets_enabled_file_types = ft;

}
