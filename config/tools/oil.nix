{
  plugins.oil = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        cmd = [ "Oil" ];
      };
    };
    settings = {
      delete_to_trash = true;
      default_file_explorer = false; # ./neotree.nix
    };
  };
}
