{ config, ... }:
{
  plugins.treesitter = {
    enable = true;
    grammarPackages = config.plugins.treesitter.package.allGrammars;
  };
}
