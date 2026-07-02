{
  imports = [ ./picker.nix ./dashboard.nix];
  plugins.snacks = {
    enable = true;
    settings = {
      images.enabled = true;
    };
  };
}
