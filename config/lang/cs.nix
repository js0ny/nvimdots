{
  # autoCmd is preferred, which has higher priority
  autoCmd = [
    {
      event = "FileType";
      pattern = "cs";
      callback.__raw = ''
        function() 
          vim.bo.indentexpr = "" 
          vim.bo.cindent = true 
        end 
      '';
    }
  ];
  # not working, cannot override treesitter settings
  files."after/ftplugin/cs.lua" = {
    localOpts = {
      indentexpr = "";
      cindent = true;
    };
  };
}
