{
  pkgs,
  lib,
  ...
}:
{
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
}
