{ myLib, ... }: {
  imports = myLib.scanPaths ./.;
  extraConfigLua = builtins.readFile ./commands.lua;
}
