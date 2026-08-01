let
  keepsl = key: {
    inherit key;
    mode = [ "v" ];
    action = "${key}gv";
    options.desc = "Indent ${key} and keep selection";
  };
  wrappedMove = key: action: desc: {
    inherit key;
    action = "v:count == 0 ? 'g${action}' : '${action}'";
    mode = [
      "n"
      "x"
    ];
    options = {
      inherit desc;
      expr = true;
      silent = true;
    };
  };
  wrappedJ = key: wrappedMove key "j" "Down";
  wrappedK = key: wrappedMove key "k" "Up";
in
{
  keymaps = [
    {
      key = "<Tab>";
      mode = [ "n" ];
      action = "%";
      options.desc = "Match pairs";
    }
    {
      key = "<C-c>";
      mode = [ "v" ];
      action = ''"+y'';
      options.desc = "Copy selection to system clipboard";
    }
    {
      key = "<C-v>";
      mode = [ "i" ];
      action = ''<Esc>"+pi'';
      options.desc = "Paste from system clipboard";
    }
    {
      key = "<Esc>";
      mode = [ "n" ];
      # https://github.com/LazyVim/LazyVim/blob/d1529f650fdd89cb620258bdeca5ed7b558420c7/lua/lazyvim/config/keymaps.lua#L60
      action = "<Cmd>nohlsearch<Bar>diffupdate<CR>";
      options.desc = "Smart Esc";
    }
    (keepsl "<")
    (keepsl ">")
    (wrappedJ "j")
    (wrappedJ "<Down>")
    (wrappedK "k")
    (wrappedK "<Up>")
  ];
}
