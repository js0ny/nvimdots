let
  ft = [
    "markdown"
    "gitcommit"
    "typst"
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
