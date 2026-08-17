{ lib, ... }:
let
  inherit (lib.nixvim.utils) listToUnkeyedAttrs mkRaw;
  pairCfg = pairs: cfg: (listToUnkeyedAttrs pairs // cfg);
in
{
  plugins.blink-pairs = {
    enable = true;
    settings = {
      mappings = {
        enabled = true;
        cmdline = true;
        disabled_filetypes = [ ];
        # https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L52
        pairs = {
          "'" = [
            (pairCfg [ "''" ] {
              languages = [ "nix" ];
              when.__raw = /* lua */ ''
                function(ctx)
                  function is_inside_string()
                    NODE = "string_fragment"
                    local ok, node = pcall(vim.treesitter.get_node)
                    if not ok or not node then return false end
                    while node do
                      if node:type() == NODE then return true end
                      node = node:parent()
                    end
                    return false
                  end
                  return ctx:text_before_cursor(1) == "'" and not is_inside_string()
                end
              '';
            })
          ];
        };
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
