{ pkgs, lib, ... }:
{
  imports = [
    ./blink-pairs.nix
    ./treesitter.nix
    ./edit/flash.nix
    ./vcs/neogit.nix
    ./apperance/lualine.nix
    ./apperance/neotree.nix
    ./apperance/bufferline.nix
    ./apperance/colorful-winsep.nix
    ./apperance/noice.nix
    ./tools/direnv.nix
    ./edit/blink-cmp.nix
    ./misc/cord.nix
    ./edit/img-clip.nix
    ./tools/kitty-scrollback.nix
    ./edit/treesitter-context.nix
    ./edit/treesj.nix
    ./edit/blink-indent.nix
    ./lang/bullets.nix
    ./vcs/codediff.nix
    ./tools/conform.nix
    ./apperance/dropbar.nix
    ./vcs/gitsigns.nix
    ./tools/grug-far.nix
    ./lsp
    ./lang/lazydev.nix
  ];
  plugins.lz-n.enable = true;
  colorschemes.kanagawa.enable = true;
  globals = {
    mapleader = " ";
    maplocalleader = "\\";
    autoformat = true;
    loaded_netrw = 1;
  };
  globalOpts = {
    number = true;
    relativenumber = true;
    termguicolors = true;
    mouse = "a";
    ignorecase = true;
    smartcase = true;
    encoding = "utf-8";
    fileencoding = "utf-8";
    cursorline = true;
    linebreak = true;
    cmdheight = 0;
    laststatus = 3;
    conceallevel = 2;
    mousemoveevent = true;
    confirm = true;
    scrolloff = 5;
    sidescrolloff = 10;
    expandtab = true;
    shiftwidth = 4;
    tabstop = 4;
    shiftround = true;
    smartindent = false;
    autoindent = true;
    grepprg = "${lib.getExe pkgs.ripgrep} --vimgrep --no-heading --smart-case";
    grepformat = "%f:%l:%c:%m";
    exrc = true;
    foldmethod = "expr";
    foldexpr = /* vim */ "v:lua.vim.treesitter.foldexpr()";
    foldtext = /* vim */ "v:lua.ConfigFoldText()";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;
  };
  extraConfigLuaPre = /* lua */ ''
    function _G.ConfigFoldText()
      local hidden_count = vim.v.foldend - vim.v.foldstart
      local parts = { { vim.fn.getline(vim.v.foldstart), 'ConfigFoldPreview' } }
      local end_text = vim.trim(vim.fn.getline(vim.v.foldend))
      if end_text ~= "" then
        table.insert(parts, { " ⋯ ", "ConfigFoldMuted" })
        table.insert(parts, { end_text, "ConfigFoldPreview" })
      end

      table.insert(parts, { "   ↙️ [" .. hidden_count .. " lines hidden]", "ConfigFoldTail" })
      return parts
    end
  '';
  plugins = {
    # avante.enable = true;
    luasnip.enable = true;
    multicursors.enable = true;
    treesitter-textobjects.enable = true;
    ts-autotag.enable = true;
    nvim-ufo.enable = true;
    todo-comments.enable = true;
    toggleterm.enable = true;
    trouble.enable = true;
    typst-preview.enable = true;
    vimtex.enable = true;
    snacks.enable = true;
  };

}
