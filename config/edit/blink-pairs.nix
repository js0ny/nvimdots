{ lib, ... }:
let
  inherit (lib.nixvim.utils) listToUnkeyedAttrs mkRaw;
in
{
  plugins.blink-pairs = {
    enable = true;
    settings = {
      mappings = {
        enabled = true;
        cmdline = true;
        disabled_filetypes = [ ];
        pairs.__raw = /* lua */ ''
          function()
           ${builtins.readFile ./blink-pairs-pairs.lua}
          end
        '';
      };
      highlights = {
        enabled = true;
        cmdline = true;
        groups = [
          "BlinkPairsOrange"
          "BlinkPairsPurple"
          "BlinkPairsBlue"
        ];
        unmatched_group = "BlinkPairsUnmatched";
        matchparen = {
          enabled = true;
          cmdline = false;
          include_surrounding = false;
          group = "BlinkPairsMatchParen";
          priority = 250;
        };
      };
    };
  };
}
