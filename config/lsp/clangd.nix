{
  plugins.lsp.servers = {
    clangd = {
      enable = true;
      package = null;
      cmd = [
        "clangd"
        "--clang-tidy"
        "--header-insertion=iwyu"
        "--completion-style=detailed"
        "--function-arg-placeholders"
        "--fallback-style=none"
      ];
      filetypes = [
        "c"
        "cpp"
        "cuda"
      ];
      rootMarkers = [
        ".clangd"
        ".clang-format"
        "compile_commands.json"
        "compile_flags.txt"
      ];
    };
  };
}
