{
  plugins.luasnip = {
    enable = true;
    lazyLoad.settings = {
      event = [ "InsertEnter" ];
    };
    fromVscode = [ { paths = "~/.config/lsp-snippets"; } ];
    settings = {
      enable_autosnippets = true;
      history = true;
    };
  };
}
