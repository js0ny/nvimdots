let
  q = s: ''"${s}"'';
  mapq = builtins.mapAttrs (_: value: q value);
  dsigns = mapq {
    Error = "";
    Warning = "";
    Hint = "";
    Information = "";
  };
in
{
  diagnostic.settings = {
    virtual_text = true;
    virtual_lines = false;
    severity_sort = true;
    update_in_insert = true;
    float = true;
    signs.text.__raw = /* lua */ ''
      {
        [vim.diagnostic.severity.HINT] = ${dsigns.Hint},
        [vim.diagnostic.severity.WARN] = ${dsigns.Warning},
        [vim.diagnostic.severity.ERROR] = ${dsigns.Error},
      }
    '';
  };
}
