{
  plugins.ts-autotag = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        ft = [
          "html"
          "javascriptreact"
          "typescriptreact"
          "vue"
          "svelte"
          "xml"
        ];
      };
    };
  };
}
