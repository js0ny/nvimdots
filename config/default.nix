{
  imports = [
    # keep-sorted start
    ./appearance/bufferline.nix
    ./appearance/colorful-winsep.nix
    ./appearance/dropbar.nix
    ./appearance/lualine.nix
    ./appearance/noice.nix
    ./appearance/todo-comments.nix
    ./appearance/which-key.nix
    ./appearance/whitespace.nix
    ./core
    ./edit/blink-cmp.nix
    ./edit/blink-pairs.nix
    ./edit/flash.nix
    ./edit/img-clip.nix
    ./edit/luasnip.nix
    ./edit/multicursors.nix
    ./edit/treesitter-autotag.nix
    ./edit/treesitter-context.nix
    ./edit/treesitter-textobjects.nix
    ./edit/treesitter.nix
    ./edit/treesj.nix
    ./lang
    ./lsp
    ./misc/cord.nix
    ./options.nix
    ./snacks
    ./tools/code-runner.nix
    ./tools/conform
    ./tools/dap.nix
    ./tools/diagnostic.nix
    ./tools/direnv.nix
    ./tools/grug-far.nix
    ./tools/kitty-scrollback.nix
    ./tools/limes.nix
    ./tools/neotree.nix
    ./tools/oil.nix
    ./tools/sops.nix
    ./tools/trouble.nix
    ./vcs/codediff.nix
    ./vcs/gitsigns.nix
    ./vcs/neogit.nix
    # keep-sorted end
  ];
  plugins = {
    lz-n.enable = true;
    startup.enable = true;
  };
  colorschemes.catppuccin.enable = true;
}
