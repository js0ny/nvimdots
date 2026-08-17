{ config, ... }:
{
  plugins.treesitter = {
    enable = true;
    grammarPackages = config.plugins.treesitter.package.allGrammars;
    highlight.enable = true;
    indent.enable = true;
    folding.enable = true;
  };
}
