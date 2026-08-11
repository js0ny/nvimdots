{ lib, ... }:
let
  inherit (lib.nixvim) toLuaObject;
  pickSnack = key: args: desc: {
    key = "<leader>${key}";
    action.__raw = /* lua */ ''
      function() require('snacks').picker(${args}) end
    '';
    options.desc = desc;
  };
  pickLeader =
    key: command: desc:
    pickLeaderWithArgs key command desc "";
  pickWithArgs = key: command: desc: args: {
    inherit key;
    action.__raw = /* lua */ ''
      function() require('snacks').picker.${command}(${args}) end
    '';
    options.desc = desc;
  };
  pickLeaderWithArgs =
    key: command: desc: args:
    pickWithArgs "<leader>${key}" command desc args;
  grepArgs = toLuaObject {
    glob = [
      # keep-sorted start
      "!Cargo.lock"
      "!composer.lock"
      "!flake.lock"
      "!go.sum"
      "!package-lock.json"
      "!pnpm-lock.yaml"
      "!poetry.lock"
      "!uv.lock"
      "!yarn.lock"
      # keep-sorted end
    ];
  };
in
{
  plugins.snacks.settings.picker = {
    enabled = true;
    ui_select = true;
  };
  keymaps = [
    (pickLeader "<space>" "smart" "Pick files")
    (pickLeaderWithArgs "/" "grep" "Grep files" grepArgs)
    (pickLeader "R" "resume" "Resume last pick")
    (pickLeader ";" "commands" "Show commands")
    (pickSnack ":" "" "Pick Snacks")
    (pickLeader "ui" "colorschemes" "Change Colorscheme")
    (pickLeader "pd" "zoxide" "Change project directories (via zoxide)")
    (pickLeader "gs" "git_status" "Git Status")
    (pickLeader "gt" "git_branches" "Git Branches")
    (pickLeader "gc" "git_log" "Git Log (Commits)")
    (pickLeader "ff" "files" "Find Files")
    (pickLeader "fb" "buffers" "List buffers")
    (pickLeader "bB" "buffers" "List buffers")
    (pickLeader "fh" "recent" "Recent Files")
    (pickLeader "cs" "lsp_symbols" "Search Symbols")
    (
      /*nixfmt:disable*/
      (pickLeader "cS" "grep_word" "Search Current Symbol")
      // { mode = [ "n" "x" ]; }
      /*nixfmt:enable*/
    )
    (pickWithArgs "gd" "lsp_definitions" "Goto definition" "")
    (pickWithArgs "gy" "lsp_type_definitions" "Goto T[y]pe Definition" "")
    (pickWithArgs "gr" "lsp_references" "References" "")
  ];
}
