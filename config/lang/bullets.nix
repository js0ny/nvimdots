{
  plugins.bullets = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        ft = [
          "markdown"
          "gitcommit"
          "typst"
        ];
      };
    };
  };
  extraConfigLuaPost = /* lua */ ''
    vim.g.bullets_enabled_file_types = { 'markdown', 'typst', 'gitcommit' }
  '';
}
