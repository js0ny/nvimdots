{ lib, pkgs, ... }:
let
  switchToBuffer = key: bufnr: {
    inherit key;
    action = "<cmd>BufferLineGoToBuffer ${bufnr}<CR>";
    options.desc = "Switch to Buffer #${bufnr}";
  };
  switchToBufferSameFormatter = bufnr: formatter: switchToBuffer (formatter bufnr) bufnr;
  winpfx = if pkgs.stdenv.isDarwin then "D" else "A";
in
{
  plugins.bufferline = {
    enable = true;
    # lazyLoad.enable = true;
    settings = {
      options = {
        indicator = {
          icon = "▎";
          style = "icon";
        };
        diagnostics = "nvim_lsp";
        diagnostics_indicator = /* lua */ ''
          function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end
        '';
        show_buffer_icons = true;
        numbers = "ordinal";
        name_formatter = /* lua */ ''
          function(buf)
            -- Nix: truncate default.nix -> folder name with slash
            if buf.name:match('default.nix') then
              return vim.fn.fnamemodify(buf.path, ':h:t') .. '/'
            end
          end
        '';
        close_command = "bdelete! %d";
        right_mouse_command = null;
        middle_mouse_command = "bdelete! %d";
      };
    };
  };

  keymaps = [
    {
      key = "H";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options.desc = "bp";
    }
    {
      key = "L";
      action = "<cmd>BufferLineCycleNext<CR>";
      options.desc = "bn";
    }
    {
      key = "<leader>b#";
      action = "<cmd>BufferLineGoToBuffer #<CR>";
      options.desc = "Switch to Buffer #";
    }
    {
      key = "<leader>b,";
      action = "<cmd>BufferLineMovePrev<CR>";
      options.desc = "Move Buffer Left";
    }
    {
      key = "<leader>b.";
      action = "<cmd>BufferLineMoveNext<CR>";
      options.desc = "Move Buffer Right";
    }
    {
      key = "<leader>bb";
      action = "<cmd>BufferLinePick<CR>";
      options.desc = "Quick Switch Buffers";
    }
    {
      key = "<leader>bD";
      action = "<cmd>BufferLineCloseOthers<CR>";
      options.desc = "Delete Other Buffers";
    }
    {
      key = "<leader>bxx";
      action = "<cmd>BufferLineCloseOthers<CR>";
      options.desc = "Delete Other Buffers";
    }
    {
      key = "<leader>bxh";
      action = "<cmd>BufferLineCloseLeft<CR>";
      options.desc = "Delete Buffers Left";
    }
    {
      key = "<leader>bxl";
      action = "<cmd>BufferLineCloseRight<CR>";
      options.desc = "Delete Buffers Right";
    }
    {
      key = "<leader>bX";
      action = "<cmd>BufferLineCloseOthers<CR>";
      options.desc = "Delete Other Buffers";
    }
    {
      key = "<leader>bt";
      action = "<cmd>BufferLineTogglePin<CR>";
      options.desc = "Pin Buffer";
    }
  ]
  ++ (map (
    num:
    let
      b = toString num;
    in
    switchToBufferSameFormatter b (s: "<leader>b${s}")
  ) (lib.range 1 9))
  ++ (map (
    num:
    let
      b = toString num;
    in
    switchToBufferSameFormatter b (s: "<${winpfx}-${s}>")
  ) (lib.range 1 9));

  plugins = {
    mini-icons.enable = true;
  };
}
