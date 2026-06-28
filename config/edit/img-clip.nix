{
  plugins.img-clip = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        ft = [
          "avante"
          "markdown"
          "typst"
          "org"
          "tex"
        ];
        cmd = ["PasteImage"];
        keys = ["<localleader>p"];
      };
    };
    settings = {
      default = {
        embed_image_as_base64 = false;
        prompt_for_file_name = false;
        drag_and_drop.insert_mode = true;
        use_absolute_path = true;
      };
    };
  };
  keymaps = [
    {
      mode = ["n"];
      key = "<localleader>p";
      action.__raw = ''
        function()
          require("img-clip").paste_image()
        end
      '';
      options.desc = "Paste image from clipboard";
    }
  ];
}
