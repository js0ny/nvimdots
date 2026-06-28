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
      key = "<leader>b1";
      action = "<cmd>BufferLineGoToBuffer 1<CR>";
      options.desc = "Switch to Buffer #1";
    }
    {
      key = "<leader>b2";
      action = "<cmd>BufferLineGoToBuffer 2<CR>";
      options.desc = "Switch to Buffer #2";
    }
    {
      key = "<leader>b3";
      action = "<cmd>BufferLineGoToBuffer 3<CR>";
      options.desc = "Switch to Buffer #3";
    }
    {
      key = "<leader>b4";
      action = "<cmd>BufferLineGoToBuffer 4<CR>";
      options.desc = "Switch to Buffer #4";
    }
    {
      key = "<leader>b5";
      action = "<cmd>BufferLineGoToBuffer 5<CR>";
      options.desc = "Switch to Buffer #5";
    }
    {
      key = "<leader>b6";
      action = "<cmd>BufferLineGoToBuffer 6<CR>";
      options.desc = "Switch to Buffer #6";
    }
    {
      key = "<leader>b7";
      action = "<cmd>BufferLineGoToBuffer 7<CR>";
      options.desc = "Switch to Buffer #7";
    }
    {
      key = "<leader>b8";
      action = "<cmd>BufferLineGoToBuffer 8<CR>";
      options.desc = "Switch to Buffer #8";
    }
    {
      key = "<leader>b9";
      action = "<cmd>BufferLineGoToBuffer 9<CR>";
      options.desc = "Switch to Buffer #9";
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
  ];

  plugins = {
    mini-icons.enable = true;
  };
}
