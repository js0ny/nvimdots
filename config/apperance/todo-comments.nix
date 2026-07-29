{
  plugins.todo-comments = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        event = [ "BufRead" ];
        cmd = [
          "TodoTrouble"
          "TodoQuickFix"
          "TodoLocList"
          "TodoSnacks"
        ];
      };
    };
  };
}
