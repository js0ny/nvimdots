{ myLib, ... }: {
  imports = myLib.scanPaths ./.;
  plugins.snacks = {
    enable = true;
    settings = {
      image.enabled = true;
      input.enabled = true;
    };
  };
}
